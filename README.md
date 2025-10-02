# 海关数据申报系统

基于前后端分离架构的海关数据在线申报系统，用于企业用户在线完成海关相关数据的填报与提交。

## 技术栈

### 前端
- Vue 3 (Composition API)
- Element Plus UI框架
- Vite
- Pinia (状态管理)
- Vue Router
- Axios

### 后端
- .NET 8+ Web API
- JWT认证
- SQL Server / Oracle 数据库
- Serilog 日志框架

## 功能模块

### 1. 用户管理系统
- 用户注册、登录、权限管理
- 角色分配：管理员、申报员、审核员
- 用户信息维护
- 登录日志记录

### 2. 车辆管理系统
- 车辆信息录入与维护
- 车辆查询与统计

### 3. 申报数据管理系统
- 核放单管理
- 账册管理
- 商品明细管理
- 单一申报界面

### 4. 系统辅助功能
- 数据导入导出（Excel格式）
- 报表统计与查询
- 数据模板管理
- 系统日志管理

## 项目结构

```
├── frontend/              # 前端项目
│   ├── src/
│   │   ├── api/          # API接口
│   │   ├── components/   # 公共组件
│   │   ├── views/        # 页面视图
│   │   ├── router/       # 路由配置
│   │   ├── stores/       # 状态管理
│   │   └── utils/        # 工具函数
│   └── package.json
│
├── backend/              # 后端项目
│   └── CustomsDeclaration.API/
│       ├── Controllers/  # 控制器
│       ├── Services/     # 业务逻辑层
│       ├── Models/       # 数据模型
│       ├── Data/         # 数据访问层
│       └── Program.cs
│
└── README.md
```

## 快速开始

### 前端开发

```bash
# 进入前端目录
cd frontend

# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 构建生产版本
npm run build
```

### 后端开发

```bash
# 进入后端目录
cd backend/CustomsDeclaration.API

# 还原依赖
dotnet restore

# 运行项目
dotnet run

# 构建项目
dotnet build
```

## 配置说明

### 后端配置

编辑 `backend/CustomsDeclaration.API/appsettings.json`：

```json
{
  "DatabaseProvider": "SqlServer",  // 或 "Oracle"
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string"
  },
  "JwtSettings": {
    "SecretKey": "your-secret-key",
    "Issuer": "CustomsDeclarationAPI",
    "Audience": "CustomsDeclarationClient",
    "ExpirationMinutes": 1440
  }
}
```

### 前端配置

编辑 `frontend/.env.development`：

```
VITE_API_BASE_URL=http://localhost:5002/api
```

## 数据库

系统支持SQL Server和Oracle数据库，主要表结构：

- `BASE_VEHICLE` - 车辆基础信息表
- `HF_HEAD_PRE` - 核放单表头
- `EMS_HEAD` - 账册表头表
- `EMS_AIMG_PRE` - 账册进口商品明细
- `EMS_AEXG_PRE` - 账册出口商品明细
- `HF_BODY_PRE` - 核放单关联货物表
- `HF_GJGOODS_PRE` - 核放单关联货物明细表

## 端口配置

- 前端开发服务器: http://localhost:3000
- 后端API服务: http://localhost:5002
- Swagger文档: http://localhost:5002/swagger (如启用)

## 安全要求

- JWT Token认证
- 密码加密存储
- SQL注入防护
- XSS攻击防护
- 操作日志记录

## 许可证

[MIT License](LICENSE)

## 联系方式

如有问题或建议，请提交Issue。
