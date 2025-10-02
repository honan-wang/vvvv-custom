prompt Creating BASE_CURR...
create table BASE_CURR
(
  auto_id VARCHAR2(36),
  code    VARCHAR2(3) not null,
  name    VARCHAR2(40),
  e_name  VARCHAR2(20)
)
tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table BASE_CURR
  is '��������-���Ҵ���';
comment on column BASE_CURR.auto_id
  is '�Զ����';
comment on column BASE_CURR.code
  is '����';
comment on column BASE_CURR.name
  is '����';
comment on column BASE_CURR.e_name
  is 'Ӣ������';
create index WA_SYS_NAME_3CBF0154 on BASE_CURR (NAME)
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
alter table BASE_CURR
  add constraint PK_BASE_CURR primary key (CODE)
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

prompt Disabling triggers for BASE_CURR...
alter table BASE_CURR disable all triggers;
prompt Loading BASE_CURR...
