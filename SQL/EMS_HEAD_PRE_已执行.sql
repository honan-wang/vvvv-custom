-- Create table
create table EMS_HEAD_PRE
(
  pre_no           VARCHAR2(50) not null,
  ems_no           VARCHAR2(64),
  h_ems_no         VARCHAR2(20),
  ems_type         VARCHAR2(1),
  ems_class        VARCHAR2(1),
  ems_attribute    VARCHAR2(10),
  ems_flag         VARCHAR2(10),
  trade_code       VARCHAR2(20),
  trade_name       VARCHAR2(200),
  owner_code       VARCHAR2(20),
  owner_name       VARCHAR2(100),
  declare_code     VARCHAR2(20),
  declare_name     VARCHAR2(200),
  district_code    VARCHAR2(5),
  trade_mode       VARCHAR2(4),
  cut_mode         VARCHAR2(4),
  master_ftc       VARCHAR2(6),
  manage_object    VARCHAR2(1),
  modify_mark      VARCHAR2(1),
  equip_mode       VARCHAR2(1),
  end_date         DATE,
  modify_times     NUMBER(19),
  hchx_suject      VARCHAR2(4),
  hchx_type        VARCHAR2(4),
  hchx_cycle       NUMBER(19),
  hchx_sdate       DATE,
  hchx_edate       DATE,
  hchx_stockdate   DATE,
  area_code        VARCHAR2(10),
  customs_code     VARCHAR2(10),
  input_code       VARCHAR2(20) not null,
  input_name       VARCHAR2(200) not null,
  step_id          VARCHAR2(20) not null,
  pre_step_id      VARCHAR2(20),
  oper_type        VARCHAR2(10),
  oper_result      VARCHAR2(10),
  create_person    VARCHAR2(40) not null,
  create_date      DATE not null,
  declare_person   VARCHAR2(40),
  declare_date     DATE,
  approve_person   VARCHAR2(40),
  approve_date     DATE,
  oper_person      VARCHAR2(40) default '0',
  oper_date        DATE,
  outer_comment    VARCHAR2(500),
  inner_comment    VARCHAR2(500),
  used_flag        VARCHAR2(1) default '1',
  used_flag_reason VARCHAR2(500),
  plat_no          VARCHAR2(10),
  work_no          VARCHAR2(50),
  note             VARCHAR2(500),
  qp_status        VARCHAR2(10),
  contr_in         VARCHAR2(20),
  note_1           VARCHAR2(20),
  produce_type     VARCHAR2(4),
  appr_img_amt     NUMBER(19,5),
  appr_exg_amt     NUMBER(19,5),
  ex_curr          VARCHAR2(4),
  im_curr          VARCHAR2(4),
  cop_ems_no       VARCHAR2(20),
  ems_appr_no      VARCHAR2(50),
  foreign_co_name  VARCHAR2(1200),
  img_amount       NUMBER(19,5),
  exg_amount       NUMBER(19,5),
  img_items        NUMBER(19),
  exg_items        NUMBER(19),
  contr_out        VARCHAR2(32),
  agree_no         VARCHAR2(32),
  pay_mode         VARCHAR2(1),
  input_er         VARCHAR2(10),
  store_vol        NUMBER(19,5),
  store_area       NUMBER(19,5),
  product_ratio    NUMBER(19,5),
  note_amount      NUMBER(19,5),
  foreign_mgr      VARCHAR2(32),
  in_ratio         NUMBER(19,4),
  trans_mode       VARCHAR2(1),
  trade_country    VARCHAR2(3),
  license_no       VARCHAR2(20),
  i_e_port         VARCHAR2(1200),
  declare_type     VARCHAR2(1)
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
comment on table EMS_HEAD_PRE
  is '归并关系-账册表头-业务表';
-- Add comments to the columns 
comment on column EMS_HEAD_PRE.pre_no
  is '预录入号';
comment on column EMS_HEAD_PRE.ems_no
  is '平台账册号';
comment on column EMS_HEAD_PRE.h_ems_no
  is 'H2010账册编号';
comment on column EMS_HEAD_PRE.ems_type
  is '账册类型：3-出口加工区加工企业、4-出口加工区仓储企业';
comment on column EMS_HEAD_PRE.ems_class
  is '账册种类：1-仓储类、2-加工类、3-研发类、4-维修类、5-设备类
';
comment on column EMS_HEAD_PRE.ems_attribute
  is '账册属性：记账式、备案式';
comment on column EMS_HEAD_PRE.ems_flag
  is '账册标识：料号类、项号类、单耗类';
comment on column EMS_HEAD_PRE.trade_code
  is '经营单位代码';
comment on column EMS_HEAD_PRE.trade_name
  is '经营单位名称';
comment on column EMS_HEAD_PRE.owner_code
  is '加工单位';
comment on column EMS_HEAD_PRE.owner_name
  is '加工单位名称';
comment on column EMS_HEAD_PRE.declare_code
  is '申请单位代码';
comment on column EMS_HEAD_PRE.declare_name
  is '申请单位名称';
comment on column EMS_HEAD_PRE.district_code
  is '地区代码';
comment on column EMS_HEAD_PRE.trade_mode
  is '贸易方式';
comment on column EMS_HEAD_PRE.cut_mode
  is '征免性质';
comment on column EMS_HEAD_PRE.master_ftc
  is '主管外经贸';
comment on column EMS_HEAD_PRE.manage_object
  is '管理对象';
comment on column EMS_HEAD_PRE.modify_mark
  is '修改标志';
comment on column EMS_HEAD_PRE.equip_mode
  is '单耗申报环节';
comment on column EMS_HEAD_PRE.end_date
  is '结束有效期';
comment on column EMS_HEAD_PRE.modify_times
  is '变更次数';
comment on column EMS_HEAD_PRE.hchx_suject
  is '核算主体';
comment on column EMS_HEAD_PRE.hchx_type
  is '核算方式';
comment on column EMS_HEAD_PRE.hchx_cycle
  is '核算周期';
comment on column EMS_HEAD_PRE.hchx_sdate
  is '核算开始日期';
comment on column EMS_HEAD_PRE.hchx_edate
  is '核算结束日期';
comment on column EMS_HEAD_PRE.hchx_stockdate
  is '库存申报日期';
comment on column EMS_HEAD_PRE.area_code
  is '区域代码(当前用户中存储的区域代码)';
comment on column EMS_HEAD_PRE.customs_code
  is '主管海关';
comment on column EMS_HEAD_PRE.input_code
  is '录入单位代码';
comment on column EMS_HEAD_PRE.input_name
  is '录入单位名称';
comment on column EMS_HEAD_PRE.step_id
  is '当前环节';
comment on column EMS_HEAD_PRE.pre_step_id
  is '前置环节';
comment on column EMS_HEAD_PRE.oper_type
  is '操作类型(对应前置环节)';
comment on column EMS_HEAD_PRE.oper_result
  is '操作结果(对应前置环节)';
comment on column EMS_HEAD_PRE.create_person
  is '创建人';
comment on column EMS_HEAD_PRE.create_date
  is '创建时间';
comment on column EMS_HEAD_PRE.declare_person
  is '申报人';
comment on column EMS_HEAD_PRE.declare_date
  is '申报时间';
comment on column EMS_HEAD_PRE.approve_person
  is '审批人';
comment on column EMS_HEAD_PRE.approve_date
  is '审批时间';
comment on column EMS_HEAD_PRE.oper_person
  is '岗位操作人';
comment on column EMS_HEAD_PRE.oper_date
  is '岗位分配时间';
comment on column EMS_HEAD_PRE.outer_comment
  is '外部审批意见';
comment on column EMS_HEAD_PRE.inner_comment
  is '内部审批意见';
comment on column EMS_HEAD_PRE.used_flag
  is '启用/停用：1-启用，0-停用';
comment on column EMS_HEAD_PRE.used_flag_reason
  is '启用/停用原因';
comment on column EMS_HEAD_PRE.plat_no
  is '平台代码';
comment on column EMS_HEAD_PRE.work_no
  is '预申请单号';
comment on column EMS_HEAD_PRE.note
  is '备注';
comment on column EMS_HEAD_PRE.qp_status
  is 'TCS状态';
comment on column EMS_HEAD_PRE.contr_in
  is '进口合同（TCS）';
comment on column EMS_HEAD_PRE.note_1
  is '备用标志1（TCS）';
comment on column EMS_HEAD_PRE.produce_type
  is '加工种类（TCS）';
comment on column EMS_HEAD_PRE.appr_img_amt
  is '备案进口总额（TCS）';
comment on column EMS_HEAD_PRE.appr_exg_amt
  is '备案进口总额（TCS）';
comment on column EMS_HEAD_PRE.ex_curr
  is '出口币制（TCS）';
comment on column EMS_HEAD_PRE.im_curr
  is '进口币制（TCS）';
comment on column EMS_HEAD_PRE.cop_ems_no
  is '企业内部编号';
comment on column EMS_HEAD_PRE.ems_appr_no
  is '批准证编号';
comment on column EMS_HEAD_PRE.foreign_co_name
  is '外商公司';
comment on column EMS_HEAD_PRE.img_amount
  is '进口总金额';
comment on column EMS_HEAD_PRE.exg_amount
  is '出口总金额';
comment on column EMS_HEAD_PRE.img_items
  is '进口货物项数';
comment on column EMS_HEAD_PRE.exg_items
  is '出口货物项数';
comment on column EMS_HEAD_PRE.contr_out
  is '出口合同号';
comment on column EMS_HEAD_PRE.agree_no
  is '协议号';
comment on column EMS_HEAD_PRE.pay_mode
  is '保税方式';
comment on column EMS_HEAD_PRE.input_er
  is '录入员代号';
comment on column EMS_HEAD_PRE.store_vol
  is '仓库体积';
comment on column EMS_HEAD_PRE.store_area
  is '仓库面积';
comment on column EMS_HEAD_PRE.product_ratio
  is '生产能力';
comment on column EMS_HEAD_PRE.note_amount
  is '备用金额';
comment on column EMS_HEAD_PRE.foreign_mgr
  is '外商经理人';
comment on column EMS_HEAD_PRE.in_ratio
  is '内销比率';
comment on column EMS_HEAD_PRE.trans_mode
  is '成交方式';
comment on column EMS_HEAD_PRE.trade_country
  is '起抵地';
comment on column EMS_HEAD_PRE.license_no
  is '许可证编号';
comment on column EMS_HEAD_PRE.i_e_port
  is '进出口岸';
comment on column EMS_HEAD_PRE.declare_type
  is '申报类型';
-- Create/Recreate indexes 
create index IDX_EMS_HEAD_PRE_EMS_NO on EMS_HEAD_PRE (EMS_NO)
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
create index IDX_EMS_HEAD_PRE_WORK_NO on EMS_HEAD_PRE (WORK_NO)
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
alter table EMS_HEAD_PRE
  add constraint PK_EMS_HEAD_PRE primary key (PRE_NO)
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
