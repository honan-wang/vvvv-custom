-- Create table
CREATE TABLE FBG_BODY_PRE
(
  auto_id            VARCHAR(50) NOT NULL,
  gatejob_no         VARCHAR(50),
  g_no               NUMERIC(19,0),
  code_ts            VARCHAR(13),
  g_name             VARCHAR(500),
  g_model            VARCHAR(1000),
  app_qty            NUMERIC(18,5),
  app_unit           VARCHAR(4),
  qty_1              NUMERIC(18,5),
  unit_1             VARCHAR(4),
  qty_2              NUMERIC(18,5),
  unit_2             VARCHAR(4),
  dec_price          NUMERIC(18,5),
  total_price        NUMERIC(18,5),
  curr               VARCHAR(3),
  country            VARCHAR(3),
  use_to             VARCHAR(2),
  duty_mode          VARCHAR(1),
  version_no         VARCHAR(10),
  m_p                VARCHAR(1),
  belong             VARCHAR(1),
  goods_form         VARCHAR(1),
  op_flag            VARCHAR(1),
  stat_usd           NUMERIC(18,5),
  stat_rmb           NUMERIC(18,5),
  item_no            NUMERIC(9,0),
  mark               VARCHAR(1),
  source_no          VARCHAR(20),
  source_g_no        VARCHAR(20),
  note               VARCHAR(500),
  destinationcountry VARCHAR(32),
  guarante_price     NUMERIC(18,5),
  b2b_auto_id        VARCHAR(50)
);

-- Add comments to the table 
EXEC sp_addextendedproperty 'MS_Description', '卡口登记申请单表体', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE';

-- Add comments to the columns 
EXEC sp_addextendedproperty 'MS_Description', '自动编辑', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'auto_id';
EXEC sp_addextendedproperty 'MS_Description', '非报关申请单号', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'gatejob_no';
EXEC sp_addextendedproperty 'MS_Description', '项号', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'g_no';
EXEC sp_addextendedproperty 'MS_Description', '商品编号', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'code_ts';
EXEC sp_addextendedproperty 'MS_Description', '商品名称', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'g_name';
EXEC sp_addextendedproperty 'MS_Description', '规格型号', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'g_model';
EXEC sp_addextendedproperty 'MS_Description', '成交数量', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'app_qty';
EXEC sp_addextendedproperty 'MS_Description', '成交单位', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'app_unit';
EXEC sp_addextendedproperty 'MS_Description', '第一数量', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'qty_1';
EXEC sp_addextendedproperty 'MS_Description', '第一单位', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'unit_1';
EXEC sp_addextendedproperty 'MS_Description', '第二数量', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'qty_2';
EXEC sp_addextendedproperty 'MS_Description', '第二单位', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'unit_2';
EXEC sp_addextendedproperty 'MS_Description', '单价', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'dec_price';
EXEC sp_addextendedproperty 'MS_Description', '总价', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'total_price';
EXEC sp_addextendedproperty 'MS_Description', '币制', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'curr';
EXEC sp_addextendedproperty 'MS_Description', '原产国', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'country';
EXEC sp_addextendedproperty 'MS_Description', '用途', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'use_to';
EXEC sp_addextendedproperty 'MS_Description', '征免方式', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'duty_mode';
EXEC sp_addextendedproperty 'MS_Description', '版本号', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'version_no';
EXEC sp_addextendedproperty 'MS_Description', '料件性质', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'm_p';
EXEC sp_addextendedproperty 'MS_Description', '归属：区内、区外', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'belong';
EXEC sp_addextendedproperty 'MS_Description', '货物形态', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'goods_form';
EXEC sp_addextendedproperty 'MS_Description', '操作标志', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'op_flag';
EXEC sp_addextendedproperty 'MS_Description', '统计美元值', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'stat_usd';
EXEC sp_addextendedproperty 'MS_Description', '统计人民币值', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'stat_rmb';
EXEC sp_addextendedproperty 'MS_Description', '序号', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'item_no';
EXEC sp_addextendedproperty 'MS_Description', '加工标志', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'mark';
EXEC sp_addextendedproperty 'MS_Description', '来源单号', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'source_no';
EXEC sp_addextendedproperty 'MS_Description', '来源项次', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'source_g_no';
EXEC sp_addextendedproperty 'MS_Description', '备注', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'note';
EXEC sp_addextendedproperty 'MS_Description', '最终目的国(地区)', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'destinationcountry';
EXEC sp_addextendedproperty 'MS_Description', '担保金额', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'guarante_price';
EXEC sp_addextendedproperty 'MS_Description', 'B2B主键', 'SCHEMA', 'dbo', 'TABLE', 'FBG_BODY_PRE', 'COLUMN', 'b2b_auto_id';

-- Create indexes 
CREATE INDEX IDX_FBG_BODY_CODETS ON FBG_BODY_PRE (CODE_TS);
CREATE INDEX IDX_FBG_BODY_GATEJOB_NO ON FBG_BODY_PRE (GATEJOB_NO);

-- Create primary key constraint
ALTER TABLE FBG_BODY_PRE
  ADD CONSTRAINT PK_FBG_BODY_PRE PRIMARY KEY (AUTO_ID);