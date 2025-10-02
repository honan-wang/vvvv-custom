namespace CustomsDeclaration.API.Models.DTOs
{
    /// <summary>
    /// 保存申请单请求DTO
    /// </summary>
    public class SaveApplicationRequestDto
    {
        /// <summary>
        /// 申请单表头信息
        /// </summary>
        public ApplicationHeaderDto? Header { get; set; }

        /// <summary>
        /// 商品明细列表
        /// </summary>
        public List<GoodsItemDto>? GoodsItems { get; set; }
    }

    /// <summary>
    /// 申请单表头DTO
    /// </summary>
    public class ApplicationHeaderDto
    {
        /// <summary>
        /// 业务类型
        /// </summary>
        public string? BizType { get; set; }

        /// <summary>
        /// 业务模式
        /// </summary>
        public string? BizMode { get; set; }

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
        /// 备注
        /// </summary>
        public string? Note { get; set; }
    }
}