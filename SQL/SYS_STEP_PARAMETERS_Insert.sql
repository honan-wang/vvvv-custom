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
  is '系统配置-环节代码参数';
comment on column SYS_STEP_PARAMETERS.workflow_type
  is '流程类型';
comment on column SYS_STEP_PARAMETERS.step_id
  is '环节编号';
comment on column SYS_STEP_PARAMETERS.step_name
  is '环节名称';
comment on column SYS_STEP_PARAMETERS.strt_flag
  is '起始环节标志位';
comment on column SYS_STEP_PARAMETERS.control_flag
  is '控制标志环节标志';
comment on column SYS_STEP_PARAMETERS.remark
  is '备注';
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
values ('G2Grt', 'G2Grt500300', '已结案', '0', '000000200', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt500400', '结案退回', '0', '000004300', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100100', '预录入', '1', '100001000', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100200', '待审批', '0', '010003000', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100300', '审批通过', '0', '001000100', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100400', '退回', '0', '022002300', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100500', '查验', '0', '000000400', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100600', '查验通过', '0', '001000100', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100900', '作废', '0', '022000200', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb100100', '备案预录入', '1', '100001000', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb100200', '备案待审批', '0', '000003000', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb100300', '备案审批通过', '0', '000000100', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb100400', '备案退回', '0', '000001300', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb200100', '变更预录入', '0', '000002000', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb200200', '变更待审批', '0', '000003000', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb200300', '变更审批通过', '0', '000000100', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb200400', '变更退回', '0', '000002300', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb300210', '备案二级待审批', '0', '000000000', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb400210', '变更二级待审批', '0', '000000000', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb500200', '结案待审批', '0', '000004000', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb500300', '已结案', '0', '000000200', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb500400', '结案退回', '0', '000004300', '金二-耗料单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp100100', '备案预录入', '1', '100001000', '金二-档案库');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp100200', '备案待审批', '0', '000003000', '金二-档案库');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp100300', '备案审批通过', '0', '000000100', '金二-档案库');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp100400', '备案退回', '0', '000001300', '金二-档案库');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp200100', '变更预录入', '0', '000002000', '金二-档案库');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp200200', '变更待审批', '0', '000003000', '金二-档案库');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp200300', '变更审批通过', '0', '000000100', '金二-档案库');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp200400', '变更退回', '0', '000002300', '金二-档案库');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp900900', '注销', '0', '000000000', '金二-档案库');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100100', '备案预录入', '1', '100001000', '金二-账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100200', '备案待审批', '0', '000003000', '金二-账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100300', '备案审批通过', '0', '000000100', '金二-账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100400', '备案退回', '0', '000001300', '金二-账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200100', '变更预录入', '0', '000002000', '金二-账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200200', '变更待审批', '0', '000003000', '金二-账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200300', '变更审批通过', '0', '000000100', '金二-账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200400', '变更退回', '0', '000002300', '金二-账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec900900', '注销', '0', '000000000', '金二-账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100100', '备案预录入', '1', '100001000', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100200', '备案待审批', '0', '000003000', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100300', '备案审批通过', '0', '000004100', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100400', '备案退回', '0', '000001300', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst200100', '变更预录入', '0', '000002000', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst200200', '变更待审批', '0', '000003000', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst200300', '变更审批通过', '0', '000004100', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG200200', '变更待审核', '0', '000003000', 'E账册-归并关系');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG200300', '变更审核通过', '0', '000000100', 'E账册-归并关系');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG200400', '变更退回', '0', '000002300', 'E账册-归并关系');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB100100', '备案预录入', '1', '100001000', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB100200', '备案待审核', '0', '000003000', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB100300', '备案审核通过', '0', '000004100', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB100400', '备案退回', '0', '000001300', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB200100', '变更预录入', '0', '000002000', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB200200', '变更待审核', '0', '000003000', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB200300', '变更审核通过', '0', '000004100', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB200400', '变更退回', '0', '000002300', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB500200', '结案待审核', '0', '000000000', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB500300', '已结案', '0', '000000200', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESQB', 'ESQB500400', '结案退回', '0', '000004300', 'E账册-业务资质');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ETZ', 'ETZ100100', '预录入', '1', '100001000', 'E账册-库存调整单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ETZ', 'ETZ100200', '待审核', '0', '000001000', 'E账册-库存调整单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ETZ', 'ETZ100300', '审核通过', '0', '000001000', 'E账册-库存调整单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ETZ', 'ETZ100400', '退回', '0', '000001000', 'E账册-库存调整单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ETZ', 'ETZ200210', '二级待审核', '0', '000001000', 'E账册-库存调整单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC100100', '备案预录入', '1', '100001000', 'E账册-账册管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC100200', '备案待审核', '0', '000003000', 'E账册-账册管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC100300', '备案审核通过', '0', '000000100', 'E账册-账册管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC100400', '备案退回', '0', '000001300', 'E账册-账册管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC200100', '变更预录入', '0', '000002000', 'E账册-账册管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC200200', '变更待审核', '0', '000003000', 'E账册-账册管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC200300', '变更审核通过', '0', '000000100', 'E账册-账册管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC200400', '变更退回', '0', '000002300', 'E账册-账册管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EZC', 'EZC900900', '注销', '0', '000000000', 'E账册-账册管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP100100', '备案预录入', '1', '100001000', 'E账册-经营范围管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP100200', '备案待审核', '0', '000003000', 'E账册-经营范围管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP100300', '备案审核通过', '0', '000000100', 'E账册-经营范围管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP100400', '备案退回', '0', '000001300', 'E账册-经营范围管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP200100', '变更预录入', '0', '000002000', 'E账册-经营范围管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP200200', '变更待审核', '0', '000003000', 'E账册-经营范围管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP200300', '变更审核通过', '0', '000000100', 'E账册-经营范围管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP200400', '变更退回', '0', '000002300', 'E账册-经营范围管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ESCP', 'ESCP900900', '注销', '0', '000000000', 'E账册-经营范围管理');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100100', '预录入', '1', '100001000', 'E账册-报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100200', '待审核', '0', '010003000', 'E账册-报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100300', '审核通过', '0', '001005100', 'E账册-报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100400', '退回', '0', '022002300', 'E账册-报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100500', '查验', '0', '000000400', 'E账册-报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100600', '查验通过', '0', '001005100', 'E账册-报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EBG', 'EBG100900', '作废', '0', '022000200', 'E账册-报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ECOR', 'ECOR100100', '预录入', '1', '100001000', 'E账册-企业分类-海关端独占');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100100', '预录入', '1', '1000000000', '先入区后报关-提运申请单-预录入');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100200', '待审核', '0', '0000000000', '先入区后报关-提运申请单-待审核');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100330', '主管海关审过', '0', '0000000000', '先入区后报关-提运申请单-主管海关审过');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100300', '口岸海关审过', '0', '0000000000', '先入区后报关-提运申请单-口岸海关审过');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100400', '退回', '0', '0000000000', '先入区后报关-提运申请单-退回');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100500', '查验', '0', '0000000000', '先入区后报关-提运申请单-查验');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100100', '备案预录入', '1', '100001000', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100200', '备案待审核', '0', '010003000', '金二跨关区转入转出');
commit;
prompt 100 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100300', '备案审核通过', '0', '001000100', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100400', '备案退回', '0', '022002300', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100500', '备案查验', '0', '000000400', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100600', '备案查验通过', '0', '001000100', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ100900', '作废', '0', '022000200', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200100', '变更预录入', '0', '100001000', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200200', '变更待审核', '0', '010003000', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200300', '变更审核通过', '0', '001000100', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200400', '变更退回', '0', '022002300', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200500', '变更查验', '0', '000000400', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQ', 'G2KGQ200600', '变更查验通过', '0', '001000100', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100100', '备案预录入', '1', '100001000', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100200', '备案待审核', '0', '010003000', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100300', '备案审核通过', '0', '001000100', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100400', '备案退回', '0', '022002300', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100500', '备案查验', '0', '000000400', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100600', '备案查验通过', '0', '001000100', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL100900', '作废', '0', '022000200', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200100', '变更预录入', '0', '100001000', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200200', '变更待审核', '0', '010003000', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200300', '变更审核通过', '0', '001000100', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200400', '变更退回', '0', '022002300', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200500', '变更查验', '0', '000000400', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2KGQBILL', 'G2KGQBILL200600', '变更查验通过', '0', '001000100', '金二跨关区转入转出');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100900', '作废', '0', '022000200', '金二-账册（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100750', '备案手工修改', '0', '000000200', '金二-账册（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200750', '变更手工修改', '0', '000000200', '金二-账册（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt100700', '备案人工审批', '0', '000000200', '金二-担保业务总担保（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt200700', '变更人工审批', '0', '000000200', '金二-担保业务总担保（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100700', '备案人工审批', '0', '000000200', '金二-担保业务保证金征收单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk100700', '备案人工审批', '0', '000000200', '金二-担保业务退还/结转（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst100950', '删除', '0', '000000200', '金二-担保业务保证金征收单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle100700', '人工审批', '0', '000000200', '金二-车辆备案（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100100', '预录入', '1', '100001000', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100200', '待审批', '0', '000003000', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100300', '审批通过', '0', '000005100', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100400', '退回', '0', '000002300', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst200400', '变更退回', '0', '000002300', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst300210', '备案二级待审批', '0', '000000000', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst400210', '变更二级待审批', '0', '000000000', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst500200', '结案待审批', '0', '000000000', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst500300', '已结案', '0', '000000200', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtDpst', 'G2GrtDpst500400', '结案退回', '0', '000004300', '金二-担保业务保证金征收单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk100100', '备案预录入', '1', '100001000', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk100200', '备案待审批', '0', '000003000', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk100300', '备案审批通过', '0', '000004100', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk100400', '备案退回', '0', '000001300', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk200100', '变更预录入', '0', '000002000', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk200200', '变更待审批', '0', '000003000', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk200300', '变更审批通过', '0', '000004100', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk200400', '变更退回', '0', '000002300', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk300210', '备案二级待审批', '0', '000000000', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk400210', '变更二级待审批', '0', '000000000', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk500200', '结案待审批', '0', '000000000', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk500300', '已结案', '0', '000000200', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2GrtRtnbk', 'G2GrtRtnbk500400', '结案退回', '0', '000004300', '金二-担保业务退还/结转');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100500', '查验', '0', '000000400', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100600', '查验通过', '0', '000005100', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100900', '作废', '0', '000000200', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100700', '人工审批', '0', '000000200', '金二-核注清单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100530', '三级待审批（不启用）', '0', '0000000000', '加工贸易货物销毁申请表-三级待审批（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100710', '一级挂起', '0', '0000000000', '加工贸易货物销毁申请表-一级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100720', '二级挂起', '0', '0000000000', '加工贸易货物销毁申请表-二级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100730', '三级挂起（不启用）', '0', '0000000000', '加工贸易货物销毁申请表-三级挂起（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100900', '审批通过', '0', '0000000000', '加工贸易货物销毁申请表-审批通过');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100990', '作废', '0', '0000000000', '加工贸易货物销毁申请表-作废');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100100', '预录入', '1', '1000000000', '加工贸易业务担保事项减免申请表-预录入');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100105', '退回', '0', '0000000000', '加工贸易业务担保事项减免申请表-退回');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100510', '一级待审批', '0', '0000000000', '加工贸易业务担保事项减免申请表-一级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100520', '二级待审批', '0', '0000000000', '加工贸易业务担保事项减免申请表-二级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100530', '三级待审批（不启用）', '0', '0000000000', '加工贸易业务担保事项减免申请表-三级待审批（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100710', '一级挂起', '0', '0000000000', '加工贸易业务担保事项减免申请表-一级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100720', '二级挂起', '0', '0000000000', '加工贸易业务担保事项减免申请表-二级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100730', '三级挂起（不启用）', '0', '0000000000', '加工贸易业务担保事项减免申请表-三级挂起（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100900', '审批通过', '0', '0000000000', '加工贸易业务担保事项减免申请表-审批通过');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScDbRed', 'G2ScDbRed100990', '作废', '0', '0000000000', '加工贸易业务担保事项减免申请表-作废');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100100', '预录入', '1', '1000000000', '其它业务类型申请表-预录入');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100105', '退回', '0', '0000000000', '其它业务类型申请表-退回');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100510', '一级待审批', '0', '0000000000', '其它业务类型申请表-一级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100520', '二级待审批', '0', '0000000000', '其它业务类型申请表-二级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100530', '三级待审批', '0', '0000000000', '其它业务类型申请表-三级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100710', '一级挂起', '0', '0000000000', '其它业务类型申请表-一级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100720', '二级挂起', '0', '0000000000', '其它业务类型申请表-二级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100730', '三级挂起', '0', '0000000000', '其它业务类型申请表-三级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100900', '审批通过', '0', '0000000000', '其它业务类型申请表-审批通过');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRest', 'G2ScRest100990', '作废', '0', '0000000000', '其它业务类型申请表-作废');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No100100', '备案预录入', '1', '100001000', '金二手册-不作价设备使用情况');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No100200', '备案待审批', '0', '010003000', '金二手册-不作价设备使用情况');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No100300', '备案审批通过', '0', '000004100', '金二手册-不作价设备使用情况');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No100400', '备案退回', '0', '000001300', '金二手册-不作价设备使用情况表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No100700', '备案人工审批', '0', '000000200', '金二手册-不作价设备使用情况G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No200100', '变更预录入', '0', '000002000', '金二手册-不作价设备使用情况');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No200200', '变更待审批', '0', '000003000', '金二手册-不作价设备使用情况');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No200300', '变更审批通过', '0', '000004100', '金二手册-不作价设备使用情况');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No200400', '变更退回', '0', '000002300', '金二手册-不作价设备使用情况');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2No', 'G2No200700', '变更人工审批', '0', '000000200', '金二手册-不作价设备使用情况（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100100', '备案预录入', '1', '100001000', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100200', '备案待审批', '0', '000003000', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100300', '备案审批通过', '0', '000000100', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100400', '备案退回', '0', '000001300', '手账册');
commit;
prompt 200 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100700', '备案人工审批', '0', '000000200', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100750', '备案手工修改', '0', '000000200', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml100900', '作废', '0', '022000200', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200100', '变更预录入', '0', '000002000', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200200', '变更待审批', '0', '000003000', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200300', '变更审批通过', '0', '000000100', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200400', '变更退回', '0', '000002300', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200700', '变更人工审批', '0', '000000200', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml200750', '变更手工修改', '0', '000000200', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Eml', 'G2Eml900900', '注销', '0', '000000000', '手账册');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100100', '预录入', '1', '100001000', '金二-以企业为单元补充申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100200', '待审批', '0', '010003000', '金二-以企业为单元补充申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('WARNSET', 'WARN100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC100100', '备案预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC100200', '备案待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC100300', '备案审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC100400', '备案退回', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC200100', '变更预录入', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC200200', '变更待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC200300', '变更审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC200400', '变更退回', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('ZC', 'ZC900900', '注销', '0', '000000000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('XXFB', 'XXFB100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('XXFB', 'XXFB100200', '待审核', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('XXFB', 'XXFB100300', '审核通过', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('XXFB', 'XXFB100400', '退回', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('XXFB', 'XXFB200210', '二级待审核', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RTN', 'RTN100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RTN', 'RTN100200', '待审核', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RTN', 'RTN100300', '审核通过', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RTN', 'RTN100400', '退回', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP100100', '备案预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP100200', '备案待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP100300', '备案审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP100400', '备案退回', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP200100', '变更预录入', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP200200', '变更待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP200300', '变更审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP200400', '变更退回', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SCP', 'SCP900900', '注销', '0', '000000000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DM', 'DM100200', '待审核', '0', '000001000', '删改单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DM', 'DM100300', '审核通过', '0', '000001000', '删改单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DM', 'DM100400', '退回', '0', '000001000', '删改单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DM', 'DM100210', '二级待审核', '0', '000001000', '删改单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FJ', 'FJ100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FJ', 'FJ100200', '待审核', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FJ', 'FJ100300', '审核通过', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FJ', 'FJ100990', '作废', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DM', 'DM100100', '预录入', '1', '100001000', '删改单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FJ', 'FJ100400', '退单', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100200', '待审核', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100300', '审核通过', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100400', '退回', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100500', '查验', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100600', '查验通过', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TXJH', 'TXJH100900', '作废', '0', '022000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON100100', '备案预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON100200', '备案待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON100300', '备案审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON100400', '备案退回', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON200100', '变更预录入', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON200200', '变更待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON200300', '变更审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON200400', '变更退回', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON500200', '结案待审核', '0', '000004000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON500300', '已结案', '0', '000000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CON', 'CON500400', '结案退回', '0', '000004300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB100100', '备案预录入', '1', '100001000', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB100200', '备案待审核', '0', '000003000', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB100300', '备案审核通过', '0', '000004100', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB100400', '备案退回', '0', '000001300', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB200100', '变更预录入', '0', '000002000', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB200200', '变更待审核', '0', '000003000', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB200300', '变更审核通过', '0', '000004100', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB200400', '变更退回', '0', '000002300', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB300210', '备案二级待审核', '0', '000000000', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB400210', '变更二级待审核', '0', '000000000', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB500200', '结案待审核', '0', '000000000', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB500300', '已结案', '0', '000000200', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EDB', 'EDB500400', '结案退回', '0', '000004300', 'E账册-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EQA', 'EQA100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EQA', 'EQA100200', '待审核', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EQA', 'EQA100300', '审核通过', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EQA', 'EQA100400', '退回', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RENT', 'RENT100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RENT', 'RENT100200', '待审核', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RENT', 'RENT100300', '审核通过', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('RENT', 'RENT100400', '退回', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100100', '预录入', '1', '100001000', 'E账册-非报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100200', '待审核', '0', '010003000', 'E账册-非报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100300', '审核通过', '0', '001000100', 'E账册-非报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100400', '退回', '0', '022002300', 'E账册-非报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100500', '查验', '0', '000000400', 'E账册-非报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100600', '查验通过', '0', '001000100', 'E账册-非报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EFBG', 'EFBG100900', '作废', '0', '022000200', 'E账册-非报关业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG100100', '备案预录入', '1', '100001000', 'E账册-归并关系');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG100200', '备案待审核', '0', '000003000', 'E账册-归并关系');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG100300', '备案审核通过', '0', '000000100', 'E账册-归并关系');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG100400', '备案退回', '0', '000001300', 'E账册-归并关系');
commit;
prompt 300 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100100', '备案预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100200', '备案待审核', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100300', '备案审核通过', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100400', '备案退回', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100500', '备案查验', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100600', '备案查验通过', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ100900', '作废', '0', '022000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200100', '变更预录入', '0', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200200', '变更待审核', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200300', '变更审核通过', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200400', '变更退回', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200500', '变更查验', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('KGQ', 'KGQ200600', '变更查验通过', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100200', '待审核', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100300', '审核通过', '0', '001005100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100400', '退回', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100500', '查验', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100600', '查验通过', '0', '001005100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BG', 'BG100900', '作废', '0', '022000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('BIZTYPESET', 'BIZ100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('CORP', 'CORP100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB100100', '备案预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB100200', '备案待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB100300', '备案审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB100400', '备案退回', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB200100', '变更预录入', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB200200', '变更待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB200300', '变更审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB200400', '变更退回', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB300210', '备案二级待审核', '0', '000000000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB400210', '变更二级待审核', '0', '000000000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB500200', '结案待审核', '0', '000004000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB500300', '已结案', '0', '000000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('DB', 'DB500400', '结案退回', '0', '000004300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EMSSET', 'EMS100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100200', '待审核', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100300', '审核通过', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100400', '退回', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100500', '查验', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100600', '查验通过', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBG', 'FBG100900', '作废', '0', '022000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX100100', '备案预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX100200', '备案待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX100300', '备案审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX100400', '备案退回', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX200100', '变更预录入', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX200200', '变更待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX200300', '变更审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('GBGX', 'GBGX200400', '变更退回', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100200', '待审核', '0', '000103000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100300', '审核通过', '0', '000100100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100400', '退回', '0', '000102000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100500', '查验', '0', '000100400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100600', '查验通过', '0', '000100100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('HFD', 'HFD100900', '作废', '0', '000100200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB100100', '备案预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB100200', '备案待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB100300', '备案审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB100400', '备案退回', '0', '000001300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB200100', '变更预录入', '0', '000002000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB200200', '变更待审核', '0', '000003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB200300', '变更审核通过', '0', '000000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB200400', '变更退回', '0', '000002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB500200', '结案待审核', '0', '000004000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB500300', '已结案', '0', '000000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('SQB', 'SQB500400', '结案退回', '0', '000004300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TZ', 'TZ100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TZ', 'TZ100200', '待审核', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TZ', 'TZ100300', '审核通过', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TZ', 'TZ100400', '退回', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('TZ', 'TZ200210', '二级待审核', '0', '000001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle100100', '备案预录入', '1', '100001000', '金二-车辆备案');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle100200', '备案待审批', '0', '000003000', '金二-车辆备案');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle100300', '备案审批通过', '0', '000000100', '金二-车辆备案');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle100400', '备案退回', '0', '000001300', '金二-车辆备案');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle200100', '变更预录入', '0', '000002000', '金二-车辆备案');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle200200', '变更待审批', '0', '000003000', '金二-车辆备案');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle200300', '变更审批通过', '0', '000000100', '金二-车辆备案');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle200400', '变更退回', '0', '000002300', '金二-车辆备案');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('EGBG', 'EGBG200100', '变更预录入', '0', '000002000', 'E账册-归并关系');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Vehicle', 'G2Vehicle900900', '注销', '0', '000000000', '金二-车辆备案');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Chgoff', 'G2Chgoff100200', '待审核', '0', '000003000', '金二-账册报核');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Chgoff', 'G2Chgoff100300', '审核通过', '0', '000000100', '金二-账册报核');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Chgoff', 'G2Chgoff100400', '退回', '0', '000001300', '金二-账册报核');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhDep', 'G2XhDep100100', '预录入', '1', '1000000000', '先入区后报关-离港确认申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhDep', 'G2XhDep100500', '待确认', '0', '0000000000', '先入区后报关-离港确认申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhDep', 'G2XhDep100900', '确认', '0', '0000000000', '先入区后报关-离港确认申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhDep', 'G2XhDep100105', '退单', '0', '0000000000', '先入区后报关-离港确认申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100100', '预录入', '1', '100001000', '金二-核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100200', '待审核', '0', '000103000', '金二-核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100300', '审核通过', '0', '000100100', '金二-核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100400', '退回', '0', '000102000', '金二-核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100500', '查验', '0', '000100400', '金二-核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100600', '查验通过', '0', '000100100', '金二-核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100900', '作废', '0', '000100200', '金二-核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Chgoff', 'G2Chgoff100100', '预录入', '1', '100001000', '金二-账册报核');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100700', '人工审批', '0', '000000200', '金二-出入库单（G2流程）');
commit;
prompt 400 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100750', '手工修改', '0', '000000200', '金二-出入库单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100700', '人工审批', '0', '000000200', '金二-核放单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100750', '手工修改', '0', '000000200', '金二-核放单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100950', '删除', '0', '000000200', '金二-核放单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb100700', '备案人工审批', '0', '000000200', '金二-耗料单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb200700', '变更人工审批', '0', '000000200', '金二-耗料单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Cmb', 'G2Cmb500700', '结案人工审批', '0', '000000200', '金二-耗料单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Arcrp', 'G2Arcrp100700', '人工审批', '0', '000000200', '金二-档案库（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec100700', '备案人工审批', '0', '000000200', '金二-账册（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Putrec', 'G2Putrec200700', '变更人工审批', '0', '000000200', '金二-账册（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhArr', 'G2XhArr100100', '预录入', '1', '1000000000', '先入区后报关-到货确认申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhArr', 'G2XhArr100500', '提交海关', '0', '0000000000', '先入区后报关-到货确认申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhArr', 'G2XhArr100900', '确认', '0', '0000000000', '先入区后报关-到货确认申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhArr', 'G2XhArr100105', '退单', '0', '0000000000', '先入区后报关-到货确认申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhSetWrn', 'G2XhSetWrn100100', '预录入', '1', '1000000000', '先入区后报关-卡口预警时间');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhSetWrn', 'G2XhSetWrn100900', '确认', '0', '0000000000', '先入区后报关-卡口预警时间');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhSetPro', 'G2XhSetPro100100', '预录入', '1', '1000000000', '先入区后报关-企业抽查比例和权限设置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhSetPro', 'G2XhSetPro100900', '确认', '0', '0000000000', '先入区后报关-企业抽查比例和权限设置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhPro', 'G2XhPro100100', '预录入', '1', '1000000000', '先入区后报关-卡口抽查-提运申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhPro', 'G2XhPro100500', '查验录入', '0', '0000000000', '先入区后报关-卡口抽查-提运申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2XhPro', 'G2XhPro100900', '查验确认', '0', '0000000000', '先入区后报关-卡口抽查-提运申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2InCc', 'G2InCc100200', '清关申报', '0', '000000000', '金二核注清单-清关结单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2InCc', 'G2InCc100105', '清关退单', '0', '000000000', '金二核注清单-清关结单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2InCc', 'G2InCc100300', '清关结关', '0', '000000000', '金二核注清单-清关结单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Passport', 'G2Passport100290', '作废待审批', '0', '010003000', '金二-核放单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt200100', '变更预录入', '0', '000002000', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt200200', '变更待审批', '0', '000003000', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt200300', '变更审批通过', '0', '000004100', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt200400', '变更退回', '0', '000002300', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock200100', '变更预录入', '0', '000002000', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock200200', '变更待审批', '0', '000003000', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock200300', '变更审批通过', '0', '000004100', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock200400', '变更退回', '0', '000002300', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock200700', '变更人工审批', '0', '000000200', '金二-出入库单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100100', '预录入', '1', '100001000', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100200', '待审核', '0', '000103000', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100600', '查验通过', '0', '0000000000', '先入区后报关-提运申请单-查验通过');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LADE', 'LADE100900', '作废', '0', '0000000000', '先入区后报关-提运申请单-作废');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2InCc', 'G2InCc100100', '清关录入', '1', '100000000', '金二核注清单-清关结单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100290', '作废待审批', '0', '010003000', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100300', '审核通过', '0', '000100100', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100400', '退回', '0', '000102000', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100500', '查验', '0', '000100400', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100600', '查验通过', '0', '000100100', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100700', '人工审批', '0', '000000200', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100750', '手工修改', '0', '000000200', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100900', '作废', '0', '000100200', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G22SPasspo', 'G22SPassport100950', '删除', '0', '000000200', '金二-两步申报核放单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt200700', '变更人工审批', '0', '000000200', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Chgoff', 'G2Chgoff100700', '人工审批', '0', '000000200', '金二-账册报核');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt100290', '作废待审批', '0', '010003000', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Invt', 'G2Invt300700', '作废人工审批', '0', '000000200', '金二-核注清单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock300700', '作废人工审批', '0', '000000200', '金二-出入库单（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS100100', '备案预录入', '1', '100001000', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS100200', '备案待审批', '0', '000003000', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS100300', '备案审批通过', '0', '000004100', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS100400', '备案退回', '0', '000001300', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS100700', '备案人工审批', '0', '000000200', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS200100', '变更预录入', '0', '000002000', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS200200', '变更待审批', '0', '000003000', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS200300', '变更审批通过', '0', '000004100', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS200400', '变更退回', '0', '000002300', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS200700', '变更人工审批', '0', '000000200', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS300200', '注销待审批', '0', '000000000', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS300300', '注销审批通过', '0', '000000200', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS300400', '注销退回', '0', '000004300', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWLEMS', 'G2BWLEMS300700', '注销人工审批', '0', '000000200', '金二-物流账册前置');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100100', '预录入', '1', '100001000', '金二-出入库申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100200', '待审核', '0', '010003000', '金二-出入库申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100300', '审核通过', '0', '001000100', '金二-出入库申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100400', '退回', '0', '022002300', '金二-出入库申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100500', '查验', '0', '000000400', '金二-出入库申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100600', '查验通过', '0', '001000100', '金二-出入库申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2BWSFBG', 'G2BWSFBG100900', '作废', '0', '022000200', '金二-出入库申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx100100', '备案预录入', '1', '100001000', '金二-账册（用于传输表体）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx100200', '备案待审核', '0', '000003000', '金二-账册（用于传输表体）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx100300', '备案审核通过', '0', '000000100', '金二-账册（用于传输表体）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx100400', '备案退回', '0', '000001300', '金二-账册（用于传输表体）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx200100', '变更预录入', '0', '000002000', '金二-账册（用于传输表体）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx200200', '变更待审核', '0', '000003000', '金二-账册（用于传输表体）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx200300', '变更审核通过', '0', '000000100', '金二-账册（用于传输表体）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Gbgx', 'G2Gbgx200400', '变更退回', '0', '000002300', '金二-账册（用于传输表体）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100100', '自动录入', '1', '100000000', '月报管理环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100105', '退单', '0', '000000000', '月报管理环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100700', '补录入', '0', '000000000', '月报管理环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl100100', '备案预录入', '1', '100001000', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl100200', '备案待审批', '0', '000003000', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl100300', '备案审批通过', '0', '000004100', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl100400', '备案退回', '0', '000001300', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl200100', '变更预录入', '0', '000002000', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl200200', '变更待审批', '0', '000003000', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl200300', '变更审批通过', '0', '000004100', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl200400', '变更退回', '0', '000002300', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl500200', '结案待审批', '0', '000000000', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl500300', '已结案', '0', '000000200', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl500400', '结案退回', '0', '000004300', '金二-申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl100700', '备案人工审批', '0', '000000200', '金二-申报表（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl200700', '变更人工审批', '0', '000000200', '金二-申报表（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Dcl', 'G2Dcl500700', '结案人工审批', '0', '000000200', '金二-申报表（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100200', '报备数据完成_一级待审批', '0', '100100000', '月报管理环节');
commit;
prompt 500 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100500', '报备数据完成_二级待审批', '0', '100100000', '月报管理环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100250', '人工一级审批', '0', '100000000', '月报管理环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100550', '人工二级审批', '0', '100000000', '月报管理环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100100', '预录入', '1', '100001000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100200', '待审核', '0', '010003000', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100300', '审核通过', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100400', '退回', '0', '022002300', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100500', '查验', '0', '000000400', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100600', '查验通过', '0', '001000100', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('FBS', 'FBS100900', '作废', '0', '022000200', null);
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Stock', 'G2Stock100290', '作废待审批', '0', '010003000', '金二-出入库单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100300', '审批通过', '0', '101000000', '月报管理环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100390', '比对通过', '0', '110000000', '月报管理环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCMON', 'LCMON100305', '比对异常', '0', '000000000', '月报管理环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100100', '预录入', '1', '100000000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100105', '退单', '0', '000000000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100200', '一级待审批', '0', '100100000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100210', '二级待审批', '0', '100100000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100500', '人工一级审批', '0', '100000000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100510', '人工二级审批', '0', '100000000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH100300', '审批通过', '0', '110000000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200100', '变更预录入', '0', '000000000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200105', '变更退单', '0', '000000000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200300', '变更一级待审批', '0', '100100000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200310', '变更二级待审批', '0', '100100000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200500', '变更人工一级审批', '0', '100000000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('LCWH', 'LCWH200510', '变更人工二级审批', '0', '100000000', '仓库信息环节');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2SC', 'G2SC100100', '预录入', '1', '1000000000', '金二-手册管理申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2SC', 'G2SC100105', '退回', '1', '0000000000', '金二-手册管理申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2SC', 'G2SC100500', '待审批', '1', '0000000000', '金二-手册管理申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2SC', 'G2SC100900', '审批通过', '1', '0000000000', '金二-手册管理申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2SC', 'G2SC100700', '发布', '1', '0000000000', '金二-手册管理申请单');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100100', '预录入', '1', '1000000000', '剩余料件结转申请表-预录入');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100105', '退回', '0', '0000000000', '剩余料件结转申请表-退回');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100510', '一级待审批', '0', '0000000000', '剩余料件结转申请表-一级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100520', '二级待审批', '0', '0000000000', '剩余料件结转申请表-二级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100530', '三级待审批（不启用）', '0', '0000000000', '剩余料件结转申请表-三级待审批（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100710', '一级挂起', '0', '0000000000', '剩余料件结转申请表-一级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100720', '二级挂起', '0', '0000000000', '剩余料件结转申请表-二级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100730', '三级挂起（不启用）', '0', '0000000000', '剩余料件结转申请表-三级挂起（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100900', '审批通过', '0', '0000000000', '剩余料件结转申请表-审批通过');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScCop', 'G2ScCop100990', '作废', '0', '0000000000', '剩余料件结转申请表-作废');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100100', '预录入', '1', '1000000000', '报核前申报单耗资质申请表-预录入');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100105', '退回', '0', '0000000000', '报核前申报单耗资质申请表-退回');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100510', '一级待审批', '0', '0000000000', '报核前申报单耗资质申请表-一级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100520', '二级待审批', '0', '0000000000', '报核前申报单耗资质申请表-二级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100530', '三级待审批（不启用）', '0', '0000000000', '报核前申报单耗资质申请表-三级待审批（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100710', '一级挂起', '0', '0000000000', '报核前申报单耗资质申请表-一级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100720', '二级挂起', '0', '0000000000', '报核前申报单耗资质申请表-二级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100730', '三级挂起（不启用）', '0', '0000000000', '报核前申报单耗资质申请表-三级挂起（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100900', '审批通过', '0', '0000000000', '报核前申报单耗资质申请表-审批通过');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScRep', 'G2ScRep100990', '作废', '0', '0000000000', '报核前申报单耗资质申请表-作废');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100100', '预录入', '1', '1000000000', '加工贸易货物存放场所变更申请表-预录入');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100105', '退回', '0', '0000000000', '加工贸易货物存放场所变更申请表-退回');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100510', '一级待审批', '0', '0000000000', '加工贸易货物存放场所变更申请表-一级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100520', '二级待审批（不启用）', '0', '0000000000', '加工贸易货物存放场所变更申请表-二级待审批（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100530', '三级待审批（不启用）', '0', '0000000000', '加工贸易货物存放场所变更申请表-三级待审批（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100710', '一级挂起', '0', '0000000000', '加工贸易货物存放场所变更申请表-一级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100720', '二级挂起（不启用）', '0', '0000000000', '加工贸易货物存放场所变更申请表-二级挂起（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100730', '三级挂起（不启用）', '0', '0000000000', '加工贸易货物存放场所变更申请表-三级挂起（不启用）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100900', '审批通过', '0', '0000000000', '加工贸易货物存放场所变更申请表-审批通过');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGPlace', 'G2ScGPlace100990', '作废', '0', '0000000000', '加工贸易货物存放场所变更申请表-作废');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100100', '预录入', '1', '1000000000', '货物抵押申请表-预录入');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100105', '退回', '0', '0000000000', '货物抵押申请表-退回');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100510', '一级待审批', '0', '0000000000', '货物抵押申请表-一级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100520', '二级待审批', '0', '0000000000', '货物抵押申请表-二级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100530', '三级待审批', '0', '0000000000', '货物抵押申请表-三级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100710', '一级挂起', '0', '0000000000', '货物抵押申请表-一级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100720', '二级挂起', '0', '0000000000', '货物抵押申请表-二级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100730', '三级挂起', '0', '0000000000', '货物抵押申请表-三级挂起');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100900', '审批通过', '0', '0000000000', '货物抵押申请表-审批通过');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGMor', 'G2ScGMor100990', '作废', '0', '0000000000', '货物抵押申请表-作废');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100100', '预录入', '1', '1000000000', '加工贸易货物销毁申请表-预录入');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100105', '退回', '0', '0000000000', '加工贸易货物销毁申请表-退回');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100510', '一级待审批', '0', '0000000000', '加工贸易货物销毁申请表-一级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2ScGDes', 'G2ScGDes100520', '二级待审批', '0', '0000000000', '加工贸易货物销毁申请表-二级待审批');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt100100', '备案预录入', '1', '100001000', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt100200', '备案待审批', '0', '000003000', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt100300', '备案审批通过', '0', '000004100', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt100400', '备案退回', '0', '000001300', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt200100', '变更预录入', '0', '000002000', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt200200', '变更待审批', '0', '000003000', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt200300', '变更审批通过', '0', '000004100', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt200400', '变更退回', '0', '000002300', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt300210', '备案二级待审批', '0', '000000000', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt400210', '变更二级待审批', '0', '000000000', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Grt', 'G2Grt500200', '结案待审批', '0', '000000000', '金二-担保业务');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100300', '审批通过', '0', '001000100', '金二-以企业为单元补充申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100400', '审批退回', '0', '022002300', '金二-以企业为单元补充申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100500', '查验', '0', '000000400', '金二-以企业为单元补充申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100600', '查验通过', '0', '001000100', '金二-以企业为单元补充申报');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100700', '人工审批', '0', '000000200', '金二-以企业为单元补充申报（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2NemsDcl', 'G2NemsDcl100750', '手工修改', '0', '000000200', '金二-以企业为单元补充申报（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr100100', '备案预录入', '1', '100001000', '金二-外发加工申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr100200', '备案待审批', '0', '010003000', '金二-外发加工申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr100300', '备案审批通过', '0', '000004100', '金二-外发加工申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr100400', '备案退回', '0', '000001300', '金二-外发加工申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr100700', '备案人工审批', '0', '000000200', '金二-外发加工申报表（G2流程）');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr200100', '变更预录入', '0', '000002000', '金二-外发加工申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr200200', '变更待审批', '0', '000003000', '金二-外发加工申报表');
commit;
prompt 600 records committed...
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr200300', '变更审批通过', '0', '000004100', '金二-外发加工申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr200400', '变更退回', '0', '000002300', '金二-外发加工申报表');
insert into SYS_STEP_PARAMETERS (workflow_type, step_id, step_name, strt_flag, control_flag, remark)
values ('G2Pr', 'G2Pr200700', '变更人工审批', '0', '000000200', '金二-外发加工申报表（G2流程）');
commit;
prompt 603 records loaded
prompt Enabling triggers for SYS_STEP_PARAMETERS...
alter table SYS_STEP_PARAMETERS enable all triggers;
