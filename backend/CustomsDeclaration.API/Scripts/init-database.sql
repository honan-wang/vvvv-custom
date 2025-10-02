-- 海关数据申报系统数据库初始化脚本
-- 适用于SQL Server

-- 创建用户表
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SYS_USERS' AND xtype='U')
BEGIN
    CREATE TABLE SYS_USERS (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(255) NOT NULL,
        Role NVARCHAR(20) NOT NULL DEFAULT '申报员',
        IsActive BIT NOT NULL DEFAULT 1,
        CustomsCode NVARCHAR(10) NOT NULL,
        CompanyName NVARCHAR(200) NOT NULL,
        CreateTime DATETIME2 NOT NULL DEFAULT GETDATE(),
        LastLoginTime DATETIME2 NULL,
        IsDeleted BIT NOT NULL DEFAULT 0
    );
    
    -- 创建索引
    CREATE INDEX IX_SYS_USERS_Username ON SYS_USERS(Username);
    CREATE INDEX IX_SYS_USERS_CustomsCode ON SYS_USERS(CustomsCode);
END

-- 创建登录日志表
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
END

-- 创建车辆基础信息表（如果不存在）
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='BASE_VEHICLE' AND xtype='U')
BEGIN
    CREATE TABLE BASE_VEHICLE (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        PlateNumber NVARCHAR(20) NOT NULL,
        VehicleType NVARCHAR(50) NULL,
        Brand NVARCHAR(100) NULL,
        IcCardNo NVARCHAR(50) NULL,
        ElectronicPlate NVARCHAR(50) NULL,
        LicenseNo NVARCHAR(50) NULL,
        VehicleWeight DECIMAL(18,2) NOT NULL DEFAULT 0,
        LoadWeight DECIMAL(18,2) NOT NULL DEFAULT 0,
        PassengerCapacity INT NOT NULL DEFAULT 0,
        Color NVARCHAR(20) NULL,
        OperatingCompany NVARCHAR(200) NULL,
        AffiliatedUnit NVARCHAR(200) NULL,
        Applicant NVARCHAR(100) NULL,
        RecordStatus NVARCHAR(20) NULL,
        ValidFromDate DATETIME2 NULL,
        ValidToDate DATETIME2 NULL,
        CreateTime DATETIME2 NOT NULL DEFAULT GETDATE(),
        UpdateTime DATETIME2 NULL,
        IsDeleted BIT NOT NULL DEFAULT 0
    );
    
    -- 创建索引
    CREATE UNIQUE INDEX IX_BASE_VEHICLE_PlateNumber ON BASE_VEHICLE(PlateNumber) WHERE IsDeleted = 0;
    CREATE INDEX IX_BASE_VEHICLE_VehicleType ON BASE_VEHICLE(VehicleType);
    CREATE INDEX IX_BASE_VEHICLE_RecordStatus ON BASE_VEHICLE(RecordStatus);
END

-- 创建核放单表头（如果不存在）
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='HF_HEAD_PRE' AND xtype='U')
BEGIN
    CREATE TABLE HF_HEAD_PRE (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        DischargedNo NVARCHAR(50) NOT NULL,
        CarNo NVARCHAR(20) NOT NULL,
        CarWeight DECIMAL(18,2) NOT NULL DEFAULT 0,
        StartPlace NVARCHAR(100) NULL,
        Destination NVARCHAR(100) NULL,
        AreaMark NVARCHAR(20) NULL,
        TotalWeight DECIMAL(18,2) NOT NULL DEFAULT 0,
        Remark NVARCHAR(500) NULL,
        PackageCount INT NOT NULL DEFAULT 0,
        GrossWeight DECIMAL(18,2) NOT NULL DEFAULT 0,
        PackageType NVARCHAR(50) NULL,
        IeMark NVARCHAR(1) NOT NULL, -- I进口/E出口
        MaterialType NVARCHAR(50) NULL,
        BookNo NVARCHAR(50) NULL,
        Status NVARCHAR(20) NOT NULL DEFAULT 'draft',
        CreateTime DATETIME2 NOT NULL DEFAULT GETDATE(),
        CreateUserId INT NOT NULL,
        UpdateTime DATETIME2 NULL,
        IsDeleted BIT NOT NULL DEFAULT 0,
        FOREIGN KEY (CreateUserId) REFERENCES SYS_USERS(Id)
    );
    
    -- 创建索引
    CREATE UNIQUE INDEX IX_HF_HEAD_PRE_DischargedNo ON HF_HEAD_PRE(DischargedNo) WHERE IsDeleted = 0;
    CREATE INDEX IX_HF_HEAD_PRE_CarNo ON HF_HEAD_PRE(CarNo);
    CREATE INDEX IX_HF_HEAD_PRE_IeMark ON HF_HEAD_PRE(IeMark);
    CREATE INDEX IX_HF_HEAD_PRE_Status ON HF_HEAD_PRE(Status);
    CREATE INDEX IX_HF_HEAD_PRE_CreateTime ON HF_HEAD_PRE(CreateTime);
END

-- 创建核放单商品明细表（如果不存在）
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='HF_GOODS_PRE' AND xtype='U')
BEGIN
    CREATE TABLE HF_GOODS_PRE (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        DeclarationId INT NOT NULL,
        ItemNo NVARCHAR(10) NOT NULL,
        GoodsName NVARCHAR(200) NOT NULL,
        DeclareQty DECIMAL(18,4) NOT NULL DEFAULT 0,
        GoodsCode NVARCHAR(50) NULL,
        GoodsSpec NVARCHAR(500) NULL,
        Unit NVARCHAR(20) NULL,
        UnitPrice DECIMAL(18,4) NOT NULL DEFAULT 0,
        TotalPrice DECIMAL(18,2) NOT NULL DEFAULT 0,
        Currency NVARCHAR(10) NULL,
        MaterialType NVARCHAR(50) NULL,
        Remark NVARCHAR(500) NULL,
        FOREIGN KEY (DeclarationId) REFERENCES HF_HEAD_PRE(Id) ON DELETE CASCADE
    );
    
    -- 创建索引
    CREATE INDEX IX_HF_GOODS_PRE_DeclarationId ON HF_GOODS_PRE(DeclarationId);
    CREATE INDEX IX_HF_GOODS_PRE_ItemNo ON HF_GOODS_PRE(ItemNo);
END

-- 插入默认管理员用户
IF NOT EXISTS (SELECT * FROM SYS_USERS WHERE Username = 'admin')
BEGIN
    INSERT INTO SYS_USERS (Username, PasswordHash, Role, IsActive, CustomsCode, CompanyName)
    VALUES ('admin', '$2a$11$rKWn2vTKZgZgBGTgYgBY2.ZzJ5J5J5J5J5J5J5J5J5J5J5J5J5J5J5J5J', '管理员', 1, '0000000000', '系统管理员');
END

-- 插入测试数据
IF NOT EXISTS (SELECT * FROM SYS_USERS WHERE Username = 'test_user')
BEGIN
    INSERT INTO SYS_USERS (Username, PasswordHash, Role, IsActive, CustomsCode, CompanyName)
    VALUES ('test_user', '$2a$11$rKWn2vTKZgZgBGTgYgBY2.ZzJ5J5J5J5J5J5J5J5J5J5J5J5J5J5J5J5J', '申报员', 1, '1234567890', '测试企业有限公司');
END

-- 创建存储过程SP_GET_JOB_NO（如果不存在）
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SP_GET_JOB_NO' AND xtype='P')
BEGIN
    EXEC('
    CREATE PROCEDURE SP_GET_JOB_NO
        @JobType NVARCHAR(10) = ''HF'', -- HF：核放单
        @NewJobNo NVARCHAR(50) OUTPUT
    AS
    BEGIN
        SET NOCOUNT ON;
        
        DECLARE @CurrentDate NVARCHAR(8) = FORMAT(GETDATE(), ''yyyyMMdd'');
        DECLARE @Prefix NVARCHAR(20) = @JobType + @CurrentDate;
        DECLARE @MaxSeq INT = 0;
        
        -- 获取当日最大序号
        SELECT @MaxSeq = ISNULL(MAX(CAST(RIGHT(DischargedNo, 4) AS INT)), 0)
        FROM HF_HEAD_PRE 
        WHERE DischargedNo LIKE @Prefix + ''%''
        AND LEN(DischargedNo) = LEN(@Prefix) + 4;
        
        -- 生成新编号
        SET @NewJobNo = @Prefix + RIGHT(''0000'' + CAST(@MaxSeq + 1 AS NVARCHAR), 4);
    END
    ')
END

PRINT '数据库初始化完成！';
PRINT '默认管理员账号: admin';
PRINT '默认密码需要通过API进行BCrypt加密后设置';