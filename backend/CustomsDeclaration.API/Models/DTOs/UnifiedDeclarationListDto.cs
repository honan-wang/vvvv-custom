namespace CustomsDeclaration.API.Models.DTOs
{
    /// <summary>
    /// 单一申报列表项DTO
    /// </summary>
    public class UnifiedDeclarationListDto
    {
        /// <summary>
        /// 序号
        /// </summary>
        public int SerialNumber { get; set; }

        /// <summary>
        /// 核放单号
        /// </summary>
        public string DischargedNo { get; set; } = string.Empty;

        /// <summary>
        /// 申请单号
        /// </summary>
        public string ApplicationNo { get; set; } = string.Empty;

        /// <summary>
        /// 车牌号码
        /// </summary>
        public string CarNo { get; set; } = string.Empty;

        /// <summary>
        /// 项号（多个用逗号分隔）
        /// </summary>
        public string ItemNos { get; set; } = string.Empty;

        /// <summary>
        /// 货物品名（多个用逗号分隔）
        /// </summary>
        public string GoodsNames { get; set; } = string.Empty;

        /// <summary>
        /// 进出标志
        /// </summary>
        public string IEMark { get; set; } = string.Empty;

        /// <summary>
        /// 录入时间
        /// </summary>
        public DateTime? CreateTime { get; set; }

        /// <summary>
        /// 申报时间
        /// </summary>
        public DateTime? DeclareTime { get; set; }

        /// <summary>
        /// 核放单状态
        /// </summary>
        public string DischargedStatus { get; set; } = string.Empty;

        /// <summary>
        /// 申请单状态
        /// </summary>
        public string ApplicationStatus { get; set; } = string.Empty;

        /// <summary>
        /// 过卡时间
        /// </summary>
        public DateTime? PortTime { get; set; }

        /// <summary>
        /// 总重量
        /// </summary>
        public decimal TotalWeight { get; set; }

        /// <summary>
        /// 车辆自重
        /// </summary>
        public decimal CarWeight { get; set; }

        /// <summary>
        /// 货物重量
        /// </summary>
        public decimal GoodsWeight { get; set; }

        /// <summary>
        /// 区域标志
        /// </summary>
        public string AreaName { get; set; } = string.Empty;

        /// <summary>
        /// 核放单ID（用于编辑删除）
        /// </summary>
        public int DischargedId { get; set; }

        /// <summary>
        /// 申请单ID（用于编辑删除）
        /// </summary>
        public int ApplicationId { get; set; }
    }

    /// <summary>
    /// 单一申报列表查询请求DTO
    /// </summary>
    public class UnifiedDeclarationSearchRequestDto
    {
        /// <summary>
        /// 核放单号
        /// </summary>
        public string? DischargedNo { get; set; }

        /// <summary>
        /// 申请单号
        /// </summary>
        public string? ApplicationNo { get; set; }

        /// <summary>
        /// 车牌号码
        /// </summary>
        public string? CarNo { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string? Status { get; set; }

        /// <summary>
        /// 开始日期
        /// </summary>
        public DateTime? StartDate { get; set; }

        /// <summary>
        /// 结束日期
        /// </summary>
        public DateTime? EndDate { get; set; }

        /// <summary>
        /// 页码（从1开始）
        /// </summary>
        public int Page { get; set; } = 1;

        /// <summary>
        /// 每页大小
        /// </summary>
        public int Size { get; set; } = 20;
    }

    /// <summary>
    /// 单一申报详情DTO
    /// </summary>
    public class UnifiedDeclarationDetailDto
    {
        /// <summary>
        /// 核放单信息
        /// </summary>
        public Declaration DischargedInfo { get; set; } = new();

        /// <summary>
        /// 申请单表头信息
        /// </summary>
        public ApplicationHeaderDto? ApplicationHeader { get; set; }

        /// <summary>
        /// 申请单商品明细
        /// </summary>
        public List<GoodsItemDto> GoodsItems { get; set; } = new();
    }
}