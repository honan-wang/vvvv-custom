namespace CustomsDeclaration.API.Models
{
    /// <summary>
    /// 核放单商品明细实体 - HF_GJGOODS_PRE 表
    /// </summary>
    public class HfGjgoodsPre
    {
        /// <summary>
        /// 自动ID
        /// </summary>
        public string? AutoId { get; set; }

        /// <summary>
        /// 放行单号
        /// </summary>
        public string? DischargedNo { get; set; }

        /// <summary>
        /// 核放单号
        /// </summary>
        public string? GatejobNo { get; set; }

        /// <summary>
        /// 项号
        /// </summary>
        public int? GNo { get; set; }

        /// <summary>
        /// 商品编码
        /// </summary>
        public string? CodeTs { get; set; }

        /// <summary>
        /// 商品名称
        /// </summary>
        public string? GName { get; set; }

        /// <summary>
        /// 规格型号
        /// </summary>
        public string? GModel { get; set; }

        /// <summary>
        /// 申报数量
        /// </summary>
        public decimal? AppQty { get; set; }

        /// <summary>
        /// 申报单位
        /// </summary>
        public string? AppUnit { get; set; }

        /// <summary>
        /// 单价
        /// </summary>
        public decimal? DecPrice { get; set; }

        /// <summary>
        /// 币制
        /// </summary>
        public string? Curr { get; set; }

        /// <summary>
        /// 料件性质
        /// </summary>
        public string? MP { get; set; }

        /// <summary>
        /// 申请单商品明细关联ID
        /// </summary>
        public string? B2bAutoId { get; set; }
    }
}