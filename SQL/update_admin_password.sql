-- 更新admin用户密码为honan123
-- BCrypt哈希: $2a$11$6T6AqxdXWRzNY/M7x6naP.kX.4Ky1oo2zrBl3uSq8XFeUCYVRH9jK

UPDATE SYS_USERS 
SET PasswordHash = '$2a$11$6T6AqxdXWRzNY/M7x6naP.kX.4Ky1oo2zrBl3uSq8XFeUCYVRH9jK'
WHERE Username = 'admin';

-- 验证更新结果
SELECT Username, PasswordHash, Role, IsActive, CustomsCode, CustomsName, CompanyName, CompanyCode 
FROM SYS_USERS 
WHERE Username = 'admin';

PRINT 'admin用户密码已更新为: honan123';