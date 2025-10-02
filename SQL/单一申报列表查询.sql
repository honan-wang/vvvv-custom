-- 单一申报列表查询SQL脚本
-- 需要展示的栏位：序号、核放单号、申请单号、车牌号码、项号、货物品名、进出标志、录入时间、申报时间、核放单状态、申请单状态、过卡时间、总重量、车辆自重、货物重量、区域标志

-- 基础查询版本（聚合多个商品到一行）
SELECT
    ROW_NUMBER() OVER (ORDER BY hh.CREATE_DATE DESC) AS 序号,
    hh.DISCHARGED_NO AS 核放单号,
    hb.GATEJOB_NO AS 申请单号,
    hh.CAR_NO AS 车牌号码,
    STRING_AGG(CAST(fbb.G_NO AS VARCHAR), ',') AS 项号, -- 多个项号逗号分隔
    STRING_AGG(fbb.G_NAME, ',') AS 货物品名, -- 多个货物品名逗号分隔
    CASE
        WHEN fh.I_E_MARK = '1' THEN '进口'
        WHEN fh.I_E_MARK = '2' THEN '出口'
        ELSE '未知'
    END AS 进出标志,
    hh.CREATE_DATE AS 录入时间,
    hh.DECLARE_DATE AS 申报时间,
    CASE
        WHEN hh.STEP_ID IN ('HFD100300','HFD100500','HFD100600') AND hh.PORT_STATUS IN ('K03','K08') THEN '至卡口'
        WHEN hh.STEP_ID IN ('HFD100500') THEN '至卡口'
        ELSE
            CASE
                WHEN hh.STEP_ID IN ('HFD100500', 'HFD100600') THEN '审核通过'
                ELSE ISNULL((SELECT MAX(STEP_NAME) FROM SYS_STEP_PARAMETERS WHERE WORKFLOW_TYPE = 'HFD' AND STEP_ID = hh.STEP_ID), hh.STEP_ID)
            END
    END AS 核放单状态,
    CASE
        WHEN fh.STEP_ID = 'FBG100100' THEN '暂存'
        WHEN fh.STEP_ID = 'FBG100200' THEN '已申报'
        WHEN fh.STEP_ID = 'FBG100300' THEN '已审核'
        ELSE ISNULL((SELECT MAX(STEP_NAME) FROM SYS_STEP_PARAMETERS WHERE WORKFLOW_TYPE = 'FBG' AND STEP_ID = fh.STEP_ID), fh.STEP_ID)
    END AS 申请单状态,
    hh.PORT_DATE AS 过卡时间,
    hh.FACT_WEIGHT AS 总重量,
    hh.CAR_WT AS 车辆自重,
    (hh.FACT_WEIGHT - hh.CAR_WT) AS 货物重量,
    region.NAME AS 区域标志
FROM HF_HEAD_PRE hh
LEFT JOIN HF_BODY_PRE hb ON hh.DISCHARGED_NO = hb.DISCHARGED_NO
LEFT JOIN FBG_HEAD_PRE fh ON hb.GATEJOB_NO = fh.GATEJOB_NO
LEFT JOIN FBG_BODY_PRE fbb ON fh.GATEJOB_NO = fbb.GATEJOB_NO
LEFT JOIN BASE_REGION region ON region.CODE = hh.AREA_CODE
WHERE hh.TRADE_CODE = @CompanyCode -- 只显示当前企业的数据
GROUP BY hh.DISCHARGED_NO, hb.GATEJOB_NO, hh.CAR_NO, fh.I_E_MARK, hh.CREATE_DATE,
         hh.DECLARE_DATE, hh.STEP_ID, hh.PORT_STATUS, fh.STEP_ID, hh.PORT_DATE,
         hh.FACT_WEIGHT, hh.CAR_WT, region.NAME
ORDER BY hh.CREATE_DATE DESC;

-- 分页查询版本（用于前端分页，聚合多个商品到一行）
SELECT
    ROW_NUMBER() OVER (ORDER BY MAX(hh.CREATE_DATE) DESC) AS 序号,
    hh.DISCHARGED_NO AS 核放单号,
    hb.GATEJOB_NO AS 申请单号,
    hh.CAR_NO AS 车牌号码,
    STRING_AGG(CAST(fbb.G_NO AS VARCHAR), ',') AS 项号, -- 多个项号逗号分隔
    STRING_AGG(fbb.G_NAME, ',') AS 货物品名, -- 多个货物品名逗号分隔
    CASE
        WHEN fh.I_E_MARK = '1' THEN '进口'
        WHEN fh.I_E_MARK = '2' THEN '出口'
        ELSE '未知'
    END AS 进出标志,
    MAX(hh.CREATE_DATE) AS 录入时间,
    MAX(hh.DECLARE_DATE) AS 申报时间,
    CASE
        WHEN hh.STEP_ID IN ('HFD100300','HFD100500','HFD100600') AND hh.PORT_STATUS IN ('K03','K08') THEN '至卡口'
        WHEN hh.STEP_ID IN ('HFD100500') THEN '至卡口'
        ELSE
            CASE
                WHEN hh.STEP_ID IN ('HFD100500', 'HFD100600') THEN '审核通过'
                ELSE ISNULL((SELECT MAX(STEP_NAME) FROM SYS_STEP_PARAMETERS WHERE WORKFLOW_TYPE = 'HFD' AND STEP_ID = hh.STEP_ID), hh.STEP_ID)
            END
    END AS 核放单状态,
    CASE
        WHEN fh.STEP_ID = 'FBG100100' THEN '暂存'
        WHEN fh.STEP_ID = 'FBG100200' THEN '已申报'
        WHEN fh.STEP_ID = 'FBG100300' THEN '已审核'
        ELSE ISNULL((SELECT MAX(STEP_NAME) FROM SYS_STEP_PARAMETERS WHERE WORKFLOW_TYPE = 'FBG' AND STEP_ID = fh.STEP_ID), fh.STEP_ID)
    END AS 申请单状态,
    MAX(hh.PORT_DATE) AS 过卡时间,
    hh.FACT_WEIGHT AS 总重量,
    hh.CAR_WT AS 车辆自重,
    (hh.FACT_WEIGHT - hh.CAR_WT) AS 货物重量,
    region.NAME AS 区域标志,
    MAX(hh.ID) AS 核放单ID, -- 用于编辑和删除操作
    MAX(fh.ID) AS 申请单ID -- 用于编辑和删除操作
FROM HF_HEAD_PRE hh
LEFT JOIN HF_BODY_PRE hb ON hh.DISCHARGED_NO = hb.DISCHARGED_NO
LEFT JOIN FBG_HEAD_PRE fh ON hb.GATEJOB_NO = fh.GATEJOB_NO
LEFT JOIN FBG_BODY_PRE fbb ON fh.GATEJOB_NO = fbb.GATEJOB_NO
LEFT JOIN BASE_REGION region ON region.CODE = hh.AREA_CODE
WHERE hh.TRADE_CODE = @CompanyCode
    AND (@DischargedNo IS NULL OR hh.DISCHARGED_NO LIKE '%' + @DischargedNo + '%')
    AND (@GatejobNo IS NULL OR hb.GATEJOB_NO LIKE '%' + @GatejobNo + '%')
    AND (@CarNo IS NULL OR hh.CAR_NO LIKE '%' + @CarNo + '%')
    AND (@Status IS NULL OR hh.STEP_ID = @Status)
    AND (@StartDate IS NULL OR hh.CREATE_DATE >= @StartDate)
    AND (@EndDate IS NULL OR hh.CREATE_DATE <= @EndDate)
GROUP BY hh.DISCHARGED_NO, hb.GATEJOB_NO, hh.CAR_NO, fh.I_E_MARK,
         hh.STEP_ID, hh.PORT_STATUS, fh.STEP_ID,
         hh.FACT_WEIGHT, hh.CAR_WT, region.NAME
ORDER BY MAX(hh.CREATE_DATE) DESC
OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;

-- 总记录数查询
SELECT COUNT(DISTINCT hh.ID) AS TotalCount
FROM HF_HEAD_PRE hh
LEFT JOIN HF_BODY_PRE hb ON hh.DISCHARGED_NO = hb.DISCHARGED_NO
LEFT JOIN FBG_HEAD_PRE fh ON hb.GATEJOB_NO = fh.GATEJOB_NO
LEFT JOIN FBG_BODY_PRE fbb ON fh.GATEJOB_NO = fbb.GATEJOB_NO
LEFT JOIN BASE_REGION region ON region.CODE = hh.AREA_CODE
WHERE hh.TRADE_CODE = @CompanyCode
    AND (@DischargedNo IS NULL OR hh.DISCHARGED_NO LIKE '%' + @DischargedNo + '%')
    AND (@GatejobNo IS NULL OR hb.GATEJOB_NO LIKE '%' + @GatejobNo + '%')
    AND (@CarNo IS NULL OR hh.CAR_NO LIKE '%' + @CarNo + '%')
    AND (@Status IS NULL OR hh.STEP_ID = @Status)
    AND (@StartDate IS NULL OR hh.CREATE_DATE >= @StartDate)
    AND (@EndDate IS NULL OR hh.CREATE_DATE <= @EndDate);

-- Oracle版本的分页查询（聚合多个商品到一行）
SELECT * FROM (
    SELECT
        ROWNUM AS RN,
        ROW_NUMBER() OVER (ORDER BY MAX(hh.CREATE_DATE) DESC) AS 序号,
        hh.DISCHARGED_NO AS 核放单号,
        hb.GATEJOB_NO AS 申请单号,
        hh.CAR_NO AS 车牌号码,
        LISTAGG(fbb.G_NO, ',') WITHIN GROUP (ORDER BY fbb.G_NO) AS 项号, -- Oracle使用LISTAGG
        LISTAGG(fbb.G_NAME, ',') WITHIN GROUP (ORDER BY fbb.G_NO) AS 货物品名,
        CASE
            WHEN fh.I_E_MARK = 'I' THEN '进口'
            WHEN fh.I_E_MARK = 'E' THEN '出口'
            ELSE '未知'
        END AS 进出标志,
        MAX(hh.CREATE_DATE) AS 录入时间,
        MAX(hh.DECLARE_DATE) AS 申报时间,
        CASE
            WHEN hh.STEP_ID IN ('HFD100300','HFD100500','HFD100600') AND hh.PORT_STATUS IN ('K03','K08') THEN '至卡口'
            WHEN hh.STEP_ID IN ('HFD100500') THEN '至卡口'
            ELSE
                CASE
                    WHEN hh.STEP_ID IN ('HFD100500', 'HFD100600') THEN '审核通过'
                    ELSE NVL((SELECT MAX(STEP_NAME) FROM SYS_STEP_PARAMETERS WHERE WORKFLOW_TYPE = 'HFD' AND STEP_ID = hh.STEP_ID), hh.STEP_ID)
                END
        END AS 核放单状态,
        CASE
            WHEN fh.STEP_ID = 'FBG100100' THEN '暂存'
            WHEN fh.STEP_ID = 'FBG100200' THEN '已申报'
            WHEN fh.STEP_ID = 'FBG100300' THEN '已审核'
            ELSE NVL((SELECT MAX(STEP_NAME) FROM SYS_STEP_PARAMETERS WHERE WORKFLOW_TYPE = 'FBG' AND STEP_ID = fh.STEP_ID), fh.STEP_ID)
        END AS 申请单状态,
        MAX(hh.PORT_DATE) AS 过卡时间,
        hh.FACT_WEIGHT AS 总重量,
        hh.CAR_WT AS 车辆自重,
        (hh.FACT_WEIGHT - hh.CAR_WT) AS 货物重量,
        region.NAME AS 区域标志,
        MAX(hh.ID) AS 核放单ID,
        MAX(fh.ID) AS 申请单ID
    FROM HF_HEAD_PRE hh
    LEFT JOIN HF_BODY_PRE hb ON hh.DISCHARGED_NO = hb.DISCHARGED_NO
    LEFT JOIN FBG_HEAD_PRE fh ON hb.GATEJOB_NO = fh.GATEJOB_NO
    LEFT JOIN FBG_BODY_PRE fbb ON fh.GATEJOB_NO = fbb.GATEJOB_NO
    WHERE hh.TRADE_CODE = :CompanyCode
        AND (:DischargedNo IS NULL OR hh.DISCHARGED_NO LIKE '%' || :DischargedNo || '%')
        AND (:GatejobNo IS NULL OR hb.GATEJOB_NO LIKE '%' || :GatejobNo || '%')
        AND (:CarNo IS NULL OR hh.CAR_NO LIKE '%' || :CarNo || '%')
        AND (:Status IS NULL OR hh.STEP_ID = :Status)
        AND (:StartDate IS NULL OR hh.CREATE_DATE >= :StartDate)
        AND (:EndDate IS NULL OR hh.CREATE_DATE <= :EndDate)
    GROUP BY hh.DISCHARGED_NO, hb.GATEJOB_NO, hh.CAR_NO, fh.I_E_MARK,
             hh.STEP_ID, hh.PORT_STATUS, fh.STEP_ID,
             hh.FACT_WEIGHT, hh.CAR_WT, region.NAME
    ORDER BY MAX(hh.CREATE_DATE) DESC
) WHERE RN > :Offset AND RN <= (:Offset + :PageSize);

-- 说明：
-- 1. 主要关联表：
--    - HF_HEAD_PRE: 核放单表头（核心表）
--    - HF_BODY_PRE: 核放单表体（关联申请单）
--    - FBG_HEAD_PRE: 申请单表头
--    - FBG_BODY_PRE: 申请单表体（商品明细）

-- 2. 可能需要调整的字段：
--    - SUBMIT_DATE: 申报时间字段，需要确认实际字段名
--    - PASS_TIME: 过卡时间字段，需要确认实际字段名
--    - 状态值的具体含义需要根据实际业务确认

-- 3. 如果一个核放单对应多个商品，会产生多行记录
--    如果只需要显示核放单维度的汇总信息，可以使用GROUP BY

-- 4. 查询参数说明：
--    @CompanyCode: 企业编码（必填）
--    @DischargedNo: 核放单号（可选，模糊查询）
--    @GatejobNo: 申请单号（可选，模糊查询）
--    @CarNo: 车牌号码（可选，模糊查询）
--    @Status: 状态（可选，精确匹配）
--    @StartDate: 开始日期（可选）
--    @EndDate: 结束日期（可选）
--    @Offset: 分页偏移量
--    @PageSize: 页大小