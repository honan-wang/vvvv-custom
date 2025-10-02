-- Create table
create table FBG_HEAD_PRE
(
  gatejob_no     VARCHAR2(50) not null,
  gatepass_no    VARCHAR2(50),
  biz_type       VARCHAR2(10),
  biz_mode       VARCHAR2(10),
  i_e_mark       VARCHAR2(1),
  goods_flow     VARCHAR2(20),
  transfer_mode  VARCHAR2(1),
  ems_no         VARCHAR2(20),
  guarante_type  VARCHAR2(1),
  guarante_id    VARCHAR2(50),
  guarante_no    VARCHAR2(200),
  guarante_desc  VARCHAR2(500),
  guarante_price NUMBER(18,5),
  correspond_no  VARCHAR2(50),
  gross_weight   NUMBER(18,5),
  net_weight     NUMBER(18,5),
  pack_no        NUMBER(18,5),
  pack_type      VARCHAR2(1),
  m_p            VARCHAR2(1),
  provider_code  VARCHAR2(20),
  provider_name  VARCHAR2(200),
  owner_code     VARCHAR2(20),
  owner_name     VARCHAR2(200),
  trade_mode     VARCHAR2(4),
  bond_flag      VARCHAR2(1),
  materiel_type  VARCHAR2(50),
  license_plate  VARCHAR2(100),
  port_status    VARCHAR2(20) default 'K501',
  comp_status    VARCHAR2(10),
  comp_info      VARCHAR2(1000),
  area_code      VARCHAR2(10) not null,
  customs_code   VARCHAR2(10) not null,
  trade_code     VARCHAR2(20) not null,
  trade_name     VARCHAR2(200) not null,
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
  oper_person    VARCHAR2(40) default '0',
  oper_date      DATE,
  outer_comment  VARCHAR2(500),
  inner_comment  VARCHAR2(500),
  plat_no        VARCHAR2(10),
  work_no        VARCHAR2(50),
  note           VARCHAR2(2000),
  port_date      DATE,
  tradecodescc   VARCHAR2(18),
  agentcodescc   VARCHAR2(18),
  ownercodescc   VARCHAR2(18),
  copcodescc     VARCHAR2(18),
  promiseitmes   VARCHAR2(32),
  tradeareacode  VARCHAR2(32),
  zs_flag        VARCHAR2(10) default 'A001',
  bat_id         VARCHAR2(50)
)
tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 3M
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table FBG_HEAD_PRE
  is '���ڵǼ����뵥��ͷ-�����';
-- Add comments to the columns 
comment on column FBG_HEAD_PRE.gatejob_no
  is '���뵥��';
comment on column FBG_HEAD_PRE.gatepass_no
  is '������';
comment on column FBG_HEAD_PRE.biz_type
  is 'ҵ������';
comment on column FBG_HEAD_PRE.biz_mode
  is 'ҵ��ģʽ';
comment on column FBG_HEAD_PRE.i_e_mark
  is '�����־';
comment on column FBG_HEAD_PRE.goods_flow
  is '��������';
comment on column FBG_HEAD_PRE.transfer_mode
  is '������ת��ʽ';
comment on column FBG_HEAD_PRE.ems_no
  is 'ƽ̨�˲��';
comment on column FBG_HEAD_PRE.guarante_type
  is '��������';
comment on column FBG_HEAD_PRE.guarante_id
  is '����ϵͳ���';
comment on column FBG_HEAD_PRE.guarante_no
  is '�������';
comment on column FBG_HEAD_PRE.guarante_desc
  is '��������';
comment on column FBG_HEAD_PRE.guarante_price
  is '�������';
comment on column FBG_HEAD_PRE.correspond_no
  is '�������뵥��';
comment on column FBG_HEAD_PRE.gross_weight
  is 'ë��';
comment on column FBG_HEAD_PRE.net_weight
  is '����';
comment on column FBG_HEAD_PRE.pack_no
  is '����';
comment on column FBG_HEAD_PRE.pack_type
  is '��װ����';
comment on column FBG_HEAD_PRE.m_p
  is '�ϼ�����';
comment on column FBG_HEAD_PRE.provider_code
  is '���̴���';
comment on column FBG_HEAD_PRE.provider_name
  is '��������';
comment on column FBG_HEAD_PRE.owner_code
  is '��Ȩ��ҵ����';
comment on column FBG_HEAD_PRE.owner_name
  is '��Ȩ��ҵ����';
comment on column FBG_HEAD_PRE.trade_mode
  is 'ó�׷�ʽ';
comment on column FBG_HEAD_PRE.bond_flag
  is '�Ƿ�˰';
comment on column FBG_HEAD_PRE.materiel_type
  is '��������';
comment on column FBG_HEAD_PRE.license_plate
  is '���˳���';
comment on column FBG_HEAD_PRE.port_status
  is '����״̬';
comment on column FBG_HEAD_PRE.comp_status
  is '�ȶ�״̬';
comment on column FBG_HEAD_PRE.comp_info
  is '�ȶԽ��';
comment on column FBG_HEAD_PRE.area_code
  is '�������(��ǰ�û��д洢���������)';
comment on column FBG_HEAD_PRE.customs_code
  is '��������(��ǰ�û��д洢���������)';
comment on column FBG_HEAD_PRE.trade_code
  is '��Ӫ��λ����';
comment on column FBG_HEAD_PRE.trade_name
  is '��Ӫ��λ����';
comment on column FBG_HEAD_PRE.input_code
  is '¼�뵥λ����';
comment on column FBG_HEAD_PRE.input_name
  is '¼�뵥λ����';
comment on column FBG_HEAD_PRE.declare_code
  is '�걨��λ����';
comment on column FBG_HEAD_PRE.declare_name
  is '�걨��λ����';
comment on column FBG_HEAD_PRE.step_id
  is '��ǰ����';
comment on column FBG_HEAD_PRE.pre_step_id
  is 'ǰ�û���';
comment on column FBG_HEAD_PRE.oper_type
  is '��������(��Ӧǰ�û���)';
comment on column FBG_HEAD_PRE.oper_result
  is '�������(��Ӧǰ�û���)';
comment on column FBG_HEAD_PRE.create_person
  is '������';
comment on column FBG_HEAD_PRE.create_date
  is '����ʱ��';
comment on column FBG_HEAD_PRE.declare_person
  is '�걨��';
comment on column FBG_HEAD_PRE.declare_date
  is '�걨ʱ��';
comment on column FBG_HEAD_PRE.approve_person
  is '������';
comment on column FBG_HEAD_PRE.approve_date
  is '����ʱ��';
comment on column FBG_HEAD_PRE.oper_person
  is '��λ������';
comment on column FBG_HEAD_PRE.oper_date
  is '��λ����ʱ��';
comment on column FBG_HEAD_PRE.outer_comment
  is '�ⲿ�������';
comment on column FBG_HEAD_PRE.inner_comment
  is '�ڲ��������';
comment on column FBG_HEAD_PRE.plat_no
  is 'ƽ̨����';
comment on column FBG_HEAD_PRE.work_no
  is 'Ԥ���뵥��';
comment on column FBG_HEAD_PRE.note
  is '��ע';
comment on column FBG_HEAD_PRE.port_date
  is '����������';
comment on column FBG_HEAD_PRE.tradecodescc
  is '��Ӫ��λͳһ����';
comment on column FBG_HEAD_PRE.agentcodescc
  is '�걨����ͳһ����';
comment on column FBG_HEAD_PRE.ownercodescc
  is '������λͳһ����';
comment on column FBG_HEAD_PRE.copcodescc
  is '¼�뵥λͳһ����';
comment on column FBG_HEAD_PRE.promiseitmes
  is '��ŵ����';
comment on column FBG_HEAD_PRE.tradeareacode
  is 'ó�׹���';
comment on column FBG_HEAD_PRE.zs_flag
  is '��ӡɨ��״̬';
comment on column FBG_HEAD_PRE.bat_id
  is '��ӡ�������κ�';
-- Create/Recreate indexes 
create index IDX_FBGHEADPRE_STEPID on FBG_HEAD_PRE (STEP_ID)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_FBG_HEAD_PRE_02 on FBG_HEAD_PRE (BIZ_TYPE, BIZ_MODE, I_E_MARK, STEP_ID)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 181M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_FBG_HEAD_PRE_BIZ_MODE on FBG_HEAD_PRE (BIZ_MODE)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_FBG_HEAD_PRE_CORRESPOND_NO on FBG_HEAD_PRE (CORRESPOND_NO)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 30M
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_FBG_HEAD_PRE_DECLARE_DATE on FBG_HEAD_PRE (DECLARE_DATE)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_FBG_HEAD_PRE_GATEPASSNO on FBG_HEAD_PRE (GATEPASS_NO)
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
create index IDX_FBG_HEAD_PRE_GUARANTEID on FBG_HEAD_PRE (GUARANTE_ID)
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
create index IDX_FBG_HEAD_PRE_TRADE on FBG_HEAD_PRE (TRADE_CODE)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table FBG_HEAD_PRE
  add constraint PK_FBG_HEAD_PRE primary key (GATEJOB_NO)
  using index 
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 768K
    next 1M
    minextents 1
    maxextents unlimited
  );
