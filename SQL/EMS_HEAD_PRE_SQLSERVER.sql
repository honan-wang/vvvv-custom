-- Create table for SQL Server
CREATE TABLE EMS_HEAD_PRE
(
  pre_no           NVARCHAR(50) NOT NULL,
  ems_no           NVARCHAR(64),
  h_ems_no         NVARCHAR(20),
  ems_type         NVARCHAR(1),
  ems_class        NVARCHAR(1),
  ems_attribute    NVARCHAR(10),
  ems_flag         NVARCHAR(10),
  trade_code       NVARCHAR(20),
  trade_name       NVARCHAR(200),
  owner_code       NVARCHAR(20),
  owner_name       NVARCHAR(100),
  declare_code     NVARCHAR(20),
  declare_name     NVARCHAR(200),
  district_code    NVARCHAR(5),
  trade_mode       NVARCHAR(4),
  cut_mode         NVARCHAR(4),
  master_ftc       NVARCHAR(6),
  manage_object    NVARCHAR(1),
  modify_mark      NVARCHAR(1),
  equip_mode       NVARCHAR(1),
  end_date         DATETIME,
  modify_times     BIGINT,
  hchx_suject      NVARCHAR(4),
  hchx_type        NVARCHAR(4),
  hchx_cycle       BIGINT,
  hchx_sdate       DATETIME,
  hchx_edate       DATETIME,
  hchx_stockdate   DATETIME,
  area_code        NVARCHAR(10),
  customs_code     NVARCHAR(10),
  input_code       NVARCHAR(20) NOT NULL,
  input_name       NVARCHAR(200) NOT NULL,
  step_id          NVARCHAR(20) NOT NULL,
  pre_step_id      NVARCHAR(20),
  oper_type        NVARCHAR(10),
  oper_result      NVARCHAR(10),
  create_person    NVARCHAR(40) NOT NULL,
  create_date      DATETIME NOT NULL,
  declare_person   NVARCHAR(40),
  declare_date     DATETIME,
  approve_person   NVARCHAR(40),
  approve_date     DATETIME,
  oper_person      NVARCHAR(40) DEFAULT '0',
  oper_date        DATETIME,
  outer_comment    NVARCHAR(500),
  inner_comment    NVARCHAR(500),
  used_flag        NVARCHAR(1) DEFAULT '1',
  used_flag_reason NVARCHAR(500),
  plat_no          NVARCHAR(10),
  work_no          NVARCHAR(50),
  note             NVARCHAR(500),
  qp_status        NVARCHAR(10),
  contr_in         NVARCHAR(20),
  note_1           NVARCHAR(20),
  produce_type     NVARCHAR(4),
  appr_img_amt     DECIMAL(19,5),
  appr_exg_amt     DECIMAL(19,5),
  ex_curr          NVARCHAR(4),
  im_curr          NVARCHAR(4),
  cop_ems_no       NVARCHAR(20),
  ems_appr_no      NVARCHAR(50),
  foreign_co_name  NVARCHAR(1200),
  img_amount       DECIMAL(19,5),
  exg_amount       DECIMAL(19,5),
  img_items        BIGINT,
  exg_items        BIGINT,
  contr_out        NVARCHAR(32),
  agree_no         NVARCHAR(32),
  pay_mode         NVARCHAR(1),
  input_er         NVARCHAR(10),
  store_vol        DECIMAL(19,5),
  store_area       DECIMAL(19,5),
  product_ratio    DECIMAL(19,5),
  note_amount      DECIMAL(19,5),
  foreign_mgr      NVARCHAR(32),
  in_ratio         DECIMAL(19,4),
  trans_mode       NVARCHAR(1),
  trade_country    NVARCHAR(3),
  license_no       NVARCHAR(20),
  i_e_port         NVARCHAR(1200),
  declare_type     NVARCHAR(1)
);

-- Add extended properties (SQL Server equivalent of Oracle comments) to the table
EXEC sp_addextendedproperty 
  @name = N'MS_Description', 
  @value = N'检并进系统-商品表头-业务表', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'EMS_HEAD_PRE';

-- Add extended properties (SQL Server equivalent of Oracle comments) to the columns 
EXEC sp_addextendedproperty 
  @name = N'MS_Description', @value = N'预录编号', 
  @level0type = N'SCHEMA', @level0name = N'dbo', 
  @level1type = N'TABLE', @level1name = N'EMS_HEAD_PRE', 
  @level2type = N'COLUMN', @level2name = N'pre_no';

-- (Additional column comments would continue here - similar pattern as before)

-- Create indexes 
CREATE INDEX IDX_EMS_HEAD_PRE_EMS_NO ON EMS_HEAD_PRE (EMS_NO);
CREATE INDEX IDX_EMS_HEAD_PRE_WORK_NO ON EMS_HEAD_PRE (WORK_NO);

-- Create/Recreate primary key constraint 
ALTER TABLE EMS_HEAD_PRE
  ADD CONSTRAINT PK_EMS_HEAD_PRE PRIMARY KEY (PRE_NO);