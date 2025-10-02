-- Create table
create table BASE_VEHICLE
(
  auto_id        VARCHAR2(36) default SYS_GUID() not null,
  vehicle_no     VARCHAR2(20),
  vehicle_type   VARCHAR2(10),
  ic_code        VARCHAR2(20),
  ele_no1        NVARCHAR2(20),
  ele_no2        VARCHAR2(20),
  ele_no3        VARCHAR2(20),
  vehicle_wt     NUMBER(18,2),
  foreign_no     VARCHAR2(20),
  vehicle_nature VARCHAR2(10),
  used_nature    VARCHAR2(10),
  brand_type     VARCHAR2(30),
  amotor_no      VARCHAR2(30),
  difference_no  VARCHAR2(30),
  vehicle_native VARCHAR2(30),
  range          VARCHAR2(10),
  vehicle_used   VARCHAR2(255),
  license_no     VARCHAR2(32),
  load_wt        NUMBER(18,2),
  load_pack      NUMBER(18),
  colour         VARCHAR2(30),
  validity_date  DATE,
  record_date    DATE,
  register_date  DATE,
  attached_name  VARCHAR2(100),
  trade_code     VARCHAR2(20),
  trade_name     VARCHAR2(200),
  app_person     VARCHAR2(20),
  app_date       DATE,
  status         VARCHAR2(10),
  customs_code   VARCHAR2(10),
  note           VARCHAR2(255),
  area_code      VARCHAR2(20),
  extend_field_1 NUMBER(18,5),
  extend_field_2 NUMBER(18,5),
  extend_field_3 VARCHAR2(50),
  extend_field_4 VARCHAR2(50),
  extend_field_5 VARCHAR2(100)
)
tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table BASE_VEHICLE
  is '基础资料-车辆信息';
-- Add comments to the columns 
comment on column BASE_VEHICLE.auto_id
  is '自动编号';
comment on column BASE_VEHICLE.vehicle_no
  is '车牌号';
comment on column BASE_VEHICLE.vehicle_type
  is '车辆类型/车辆性质';
comment on column BASE_VEHICLE.ic_code
  is 'IC卡号';
comment on column BASE_VEHICLE.ele_no1
  is '电子车牌1';
comment on column BASE_VEHICLE.ele_no2
  is '电子车牌2';
comment on column BASE_VEHICLE.ele_no3
  is '电子车牌3';
comment on column BASE_VEHICLE.vehicle_wt
  is '车自重';
comment on column BASE_VEHICLE.foreign_no
  is '国外车牌号';
comment on column BASE_VEHICLE.vehicle_nature
  is '车辆性质（同:车辆类型）
不用';
comment on column BASE_VEHICLE.used_nature
  is '使用性质';
comment on column BASE_VEHICLE.brand_type
  is '品牌型号';
comment on column BASE_VEHICLE.amotor_no
  is '发动机号码';
comment on column BASE_VEHICLE.difference_no
  is '车辆识别代号';
comment on column BASE_VEHICLE.vehicle_native
  is '车辆国籍';
comment on column BASE_VEHICLE.range
  is '承运范围（同：使用性质）
不用';
comment on column BASE_VEHICLE.vehicle_used
  is '车辆用途';
comment on column BASE_VEHICLE.license_no
  is '批文号';
comment on column BASE_VEHICLE.load_wt
  is '核定载重';
comment on column BASE_VEHICLE.load_pack
  is '载客量';
comment on column BASE_VEHICLE.colour
  is '车身颜色';
comment on column BASE_VEHICLE.validity_date
  is '车辆有效期';
comment on column BASE_VEHICLE.record_date
  is '备案日期';
comment on column BASE_VEHICLE.register_date
  is '注册登记日期';
comment on column BASE_VEHICLE.attached_name
  is '挂靠单位';
comment on column BASE_VEHICLE.trade_code
  is '运输企业代码';
comment on column BASE_VEHICLE.trade_name
  is '运输企业名称';
comment on column BASE_VEHICLE.app_person
  is '申请人';
comment on column BASE_VEHICLE.app_date
  is '申请日期';
comment on column BASE_VEHICLE.status
  is '状态';
comment on column BASE_VEHICLE.customs_code
  is '关区代码';
comment on column BASE_VEHICLE.note
  is '备注';
comment on column BASE_VEHICLE.area_code
  is '区域代码';
comment on column BASE_VEHICLE.extend_field_1
  is '预留字段1';
comment on column BASE_VEHICLE.extend_field_2
  is '预留字段2';
comment on column BASE_VEHICLE.extend_field_3
  is '预留字段3';
comment on column BASE_VEHICLE.extend_field_4
  is '预留字段4';
comment on column BASE_VEHICLE.extend_field_5
  is '预留字段5';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BASE_VEHICLE
  add constraint PK_BASE_VEHICLE primary key (AUTO_ID)
  using index 
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
