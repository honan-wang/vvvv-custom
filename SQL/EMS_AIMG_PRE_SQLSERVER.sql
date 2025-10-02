-- Create table for SQL Server
CREATE TABLE EMS_AIMG_PRE
(
  auto_id              NVARCHAR(50) NOT NULL,
  pre_no               NVARCHAR(50) NOT NULL,
  ems_no               NVARCHAR(20),
  g_no                 BIGINT,
  code_ts              NVARCHAR(13),
  g_name               NVARCHAR(500),
  g_model              NVARCHAR(1000),
  unit                 NVARCHAR(4),
  unit_1               NVARCHAR(4),
  unit_2               NVARCHAR(4),
  country_code         NVARCHAR(4),
  use_to               NVARCHAR(4),
  duty_mode            NVARCHAR(4),
  dec_price            DECIMAL(18,5),
  curr                 NVARCHAR(3),
  factor_1             DECIMAL(18,9),
  factor_2             DECIMAL(18,9),
  first_qty            DECIMAL(18,5),
  in_qty               DECIMAL(18,5),
  out_qty              DECIMAL(18,5),
  modify_mark          NVARCHAR(1),
  materials_flag       NVARCHAR(1),
  materials_use        NVARCHAR(1),
  materials_properties NVARCHAR(1),
  duty_rate            DECIMAL(3,0),
  belong               NVARCHAR(1),
  send_flag            NVARCHAR(1),
  step_id              NVARCHAR(20) NOT NULL,
  pre_step_id          NVARCHAR(20),
  oper_type            NVARCHAR(10),
  oper_result          NVARCHAR(10),
  create_person        NVARCHAR(40) NOT NULL,
  create_date          DATETIME NOT NULL,
  declare_person       NVARCHAR(40),
  declare_date         DATETIME,
  approve_person       NVARCHAR(40),
  approve_date         DATETIME,
  oper_person          NVARCHAR(40) DEFAULT '0',
  oper_date            DATETIME,
  outer_comment        NVARCHAR(500),
  inner_comment        NVARCHAR(500),
  modify_times         BIGINT,
  used_flag            NVARCHAR(1) DEFAULT '1',
  used_flag_reason     NVARCHAR(500),
  note                 NVARCHAR(500),
  goods_form           NVARCHAR(1),
  qp_status            NVARCHAR(10),
  cop_ems_no           NVARCHAR(20),
  dec_price_rmb        DECIMAL(19,4),
  qty                  DECIMAL(19,5),
  max_qty              DECIMAL(19,5),
  class_note           NVARCHAR(2000),
  factor_wt            DECIMAL(18,9),
  qp_modify_mark       NVARCHAR(1),
  kctz                 DECIMAL(18,5)
);

-- Add extended properties (SQL Server equivalent of Oracle comments) to the table
EXEC sp_addextendedproperty 
  @name = N'MS_Description', 
  @value = N'检并进系统-检并进耗材-业务表', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'EMS_AIMG_PRE';

-- Add extended properties (SQL Server equivalent of Oracle comments) to the columns 
EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'自动编号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'EMS_AIMG_PRE', 
  @level2type = N'COLUMN', @level2name = N'auto_id';

-- (Additional column comments would continue here - similar pattern as before)

-- Create indexes 
CREATE INDEX IDX_EMS_AIMG_PRE_EMS_NO ON EMS_AIMG_PRE (EMS_NO);
CREATE INDEX IDX_EMS_AIMG_PRE_G_NO ON EMS_AIMG_PRE (G_NO);
CREATE INDEX IDX_EMS_AIMG_PRE_PRE_NO ON EMS_AIMG_PRE (PRE_NO);
CREATE INDEX IDX_EMS_AIMG_PRE_STEP_ID ON EMS_AIMG_PRE (STEP_ID);

-- Create/Recreate unique constraint 
ALTER TABLE EMS_AIMG_PRE
  ADD CONSTRAINT AK_PK_EMS_AIMG_PRE_EMS_AIMG UNIQUE (AUTO_ID);