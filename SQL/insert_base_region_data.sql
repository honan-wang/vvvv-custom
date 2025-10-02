-- 插入区域标志基础数据到BASE_REGION表
-- 先删除已有数据（如果有的话）
DELETE FROM BASE_REGION;

-- 插入区域标志数据
INSERT INTO BASE_REGION (code, name, flag) VALUES 
('1', '保税区', '1'),
('2', '出口加工区', '1'),
('3', '保税物流园区', '1'),
('4', '综合保税区', '1'),
('5', '保税港区', '1'),
('6', '跨境电商综合试验区', '1'),
('7', '自由贸易试验区', '1'),
('8', '海关特殊监管区域', '1');

-- 验证插入结果
SELECT code, name, flag FROM BASE_REGION WHERE flag = '1' ORDER BY code;

PRINT '区域标志基础数据插入完成';