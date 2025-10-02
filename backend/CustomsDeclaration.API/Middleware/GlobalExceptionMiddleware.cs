using CustomsDeclaration.API.Models;
using System.Net;
using System.Text.Json;

namespace CustomsDeclaration.API.Middleware
{
    /// <summary>
    /// 全局异常处理中间件
    /// </summary>
    public class GlobalExceptionMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<GlobalExceptionMiddleware> _logger;

        public GlobalExceptionMiddleware(RequestDelegate next, ILogger<GlobalExceptionMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An unhandled exception occurred: {Message}", ex.Message);
                await HandleExceptionAsync(context, ex);
            }
        }

        private static async Task HandleExceptionAsync(HttpContext context, Exception exception)
        {
            context.Response.ContentType = "application/json";
            
            var response = exception switch
            {
                ArgumentException => new
                {
                    StatusCode = (int)HttpStatusCode.BadRequest,
                    Response = ApiResponse<object>.Fail("请求参数错误", "INVALID_ARGUMENT")
                },
                UnauthorizedAccessException => new
                {
                    StatusCode = (int)HttpStatusCode.Unauthorized,
                    Response = ApiResponse<object>.Fail("未授权访问", "UNAUTHORIZED")
                },
                KeyNotFoundException => new
                {
                    StatusCode = (int)HttpStatusCode.NotFound,
                    Response = ApiResponse<object>.Fail("资源未找到", "NOT_FOUND")
                },
                _ => new
                {
                    StatusCode = (int)HttpStatusCode.InternalServerError,
                    Response = ApiResponse<object>.Fail("服务器内部错误", "INTERNAL_SERVER_ERROR")
                }
            };

            context.Response.StatusCode = response.StatusCode;

            var jsonResponse = JsonSerializer.Serialize(response.Response, new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            });

            await context.Response.WriteAsync(jsonResponse);
        }
    }
}