# 海关数据申报系统 - 前端

基于 Vue 3 + Vite + Element Plus 构建的海关数据申报系统前端项目。

## 技术栈

- **框架**: Vue 3 (Composition API)
- **构建工具**: Vite
- **UI 组件库**: Element Plus
- **状态管理**: Pinia
- **路由**: Vue Router 4
- **HTTP 客户端**: Axios
- **日期处理**: Day.js
- **开发语言**: JavaScript

## 项目结构

```
frontend/
├── public/                 # 静态资源
├── src/                   # 源代码
│   ├── api/              # API 接口
│   ├── components/       # 通用组件
│   ├── layouts/          # 布局组件
│   ├── router/           # 路由配置
│   ├── stores/           # Pinia 状态管理
│   ├── styles/           # 全局样式
│   ├── utils/            # 工具函数
│   ├── views/            # 页面组件
│   ├── App.vue           # 根组件
│   └── main.js           # 入口文件
├── .env.development      # 开发环境配置
├── .env.production       # 生产环境配置
├── index.html            # HTML 模板
├── package.json          # 项目配置
├── vite.config.js        # Vite 配置
└── README.md             # 项目说明
```

## 功能特性

### 核心功能

1. **单一申报管理**
   - 申报单列表页面（查询、分页、排序、筛选）
   - 申报单录入页面（表头信息 + 商品表体）
   - 支持保存、申报、复制、模板管理

2. **用户认证**
   - 用户登录/登出
   - JWT Token 认证
   - 路由权限控制

3. **模板管理**
   - 保存申报单为模板
   - 加载已保存模板
   - 模板列表管理

### 技术特性

- 响应式设计，兼容桌面端
- 组件化开发，代码复用性高
- TypeScript 类型提示（通过 JSDoc）
- 自动导入 Vue 和 Element Plus API
- 统一的 API 错误处理
- 路由懒加载优化性能

## 开发指南

### 环境要求

- Node.js >= 16.0.0
- npm >= 7.0.0 或 yarn >= 1.22.0

### 安装依赖

```bash
npm install
```

### 启动开发服务器

```bash
npm run dev
```

访问地址：http://localhost:3000

### 构建生产版本

```bash
npm run build
```

### 代码检查

```bash
npm run lint
```

## 页面说明

### 1. 登录页面 (`/login`)
- 用户名密码登录
- 验证码验证（登录失败后显示）
- 记住密码功能
- 响应式设计

### 2. 单一申报列表 (`/dashboard/declaration`)
- 申报单列表展示
- 支持多条件搜索
- 分页、排序、筛选功能
- 状态管理和操作按钮

### 3. 申报单创建/编辑 (`/dashboard/declaration/create`, `/dashboard/declaration/edit/:id`)
- 核放单表头信息录入
- 商品表体在线编辑
- 实时数据验证
- 模板管理功能

## API 接口

### 认证相关
- `POST /api/auth/login` - 用户登录
- `POST /api/auth/logout` - 用户登出
- `GET /api/auth/userinfo` - 获取用户信息

### 申报单相关
- `GET /api/declaration/list` - 获取申报单列表
- `GET /api/declaration/detail/:id` - 获取申报单详情
- `POST /api/declaration/save` - 保存申报单
- `POST /api/declaration/submit/:id` - 提交申报单
- `DELETE /api/declaration/delete/:id` - 删除申报单

### 模板相关
- `GET /api/template/list` - 获取模板列表
- `POST /api/template/save` - 保存模板
- `DELETE /api/template/delete/:id` - 删除模板

## 状态管理

使用 Pinia 进行状态管理，主要包括：

- **用户状态** (`stores/user.js`)
  - 登录状态
  - 用户信息
  - 权限信息

- **申报单状态** (`stores/declaration.js`)
  - 申报单列表
  - 当前申报单
  - 模板列表

## 样式说明

- 使用 Element Plus 默认主题
- 全局样式文件 `styles/index.css`
- 支持暗色主题（Element Plus）
- 工具类样式（间距、颜色、布局等）

## 开发规范

1. **组件命名**：使用 PascalCase
2. **文件命名**：使用 kebab-case
3. **API 方法命名**：使用 camelCase
4. **CSS 类命名**：使用 kebab-case
5. **注释规范**：关键逻辑必须添加注释

## 浏览器兼容性

- Chrome >= 87
- Firefox >= 78
- Safari >= 14
- Edge >= 88

## 部署说明

### 开发环境
```bash
npm run dev
```

### 生产环境
```bash
npm run build
npm run preview  # 预览生产构建
```

构建产物在 `dist` 目录，可直接部署到静态文件服务器。

## 注意事项

1. 项目使用 ES modules，需要现代浏览器支持
2. 开发时确保后端 API 服务正常运行
3. 生产部署时需要配置正确的 API 地址
4. 路由使用 History 模式，服务器需要配置重定向

## 更新日志

### v1.0.0 (2024-01-15)
- 初始版本发布
- 完成单一申报核心功能
- 实现用户认证系统
- 添加模板管理功能