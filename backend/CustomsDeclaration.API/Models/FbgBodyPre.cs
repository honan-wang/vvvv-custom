namespace CustomsDeclaration.API.Models
{
    /// <summary>
    /// 申请单表体实体 - FBG_BODY_PRE 表
    /// </summary>
    public class FbgBodyPre
    {
        /// <summary>
        /// 海关代码
        /// </summary>
        public string? CustomsCode { get; set; }

        /// <summary>
        /// 申请单号(业务单号) - 关联 FBG_HEAD_PRE.GATEJOB_NO
        /// </summary>
        public string? GatejobNo { get; set; }

        /// <summary>
        /// 项号
        /// </summary>
        public int? GNo { get; set; }

        /// <summary>
        /// 账册号
        /// </summary>
        public string? EmsNo { get; set; }

        /// <summary>
        /// 备案序号
        /// </summary>
        public string? RecordNo { get; set; }

        /// <summary>
        /// 料件性质
        /// </summary>
        public string? MP { get; set; }

        /// <summary>
        /// 商品编号
        /// </summary>
        public string? GoodsCode { get; set; }

        /// <summary>
        /// 商品名称
        /// </summary>
        public string? GoodsName { get; set; }

        /// <summary>
        /// 商品规格
        /// </summary>
        public string? GoodsSpec { get; set; }

        /// <summary>
        /// 申报数量
        /// </summary>
        public decimal? DeclQty { get; set; }

        /// <summary>
        /// 申报单位
        /// </summary>
        public string? DeclUnit { get; set; }

        /// <summary>
        /// 法定数量
        /// </summary>
        public decimal? LegalQty { get; set; }

        /// <summary>
        /// 法定单位
        /// </summary>
        public string? LegalUnit { get; set; }

        /// <summary>
        /// 单价
        /// </summary>
        public decimal? UnitPrice { get; set; }

        /// <summary>
        /// 总价
        /// </summary>
        public decimal? TotalPrice { get; set; }

        /// <summary>
        /// 币制
        /// </summary>
        public string? Currency { get; set; }

        /// <summary>
        /// 净重
        /// </summary>
        public decimal? NetWeight { get; set; }

        /// <summary>
        /// 毛重
        /// </summary>
        public decimal? GrossWeight { get; set; }

        /// <summary>
        /// 原产国
        /// </summary>
        public string? OriginCountry { get; set; }

        /// <summary>
        /// 最终目的国
        /// </summary>
        public string? DestCountry { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string? Note { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string? CreatePerson { get; set; }

        /// <summary>
        /// 创建日期
        /// </summary>
        public DateTime? CreateDate { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string? Status { get; set; }
    }
}
