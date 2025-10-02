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
  is '�鲢��ϵ-�鲢���Ʒ-ҵ���';
-- Add comments to the columns 
comment on column EMS_AEXG_PRE.auto_id
  is '�Զ����';
comment on column EMS_AEXG_PRE.pre_no
  is 'Ԥ¼���';
comment on column EMS_AEXG_PRE.ems_no
  is 'ƽ̨�˲��';
comment on column EMS_AEXG_PRE.g_no
  is '���';
comment on column EMS_AEXG_PRE.code_ts
  is '��Ʒ���';
comment on column EMS_AEXG_PRE.g_name
  is '��Ʒ����';
comment on column EMS_AEXG_PRE.g_model
  is '����ͺ�';
comment on column EMS_AEXG_PRE.unit
  is '�걨������λ';
comment on column EMS_AEXG_PRE.unit_1
  is '����������λ';
comment on column EMS_AEXG_PRE.unit_2
  is '�����ڶ���λ';
comment on column EMS_AEXG_PRE.country_code
  is '������';
comment on column EMS_AEXG_PRE.use_to
  is '��;';
comment on column EMS_AEXG_PRE.duty_mode
  is '���ⷽʽ';
comment on column EMS_AEXG_PRE.dec_price
  is '�걨����';
comment on column EMS_AEXG_PRE.curr
  is '����';
comment on column EMS_AEXG_PRE.factor_1
  is '����������λ��������';
comment on column EMS_AEXG_PRE.factor_2
  is '�ڶ�����������λ��������';
comment on column EMS_AEXG_PRE.first_qty
  is '�ڳ����';
comment on column EMS_AEXG_PRE.in_qty
  is '��������';
comment on column EMS_AEXG_PRE.out_qty
  is '��������';
comment on column EMS_AEXG_PRE.modify_mark
  is '�����־';
comment on column EMS_AEXG_PRE.materials_flag
  is '���ϱ�ʶ';
comment on column EMS_AEXG_PRE.materials_use
  is '������;';
comment on column EMS_AEXG_PRE.materials_properties
  is '��������';
comment on column EMS_AEXG_PRE.duty_rate
  is '�Ǳ�˰�ϼ�����';
comment on column EMS_AEXG_PRE.belong
  is '���������ڡ�����';
comment on column EMS_AEXG_PRE.send_flag
  is '������ʶ';
comment on column EMS_AEXG_PRE.step_id
  is '��ǰ����';
comment on column EMS_AEXG_PRE.pre_step_id
  is 'ǰ�û���';
comment on column EMS_AEXG_PRE.oper_type
  is '��������(��Ӧǰ�û���)';
comment on column EMS_AEXG_PRE.oper_result
  is '�������(��Ӧǰ�û���)';
comment on column EMS_AEXG_PRE.create_person
  is '������';
comment on column EMS_AEXG_PRE.create_date
  is '����ʱ��';
comment on column EMS_AEXG_PRE.declare_person
  is '�걨��';
comment on column EMS_AEXG_PRE.declare_date
  is '�걨ʱ��';
comment on column EMS_AEXG_PRE.approve_person
  is '������';
comment on column EMS_AEXG_PRE.approve_date
  is '����ʱ��';
comment on column EMS_AEXG_PRE.oper_person
  is '��λ������';
comment on column EMS_AEXG_PRE.oper_date
  is '��λ����ʱ��';
comment on column EMS_AEXG_PRE.outer_comment
  is '�ⲿ�������';
comment on column EMS_AEXG_PRE.inner_comment
  is '�ڲ��������';
comment on column EMS_AEXG_PRE.modify_times
  is '�������';
comment on column EMS_AEXG_PRE.used_flag
  is '����/ͣ�ã�1-���ã�0-ͣ��';
comment on column EMS_AEXG_PRE.used_flag_reason
  is '����/ͣ��ԭ��';
comment on column EMS_AEXG_PRE.note
  is '��ע';
comment on column EMS_AEXG_PRE.goods_form
  is '������̬';
comment on column EMS_AEXG_PRE.qp_status
  is 'TCS״̬';
comment on column EMS_AEXG_PRE.cop_ems_no
  is '��ҵ�ڲ����';
comment on column EMS_AEXG_PRE.dec_price_rmb
  is '�걨����RMB';
comment on column EMS_AEXG_PRE.qty
  is '�걨����';
comment on column EMS_AEXG_PRE.max_qty
  is '��׼�������';
comment on column EMS_AEXG_PRE.class_note
  is '����˵��';
comment on column EMS_AEXG_PRE.factor_wt
  is '������λ����';
comment on column EMS_AEXG_PRE.qp_modify_mark
  is 'QP�����־';
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
