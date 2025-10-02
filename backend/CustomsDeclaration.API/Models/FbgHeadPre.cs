namespace CustomsDeclaration.API.Models
{
    /// <summary>
    /// 申请单表头实体 - FBG_HEAD_PRE 表
    /// </summary>
    public class FbgHeadPre
    {
        /// <summary>
        /// 海关代码
        /// </summary>
        public string? CustomsCode { get; set; }

        /// <summary>
        /// 业务单号(申请单号) - 调用SP_GET_JOB_NO生成
        /// </summary>
        public string? GatejobNo { get; set; }

        /// <summary>
        /// 业务类型
        /// </summary>
        public string? BizType { get; set; }

        /// <summary>
        /// 业务模式
        /// </summary>
        public string? BizMode { get; set; }

        /// <summary>
        /// 通行证号
        /// </summary>
        public string? GatepassNo { get; set; }

        /// <summary>
        /// 进出标志 (1:进场, 2:出场)
        /// </summary>
        public string? IEMark { get; set; }

        /// <summary>
        /// 货物流向
        /// </summary>
        public string? GoodsFlow { get; set; }

        /// <summary>
        /// 账册号
        /// </summary>
        public string? EmsNo { get; set; }

        /// <summary>
        /// 料件性质
        /// </summary>
        public string? MP { get; set; }

        /// <summary>
        /// 运输方式
        /// </summary>
        public string? TransferMode { get; set; }

        /// <summary>
        /// 担保类型
        /// </summary>
        public string? GuaranteType { get; set; }

        /// <summary>
        /// 担保号码
        /// </summary>
        public string? GuaranteNo { get; set; }

        /// <summary>
        /// 担保编号
        /// </summary>
        public string? GuaranteId { get; set; }

        /// <summary>
        /// 担保金额
        /// </summary>
        public string? GuarantePrice { get; set; }

        /// <summary>
        /// 担保说明
        /// </summary>
        public string? GuaranteDesc { get; set; }

        /// <summary>
        /// 贸易代码
        /// </summary>
        public string? TradeCode { get; set; }

        /// <summary>
        /// 贸易名称
        /// </summary>
        public string? TradeName { get; set; }

        /// <summary>
        /// 供应商代码
        /// </summary>
        public string? ProviderCode { get; set; }

        /// <summary>
        /// 供应商名称
        /// </summary>
        public string? ProviderName { get; set; }

        /// <summary>
        /// 区域代码
        /// </summary>
        public string? AreaCode { get; set; }

        /// <summary>
        /// 净重
        /// </summary>
        public decimal? NetWeight { get; set; }

        /// <summary>
        /// 毛重
        /// </summary>
        public decimal? GrossWeight { get; set; }

        /// <summary>
        /// 对应单号
        /// </summary>
        public string? CorrespondNo { get; set; }

        /// <summary>
        /// 包装件数
        /// </summary>
        public int? PackNo { get; set; }

        /// <summary>
        /// 包装种类
        /// </summary>
        public string? PackType { get; set; }

        /// <summary>
        /// 车牌号
        /// </summary>
        public string? LicensePlate { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string? CreatePerson { get; set; }

        /// <summary>
        /// 创建日期
        /// </summary>
        public DateTime? CreateDate { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string? Note { get; set; }

        /// <summary>
        /// 录入代码
        /// </summary>
        public string? InputCode { get; set; }

        /// <summary>
        /// 录入名称
        /// </summary>
        public string? InputName { get; set; }

        /// <summary>
        /// 操作类型
        /// </summary>
        public string? OperType { get; set; }

        /// <summary>
        /// 步骤ID
        /// </summary>
        public string? StepId { get; set; }
    }
}