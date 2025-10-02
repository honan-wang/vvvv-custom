namespace CustomsDeclaration.API.Models.DTOs
{
    /// <summary>
    /// 商品明细DTO
    /// </summary>
    public class GoodsItemDto
    {
        /// <summary>
        /// 项号
        /// </summary>
        public string? ItemNo { get; set; }

        /// <summary>
        /// 商品名称
        /// </summary>
        public string? GoodsName { get; set; }

        /// <summary>
        /// 申报数量
        /// </summary>
        public decimal? Quantity { get; set; }

        /// <summary>
        /// 商品编码
        /// </summary>
        public string? GoodsCode { get; set; }

        /// <summary>
        /// 商品规格
        /// </summary>
        public string? Specification { get; set; }

        /// <summary>
        /// 计量单位
        /// </summary>
        public string? Unit { get; set; }

        /// <summary>
        /// 商品单价
        /// </summary>
        public decimal? UnitPrice { get; set; }

        /// <summary>
        /// 商品总价
        /// </summary>
        public decimal? TotalPrice { get; set; }

        /// <summary>
        /// 申报币值
        /// </summary>
        public string? Currency { get; set; }

        /// <summary>
        /// 料件性质
        /// </summary>
        public string? MaterialProperty { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string? Remark { get; set; }
    }
}