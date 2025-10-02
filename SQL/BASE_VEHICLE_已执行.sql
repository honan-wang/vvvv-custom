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
  is '��������-������Ϣ';
-- Add comments to the columns 
comment on column BASE_VEHICLE.auto_id
  is '�Զ����';
comment on column BASE_VEHICLE.vehicle_no
  is '���ƺ�';
comment on column BASE_VEHICLE.vehicle_type
  is '��������/��������';
comment on column BASE_VEHICLE.ic_code
  is 'IC����';
comment on column BASE_VEHICLE.ele_no1
  is '���ӳ���1';
comment on column BASE_VEHICLE.ele_no2
  is '���ӳ���2';
comment on column BASE_VEHICLE.ele_no3
  is '���ӳ���3';
comment on column BASE_VEHICLE.vehicle_wt
  is '������';
comment on column BASE_VEHICLE.foreign_no
  is '���⳵�ƺ�';
comment on column BASE_VEHICLE.vehicle_nature
  is '�������ʣ�ͬ:�������ͣ�
����';
comment on column BASE_VEHICLE.used_nature
  is 'ʹ������';
comment on column BASE_VEHICLE.brand_type
  is 'Ʒ���ͺ�';
comment on column BASE_VEHICLE.amotor_no
  is '����������';
comment on column BASE_VEHICLE.difference_no
  is '����ʶ�����';
comment on column BASE_VEHICLE.vehicle_native
  is '��������';
comment on column BASE_VEHICLE.range
  is '���˷�Χ��ͬ��ʹ�����ʣ�
����';
comment on column BASE_VEHICLE.vehicle_used
  is '������;';
comment on column BASE_VEHICLE.license_no
  is '���ĺ�';
comment on column BASE_VEHICLE.load_wt
  is '�˶�����';
comment on column BASE_VEHICLE.load_pack
  is '�ؿ���';
comment on column BASE_VEHICLE.colour
  is '������ɫ';
comment on column BASE_VEHICLE.validity_date
  is '������Ч��';
comment on column BASE_VEHICLE.record_date
  is '��������';
comment on column BASE_VEHICLE.register_date
  is 'ע��Ǽ�����';
comment on column BASE_VEHICLE.attached_name
  is '�ҿ���λ';
comment on column BASE_VEHICLE.trade_code
  is '������ҵ����';
comment on column BASE_VEHICLE.trade_name
  is '������ҵ����';
comment on column BASE_VEHICLE.app_person
  is '������';
comment on column BASE_VEHICLE.app_date
  is '��������';
comment on column BASE_VEHICLE.status
  is '״̬';
comment on column BASE_VEHICLE.customs_code
  is '��������';
comment on column BASE_VEHICLE.note
  is '��ע';
comment on column BASE_VEHICLE.area_code
  is '�������';
comment on column BASE_VEHICLE.extend_field_1
  is 'Ԥ���ֶ�1';
comment on column BASE_VEHICLE.extend_field_2
  is 'Ԥ���ֶ�2';
comment on column BASE_VEHICLE.extend_field_3
  is 'Ԥ���ֶ�3';
comment on column BASE_VEHICLE.extend_field_4
  is 'Ԥ���ֶ�4';
comment on column BASE_VEHICLE.extend_field_5
  is 'Ԥ���ֶ�5';
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
