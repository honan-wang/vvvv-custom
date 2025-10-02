# 海关数据申报系统后端API

基于 .NET 8 开发的海关数据在线申报系统后端API服务。

## 🏗️ 项目架构

- **框架**: .NET 8 Web API
- **架构模式**: 三层架构（Controller - Service - Data）
- **认证方式**: JWT Bearer Token
- **数据库**: SQL Server / Oracle（可切换）
- **日志**: Serilog
- **API文档**: Swagger/OpenAPI

## 📁 项目结构

```
CustomsDeclaration.API/
├── Controllers/           # 控制器层
│   ├── AuthController.cs     # 认证控制器
│   └── VehicleController.cs  # 车辆管理控制器
├── Data/                  # 数据访问层
│   ├── IDbConnectionFactory.cs
│   ├── DbConnectionFactory.cs
│   └── DatabaseHelper.cs
├── Middleware/            # 中间件
│   └── GlobalExceptionMiddleware.cs
├── Models/               # 数据模型
│   ├── ApiResponse.cs
│   ├── User.cs
│   ├── Vehicle.cs
│   └── Declaration.cs
├── Services/             # 业务服务层
│   ├── IJwtService.cs
│   ├── JwtService.cs
│   ├── IUserService.cs
│   ├── UserService.cs
│   ├── IVehicleService.cs
│   └── VehicleService.cs
├── Scripts/              # 数据库脚本
│   └── init-database.sql
└── Program.cs            # 程序入口
```

## 🛠️ 技术栈

### 核心框架
- .NET 8.0
- ASP.NET Core Web API

### 数据库相关
- Microsoft.Data.SqlClient (SQL Server)
- Oracle.ManagedDataAccess.Core (Oracle)
- 自定义数据库操作类（无ORM依赖）

### 认证授权
- Microsoft.AspNetCore.Authentication.JwtBearer
- System.IdentityModel.Tokens.Jwt
- BCrypt.Net-Next (密码加密)

### 日志记录
- Serilog.AspNetCore
- Serilog.Sinks.File

### API文档
- Swashbuckle.AspNetCore (Swagger)

## ⚙️ 配置说明

### appsettings.json 配置项

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "SQL Server连接字符串",
    "OracleConnection": "Oracle连接字符串"
  },
  "DatabaseProvider": "SqlServer", // 或 "Oracle"
  "JwtSettings": {
    "SecretKey": "JWT密钥",
    "Issuer": "发行者",
    "Audience": "受众",
    "ExpiryMinutes": 60
  },
  "Cors": {
    "AllowedOrigins": ["http://localhost:3000"],
    "AllowedMethods": ["GET", "POST", "PUT", "DELETE"],
    "AllowedHeaders": ["*"]
  }
}
```

## 🚀 快速开始

### 1. 环境要求
- .NET 8 SDK
- SQL Server 2019+ 或 Oracle 12c+
- Visual Studio 2022 或 VS Code

### 2. 数据库初始化
```sql
-- 执行初始化脚本
sqlcmd -S your_server -d your_database -i Scripts/init-database.sql
```

### 3. 配置连接字符串
修改 `appsettings.json` 中的数据库连接配置。

### 4. 运行项目
```bash
# 还原依赖
dotnet restore

# 运行项目
dotnet run

# 或使用监视模式
dotnet watch run
```

### 5. 访问API文档
启动后访问：`https://localhost:5001` 查看Swagger API文档

## 🔐 认证说明

### 默认账号
- 用户名: `admin`
- 密码: `admin123` (需要在数据库中设置BCrypt加密后的值)

### JWT Token使用
1. 调用 `/api/auth/login` 获取Token
2. 在请求头中添加: `Authorization: Bearer {token}`

## 📚 API接口

### 认证接口
- `POST /api/auth/login` - 用户登录
- `GET /api/auth/profile` - 获取当前用户信息
- `POST /api/auth/logout` - 用户退出

### 车辆管理接口
- `GET /api/vehicle` - 获取车辆列表
- `GET /api/vehicle/{id}` - 获取车辆详情
- `GET /api/vehicle/by-plate/{plateNumber}` - 根据车牌号获取车辆
- `POST /api/vehicle` - 创建车辆
- `PUT /api/vehicle/{id}` - 更新车辆
- `DELETE /api/vehicle/{id}` - 删除车辆

### 系统接口
- `GET /health` - 健康检查

## 🔒 权限说明

### 角色定义
- **管理员**: 系统管理员，拥有所有权限
- **申报员**: 申报操作员，可以进行申报相关操作
- **审核员**: 审核人员，负责审核申报数据

### 权限控制
- 使用 `[Authorize]` 特性进行认证控制
- 使用 `[Authorize(Roles = "角色名")]` 进行角色授权

## 🗄️ 数据库表结构

### 核心表
- `SYS_USERS` - 用户表
- `SYS_LOGIN_LOGS` - 登录日志表
- `BASE_VEHICLE` - 车辆基础信息表
- `HF_HEAD_PRE` - 核放单表头
- `HF_GOODS_PRE` - 核放单商品明细表

## 📝 开发说明

### 代码规范
- 遵循C#编码规范
- 使用XML注释进行API文档化
- 统一异常处理机制
- 结构化日志记录

### 错误处理
- 全局异常处理中间件
- 统一API响应格式
- 详细的错误日志记录

### 安全性
- JWT Token认证
- 密码BCrypt加密
- SQL注入防护
- CORS跨域配置

## 🔍 日志说明

### 日志级别
- Information: 一般信息
- Warning: 警告信息
- Error: 错误信息
- Fatal: 致命错误

### 日志文件
- 控制台输出
- 文件输出: `logs/api-{date}.txt`

## 🧪 测试

### API测试
1. 使用Swagger UI进行接口测试
2. 使用Postman等工具进行集成测试

### 健康检查
访问 `/health` 端点检查服务状态

## 📞 技术支持

如有问题，请查看：
1. Swagger API文档
2. 日志文件
3. 数据库连接配置

## 📄 许可证

本项目采用 MIT 许可证。