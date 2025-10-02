-- Create table
create table EMS_AEXG_PRE
(
  auto_id              VARCHAR2(50) not null,
  pre_no               VARCHAR2(50) not null,
  ems_no               VARCHAR2(20),
  g_no                 NUMBER(19),
  code_ts              VARCHAR2(13),
  g_name               VARCHAR2(500),
  g_model              VARCHAR2(1000),
  unit                 VARCHAR2(4),
  unit_1               VARCHAR2(4),
  unit_2               VARCHAR2(4),
  country_code         VARCHAR2(4),
  use_to               VARCHAR2(4),
  duty_mode            VARCHAR2(4),
  dec_price            NUMBER(18,5),
  curr                 VARCHAR2(3),
  factor_1             NUMBER(18,9),
  factor_2             NUMBER(18,9),
  first_qty            NUMBER(18,5),
  in_qty               NUMBER(18,5),
  out_qty              NUMBER(18,5),
  modify_mark          VARCHAR2(1),
  materials_flag       VARCHAR2(1),
  materials_use        VARCHAR2(1),
  materials_properties VARCHAR2(1),
  duty_rate            NUMBER(3),
  belong               VARCHAR2(1),
  send_flag            VARCHAR2(1),
  step_id              VARCHAR2(20) not null,
  pre_step_id          VARCHAR2(20),
  oper_type            VARCHAR2(10),
  oper_result          VARCHAR2(10),
  create_person        VARCHAR2(40) not null,
  create_date          DATE not null,
  declare_person       VARCHAR2(40),
  declare_date         DATE,
  approve_person       VARCHAR2(40),
  approve_date         DATE,
  oper_person          VARCHAR2(40) default '0',
  oper_date            DATE,
  outer_comment        VARCHAR2(500),
  inner_comment        VARCHAR2(500),
  modify_times         NUMBER(19),
  used_flag            VARCHAR2(1) default '1',
  used_flag_reason     VARCHAR2(500),
  note                 VARCHAR2(500),
  goods_form           VARCHAR2(1),
  qp_status            VARCHAR2(10),
  cop_ems_no           VARCHAR2(20),
  dec_price_rmb        NUMBER(19,4),
  qty                  NUMBER(19,5),
  max_qty              NUMBER(19,5),
  class_note           VARCHAR2(2000),
  factor_wt            NUMBER(18,9),
  qp_modify_mark       VARCHAR2(1),
  kctz                 NUMBER(18,5)
)
tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 6M
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table EMS_AEXG_PRE
  is '归并关系-归并后成品-业务表';
-- Add comments to the columns 
comment on column EMS_AEXG_PRE.auto_id
  is '自动编号';
comment on column EMS_AEXG_PRE.pre_no
  is '预录入号';
comment on column EMS_AEXG_PRE.ems_no
  is '平台账册号';
comment on column EMS_AEXG_PRE.g_no
  is '项号';
comment on column EMS_AEXG_PRE.code_ts
  is '商品编号';
comment on column EMS_AEXG_PRE.g_name
  is '商品名称';
comment on column EMS_AEXG_PRE.g_model
  is '规格型号';
comment on column EMS_AEXG_PRE.unit
  is '申报计量单位';
comment on column EMS_AEXG_PRE.unit_1
  is '法定计量单位';
comment on column EMS_AEXG_PRE.unit_2
  is '法定第二单位';
comment on column EMS_AEXG_PRE.country_code
  is '产销国';
comment on column EMS_AEXG_PRE.use_to
  is '用途';
comment on column EMS_AEXG_PRE.duty_mode
  is '征免方式';
comment on column EMS_AEXG_PRE.dec_price
  is '申报单价';
comment on column EMS_AEXG_PRE.curr
  is '币制';
comment on column EMS_AEXG_PRE.factor_1
  is '法定计量单位比例因子';
comment on column EMS_AEXG_PRE.factor_2
  is '第二法定计量单位比例因子';
comment on column EMS_AEXG_PRE.first_qty
  is '期初库存';
comment on column EMS_AEXG_PRE.in_qty
  is '进区数量';
comment on column EMS_AEXG_PRE.out_qty
  is '出区数量';
comment on column EMS_AEXG_PRE.modify_mark
  is '处理标志';
comment on column EMS_AEXG_PRE.materials_flag
  is '主料标识';
comment on column EMS_AEXG_PRE.materials_use
  is '物料用途';
comment on column EMS_AEXG_PRE.materials_properties
  is '物料性质';
comment on column EMS_AEXG_PRE.duty_rate
  is '非保税料件比例';
comment on column EMS_AEXG_PRE.belong
  is '归属：区内、区外';
comment on column EMS_AEXG_PRE.send_flag
  is '操作标识';
comment on column EMS_AEXG_PRE.step_id
  is '当前环节';
comment on column EMS_AEXG_PRE.pre_step_id
  is '前置环节';
comment on column EMS_AEXG_PRE.oper_type
  is '操作类型(对应前置环节)';
comment on column EMS_AEXG_PRE.oper_result
  is '操作结果(对应前置环节)';
comment on column EMS_AEXG_PRE.create_person
  is '创建人';
comment on column EMS_AEXG_PRE.create_date
  is '创建时间';
comment on column EMS_AEXG_PRE.declare_person
  is '申报人';
comment on column EMS_AEXG_PRE.declare_date
  is '申报时间';
comment on column EMS_AEXG_PRE.approve_person
  is '审批人';
comment on column EMS_AEXG_PRE.approve_date
  is '审批时间';
comment on column EMS_AEXG_PRE.oper_person
  is '岗位操作人';
comment on column EMS_AEXG_PRE.oper_date
  is '岗位分配时间';
comment on column EMS_AEXG_PRE.outer_comment
  is '外部审批意见';
comment on column EMS_AEXG_PRE.inner_comment
  is '内部审批意见';
comment on column EMS_AEXG_PRE.modify_times
  is '变更次数';
comment on column EMS_AEXG_PRE.used_flag
  is '启用/停用：1-启用，0-停用';
comment on column EMS_AEXG_PRE.used_flag_reason
  is '启用/停用原因';
comment on column EMS_AEXG_PRE.note
  is '备注';
comment on column EMS_AEXG_PRE.goods_form
  is '货物形态';
comment on column EMS_AEXG_PRE.qp_status
  is 'TCS状态';
comment on column EMS_AEXG_PRE.cop_ems_no
  is '企业内部编号';
comment on column EMS_AEXG_PRE.dec_price_rmb
  is '申报单价RMB';
comment on column EMS_AEXG_PRE.qty
  is '申报数量';
comment on column EMS_AEXG_PRE.max_qty
  is '批准最大余量';
comment on column EMS_AEXG_PRE.class_note
  is '归类说明';
comment on column EMS_AEXG_PRE.factor_wt
  is '重量单位比例';
comment on column EMS_AEXG_PRE.qp_modify_mark
  is 'QP处理标志';
-- Create/Recreate indexes 
create index IDX_EMS_AEXG_PRE_EMS_NO on EMS_AEXG_PRE (EMS_NO)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 896K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_EMS_AEXG_PRE_G_NO on EMS_AEXG_PRE (G_NO)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 512K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_EMS_AEXG_PRE_PRE_NO on EMS_AEXG_PRE (PRE_NO)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_EMS_AEXG_PRE_STEP_ID on EMS_AEXG_PRE (STEP_ID)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 640K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table EMS_AEXG_PRE
  add constraint PK_EMS_AEXG_PRE primary key (AUTO_ID)
  using index 
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
