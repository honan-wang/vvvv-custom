CREATE TABLE SYS_PARAMETERS
(
  para_type  VARCHAR(36) NOT NULL,
  para_code  VARCHAR(20) NOT NULL,
  para_name  VARCHAR(255),
  para_index NUMERIC(9) NOT NULL,
  used_flag  VARCHAR(1) NOT NULL,
  remark     VARCHAR(255)
);