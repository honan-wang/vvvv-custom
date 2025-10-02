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
  is '�鲢��ϵ-�˲��ͷ-ҵ���';
-- Add comments to the columns 
comment on column EMS_HEAD_PRE.pre_no
  is 'Ԥ¼���';
comment on column EMS_HEAD_PRE.ems_no
  is 'ƽ̨�˲��';
comment on column EMS_HEAD_PRE.h_ems_no
  is 'H2010�˲���';
comment on column EMS_HEAD_PRE.ems_type
  is '�˲����ͣ�3-���ڼӹ����ӹ���ҵ��4-���ڼӹ����ִ���ҵ';
comment on column EMS_HEAD_PRE.ems_class
  is '�˲����ࣺ1-�ִ��ࡢ2-�ӹ��ࡢ3-�з��ࡢ4-ά���ࡢ5-�豸��
';
comment on column EMS_HEAD_PRE.ems_attribute
  is '�˲����ԣ�����ʽ������ʽ';
comment on column EMS_HEAD_PRE.ems_flag
  is '�˲��ʶ���Ϻ��ࡢ����ࡢ������';
comment on column EMS_HEAD_PRE.trade_code
  is '��Ӫ��λ����';
comment on column EMS_HEAD_PRE.trade_name
  is '��Ӫ��λ����';
comment on column EMS_HEAD_PRE.owner_code
  is '�ӹ���λ';
comment on column EMS_HEAD_PRE.owner_name
  is '�ӹ���λ����';
comment on column EMS_HEAD_PRE.declare_code
  is '���뵥λ����';
comment on column EMS_HEAD_PRE.declare_name
  is '���뵥λ����';
comment on column EMS_HEAD_PRE.district_code
  is '��������';
comment on column EMS_HEAD_PRE.trade_mode
  is 'ó�׷�ʽ';
comment on column EMS_HEAD_PRE.cut_mode
  is '��������';
comment on column EMS_HEAD_PRE.master_ftc
  is '�����⾭ó';
comment on column EMS_HEAD_PRE.manage_object
  is '�������';
comment on column EMS_HEAD_PRE.modify_mark
  is '�޸ı�־';
comment on column EMS_HEAD_PRE.equip_mode
  is '�����걨����';
comment on column EMS_HEAD_PRE.end_date
  is '������Ч��';
comment on column EMS_HEAD_PRE.modify_times
  is '�������';
comment on column EMS_HEAD_PRE.hchx_suject
  is '��������';
comment on column EMS_HEAD_PRE.hchx_type
  is '���㷽ʽ';
comment on column EMS_HEAD_PRE.hchx_cycle
  is '��������';
comment on column EMS_HEAD_PRE.hchx_sdate
  is '���㿪ʼ����';
comment on column EMS_HEAD_PRE.hchx_edate
  is '�����������';
comment on column EMS_HEAD_PRE.hchx_stockdate
  is '����걨����';
comment on column EMS_HEAD_PRE.area_code
  is '�������(��ǰ�û��д洢���������)';
comment on column EMS_HEAD_PRE.customs_code
  is '���ܺ���';
comment on column EMS_HEAD_PRE.input_code
  is '¼�뵥λ����';
comment on column EMS_HEAD_PRE.input_name
  is '¼�뵥λ����';
comment on column EMS_HEAD_PRE.step_id
  is '��ǰ����';
comment on column EMS_HEAD_PRE.pre_step_id
  is 'ǰ�û���';
comment on column EMS_HEAD_PRE.oper_type
  is '��������(��Ӧǰ�û���)';
comment on column EMS_HEAD_PRE.oper_result
  is '�������(��Ӧǰ�û���)';
comment on column EMS_HEAD_PRE.create_person
  is '������';
comment on column EMS_HEAD_PRE.create_date
  is '����ʱ��';
comment on column EMS_HEAD_PRE.declare_person
  is '�걨��';
comment on column EMS_HEAD_PRE.declare_date
  is '�걨ʱ��';
comment on column EMS_HEAD_PRE.approve_person
  is '������';
comment on column EMS_HEAD_PRE.approve_date
  is '����ʱ��';
comment on column EMS_HEAD_PRE.oper_person
  is '��λ������';
comment on column EMS_HEAD_PRE.oper_date
  is '��λ����ʱ��';
comment on column EMS_HEAD_PRE.outer_comment
  is '�ⲿ�������';
comment on column EMS_HEAD_PRE.inner_comment
  is '�ڲ��������';
comment on column EMS_HEAD_PRE.used_flag
  is '����/ͣ�ã�1-���ã�0-ͣ��';
comment on column EMS_HEAD_PRE.used_flag_reason
  is '����/ͣ��ԭ��';
comment on column EMS_HEAD_PRE.plat_no
  is 'ƽ̨����';
comment on column EMS_HEAD_PRE.work_no
  is 'Ԥ���뵥��';
comment on column EMS_HEAD_PRE.note
  is '��ע';
comment on column EMS_HEAD_PRE.qp_status
  is 'TCS״̬';
comment on column EMS_HEAD_PRE.contr_in
  is '���ں�ͬ��TCS��';
comment on column EMS_HEAD_PRE.note_1
  is '���ñ�־1��TCS��';
comment on column EMS_HEAD_PRE.produce_type
  is '�ӹ����ࣨTCS��';
comment on column EMS_HEAD_PRE.appr_img_amt
  is '���������ܶTCS��';
comment on column EMS_HEAD_PRE.appr_exg_amt
  is '���������ܶTCS��';
comment on column EMS_HEAD_PRE.ex_curr
  is '���ڱ��ƣ�TCS��';
comment on column EMS_HEAD_PRE.im_curr
  is '���ڱ��ƣ�TCS��';
comment on column EMS_HEAD_PRE.cop_ems_no
  is '��ҵ�ڲ����';
comment on column EMS_HEAD_PRE.ems_appr_no
  is '��׼֤���';
comment on column EMS_HEAD_PRE.foreign_co_name
  is '���̹�˾';
comment on column EMS_HEAD_PRE.img_amount
  is '�����ܽ��';
comment on column EMS_HEAD_PRE.exg_amount
  is '�����ܽ��';
comment on column EMS_HEAD_PRE.img_items
  is '���ڻ�������';
comment on column EMS_HEAD_PRE.exg_items
  is '���ڻ�������';
comment on column EMS_HEAD_PRE.contr_out
  is '���ں�ͬ��';
comment on column EMS_HEAD_PRE.agree_no
  is 'Э���';
comment on column EMS_HEAD_PRE.pay_mode
  is '��˰��ʽ';
comment on column EMS_HEAD_PRE.input_er
  is '¼��Ա����';
comment on column EMS_HEAD_PRE.store_vol
  is '�ֿ����';
comment on column EMS_HEAD_PRE.store_area
  is '�ֿ����';
comment on column EMS_HEAD_PRE.product_ratio
  is '��������';
comment on column EMS_HEAD_PRE.note_amount
  is '���ý��';
comment on column EMS_HEAD_PRE.foreign_mgr
  is '���̾�����';
comment on column EMS_HEAD_PRE.in_ratio
  is '��������';
comment on column EMS_HEAD_PRE.trans_mode
  is '�ɽ���ʽ';
comment on column EMS_HEAD_PRE.trade_country
  is '��ֵ�';
comment on column EMS_HEAD_PRE.license_no
  is '���֤���';
comment on column EMS_HEAD_PRE.i_e_port
  is '�����ڰ�';
comment on column EMS_HEAD_PRE.declare_type
  is '�걨����';
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
