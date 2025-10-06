using CustomsDeclaration.API.Data;
using CustomsDeclaration.API.Middleware;
using CustomsDeclaration.API.Services;
using CustomsDeclaration.API.Configuration;
using CustomsDeclaration.API.BackgroundServices;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Serilog;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// 配置Serilog日志
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .Enrich.FromLogContext()
    .WriteTo.Console()
    .WriteTo.File("logs/api-.txt", rollingInterval: RollingInterval.Day)
    .CreateLogger();

builder.Host.UseSerilog();

// 添加服务到容器
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        // 配置JSON序列化为camelCase，与前端保持一致
        options.JsonSerializerOptions.PropertyNamingPolicy = System.Text.Json.JsonNamingPolicy.CamelCase;
    });

// 配置CORS
var corsSettings = builder.Configuration.GetSection("Cors");
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins", policy =>
    {
        policy.WithOrigins(corsSettings.GetSection("AllowedOrigins").Get<string[]>() ?? new[] { "*" })
              .WithMethods(corsSettings.GetSection("AllowedMethods").Get<string[]>() ?? new[] { "*" })
              .WithHeaders(corsSettings.GetSection("AllowedHeaders").Get<string[]>() ?? new[] { "*" })
              .AllowCredentials();
    });
});

// 配置JWT认证
var jwtSettings = builder.Configuration.GetSection("JwtSettings");
var secretKey = jwtSettings["SecretKey"];
var issuer = jwtSettings["Issuer"];
var audience = jwtSettings["Audience"];

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidIssuer = issuer,
            ValidateAudience = true,
            ValidAudience = audience,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey!)),
            ClockSkew = TimeSpan.Zero
        };
    });

builder.Services.AddAuthorization(options =>
{
    // 不设置默认授权策略，允许 [AllowAnonymous] 属性正常工作
    options.FallbackPolicy = null;
});

// 配置认证设置
builder.Services.Configure<AuthenticationSettings>(
    builder.Configuration.GetSection("Authentication"));

// 注册数据库相关服务
builder.Services.AddSingleton<IDbConnectionFactory, DbConnectionFactory>();
builder.Services.AddScoped<DatabaseHelper>();
builder.Services.AddHttpContextAccessor();

// 注册业务服务
builder.Services.AddScoped<IJwtService, JwtService>();
builder.Services.AddScoped<IRoleService, RoleService>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IVehicleService, VehicleService>();
builder.Services.AddScoped<ISystemParameterService, SystemParameterService>();
builder.Services.AddScoped<IDeclarationService, DeclarationService>();
builder.Services.AddScoped<IJobNumberService, JobNumberService>();
builder.Services.AddScoped<ICustomsStatusService, CustomsStatusService>();
builder.Services.AddScoped<ITwoStepDeclarationService, TwoStepDeclarationService>();

// 注册后台服务
builder.Services.AddHostedService<DeclarationStatusMonitorService>();

// 配置API文档
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "海关数据申报系统 API",
        Version = "v1",
        Description = "基于.NET 8的海关数据在线申报系统后端API"
    });

    // 配置JWT认证
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme. Example: \"Bearer {token}\"",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });

    // 包含XML注释文件
    var xmlFile = $"{System.Reflection.Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
    if (File.Exists(xmlPath))
    {
        c.IncludeXmlComments(xmlPath);
    }
});

var app = builder.Build();

// 配置HTTP请求管道
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "海关数据申报系统 API V1");
        c.RoutePrefix = string.Empty; // 设置Swagger UI为根路径
    });
}

// 使用全局异常处理中间件
app.UseMiddleware<GlobalExceptionMiddleware>();

// 启用CORS
app.UseCors("AllowSpecificOrigins");

// 启用HTTPS重定向 - 开发环境下禁用以避免端口警告
if (!app.Environment.IsDevelopment())
{
    app.UseHttpsRedirection();
}

// 启用认证和授权
app.UseAuthentication();
app.UseAuthorization();

// 映射控制器路由
app.MapControllers();

// 健康检查端点
app.MapGet("/health", () => new { Status = "Healthy", Timestamp = DateTime.Now });

// 启动应用
try
{
    Log.Information("正在启动海关数据申报系统API服务...");
    app.Run();
}
catch (Exception ex)
{
    Log.Fatal(ex, "API服务启动失败");
}
finally
{
    Log.CloseAndFlush();
}
