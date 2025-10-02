namespace CustomsDeclaration.API.Models
{
    /// <summary>
    /// 核放单表体实体 - HF_BODY_PRE 表
    /// </summary>
    public class HfBodyPre
    {
        /// <summary>
        /// 毛重
        /// </summary>
        public decimal? GrossWeight { get; set; }

        /// <summary>
        /// 包装件数
        /// </summary>
        public int? PackNo { get; set; }

        /// <summary>
        /// 关联业务单号
        /// </summary>
        public string? GatejobNoRel { get; set; }

        /// <summary>
        /// 核放单号
        /// </summary>
        public string? GatejobNo { get; set; }

        /// <summary>
        /// 放行单号
        /// </summary>
        public string? DischargedNo { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string? Status { get; set; }

        /// <summary>
        /// 自动ID
        /// </summary>
        public string? AutoId { get; set; }

        /// <summary>
        /// 最后车次
        /// </summary>
        public string? LastCar { get; set; }
    }
}