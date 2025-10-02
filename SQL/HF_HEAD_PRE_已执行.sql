-- Create table
create table HF_HEAD_PRE
(
  discharged_no  VARCHAR2(50) not null,
  biz_type       VARCHAR2(10),
  biz_mode       VARCHAR2(10),
  i_e_mark       VARCHAR2(1),
  start_land     VARCHAR2(10),
  goal_land      VARCHAR2(10),
  car_no         VARCHAR2(64),
  car_wt         NUMBER(18,5),
  ic_code        VARCHAR2(128),
  gate_id        VARCHAR2(36),
  f_conta_no     VARCHAR2(20),
  f_conta_type   VARCHAR2(512),
  f_conta_wt     NUMBER(18,5),
  a_conta_no     VARCHAR2(20),
  a_conta_type   VARCHAR2(10),
  a_conta_wt     NUMBER(18,5),
  carframe_no    VARCHAR2(256),
  carframe_type  VARCHAR2(10),
  carframe_wt    NUMBER(18,5),
  goods_wt       NUMBER(18,5),
  fact_weight    NUMBER(18,5),
  pack_no        NUMBER(18,2),
  bill_no        VARCHAR2(50),
  main_goods     VARCHAR2(100),
  fit_mark       VARCHAR2(20),
  b_status       VARCHAR2(20),
  m_stauts       VARCHAR2(20),
  port_status    VARCHAR2(20) default 'K03',
  area_code      VARCHAR2(10) not null,
  customs_code   VARCHAR2(10) not null,
  trade_code     VARCHAR2(20) not null,
  trade_name     VARCHAR2(512) not null,
  input_code     VARCHAR2(20) not null,
  input_name     VARCHAR2(200) not null,
  declare_code   VARCHAR2(20),
  declare_name   VARCHAR2(200),
  step_id        VARCHAR2(20) not null,
  pre_step_id    VARCHAR2(20),
  oper_type      VARCHAR2(10),
  oper_result    VARCHAR2(10),
  create_person  VARCHAR2(40) not null,
  create_date    DATE not null,
  declare_person VARCHAR2(40),
  declare_date   DATE,
  approve_person VARCHAR2(40),
  approve_date   DATE,
  oper_person    VARCHAR2(40),
  oper_date      DATE,
  outer_comment  VARCHAR2(500),
  inner_comment  VARCHAR2(500),
  plat_no        VARCHAR2(10),
  work_no        VARCHAR2(50),
  note           VARCHAR2(500),
  port_date      DATE,
  double_random  VARCHAR2(1) default '0',
  car_ec_no      VARCHAR2(255),
  car_dec_no     VARCHAR2(255),
  fill_in        VARCHAR2(1) default '1',
  zs_flag        VARCHAR2(10) default 'A001',
  bat_id         VARCHAR2(50),
  template_id    VARCHAR2(50),
  owner_name     VARCHAR2(200),
  transport_name VARCHAR2(200),
  driver         VARCHAR2(50),
  driver_phone   VARCHAR2(20),
  custdecl       VARCHAR2(50),
  custdecl_phone VARCHAR2(20),
  entry_id       VARCHAR2(50)
)
tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table HF_HEAD_PRE
  is '核放单表头';
-- Add comments to the columns 
comment on column HF_HEAD_PRE.discharged_no
  is '核放单号';
comment on column HF_HEAD_PRE.biz_type
  is '业务类型';
comment on column HF_HEAD_PRE.biz_mode
  is '业务模式';
comment on column HF_HEAD_PRE.i_e_mark
  is '流向标志';
comment on column HF_HEAD_PRE.start_land
  is '起始地';
comment on column HF_HEAD_PRE.goal_land
  is '目的地';
comment on column HF_HEAD_PRE.car_no
  is '车牌号';
comment on column HF_HEAD_PRE.car_wt
  is '车自重';
comment on column HF_HEAD_PRE.ic_code
  is 'IC卡号';
comment on column HF_HEAD_PRE.gate_id
  is '采集号';
comment on column HF_HEAD_PRE.f_conta_no
  is '前箱号';
comment on column HF_HEAD_PRE.f_conta_type
  is '前箱型';
comment on column HF_HEAD_PRE.f_conta_wt
  is '前箱重';
comment on column HF_HEAD_PRE.a_conta_no
  is '后箱号';
comment on column HF_HEAD_PRE.a_conta_type
  is '后箱型';
comment on column HF_HEAD_PRE.a_conta_wt
  is '后箱重';
comment on column HF_HEAD_PRE.carframe_no
  is '车架号';
comment on column HF_HEAD_PRE.carframe_type
  is '车架类型';
comment on column HF_HEAD_PRE.carframe_wt
  is '车架重';
comment on column HF_HEAD_PRE.goods_wt
  is '货重';
comment on column HF_HEAD_PRE.fact_weight
  is '实际货重';
comment on column HF_HEAD_PRE.pack_no
  is '件数';
comment on column HF_HEAD_PRE.bill_no
  is '提运单号';
comment on column HF_HEAD_PRE.main_goods
  is '主要货物';
comment on column HF_HEAD_PRE.fit_mark
  is '查验标志';
comment on column HF_HEAD_PRE.b_status
  is '单证状态';
comment on column HF_HEAD_PRE.m_stauts
  is '人工操作状态';
comment on column HF_HEAD_PRE.port_status
  is '卡口状态';
comment on column HF_HEAD_PRE.area_code
  is '区域代码(当前用户中存储的区域代码)';
comment on column HF_HEAD_PRE.customs_code
  is '关区代码(当前用户中存储的区域代码)';
comment on column HF_HEAD_PRE.trade_code
  is '经营单位代码';
comment on column HF_HEAD_PRE.trade_name
  is '经营单位名称';
comment on column HF_HEAD_PRE.input_code
  is '录入单位代码';
comment on column HF_HEAD_PRE.input_name
  is '录入单位名称';
comment on column HF_HEAD_PRE.declare_code
  is '申报单位代码';
comment on column HF_HEAD_PRE.declare_name
  is '申报单位名称';
comment on column HF_HEAD_PRE.step_id
  is '当前环节';
comment on column HF_HEAD_PRE.pre_step_id
  is '前置环节';
comment on column HF_HEAD_PRE.oper_type
  is '操作类型(对应前置环节)';
comment on column HF_HEAD_PRE.oper_result
  is '操作结果(对应前置环节)';
comment on column HF_HEAD_PRE.create_person
  is '创建人';
comment on column HF_HEAD_PRE.create_date
  is '创建时间';
comment on column HF_HEAD_PRE.declare_person
  is '申报人';
comment on column HF_HEAD_PRE.declare_date
  is '申报时间';
comment on column HF_HEAD_PRE.approve_person
  is '审批人';
comment on column HF_HEAD_PRE.approve_date
  is '审批时间';
comment on column HF_HEAD_PRE.oper_person
  is '岗位操作人';
comment on column HF_HEAD_PRE.oper_date
  is '岗位分配时间';
comment on column HF_HEAD_PRE.outer_comment
  is '外部审批意见';
comment on column HF_HEAD_PRE.inner_comment
  is '内部审批意见';
comment on column HF_HEAD_PRE.plat_no
  is '平台代码';
comment on column HF_HEAD_PRE.work_no
  is '预申请单号';
comment on column HF_HEAD_PRE.note
  is '备注';
comment on column HF_HEAD_PRE.port_date
  is '过卡口日期';
comment on column HF_HEAD_PRE.double_random
  is '是否双随机';
comment on column HF_HEAD_PRE.car_ec_no
  is '关锁号/施封号';
comment on column HF_HEAD_PRE.car_dec_no
  is '电子关锁号';
comment on column HF_HEAD_PRE.fill_in
  is '补录入标志   1：已补录入,0：未补录入';
comment on column HF_HEAD_PRE.zs_flag
  is '打印扫描状态';
comment on column HF_HEAD_PRE.bat_id
  is '打印生成批次号,  金二核放单号, 用于广西一纳非保税拼车核放单';
comment on column HF_HEAD_PRE.template_id
  is '业务模板ID';
comment on column HF_HEAD_PRE.owner_name
  is '货主名称';
comment on column HF_HEAD_PRE.transport_name
  is '运输企业名称';
comment on column HF_HEAD_PRE.driver
  is '司机';
comment on column HF_HEAD_PRE.driver_phone
  is '司机电话';
comment on column HF_HEAD_PRE.custdecl
  is '报关员名称';
comment on column HF_HEAD_PRE.custdecl_phone
  is '报关员电话';
comment on column HF_HEAD_PRE.entry_id
  is '报关单号或相应审批单号';
-- Create/Recreate indexes 
create index IDX_HF_HEAD_PRE_BIZ_MODE on HF_HEAD_PRE (BIZ_MODE)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_HF_HEAD_PRE_BIZ_TYPE on HF_HEAD_PRE (BIZ_TYPE)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_HF_HEAD_PRE_GOAL_LAND on HF_HEAD_PRE (GOAL_LAND)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_HF_HEAD_PRE_IC_CODE on HF_HEAD_PRE (IC_CODE)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_HF_HEAD_PRE_START_LAND on HF_HEAD_PRE (START_LAND)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table HF_HEAD_PRE
  add constraint PK_HF_HEAD_PRE primary key (DISCHARGED_NO)
  using index 
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
