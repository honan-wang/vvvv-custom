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
  is '�˷ŵ���ͷ';
-- Add comments to the columns 
comment on column HF_HEAD_PRE.discharged_no
  is '�˷ŵ���';
comment on column HF_HEAD_PRE.biz_type
  is 'ҵ������';
comment on column HF_HEAD_PRE.biz_mode
  is 'ҵ��ģʽ';
comment on column HF_HEAD_PRE.i_e_mark
  is '�����־';
comment on column HF_HEAD_PRE.start_land
  is '��ʼ��';
comment on column HF_HEAD_PRE.goal_land
  is 'Ŀ�ĵ�';
comment on column HF_HEAD_PRE.car_no
  is '���ƺ�';
comment on column HF_HEAD_PRE.car_wt
  is '������';
comment on column HF_HEAD_PRE.ic_code
  is 'IC����';
comment on column HF_HEAD_PRE.gate_id
  is '�ɼ���';
comment on column HF_HEAD_PRE.f_conta_no
  is 'ǰ���';
comment on column HF_HEAD_PRE.f_conta_type
  is 'ǰ����';
comment on column HF_HEAD_PRE.f_conta_wt
  is 'ǰ����';
comment on column HF_HEAD_PRE.a_conta_no
  is '�����';
comment on column HF_HEAD_PRE.a_conta_type
  is '������';
comment on column HF_HEAD_PRE.a_conta_wt
  is '������';
comment on column HF_HEAD_PRE.carframe_no
  is '���ܺ�';
comment on column HF_HEAD_PRE.carframe_type
  is '��������';
comment on column HF_HEAD_PRE.carframe_wt
  is '������';
comment on column HF_HEAD_PRE.goods_wt
  is '����';
comment on column HF_HEAD_PRE.fact_weight
  is 'ʵ�ʻ���';
comment on column HF_HEAD_PRE.pack_no
  is '����';
comment on column HF_HEAD_PRE.bill_no
  is '���˵���';
comment on column HF_HEAD_PRE.main_goods
  is '��Ҫ����';
comment on column HF_HEAD_PRE.fit_mark
  is '�����־';
comment on column HF_HEAD_PRE.b_status
  is '��֤״̬';
comment on column HF_HEAD_PRE.m_stauts
  is '�˹�����״̬';
comment on column HF_HEAD_PRE.port_status
  is '����״̬';
comment on column HF_HEAD_PRE.area_code
  is '�������(��ǰ�û��д洢���������)';
comment on column HF_HEAD_PRE.customs_code
  is '��������(��ǰ�û��д洢���������)';
comment on column HF_HEAD_PRE.trade_code
  is '��Ӫ��λ����';
comment on column HF_HEAD_PRE.trade_name
  is '��Ӫ��λ����';
comment on column HF_HEAD_PRE.input_code
  is '¼�뵥λ����';
comment on column HF_HEAD_PRE.input_name
  is '¼�뵥λ����';
comment on column HF_HEAD_PRE.declare_code
  is '�걨��λ����';
comment on column HF_HEAD_PRE.declare_name
  is '�걨��λ����';
comment on column HF_HEAD_PRE.step_id
  is '��ǰ����';
comment on column HF_HEAD_PRE.pre_step_id
  is 'ǰ�û���';
comment on column HF_HEAD_PRE.oper_type
  is '��������(��Ӧǰ�û���)';
comment on column HF_HEAD_PRE.oper_result
  is '�������(��Ӧǰ�û���)';
comment on column HF_HEAD_PRE.create_person
  is '������';
comment on column HF_HEAD_PRE.create_date
  is '����ʱ��';
comment on column HF_HEAD_PRE.declare_person
  is '�걨��';
comment on column HF_HEAD_PRE.declare_date
  is '�걨ʱ��';
comment on column HF_HEAD_PRE.approve_person
  is '������';
comment on column HF_HEAD_PRE.approve_date
  is '����ʱ��';
comment on column HF_HEAD_PRE.oper_person
  is '��λ������';
comment on column HF_HEAD_PRE.oper_date
  is '��λ����ʱ��';
comment on column HF_HEAD_PRE.outer_comment
  is '�ⲿ�������';
comment on column HF_HEAD_PRE.inner_comment
  is '�ڲ��������';
comment on column HF_HEAD_PRE.plat_no
  is 'ƽ̨����';
comment on column HF_HEAD_PRE.work_no
  is 'Ԥ���뵥��';
comment on column HF_HEAD_PRE.note
  is '��ע';
comment on column HF_HEAD_PRE.port_date
  is '����������';
comment on column HF_HEAD_PRE.double_random
  is '�Ƿ�˫���';
comment on column HF_HEAD_PRE.car_ec_no
  is '������/ʩ���';
comment on column HF_HEAD_PRE.car_dec_no
  is '���ӹ�����';
comment on column HF_HEAD_PRE.fill_in
  is '��¼���־   1���Ѳ�¼��,0��δ��¼��';
comment on column HF_HEAD_PRE.zs_flag
  is '��ӡɨ��״̬';
comment on column HF_HEAD_PRE.bat_id
  is '��ӡ�������κ�,  ����˷ŵ���, ���ڹ���һ�ɷǱ�˰ƴ���˷ŵ�';
comment on column HF_HEAD_PRE.template_id
  is 'ҵ��ģ��ID';
comment on column HF_HEAD_PRE.owner_name
  is '��������';
comment on column HF_HEAD_PRE.transport_name
  is '������ҵ����';
comment on column HF_HEAD_PRE.driver
  is '˾��';
comment on column HF_HEAD_PRE.driver_phone
  is '˾���绰';
comment on column HF_HEAD_PRE.custdecl
  is '����Ա����';
comment on column HF_HEAD_PRE.custdecl_phone
  is '����Ա�绰';
comment on column HF_HEAD_PRE.entry_id
  is '���ص��Ż���Ӧ��������';
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
