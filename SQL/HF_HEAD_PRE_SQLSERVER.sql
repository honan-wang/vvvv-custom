-- Create table for SQL Server
CREATE TABLE HF_HEAD_PRE
(
  discharged_no  NVARCHAR(50) NOT NULL,
  biz_type       NVARCHAR(10),
  biz_mode       NVARCHAR(10),
  i_e_mark       NVARCHAR(1),
  start_land     NVARCHAR(10),
  goal_land      NVARCHAR(10),
  car_no         NVARCHAR(64),
  car_wt         DECIMAL(18,5),
  ic_code        NVARCHAR(128),
  gate_id        NVARCHAR(36),
  f_conta_no     NVARCHAR(20),
  f_conta_type   NVARCHAR(512),
  f_conta_wt     DECIMAL(18,5),
  a_conta_no     NVARCHAR(20),
  a_conta_type   NVARCHAR(10),
  a_conta_wt     DECIMAL(18,5),
  carframe_no    NVARCHAR(256),
  carframe_type  NVARCHAR(10),
  carframe_wt    DECIMAL(18,5),
  goods_wt       DECIMAL(18,5),
  fact_weight    DECIMAL(18,5),
  pack_no        DECIMAL(18,2),
  bill_no        NVARCHAR(50),
  main_goods     NVARCHAR(100),
  fit_mark       NVARCHAR(20),
  b_status       NVARCHAR(20),
  m_stauts       NVARCHAR(20),
  port_status    NVARCHAR(20) DEFAULT 'K03',
  area_code      NVARCHAR(10) NOT NULL,
  customs_code   NVARCHAR(10) NOT NULL,
  trade_code     NVARCHAR(20) NOT NULL,
  trade_name     NVARCHAR(512) NOT NULL,
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
  oper_person    NVARCHAR(40),
  oper_date      DATETIME,
  outer_comment  NVARCHAR(500),
  inner_comment  NVARCHAR(500),
  plat_no        NVARCHAR(10),
  work_no        NVARCHAR(50),
  note           NVARCHAR(500),
  port_date      DATETIME,
  double_random  NVARCHAR(1) DEFAULT '0',
  car_ec_no      NVARCHAR(255),
  car_dec_no     NVARCHAR(255),
  fill_in        NVARCHAR(1) DEFAULT '1',
  zs_flag        NVARCHAR(10) DEFAULT 'A001',
  bat_id         NVARCHAR(50),
  template_id    NVARCHAR(50),
  owner_name     NVARCHAR(200),
  transport_name NVARCHAR(200),
  driver         NVARCHAR(50),
  driver_phone   NVARCHAR(20),
  custdecl       NVARCHAR(50),
  custdecl_phone NVARCHAR(20),
  entry_id       NVARCHAR(50)
);

-- Add extended properties (SQL Server equivalent of Oracle comments) to the table 
EXEC sp_addextendedproperty 
  @name = N'MS_Description', 
  @value = N'核放单表头', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'HF_HEAD_PRE';

-- Add extended properties (SQL Server equivalent of Oracle comments) to the columns 
EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'核放单号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'HF_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'discharged_no';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'业务类型', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'HF_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'biz_type';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'业务模式', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'HF_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'biz_mode';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'进出标志', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'HF_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'i_e_mark';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'启始地', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'HF_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'start_land';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'目的地', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'HF_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'goal_land';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'车牌号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'HF_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'car_no';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'车辆重量', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'HF_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'car_wt';

EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'IC卡号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'HF_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'ic_code';

-- (Additional column comments would continue here...)

-- Create indexes 
CREATE INDEX IDX_HF_HEAD_PRE_BIZ_MODE ON HF_HEAD_PRE (BIZ_MODE);
CREATE INDEX IDX_HF_HEAD_PRE_BIZ_TYPE ON HF_HEAD_PRE (BIZ_TYPE);
CREATE INDEX IDX_HF_HEAD_PRE_GOAL_LAND ON HF_HEAD_PRE (GOAL_LAND);
CREATE INDEX IDX_HF_HEAD_PRE_IC_CODE ON HF_HEAD_PRE (IC_CODE);
CREATE INDEX IDX_HF_HEAD_PRE_START_LAND ON HF_HEAD_PRE (START_LAND);

-- Create/Recreate primary key constraint 
ALTER TABLE HF_HEAD_PRE
  ADD CONSTRAINT PK_HF_HEAD_PRE PRIMARY KEY (DISCHARGED_NO);