-- 用户表
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SYS_USERS' AND xtype='U')
BEGIN
    CREATE TABLE SYS_USERS (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(255) NOT NULL,
        Role NVARCHAR(20) NOT NULL DEFAULT 'User',
        IsActive BIT NOT NULL DEFAULT 1,
        CustomsCode NVARCHAR(20) NOT NULL,
        CustomsName NVARCHAR(100) NULL,
        CompanyName NVARCHAR(200) NOT NULL,
        CompanyCode NVARCHAR(20) NULL,
        CreateTime DATETIME2 NOT NULL DEFAULT GETDATE(),
        LastLoginTime DATETIME2 NULL,
        IsDeleted BIT NOT NULL DEFAULT 0
    );

    -- 创建索引
    CREATE INDEX IX_SYS_USERS_Username ON SYS_USERS(Username);
    CREATE INDEX IX_SYS_USERS_CustomsCode ON SYS_USERS(CustomsCode);
    CREATE INDEX IX_SYS_USERS_IsDeleted ON SYS_USERS(IsDeleted);

    PRINT '用户表 SYS_USERS 创建成功';
END
ELSE
BEGIN
    PRINT '用户表 SYS_USERS 已存在';
END

-- 登录日志表
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SYS_LOGIN_LOGS' AND xtype='U')
BEGIN
    CREATE TABLE SYS_LOGIN_LOGS (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        UserId INT NOT NULL,
        IpAddress NVARCHAR(50) NULL,
        LoginTime DATETIME2 NOT NULL DEFAULT GETDATE(),
        FOREIGN KEY (UserId) REFERENCES SYS_USERS(Id)
    );

    -- 创建索引
    CREATE INDEX IX_SYS_LOGIN_LOGS_UserId ON SYS_LOGIN_LOGS(UserId);
    CREATE INDEX IX_SYS_LOGIN_LOGS_LoginTime ON SYS_LOGIN_LOGS(LoginTime);

    PRINT '登录日志表 SYS_LOGIN_LOGS 创建成功';
END
ELSE
BEGIN
    PRINT '登录日志表 SYS_LOGIN_LOGS 已存在';
END

-- 插入默认管理员账号
IF NOT EXISTS (SELECT * FROM SYS_USERS WHERE Username = 'admin')
BEGIN
    INSERT INTO SYS_USERS (Username, PasswordHash, Role, IsActive, CustomsCode, CustomsName, CompanyName, CompanyCode)
    VALUES ('admin', '$2a$11$N7HbcjKnUtTLuC0R/HJf6OKXHyJPKZhkKLvr4G5JKgXHJZK4bQfYa', 'Admin', 1, '1234567890', '北京海关', '系统管理', 'SYS001');
    -- 默认密码: admin123
    PRINT '默认管理员账号创建成功 - 用户名: admin, 密码: admin123';
END
ELSE
BEGIN
    PRINT '默认管理员账号已存在';
END

-- 插入测试用户账号
IF NOT EXISTS (SELECT * FROM SYS_USERS WHERE Username = 'testuser')
BEGIN
    INSERT INTO SYS_USERS (Username, PasswordHash, Role, IsActive, CustomsCode, CustomsName, CompanyName, CompanyCode)
    VALUES ('testuser', '$2a$11$N7HbcjKnUtTLuC0R/HJf6OKXHyJPKZhkKLvr4G5JKgXHJZK4bQfYa', 'User', 1, '0987654321', '上海海关', '测试企业', 'TEST01');
    -- 默认密码: admin123
    PRINT '测试用户账号创建成功 - 用户名: testuser, 密码: admin123';
END
ELSE
BEGIN
    PRINT '测试用户账号已存在';
END