-- Create table for SQL Server
CREATE TABLE FBG_HEAD_PRE
(
  gatejob_no     NVARCHAR(50) NOT NULL,
  gatepass_no    NVARCHAR(50),
  biz_type       NVARCHAR(10),
  biz_mode       NVARCHAR(10),
  i_e_mark       NVARCHAR(1),
  goods_flow     NVARCHAR(20),
  transfer_mode  NVARCHAR(1),
  ems_no         NVARCHAR(20),
  guarante_type  NVARCHAR(1),
  guarante_id    NVARCHAR(50),
  guarante_no    NVARCHAR(200),
  guarante_desc  NVARCHAR(500),
  guarante_price DECIMAL(18,5),
  correspond_no  NVARCHAR(50),
  gross_weight   DECIMAL(18,5),
  net_weight     DECIMAL(18,5),
  pack_no        DECIMAL(18,5),
  pack_type      NVARCHAR(1),
  m_p            NVARCHAR(1),
  provider_code  NVARCHAR(20),
  provider_name  NVARCHAR(200),
  owner_code     NVARCHAR(20),
  owner_name     NVARCHAR(200),
  trade_mode     NVARCHAR(4),
  bond_flag      NVARCHAR(1),
  materiel_type  NVARCHAR(50),
  license_plate  NVARCHAR(100),
  port_status    NVARCHAR(20) DEFAULT 'K501',
  comp_status    NVARCHAR(10),
  comp_info      NVARCHAR(1000),
  area_code      NVARCHAR(10) NOT NULL,
  customs_code   NVARCHAR(10) NOT NULL,
  trade_code     NVARCHAR(20) NOT NULL,
  trade_name     NVARCHAR(200) NOT NULL,
  input_code     NVARCHAR(20) NOT NULL,
  input_name     NVARCHAR(200) NOT NULL,
  declare_code   NVARCHAR(20),
  declare_name   NVARCHAR(200),
  step_id        NVARCHAR(20) NOT NULL,
  pre_step_id    NVARCHAR(20),
  oper_type      NVARCHAR(10),
  oper_result    NVARCHAR(10),
  create_person  NVARCHAR(40) NOT NULL,
  create_date    DATETIME NOT NULL,
  declare_person NVARCHAR(40),
  declare_date   DATETIME,
  approve_person NVARCHAR(40),
  approve_date   DATETIME,
  oper_person    NVARCHAR(40) DEFAULT '0',
  oper_date      DATETIME,
  outer_comment  NVARCHAR(500),
  inner_comment  NVARCHAR(500),
  plat_no        NVARCHAR(10),
  work_no        NVARCHAR(50),
  note           NVARCHAR(2000),
  port_date      DATETIME,
  tradecodescc   NVARCHAR(18),
  agentcodescc   NVARCHAR(18),
  ownercodescc   NVARCHAR(18),
  copcodescc     NVARCHAR(18),
  promiseitmes   NVARCHAR(32),
  tradeareacode  NVARCHAR(32),
  zs_flag        NVARCHAR(10) DEFAULT 'A001',
  bat_id         NVARCHAR(50)
);

-- Add extended properties (SQL Server equivalent of Oracle comments) to the table
EXEC sp_addextendedproperty 
  @name = N'MS_Description', 
  @value = N'自贸区登记备案入区单表头-业务表', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'FBG_HEAD_PRE';

-- Add extended properties (SQL Server equivalent of Oracle comments) to the columns 
EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'入区单号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'FBG_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'gatejob_no';

-- (Additional column comments would continue here - similar pattern as before)

-- Create indexes 
CREATE INDEX IDX_FBGHEADPRE_STEPID ON FBG_HEAD_PRE (STEP_ID);
CREATE INDEX IDX_FBG_HEAD_PRE_02 ON FBG_HEAD_PRE (BIZ_TYPE, BIZ_MODE, I_E_MARK, STEP_ID);
CREATE INDEX IDX_FBG_HEAD_PRE_BIZ_MODE ON FBG_HEAD_PRE (BIZ_MODE);
CREATE INDEX IDX_FBG_HEAD_PRE_CORRESPOND_NO ON FBG_HEAD_PRE (CORRESPOND_NO);
CREATE INDEX IDX_FBG_HEAD_PRE_DECLARE_DATE ON FBG_HEAD_PRE (DECLARE_DATE);
CREATE INDEX IDX_FBG_HEAD_PRE_GATEPASSNO ON FBG_HEAD_PRE (GATEPASS_NO);
CREATE INDEX IDX_FBG_HEAD_PRE_GUARANTEID ON FBG_HEAD_PRE (GUARANTE_ID);
CREATE INDEX IDX_FBG_HEAD_PRE_TRADE ON FBG_HEAD_PRE (TRADE_CODE);

-- Create/Recreate primary key constraint 
ALTER TABLE FBG_HEAD_PRE
  ADD CONSTRAINT PK_FBG_HEAD_PRE PRIMARY KEY (GATEJOB_NO);