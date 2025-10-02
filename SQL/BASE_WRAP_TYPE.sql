CREATE TABLE BASE_WRAP_TYPE
(
  auto_id VARCHAR(36),
  code    VARCHAR(1) NOT NULL,
  name    VARCHAR(20),
  flag    VARCHAR(36)
);

-- Add comments to the table 
EXEC sp_addextendedproperty 
    'MS_Description', '基础资料-包装种类代码',
    'SCHEMA', 'dbo', 
    'TABLE', 'BASE_WRAP_TYPE';

-- Add comments to the columns 
EXEC sp_addextendedproperty 
    'MS_Description', '自动编号',
    'SCHEMA', 'dbo', 
    'TABLE', 'BASE_WRAP_TYPE', 
    'COLUMN', 'auto_id';

EXEC sp_addextendedproperty 
    'MS_Description', '代码',
    'SCHEMA', 'dbo', 
    'TABLE', 'BASE_WRAP_TYPE', 
    'COLUMN', 'code';

EXEC sp_addextendedproperty 
    'MS_Description', '名称',
    'SCHEMA', 'dbo', 
    'TABLE', 'BASE_WRAP_TYPE', 
    'COLUMN', 'name';

-- Create/Recreate primary key constraint
ALTER TABLE BASE_WRAP_TYPE
  ADD CONSTRAINT PK_BASE_WRAP_TYPE PRIMARY KEY (CODE);