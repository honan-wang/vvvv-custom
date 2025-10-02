prompt Creating SYS_STEP_PARAMETERS...
create table SYS_STEP_PARAMETERS
(
  workflow_type VARCHAR2(10) not null,
  step_id       VARCHAR2(20) not null,
  step_name     VARCHAR2(50) not null,
  strt_flag     VARCHAR2(10),
  control_flag  VARCHAR2(10) not null,
  remark        VARCHAR2(255)
)
tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table SYS_STEP_PARAMETERS
  is 'ϵͳ����-���ڴ������';
comment on column SYS_STEP_PARAMETERS.workflow_type
  is '��������';
comment on column SYS_STEP_PARAMETERS.step_id
  is '���ڱ��';
comment on column SYS_STEP_PARAMETERS.step_name
  is '��������';
comment on column SYS_STEP_PARAMETERS.strt_flag
  is '��ʼ���ڱ�־λ';
comment on column SYS_STEP_PARAMETERS.control_flag
  is '���Ʊ�־���ڱ�־';
comment on column SYS_STEP_PARAMETERS.remark
  is '��ע';
alter table SYS_STEP_PARAMETERS
  add constraint PK_SYS_STEP_PARAMETERS primary key (WORKFLOW_TYPE, STEP_ID)
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

prompt Disabling triggers for SYS_STEP_PARAMETERS...
alter table SYS_STEP_PARAMETERS disable all triggers;
prompt Loading SYS_STEP_PARAMETERS...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt500300', '�ѽ᰸', '0', '000000200', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt500400', '�᰸�˻�', '0', '000004300', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100100', 'Ԥ¼��', '1', '100001000', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100200', '������', '0', '010003000', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100300', '����ͨ��', '0', '001000100', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100400', '�˻�', '0', '022002300', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100500', '����', '0', '000000400', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100600', '����ͨ��', '0', '001000100', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100900', '����', '0', '022000200', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb100100', '����Ԥ¼��', '1', '100001000', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb100200', '����������', '0', '000003000', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb100300', '��������ͨ��', '0', '000000100', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb100400', '�����˻�', '0', '000001300', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb200100', '���Ԥ¼��', '0', '000002000', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb200200', '���������', '0', '000003000', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb200300', '�������ͨ��', '0', '000000100', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb200400', '����˻�', '0', '000002300', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb300210', '��������������', '0', '000000000', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb400210', '�������������', '0', '000000000', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb500200', '�᰸������', '0', '000004000', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb500300', '�ѽ᰸', '0', '000000200', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb500400', '�᰸�˻�', '0', '000004300', '���-���ϵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp100100', '����Ԥ¼��', '1', '100001000', '���-������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp100200', '����������', '0', '000003000', '���-������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp100300', '��������ͨ��', '0', '000000100', '���-������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp100400', '�����˻�', '0', '000001300', '���-������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp200100', '���Ԥ¼��', '0', '000002000', '���-������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp200200', '���������', '0', '000003000', '���-������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp200300', '�������ͨ��', '0', '000000100', '���-������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp200400', '����˻�', '0', '000002300', '���-������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp900900', 'ע��', '0', '000000000', '���-������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100100', '����Ԥ¼��', '1', '100001000', '���-�˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100200', '����������', '0', '000003000', '���-�˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100300', '��������ͨ��', '0', '000000100', '���-�˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100400', '�����˻�', '0', '000001300', '���-�˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200100', '���Ԥ¼��', '0', '000002000', '���-�˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200200', '���������', '0', '000003000', '���-�˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200300', '�������ͨ��', '0', '000000100', '���-�˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200400', '����˻�', '0', '000002300', '���-�˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec900900', 'ע��', '0', '000000000', '���-�˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100100', '����Ԥ¼��', '1', '100001000', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100200', '����������', '0', '000003000', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100300', '��������ͨ��', '0', '000004100', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100400', '�����˻�', '0', '000001300', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst200100', '���Ԥ¼��', '0', '000002000', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst200200', '���������', '0', '000003000', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst200300', '�������ͨ��', '0', '000004100', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG200200', '��������', '0', '000003000', 'E�˲�-�鲢��ϵ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG200300', '������ͨ��', '0', '000000100', 'E�˲�-�鲢��ϵ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG200400', '����˻�', '0', '000002300', 'E�˲�-�鲢��ϵ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB100100', '����Ԥ¼��', '1', '100001000', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB100200', '���������', '0', '000003000', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB100300', '�������ͨ��', '0', '000004100', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB100400', '�����˻�', '0', '000001300', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB200100', '���Ԥ¼��', '0', '000002000', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB200200', '��������', '0', '000003000', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB200300', '������ͨ��', '0', '000004100', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB200400', '����˻�', '0', '000002300', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB500200', '�᰸�����', '0', '000000000', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB500300', '�ѽ᰸', '0', '000000200', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB500400', '�᰸�˻�', '0', '000004300', 'E�˲�-ҵ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ETZ', 'ETZ100100', 'Ԥ¼��', '1', '100001000', 'E�˲�-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ETZ', 'ETZ100200', '�����', '0', '000001000', 'E�˲�-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ETZ', 'ETZ100300', '���ͨ��', '0', '000001000', 'E�˲�-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ETZ', 'ETZ100400', '�˻�', '0', '000001000', 'E�˲�-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ETZ', 'ETZ200210', '���������', '0', '000001000', 'E�˲�-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC100100', '����Ԥ¼��', '1', '100001000', 'E�˲�-�˲����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC100200', '���������', '0', '000003000', 'E�˲�-�˲����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC100300', '�������ͨ��', '0', '000000100', 'E�˲�-�˲����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC100400', '�����˻�', '0', '000001300', 'E�˲�-�˲����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC200100', '���Ԥ¼��', '0', '000002000', 'E�˲�-�˲����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC200200', '��������', '0', '000003000', 'E�˲�-�˲����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC200300', '������ͨ��', '0', '000000100', 'E�˲�-�˲����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC200400', '����˻�', '0', '000002300', 'E�˲�-�˲����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC900900', 'ע��', '0', '000000000', 'E�˲�-�˲����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP100100', '����Ԥ¼��', '1', '100001000', 'E�˲�-��Ӫ��Χ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP100200', '���������', '0', '000003000', 'E�˲�-��Ӫ��Χ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP100300', '�������ͨ��', '0', '000000100', 'E�˲�-��Ӫ��Χ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP100400', '�����˻�', '0', '000001300', 'E�˲�-��Ӫ��Χ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP200100', '���Ԥ¼��', '0', '000002000', 'E�˲�-��Ӫ��Χ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP200200', '��������', '0', '000003000', 'E�˲�-��Ӫ��Χ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP200300', '������ͨ��', '0', '000000100', 'E�˲�-��Ӫ��Χ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP200400', '����˻�', '0', '000002300', 'E�˲�-��Ӫ��Χ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP900900', 'ע��', '0', '000000000', 'E�˲�-��Ӫ��Χ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100100', 'Ԥ¼��', '1', '100001000', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100200', '�����', '0', '010003000', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100300', '���ͨ��', '0', '001005100', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100400', '�˻�', '0', '022002300', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100500', '����', '0', '000000400', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100600', '����ͨ��', '0', '001005100', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100900', '����', '0', '022000200', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ECOR', 'ECOR100100', 'Ԥ¼��', '1', '100001000', 'E�˲�-��ҵ����-���ض˶�ռ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100100', 'Ԥ¼��', '1', '1000000000', '�������󱨹�-�������뵥-Ԥ¼��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100200', '�����', '0', '0000000000', '�������󱨹�-�������뵥-�����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100330', '���ܺ������', '0', '0000000000', '�������󱨹�-�������뵥-���ܺ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100300', '�ڰ��������', '0', '0000000000', '�������󱨹�-�������뵥-�ڰ��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100400', '�˻�', '0', '0000000000', '�������󱨹�-�������뵥-�˻�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100500', '����', '0', '0000000000', '�������󱨹�-�������뵥-����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100100', '����Ԥ¼��', '1', '100001000', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100200', '���������', '0', '010003000', '��������ת��ת��');
commit;
prompt 100 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100300', '�������ͨ��', '0', '001000100', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100400', '�����˻�', '0', '022002300', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100500', '��������', '0', '000000400', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100600', '��������ͨ��', '0', '001000100', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100900', '����', '0', '022000200', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200100', '���Ԥ¼��', '0', '100001000', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200200', '��������', '0', '010003000', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200300', '������ͨ��', '0', '001000100', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200400', '����˻�', '0', '022002300', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200500', '�������', '0', '000000400', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200600', '�������ͨ��', '0', '001000100', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100100', '����Ԥ¼��', '1', '100001000', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100200', '���������', '0', '010003000', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100300', '�������ͨ��', '0', '001000100', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100400', '�����˻�', '0', '022002300', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100500', '��������', '0', '000000400', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100600', '��������ͨ��', '0', '001000100', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100900', '����', '0', '022000200', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200100', '���Ԥ¼��', '0', '100001000', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200200', '��������', '0', '010003000', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200300', '������ͨ��', '0', '001000100', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200400', '����˻�', '0', '022002300', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200500', '�������', '0', '000000400', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200600', '�������ͨ��', '0', '001000100', '��������ת��ת��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100900', '����', '0', '022000200', '���-�˲ᣨG2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100750', '�����ֹ��޸�', '0', '000000200', '���-�˲ᣨG2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200750', '����ֹ��޸�', '0', '000000200', '���-�˲ᣨG2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt100700', '�����˹�����', '0', '000000200', '���-����ҵ���ܵ�����G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt200700', '����˹�����', '0', '000000200', '���-����ҵ���ܵ�����G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100700', '�����˹�����', '0', '000000200', '���-����ҵ��֤�����յ���G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk100700', '�����˹�����', '0', '000000200', '���-����ҵ���˻�/��ת��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100950', 'ɾ��', '0', '000000200', '���-����ҵ��֤�����յ���G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle100700', '�˹�����', '0', '000000200', '���-����������G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100100', 'Ԥ¼��', '1', '100001000', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100200', '������', '0', '000003000', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100300', '����ͨ��', '0', '000005100', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100400', '�˻�', '0', '000002300', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst200400', '����˻�', '0', '000002300', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst300210', '��������������', '0', '000000000', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst400210', '�������������', '0', '000000000', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst500200', '�᰸������', '0', '000000000', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst500300', '�ѽ᰸', '0', '000000200', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst500400', '�᰸�˻�', '0', '000004300', '���-����ҵ��֤�����յ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk100100', '����Ԥ¼��', '1', '100001000', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk100200', '����������', '0', '000003000', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk100300', '��������ͨ��', '0', '000004100', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk100400', '�����˻�', '0', '000001300', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk200100', '���Ԥ¼��', '0', '000002000', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk200200', '���������', '0', '000003000', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk200300', '�������ͨ��', '0', '000004100', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk200400', '����˻�', '0', '000002300', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk300210', '��������������', '0', '000000000', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk400210', '�������������', '0', '000000000', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk500200', '�᰸������', '0', '000000000', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk500300', '�ѽ᰸', '0', '000000200', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk500400', '�᰸�˻�', '0', '000004300', '���-����ҵ���˻�/��ת');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100500', '����', '0', '000000400', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100600', '����ͨ��', '0', '000005100', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100900', '����', '0', '000000200', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100700', '�˹�����', '0', '000000200', '���-��ע�嵥��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100530', '�����������������ã�', '0', '0000000000', '�ӹ�ó�׻������������-�����������������ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100710', 'һ������', '0', '0000000000', '�ӹ�ó�׻������������-һ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100720', '��������', '0', '0000000000', '�ӹ�ó�׻������������-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100730', '�������𣨲����ã�', '0', '0000000000', '�ӹ�ó�׻������������-�������𣨲����ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100900', '����ͨ��', '0', '0000000000', '�ӹ�ó�׻������������-����ͨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100990', '����', '0', '0000000000', '�ӹ�ó�׻������������-����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100100', 'Ԥ¼��', '1', '1000000000', '�ӹ�ó��ҵ�񵣱�������������-Ԥ¼��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100105', '�˻�', '0', '0000000000', '�ӹ�ó��ҵ�񵣱�������������-�˻�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100510', 'һ��������', '0', '0000000000', '�ӹ�ó��ҵ�񵣱�������������-һ��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100520', '����������', '0', '0000000000', '�ӹ�ó��ҵ�񵣱�������������-����������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100530', '�����������������ã�', '0', '0000000000', '�ӹ�ó��ҵ�񵣱�������������-�����������������ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100710', 'һ������', '0', '0000000000', '�ӹ�ó��ҵ�񵣱�������������-һ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100720', '��������', '0', '0000000000', '�ӹ�ó��ҵ�񵣱�������������-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100730', '�������𣨲����ã�', '0', '0000000000', '�ӹ�ó��ҵ�񵣱�������������-�������𣨲����ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100900', '����ͨ��', '0', '0000000000', '�ӹ�ó��ҵ�񵣱�������������-����ͨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100990', '����', '0', '0000000000', '�ӹ�ó��ҵ�񵣱�������������-����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100100', 'Ԥ¼��', '1', '1000000000', '����ҵ�����������-Ԥ¼��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100105', '�˻�', '0', '0000000000', '����ҵ�����������-�˻�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100510', 'һ��������', '0', '0000000000', '����ҵ�����������-һ��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100520', '����������', '0', '0000000000', '����ҵ�����������-����������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100530', '����������', '0', '0000000000', '����ҵ�����������-����������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100710', 'һ������', '0', '0000000000', '����ҵ�����������-һ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100720', '��������', '0', '0000000000', '����ҵ�����������-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100730', '��������', '0', '0000000000', '����ҵ�����������-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100900', '����ͨ��', '0', '0000000000', '����ҵ�����������-����ͨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100990', '����', '0', '0000000000', '����ҵ�����������-����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No100100', '����Ԥ¼��', '1', '100001000', '����ֲ�-�������豸ʹ�����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No100200', '����������', '0', '010003000', '����ֲ�-�������豸ʹ�����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No100300', '��������ͨ��', '0', '000004100', '����ֲ�-�������豸ʹ�����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No100400', '�����˻�', '0', '000001300', '����ֲ�-�������豸ʹ�������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No100700', '�����˹�����', '0', '000000200', '����ֲ�-�������豸ʹ�����G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No200100', '���Ԥ¼��', '0', '000002000', '����ֲ�-�������豸ʹ�����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No200200', '���������', '0', '000003000', '����ֲ�-�������豸ʹ�����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No200300', '�������ͨ��', '0', '000004100', '����ֲ�-�������豸ʹ�����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No200400', '����˻�', '0', '000002300', '����ֲ�-�������豸ʹ�����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No200700', '����˹�����', '0', '000000200', '����ֲ�-�������豸ʹ�������G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100100', '����Ԥ¼��', '1', '100001000', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100200', '����������', '0', '000003000', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100300', '��������ͨ��', '0', '000000100', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100400', '�����˻�', '0', '000001300', '���˲�');
commit;
prompt 200 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100700', '�����˹�����', '0', '000000200', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100750', '�����ֹ��޸�', '0', '000000200', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100900', '����', '0', '022000200', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200100', '���Ԥ¼��', '0', '000002000', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200200', '���������', '0', '000003000', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200300', '�������ͨ��', '0', '000000100', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200400', '����˻�', '0', '000002300', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200700', '����˹�����', '0', '000000200', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200750', '����ֹ��޸�', '0', '000000200', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml900900', 'ע��', '0', '000000000', '���˲�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100100', 'Ԥ¼��', '1', '100001000', '���-����ҵΪ��Ԫ�����걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100200', '������', '0', '010003000', '���-����ҵΪ��Ԫ�����걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('WARNSET', 'WARN100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC100100', '����Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC100200', '���������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC100300', '�������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC100400', '�����˻�', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC200100', '���Ԥ¼��', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC200200', '��������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC200300', '������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC200400', '����˻�', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC900900', 'ע��', '0', '000000000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('XXFB', 'XXFB100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('XXFB', 'XXFB100200', '�����', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('XXFB', 'XXFB100300', '���ͨ��', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('XXFB', 'XXFB100400', '�˻�', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('XXFB', 'XXFB200210', '���������', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RTN', 'RTN100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RTN', 'RTN100200', '�����', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RTN', 'RTN100300', '���ͨ��', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RTN', 'RTN100400', '�˻�', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP100100', '����Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP100200', '���������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP100300', '�������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP100400', '�����˻�', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP200100', '���Ԥ¼��', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP200200', '��������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP200300', '������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP200400', '����˻�', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP900900', 'ע��', '0', '000000000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DM', 'DM100200', '�����', '0', '000001000', 'ɾ�ĵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DM', 'DM100300', '���ͨ��', '0', '000001000', 'ɾ�ĵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DM', 'DM100400', '�˻�', '0', '000001000', 'ɾ�ĵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DM', 'DM100210', '���������', '0', '000001000', 'ɾ�ĵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FJ', 'FJ100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FJ', 'FJ100200', '�����', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FJ', 'FJ100300', '���ͨ��', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FJ', 'FJ100990', '����', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DM', 'DM100100', 'Ԥ¼��', '1', '100001000', 'ɾ�ĵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FJ', 'FJ100400', '�˵�', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100200', '�����', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100300', '���ͨ��', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100400', '�˻�', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100500', '����', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100600', '����ͨ��', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100900', '����', '0', '022000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON100100', '����Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON100200', '���������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON100300', '�������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON100400', '�����˻�', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON200100', '���Ԥ¼��', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON200200', '��������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON200300', '������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON200400', '����˻�', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON500200', '�᰸�����', '0', '000004000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON500300', '�ѽ᰸', '0', '000000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON500400', '�᰸�˻�', '0', '000004300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB100100', '����Ԥ¼��', '1', '100001000', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB100200', '���������', '0', '000003000', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB100300', '�������ͨ��', '0', '000004100', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB100400', '�����˻�', '0', '000001300', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB200100', '���Ԥ¼��', '0', '000002000', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB200200', '��������', '0', '000003000', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB200300', '������ͨ��', '0', '000004100', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB200400', '����˻�', '0', '000002300', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB300210', '�������������', '0', '000000000', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB400210', '������������', '0', '000000000', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB500200', '�᰸�����', '0', '000000000', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB500300', '�ѽ᰸', '0', '000000200', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB500400', '�᰸�˻�', '0', '000004300', 'E�˲�-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EQA', 'EQA100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EQA', 'EQA100200', '�����', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EQA', 'EQA100300', '���ͨ��', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EQA', 'EQA100400', '�˻�', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RENT', 'RENT100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RENT', 'RENT100200', '�����', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RENT', 'RENT100300', '���ͨ��', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RENT', 'RENT100400', '�˻�', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100100', 'Ԥ¼��', '1', '100001000', 'E�˲�-�Ǳ���ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100200', '�����', '0', '010003000', 'E�˲�-�Ǳ���ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100300', '���ͨ��', '0', '001000100', 'E�˲�-�Ǳ���ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100400', '�˻�', '0', '022002300', 'E�˲�-�Ǳ���ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100500', '����', '0', '000000400', 'E�˲�-�Ǳ���ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100600', '����ͨ��', '0', '001000100', 'E�˲�-�Ǳ���ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100900', '����', '0', '022000200', 'E�˲�-�Ǳ���ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG100100', '����Ԥ¼��', '1', '100001000', 'E�˲�-�鲢��ϵ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG100200', '���������', '0', '000003000', 'E�˲�-�鲢��ϵ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG100300', '�������ͨ��', '0', '000000100', 'E�˲�-�鲢��ϵ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG100400', '�����˻�', '0', '000001300', 'E�˲�-�鲢��ϵ');
commit;
prompt 300 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100100', '����Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100200', '���������', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100300', '�������ͨ��', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100400', '�����˻�', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100500', '��������', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100600', '��������ͨ��', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100900', '����', '0', '022000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200100', '���Ԥ¼��', '0', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200200', '��������', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200300', '������ͨ��', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200400', '����˻�', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200500', '�������', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200600', '�������ͨ��', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100200', '�����', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100300', '���ͨ��', '0', '001005100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100400', '�˻�', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100500', '����', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100600', '����ͨ��', '0', '001005100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100900', '����', '0', '022000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BIZTYPESET', 'BIZ100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CORP', 'CORP100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB100100', '����Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB100200', '���������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB100300', '�������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB100400', '�����˻�', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB200100', '���Ԥ¼��', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB200200', '��������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB200300', '������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB200400', '����˻�', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB300210', '�������������', '0', '000000000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB400210', '������������', '0', '000000000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB500200', '�᰸�����', '0', '000004000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB500300', '�ѽ᰸', '0', '000000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB500400', '�᰸�˻�', '0', '000004300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EMSSET', 'EMS100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100200', '�����', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100300', '���ͨ��', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100400', '�˻�', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100500', '����', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100600', '����ͨ��', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100900', '����', '0', '022000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX100100', '����Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX100200', '���������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX100300', '�������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX100400', '�����˻�', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX200100', '���Ԥ¼��', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX200200', '��������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX200300', '������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX200400', '����˻�', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100200', '�����', '0', '000103000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100300', '���ͨ��', '0', '000100100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100400', '�˻�', '0', '000102000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100500', '����', '0', '000100400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100600', '����ͨ��', '0', '000100100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100900', '����', '0', '000100200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB100100', '����Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB100200', '���������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB100300', '�������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB100400', '�����˻�', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB200100', '���Ԥ¼��', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB200200', '��������', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB200300', '������ͨ��', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB200400', '����˻�', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB500200', '�᰸�����', '0', '000004000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB500300', '�ѽ᰸', '0', '000000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB500400', '�᰸�˻�', '0', '000004300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TZ', 'TZ100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TZ', 'TZ100200', '�����', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TZ', 'TZ100300', '���ͨ��', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TZ', 'TZ100400', '�˻�', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TZ', 'TZ200210', '���������', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle100100', '����Ԥ¼��', '1', '100001000', '���-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle100200', '����������', '0', '000003000', '���-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle100300', '��������ͨ��', '0', '000000100', '���-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle100400', '�����˻�', '0', '000001300', '���-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle200100', '���Ԥ¼��', '0', '000002000', '���-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle200200', '���������', '0', '000003000', '���-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle200300', '�������ͨ��', '0', '000000100', '���-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle200400', '����˻�', '0', '000002300', '���-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG200100', '���Ԥ¼��', '0', '000002000', 'E�˲�-�鲢��ϵ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle900900', 'ע��', '0', '000000000', '���-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Chgoff', 'G2Chgoff100200', '�����', '0', '000003000', '���-�˲ᱨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Chgoff', 'G2Chgoff100300', '���ͨ��', '0', '000000100', '���-�˲ᱨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Chgoff', 'G2Chgoff100400', '�˻�', '0', '000001300', '���-�˲ᱨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhDep', 'G2XhDep100100', 'Ԥ¼��', '1', '1000000000', '�������󱨹�-���ȷ�����뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhDep', 'G2XhDep100500', '��ȷ��', '0', '0000000000', '�������󱨹�-���ȷ�����뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhDep', 'G2XhDep100900', 'ȷ��', '0', '0000000000', '�������󱨹�-���ȷ�����뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhDep', 'G2XhDep100105', '�˵�', '0', '0000000000', '�������󱨹�-���ȷ�����뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100100', 'Ԥ¼��', '1', '100001000', '���-�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100200', '�����', '0', '000103000', '���-�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100300', '���ͨ��', '0', '000100100', '���-�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100400', '�˻�', '0', '000102000', '���-�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100500', '����', '0', '000100400', '���-�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100600', '����ͨ��', '0', '000100100', '���-�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100900', '����', '0', '000100200', '���-�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Chgoff', 'G2Chgoff100100', 'Ԥ¼��', '1', '100001000', '���-�˲ᱨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100700', '�˹�����', '0', '000000200', '���-����ⵥ��G2���̣�');
commit;
prompt 400 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100750', '�ֹ��޸�', '0', '000000200', '���-����ⵥ��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100700', '�˹�����', '0', '000000200', '���-�˷ŵ���G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100750', '�ֹ��޸�', '0', '000000200', '���-�˷ŵ���G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100950', 'ɾ��', '0', '000000200', '���-�˷ŵ���G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb100700', '�����˹�����', '0', '000000200', '���-���ϵ���G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb200700', '����˹�����', '0', '000000200', '���-���ϵ���G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb500700', '�᰸�˹�����', '0', '000000200', '���-���ϵ���G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp100700', '�˹�����', '0', '000000200', '���-�����⣨G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100700', '�����˹�����', '0', '000000200', '���-�˲ᣨG2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200700', '����˹�����', '0', '000000200', '���-�˲ᣨG2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhArr', 'G2XhArr100100', 'Ԥ¼��', '1', '1000000000', '�������󱨹�-����ȷ�����뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhArr', 'G2XhArr100500', '�ύ����', '0', '0000000000', '�������󱨹�-����ȷ�����뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhArr', 'G2XhArr100900', 'ȷ��', '0', '0000000000', '�������󱨹�-����ȷ�����뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhArr', 'G2XhArr100105', '�˵�', '0', '0000000000', '�������󱨹�-����ȷ�����뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhSetWrn', 'G2XhSetWrn100100', 'Ԥ¼��', '1', '1000000000', '�������󱨹�-����Ԥ��ʱ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhSetWrn', 'G2XhSetWrn100900', 'ȷ��', '0', '0000000000', '�������󱨹�-����Ԥ��ʱ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhSetPro', 'G2XhSetPro100100', 'Ԥ¼��', '1', '1000000000', '�������󱨹�-��ҵ��������Ȩ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhSetPro', 'G2XhSetPro100900', 'ȷ��', '0', '0000000000', '�������󱨹�-��ҵ��������Ȩ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhPro', 'G2XhPro100100', 'Ԥ¼��', '1', '1000000000', '�������󱨹�-���ڳ��-�������뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhPro', 'G2XhPro100500', '����¼��', '0', '0000000000', '�������󱨹�-���ڳ��-�������뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhPro', 'G2XhPro100900', '����ȷ��', '0', '0000000000', '�������󱨹�-���ڳ��-�������뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2InCc', 'G2InCc100200', '����걨', '0', '000000000', '�����ע�嵥-��ؽᵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2InCc', 'G2InCc100105', '����˵�', '0', '000000000', '�����ע�嵥-��ؽᵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2InCc', 'G2InCc100300', '��ؽ��', '0', '000000000', '�����ע�嵥-��ؽᵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100290', '���ϴ�����', '0', '010003000', '���-�˷ŵ���G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt200100', '���Ԥ¼��', '0', '000002000', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt200200', '���������', '0', '000003000', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt200300', '�������ͨ��', '0', '000004100', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt200400', '����˻�', '0', '000002300', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock200100', '���Ԥ¼��', '0', '000002000', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock200200', '���������', '0', '000003000', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock200300', '�������ͨ��', '0', '000004100', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock200400', '����˻�', '0', '000002300', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock200700', '����˹�����', '0', '000000200', '���-����ⵥ��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100100', 'Ԥ¼��', '1', '100001000', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100200', '�����', '0', '000103000', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100600', '����ͨ��', '0', '0000000000', '�������󱨹�-�������뵥-����ͨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100900', '����', '0', '0000000000', '�������󱨹�-�������뵥-����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2InCc', 'G2InCc100100', '���¼��', '1', '100000000', '�����ע�嵥-��ؽᵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100290', '���ϴ�����', '0', '010003000', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100300', '���ͨ��', '0', '000100100', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100400', '�˻�', '0', '000102000', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100500', '����', '0', '000100400', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100600', '����ͨ��', '0', '000100100', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100700', '�˹�����', '0', '000000200', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100750', '�ֹ��޸�', '0', '000000200', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100900', '����', '0', '000100200', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100950', 'ɾ��', '0', '000000200', '���-�����걨�˷ŵ�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt200700', '����˹�����', '0', '000000200', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Chgoff', 'G2Chgoff100700', '�˹�����', '0', '000000200', '���-�˲ᱨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100290', '���ϴ�����', '0', '010003000', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt300700', '�����˹�����', '0', '000000200', '���-��ע�嵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock300700', '�����˹�����', '0', '000000200', '���-����ⵥ��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS100100', '����Ԥ¼��', '1', '100001000', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS100200', '����������', '0', '000003000', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS100300', '��������ͨ��', '0', '000004100', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS100400', '�����˻�', '0', '000001300', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS100700', '�����˹�����', '0', '000000200', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS200100', '���Ԥ¼��', '0', '000002000', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS200200', '���������', '0', '000003000', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS200300', '�������ͨ��', '0', '000004100', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS200400', '����˻�', '0', '000002300', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS200700', '����˹�����', '0', '000000200', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS300200', 'ע��������', '0', '000000000', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS300300', 'ע������ͨ��', '0', '000000200', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS300400', 'ע���˻�', '0', '000004300', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS300700', 'ע���˹�����', '0', '000000200', '���-�����˲�ǰ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100100', 'Ԥ¼��', '1', '100001000', '���-������걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100200', '�����', '0', '010003000', '���-������걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100300', '���ͨ��', '0', '001000100', '���-������걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100400', '�˻�', '0', '022002300', '���-������걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100500', '����', '0', '000000400', '���-������걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100600', '����ͨ��', '0', '001000100', '���-������걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100900', '����', '0', '022000200', '���-������걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx100100', '����Ԥ¼��', '1', '100001000', '���-�˲ᣨ���ڴ�����壩');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx100200', '���������', '0', '000003000', '���-�˲ᣨ���ڴ�����壩');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx100300', '�������ͨ��', '0', '000000100', '���-�˲ᣨ���ڴ�����壩');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx100400', '�����˻�', '0', '000001300', '���-�˲ᣨ���ڴ�����壩');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx200100', '���Ԥ¼��', '0', '000002000', '���-�˲ᣨ���ڴ�����壩');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx200200', '��������', '0', '000003000', '���-�˲ᣨ���ڴ�����壩');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx200300', '������ͨ��', '0', '000000100', '���-�˲ᣨ���ڴ�����壩');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx200400', '����˻�', '0', '000002300', '���-�˲ᣨ���ڴ�����壩');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100100', '�Զ�¼��', '1', '100000000', '�±�������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100105', '�˵�', '0', '000000000', '�±�������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100700', '��¼��', '0', '000000000', '�±�������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl100100', '����Ԥ¼��', '1', '100001000', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl100200', '����������', '0', '000003000', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl100300', '��������ͨ��', '0', '000004100', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl100400', '�����˻�', '0', '000001300', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl200100', '���Ԥ¼��', '0', '000002000', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl200200', '���������', '0', '000003000', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl200300', '�������ͨ��', '0', '000004100', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl200400', '����˻�', '0', '000002300', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl500200', '�᰸������', '0', '000000000', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl500300', '�ѽ᰸', '0', '000000200', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl500400', '�᰸�˻�', '0', '000004300', '���-�걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl100700', '�����˹�����', '0', '000000200', '���-�걨��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl200700', '����˹�����', '0', '000000200', '���-�걨��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl500700', '�᰸�˹�����', '0', '000000200', '���-�걨��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100200', '�����������_һ��������', '0', '100100000', '�±�������');
commit;
prompt 500 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100500', '�����������_����������', '0', '100100000', '�±�������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100250', '�˹�һ������', '0', '100000000', '�±�������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100550', '�˹���������', '0', '100000000', '�±�������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100100', 'Ԥ¼��', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100200', '�����', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100300', '���ͨ��', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100400', '�˻�', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100500', '����', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100600', '����ͨ��', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100900', '����', '0', '022000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100290', '���ϴ�����', '0', '010003000', '���-����ⵥ');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100300', '����ͨ��', '0', '101000000', '�±�������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100390', '�ȶ�ͨ��', '0', '110000000', '�±�������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100305', '�ȶ��쳣', '0', '000000000', '�±�������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100100', 'Ԥ¼��', '1', '100000000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100105', '�˵�', '0', '000000000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100200', 'һ��������', '0', '100100000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100210', '����������', '0', '100100000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100500', '�˹�һ������', '0', '100000000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100510', '�˹���������', '0', '100000000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100300', '����ͨ��', '0', '110000000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200100', '���Ԥ¼��', '0', '000000000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200105', '����˵�', '0', '000000000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200300', '���һ��������', '0', '100100000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200310', '�������������', '0', '100100000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200500', '����˹�һ������', '0', '100000000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200510', '����˹���������', '0', '100000000', '�ֿ���Ϣ����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2SC', 'G2SC100100', 'Ԥ¼��', '1', '1000000000', '���-�ֲ�������뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2SC', 'G2SC100105', '�˻�', '1', '0000000000', '���-�ֲ�������뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2SC', 'G2SC100500', '������', '1', '0000000000', '���-�ֲ�������뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2SC', 'G2SC100900', '����ͨ��', '1', '0000000000', '���-�ֲ�������뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2SC', 'G2SC100700', '����', '1', '0000000000', '���-�ֲ�������뵥');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100100', 'Ԥ¼��', '1', '1000000000', 'ʣ���ϼ���ת�����-Ԥ¼��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100105', '�˻�', '0', '0000000000', 'ʣ���ϼ���ת�����-�˻�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100510', 'һ��������', '0', '0000000000', 'ʣ���ϼ���ת�����-һ��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100520', '����������', '0', '0000000000', 'ʣ���ϼ���ת�����-����������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100530', '�����������������ã�', '0', '0000000000', 'ʣ���ϼ���ת�����-�����������������ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100710', 'һ������', '0', '0000000000', 'ʣ���ϼ���ת�����-һ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100720', '��������', '0', '0000000000', 'ʣ���ϼ���ת�����-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100730', '�������𣨲����ã�', '0', '0000000000', 'ʣ���ϼ���ת�����-�������𣨲����ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100900', '����ͨ��', '0', '0000000000', 'ʣ���ϼ���ת�����-����ͨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100990', '����', '0', '0000000000', 'ʣ���ϼ���ת�����-����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100100', 'Ԥ¼��', '1', '1000000000', '����ǰ�걨�������������-Ԥ¼��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100105', '�˻�', '0', '0000000000', '����ǰ�걨�������������-�˻�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100510', 'һ��������', '0', '0000000000', '����ǰ�걨�������������-һ��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100520', '����������', '0', '0000000000', '����ǰ�걨�������������-����������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100530', '�����������������ã�', '0', '0000000000', '����ǰ�걨�������������-�����������������ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100710', 'һ������', '0', '0000000000', '����ǰ�걨�������������-һ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100720', '��������', '0', '0000000000', '����ǰ�걨�������������-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100730', '�������𣨲����ã�', '0', '0000000000', '����ǰ�걨�������������-�������𣨲����ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100900', '����ͨ��', '0', '0000000000', '����ǰ�걨�������������-����ͨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100990', '����', '0', '0000000000', '����ǰ�걨�������������-����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100100', 'Ԥ¼��', '1', '1000000000', '�ӹ�ó�׻����ų�����������-Ԥ¼��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100105', '�˻�', '0', '0000000000', '�ӹ�ó�׻����ų�����������-�˻�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100510', 'һ��������', '0', '0000000000', '�ӹ�ó�׻����ų�����������-һ��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100520', '�����������������ã�', '0', '0000000000', '�ӹ�ó�׻����ų�����������-�����������������ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100530', '�����������������ã�', '0', '0000000000', '�ӹ�ó�׻����ų�����������-�����������������ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100710', 'һ������', '0', '0000000000', '�ӹ�ó�׻����ų�����������-һ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100720', '�������𣨲����ã�', '0', '0000000000', '�ӹ�ó�׻����ų�����������-�������𣨲����ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100730', '�������𣨲����ã�', '0', '0000000000', '�ӹ�ó�׻����ų�����������-�������𣨲����ã�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100900', '����ͨ��', '0', '0000000000', '�ӹ�ó�׻����ų�����������-����ͨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100990', '����', '0', '0000000000', '�ӹ�ó�׻����ų�����������-����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100100', 'Ԥ¼��', '1', '1000000000', '�����Ѻ�����-Ԥ¼��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100105', '�˻�', '0', '0000000000', '�����Ѻ�����-�˻�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100510', 'һ��������', '0', '0000000000', '�����Ѻ�����-һ��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100520', '����������', '0', '0000000000', '�����Ѻ�����-����������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100530', '����������', '0', '0000000000', '�����Ѻ�����-����������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100710', 'һ������', '0', '0000000000', '�����Ѻ�����-һ������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100720', '��������', '0', '0000000000', '�����Ѻ�����-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100730', '��������', '0', '0000000000', '�����Ѻ�����-��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100900', '����ͨ��', '0', '0000000000', '�����Ѻ�����-����ͨ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100990', '����', '0', '0000000000', '�����Ѻ�����-����');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100100', 'Ԥ¼��', '1', '1000000000', '�ӹ�ó�׻������������-Ԥ¼��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100105', '�˻�', '0', '0000000000', '�ӹ�ó�׻������������-�˻�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100510', 'һ��������', '0', '0000000000', '�ӹ�ó�׻������������-һ��������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100520', '����������', '0', '0000000000', '�ӹ�ó�׻������������-����������');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt100100', '����Ԥ¼��', '1', '100001000', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt100200', '����������', '0', '000003000', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt100300', '��������ͨ��', '0', '000004100', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt100400', '�����˻�', '0', '000001300', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt200100', '���Ԥ¼��', '0', '000002000', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt200200', '���������', '0', '000003000', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt200300', '�������ͨ��', '0', '000004100', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt200400', '����˻�', '0', '000002300', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt300210', '��������������', '0', '000000000', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt400210', '�������������', '0', '000000000', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt500200', '�᰸������', '0', '000000000', '���-����ҵ��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100300', '����ͨ��', '0', '001000100', '���-����ҵΪ��Ԫ�����걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100400', '�����˻�', '0', '022002300', '���-����ҵΪ��Ԫ�����걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100500', '����', '0', '000000400', '���-����ҵΪ��Ԫ�����걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100600', '����ͨ��', '0', '001000100', '���-����ҵΪ��Ԫ�����걨');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100700', '�˹�����', '0', '000000200', '���-����ҵΪ��Ԫ�����걨��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100750', '�ֹ��޸�', '0', '000000200', '���-����ҵΪ��Ԫ�����걨��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr100100', '����Ԥ¼��', '1', '100001000', '���-�ⷢ�ӹ��걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr100200', '����������', '0', '010003000', '���-�ⷢ�ӹ��걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr100300', '��������ͨ��', '0', '000004100', '���-�ⷢ�ӹ��걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr100400', '�����˻�', '0', '000001300', '���-�ⷢ�ӹ��걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr100700', '�����˹�����', '0', '000000200', '���-�ⷢ�ӹ��걨��G2���̣�');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr200100', '���Ԥ¼��', '0', '000002000', '���-�ⷢ�ӹ��걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr200200', '���������', '0', '000003000', '���-�ⷢ�ӹ��걨��');
commit;
prompt 600 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr200300', '�������ͨ��', '0', '000004100', '���-�ⷢ�ӹ��걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr200400', '����˻�', '0', '000002300', '���-�ⷢ�ӹ��걨��');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr200700', '����˹�����', '0', '000000200', '���-�ⷢ�ӹ��걨��G2���̣�');
commit;
prompt 603 records loaded
prompt Enabling triggers for SYS_STEP_PARAMETERS...
alter table SYS_STEP_PARAMETERS enable all triggers;
