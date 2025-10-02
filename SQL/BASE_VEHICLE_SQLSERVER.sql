-- Create table for SQL Server
CREATE TABLE BASE_VEHICLE
(
  auto_id        NVARCHAR(36) DEFAULT NEWID() NOT NULL,
  vehicle_no     NVARCHAR(20),
  vehicle_type   NVARCHAR(10),
  ic_code        NVARCHAR(20),
  ele_no1        NVARCHAR(20),
  ele_no2        NVARCHAR(20),
  ele_no3        NVARCHAR(20),
  vehicle_wt     DECIMAL(18,2),
  foreign_no     NVARCHAR(20),
  vehicle_nature NVARCHAR(10),
  used_nature    NVARCHAR(10),
  brand_type     NVARCHAR(30),
  amotor_no      NVARCHAR(30),
  difference_no  NVARCHAR(30),
  vehicle_native NVARCHAR(30),
  range          NVARCHAR(10),
  vehicle_used   NVARCHAR(255),
  license_no     NVARCHAR(32),
  load_wt        DECIMAL(18,2),
  load_pack      DECIMAL(18,0),
  colour         NVARCHAR(30),
  validity_date  DATETIME,
  record_date    DATETIME,
  register_date  DATETIME,
  attached_name  NVARCHAR(100),
  trade_code     NVARCHAR(20),
  trade_name     NVARCHAR(200),
  app_person     NVARCHAR(20),
  app_date       DATETIME,
  status         NVARCHAR(10),
  customs_code   NVARCHAR(10),
  note           NVARCHAR(255),
  area_code      NVARCHAR(20),
  extend_field_1 DECIMAL(18,5),
  extend_field_2 DECIMAL(18,5),
  extend_field_3 NVARCHAR(50),
  extend_field_4 NVARCHAR(50),
  extend_field_5 NVARCHAR(100)
);

-- Add extended properties (SQL Server equivalent of Oracle comments) to the table 
EXEC sp_addextendedproperty 
  @name = N'MS_Description', 
  @value = N'基础信息-车辆信息', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE';

-- Add extended properties (SQL Server equivalent of Oracle comments) to the columns 
EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'自动编号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'auto_id';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'车牌号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'vehicle_no';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'车辆类型/运输工具', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'vehicle_type';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'IC卡号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'ic_code';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'电子车牌1', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'ele_no1';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'电子车牌2', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'ele_no2';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'电子车牌3', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'ele_no3';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'车辆重量', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'vehicle_wt';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'境外车牌号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'foreign_no';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'车辆性质，同:运输工具类型，
待删', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'vehicle_nature';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'使用性质', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'used_nature';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'品牌型号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'brand_type';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'发动机号码', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'amotor_no';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'车辆识别代号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'difference_no';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'车辆国别', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'vehicle_native';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'载人范围，同载使用性质，
待删', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'range';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'车辆用途', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'vehicle_used';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'许可证号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'license_no';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'载重量载', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'load_wt';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'载客量', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'load_pack';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'车辆颜色', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'colour';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'证件有效期', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'validity_date';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'备案日期', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'record_date';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'注册登记日期', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'register_date';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'挂靠单位', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'attached_name';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'经营企业编码', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'trade_code';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'经营企业名称', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'trade_name';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'申请人', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'app_person';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'申请日期', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'app_date';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'状态', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'status';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'海关编码', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'customs_code';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'备注', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'note';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'区域代码', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'area_code';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'预留字段1', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'extend_field_1';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'预留字段2', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'extend_field_2';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'预留字段3', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'extend_field_3';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'预留字段4', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'extend_field_4';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'预留字段5', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'BASE_VEHICLE', 
  @level2type = N'COLUMN', @level2name = N'extend_field_5';

-- Create/Recreate primary key constraint 
ALTER TABLE BASE_VEHICLE
  ADD CONSTRAINT PK_BASE_VEHICLE PRIMARY KEY (AUTO_ID);