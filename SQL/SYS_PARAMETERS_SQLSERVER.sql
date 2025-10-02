-- 创建系统参数表
CREATE TABLE SYS_PARAMETERS
(
    PARA_TYPE  VARCHAR(36) NOT NULL,    -- 参数类型
    PARA_CODE  VARCHAR(20) NOT NULL,    -- 参数代码
    PARA_NAME  VARCHAR(255),            -- 参数名称  
    PARA_INDEX NUMERIC(9) NOT NULL,     -- 排序索引
    USED_FLAG  VARCHAR(1) NOT NULL,     -- 使用标志 (1:启用, 0:禁用)
    REMARK     VARCHAR(255)             -- 备注
);

-- 插入港口代码测试数据
INSERT INTO SYS_PARAMETERS (PARA_TYPE, PARA_CODE, PARA_NAME, PARA_INDEX, USED_FLAG, REMARK) 
VALUES 
-- 港口代码数据
('PORT_KA', '440300', '深圳', 1, '1', '深圳港口'),
('PORT_KA', '440100', '广州', 2, '1', '广州港口'),
('PORT_KA', '441900', '东莞', 3, '1', '东莞港口'),
('PORT_KA', '441300', '惠州', 4, '1', '惠州港口'),
('PORT_KA', 'HK', '香港', 5, '1', '香港港口'),
('PORT_KA', 'MO', '澳门', 6, '1', '澳门港口'),
('PORT_KA', 'SZW', '深圳湾', 7, '1', '深圳湾口岸'),
('PORT_KA', 'HG', '皇岗', 8, '1', '皇岗口岸'),
('PORT_KA', 'LMC', '罗湖', 9, '1', '罗湖口岸'),
('PORT_KA', 'FT', '福田', 10, '1', '福田口岸');

-- 可以为其他下拉框添加更多参数类型的数据，例如：

-- 包装种类
INSERT INTO SYS_PARAMETERS (PARA_TYPE, PARA_CODE, PARA_NAME, PARA_INDEX, USED_FLAG, REMARK) 
VALUES 
('PACK_TYPE', '1', '纸箱', 1, '1', '纸质包装箱'),
('PACK_TYPE', '2', '木箱', 2, '1', '木质包装箱'),
('PACK_TYPE', '3', '编织袋', 3, '1', '编织袋包装'),
('PACK_TYPE', '4', '托盘', 4, '1', '托盘包装'),
('PACK_TYPE', '5', '散装', 5, '1', '散装货物');

-- 区域标志
INSERT INTO SYS_PARAMETERS (PARA_TYPE, PARA_CODE, PARA_NAME, PARA_INDEX, USED_FLAG, REMARK) 
VALUES 
('AREA_CODE', '1', '保税区', 1, '1', '保税区域'),
('AREA_CODE', '2', '出口加工区', 2, '1', '出口加工区域'),
('AREA_CODE', '3', '保税物流园区', 3, '1', '保税物流园区域'),
('AREA_CODE', '4', '综合保税区', 4, '1', '综合保税区域');

-- 料件性质
INSERT INTO SYS_PARAMETERS (PARA_TYPE, PARA_CODE, PARA_NAME, PARA_INDEX, USED_FLAG, REMARK) 
VALUES 
('MATERIAL_NATURE', '1', '原材料', 1, '1', '生产原材料'),
('MATERIAL_NATURE', '2', '辅助材料', 2, '1', '辅助生产材料'),
('MATERIAL_NATURE', '3', '燃料', 3, '1', '生产燃料'),
('MATERIAL_NATURE', '4', '零部件', 4, '1', '生产零部件'),
('MATERIAL_NATURE', '5', '消耗品', 5, '1', '生产消耗品');

-- 计量单位
INSERT INTO SYS_PARAMETERS (PARA_TYPE, PARA_CODE, PARA_NAME, PARA_INDEX, USED_FLAG, REMARK) 
VALUES 
('UNIT', 'KG', '千克', 1, '1', '重量单位'),
('UNIT', 'PCS', '个', 2, '1', '数量单位'),
('UNIT', 'M', '米', 3, '1', '长度单位'),
('UNIT', 'SET', '套', 4, '1', '套装单位'),
('UNIT', 'TON', '吨', 5, '1', '重量单位'),
('UNIT', 'L', '升', 6, '1', '体积单位');