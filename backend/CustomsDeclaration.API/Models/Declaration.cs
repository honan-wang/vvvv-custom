using System.Text.Json.Serialization;

namespace CustomsDeclaration.API.Models
{
    /// <summary>
    /// 核放单实体类（基于HF_HEAD_PRE表）
    /// </summary>
    public class Declaration
    {
        /// <summary>
        /// 核放单ID
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// 核放单编号
        /// </summary>
        [JsonPropertyName("dischargedNo")]
        public string DischargedNo { get; set; } = string.Empty;

        /// <summary>
        /// 车牌号码
        /// </summary>
        [JsonPropertyName("carNo")]
        public string CarNo { get; set; } = string.Empty;

        /// <summary>
        /// 车重
        /// </summary>
        [JsonPropertyName("carWeight")]
        public decimal CarWeight { get; set; }

        /// <summary>
        /// 起始地
        /// </summary>
        [JsonPropertyName("startPlace")]
        public string StartPlace { get; set; } = string.Empty;

        /// <summary>
        /// 目的地
        /// </summary>
        [JsonPropertyName("destination")]
        public string Destination { get; set; } = string.Empty;

        /// <summary>
        /// 区域标志
        /// </summary>
        [JsonPropertyName("areaMark")]
        public string AreaMark { get; set; } = string.Empty;

        /// <summary>
        /// 总重量
        /// </summary>
        [JsonPropertyName("totalWeight")]
        public decimal TotalWeight { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [JsonPropertyName("remark")]
        public string Remark { get; set; } = string.Empty;

        /// <summary>
        /// 包装件数
        /// </summary>
        [JsonPropertyName("packageCount")]
        public int PackageCount { get; set; }

        /// <summary>
        /// 毛重
        /// </summary>
        [JsonPropertyName("grossWeight")]
        public decimal GrossWeight { get; set; }

        /// <summary>
        /// 包装种类
        /// </summary>
        [JsonPropertyName("packageType")]
        public string PackageType { get; set; } = string.Empty;

        /// <summary>
        /// 进出标志（I进口/E出口）
        /// </summary>
        [JsonPropertyName("ieMark")]
        public string IeMark { get; set; } = string.Empty;

        /// <summary>
        /// 料件性质
        /// </summary>
        [JsonPropertyName("materialType")]
        public string MaterialType { get; set; } = string.Empty;

        /// <summary>
        /// 账册号
        /// </summary>
        [JsonPropertyName("bookNo")]
        public string BookNo { get; set; } = string.Empty;

        /// <summary>
        /// 业务类型
        /// </summary>
        [JsonPropertyName("bizType")]
        public string BizType { get; set; } = string.Empty;

        /// <summary>
        /// 业务模式
        /// </summary>
        [JsonPropertyName("bizMode")]
        public string BizMode { get; set; } = string.Empty;

        /// <summary>
        /// 海关编码
        /// </summary>
        [JsonPropertyName("customsCode")]
        public string CustomsCode { get; set; } = string.Empty;

        /// <summary>
        /// 状态
        /// </summary>
        [JsonPropertyName("status")]
        public string Status { get; set; } = "draft";

        /// <summary>
        /// 创建时间
        /// </summary>
        [JsonPropertyName("createTime")]
        public DateTime CreateTime { get; set; } = DateTime.Now;

        /// <summary>
        /// 创建人ID
        /// </summary>
        [JsonPropertyName("createUserId")]
        public int CreateUserId { get; set; }

        /// <summary>
        /// 更新时间
        /// </summary>
        [JsonPropertyName("updateTime")]
        public DateTime? UpdateTime { get; set; }

        /// <summary>
        /// 商品明细列表
        /// </summary>
        [JsonPropertyName("goodsList")]
        public List<DeclarationGoods> GoodsList { get; set; } = new();
    }

    /// <summary>
    /// 核放单商品明细实体类
    /// </summary>
    public class DeclarationGoods
    {
        /// <summary>
        /// 明细ID
        /// </summary>
        [JsonPropertyName("id")]
        public int Id { get; set; }

        /// <summary>
        /// 核放单ID
        /// </summary>
        [JsonPropertyName("declarationId")]
        public int DeclarationId { get; set; }

        /// <summary>
        /// 项号
        /// </summary>
        [JsonPropertyName("itemNo")]
        public string ItemNo { get; set; } = string.Empty;

        /// <summary>
        /// 商品名称
        /// </summary>
        [JsonPropertyName("goodsName")]
        public string GoodsName { get; set; } = string.Empty;

        /// <summary>
        /// 申报数量
        /// </summary>
        [JsonPropertyName("declareQty")]
        public decimal DeclareQty { get; set; }

        /// <summary>
        /// 商品编码
        /// </summary>
        [JsonPropertyName("goodsCode")]
        public string GoodsCode { get; set; } = string.Empty;

        /// <summary>
        /// 商品规格
        /// </summary>
        [JsonPropertyName("goodsSpec")]
        public string GoodsSpec { get; set; } = string.Empty;

        /// <summary>
        /// 计量单位
        /// </summary>
        [JsonPropertyName("unit")]
        public string Unit { get; set; } = string.Empty;

        /// <summary>
        /// 商品单价
        /// </summary>
        [JsonPropertyName("unitPrice")]
        public decimal UnitPrice { get; set; }

        /// <summary>
        /// 商品总价
        /// </summary>
        [JsonPropertyName("totalPrice")]
        public decimal TotalPrice { get; set; }

        /// <summary>
        /// 申报币值
        /// </summary>
        [JsonPropertyName("currency")]
        public string Currency { get; set; } = string.Empty;

        /// <summary>
        /// 料件性质
        /// </summary>
        [JsonPropertyName("materialType")]
        public string MaterialType { get; set; } = string.Empty;

        /// <summary>
        /// 备注
        /// </summary>
        [JsonPropertyName("remark")]
        public string Remark { get; set; } = string.Empty;
    }

    /// <summary>
    /// 申报查询请求模型
    /// </summary>
    public class DeclarationSearchRequest
    {
        /// <summary>
        /// 核放单号（模糊查询）
        /// </summary>
        public string? DischargedNo { get; set; }

        /// <summary>
        /// 车牌号（模糊查询）
        /// </summary>
        public string? CarNo { get; set; }

        /// <summary>
        /// 进出标志
        /// </summary>
        public string? IeMark { get; set; }

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
        /// 页码
        /// </summary>
        public int Page { get; set; } = 1;

        /// <summary>
        /// 页大小
        /// </summary>
        public int Size { get; set; } = 20;
    }
}