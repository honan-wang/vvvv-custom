namespace CustomsDeclaration.API.Models
{
    /// <summary>
    /// 车辆信息实体类（基于BASE_VEHICLE表）
    /// </summary>
    public class Vehicle
    {
        /// <summary>
        /// 自动编号
        /// </summary>
        public string AutoId { get; set; } = string.Empty;

        /// <summary>
        /// 车牌号
        /// </summary>
        public string VehicleNo { get; set; } = string.Empty;

        /// <summary>
        /// 车辆类型/运输工具
        /// </summary>
        public string VehicleType { get; set; } = string.Empty;

        /// <summary>
        /// IC卡号
        /// </summary>
        public string IcCode { get; set; } = string.Empty;

        /// <summary>
        /// 电子车牌1
        /// </summary>
        public string EleNo1 { get; set; } = string.Empty;

        /// <summary>
        /// 电子车牌2
        /// </summary>
        public string EleNo2 { get; set; } = string.Empty;

        /// <summary>
        /// 电子车牌3
        /// </summary>
        public string EleNo3 { get; set; } = string.Empty;

        /// <summary>
        /// 车辆重量
        /// </summary>
        public decimal? VehicleWt { get; set; }

        /// <summary>
        /// 境外车牌号
        /// </summary>
        public string ForeignNo { get; set; } = string.Empty;

        /// <summary>
        /// 车辆性质，同:运输工具类型，待删
        /// </summary>
        public string VehicleNature { get; set; } = string.Empty;

        /// <summary>
        /// 使用性质
        /// </summary>
        public string UsedNature { get; set; } = string.Empty;

        /// <summary>
        /// 品牌型号
        /// </summary>
        public string BrandType { get; set; } = string.Empty;

        /// <summary>
        /// 发动机号码
        /// </summary>
        public string AmotorNo { get; set; } = string.Empty;

        /// <summary>
        /// 车辆识别代号
        /// </summary>
        public string DifferenceNo { get; set; } = string.Empty;

        /// <summary>
        /// 车辆国别
        /// </summary>
        public string VehicleNative { get; set; } = string.Empty;

        /// <summary>
        /// 载人范围，同载使用性质，待删
        /// </summary>
        public string Range { get; set; } = string.Empty;

        /// <summary>
        /// 车辆用途
        /// </summary>
        public string VehicleUsed { get; set; } = string.Empty;

        /// <summary>
        /// 许可证号
        /// </summary>
        public string LicenseNo { get; set; } = string.Empty;

        /// <summary>
        /// 载重量载
        /// </summary>
        public decimal? LoadWt { get; set; }

        /// <summary>
        /// 载客量
        /// </summary>
        public decimal? LoadPack { get; set; }

        /// <summary>
        /// 车辆颜色
        /// </summary>
        public string Colour { get; set; } = string.Empty;

        /// <summary>
        /// 证件有效期
        /// </summary>
        public DateTime? ValidityDate { get; set; }

        /// <summary>
        /// 备案日期
        /// </summary>
        public DateTime? RecordDate { get; set; }

        /// <summary>
        /// 注册登记日期
        /// </summary>
        public DateTime? RegisterDate { get; set; }

        /// <summary>
        /// 挂靠单位
        /// </summary>
        public string AttachedName { get; set; } = string.Empty;

        /// <summary>
        /// 经营企业编码
        /// </summary>
        public string TradeCode { get; set; } = string.Empty;

        /// <summary>
        /// 经营企业名称
        /// </summary>
        public string TradeName { get; set; } = string.Empty;

        /// <summary>
        /// 申请人
        /// </summary>
        public string AppPerson { get; set; } = string.Empty;

        /// <summary>
        /// 申请日期
        /// </summary>
        public DateTime? AppDate { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string Status { get; set; } = string.Empty;

        /// <summary>
        /// 海关编码
        /// </summary>
        public string CustomsCode { get; set; } = string.Empty;

        /// <summary>
        /// 备注
        /// </summary>
        public string Note { get; set; } = string.Empty;

        /// <summary>
        /// 区域代码
        /// </summary>
        public string AreaCode { get; set; } = string.Empty;

        /// <summary>
        /// 预留字段1
        /// </summary>
        public decimal? ExtendField1 { get; set; }

        /// <summary>
        /// 预留字段2
        /// </summary>
        public decimal? ExtendField2 { get; set; }

        /// <summary>
        /// 预留字段3
        /// </summary>
        public string ExtendField3 { get; set; } = string.Empty;

        /// <summary>
        /// 预留字段4
        /// </summary>
        public string ExtendField4 { get; set; } = string.Empty;

        /// <summary>
        /// 预留字段5
        /// </summary>
        public string ExtendField5 { get; set; } = string.Empty;
    }

    /// <summary>
    /// 车辆查询请求模型
    /// </summary>
    public class VehicleSearchRequest
    {
        /// <summary>
        /// 车牌号（模糊查询）
        /// </summary>
        public string? VehicleNo { get; set; }

        /// <summary>
        /// 车辆类型
        /// </summary>
        public string? VehicleType { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string? Status { get; set; }

        /// <summary>
        /// 经营企业编码
        /// </summary>
        public string? TradeCode { get; set; }

        /// <summary>
        /// 经营企业名称（模糊查询）
        /// </summary>
        public string? TradeName { get; set; }

        /// <summary>
        /// 页码
        /// </summary>
        public int Page { get; set; } = 1;

        /// <summary>
        /// 页大小
        /// </summary>
        public int Size { get; set; } = 20;
    }

    /// <summary>
    /// 车辆搜索结果模型（用于自动完成）
    /// </summary>
    public class VehicleSearchResult
    {
        /// <summary>
        /// 自动编号
        /// </summary>
        public string AutoId { get; set; } = string.Empty;

        /// <summary>
        /// 车牌号
        /// </summary>
        public string VehicleNo { get; set; } = string.Empty;

        /// <summary>
        /// 车辆类型
        /// </summary>
        public string VehicleType { get; set; } = string.Empty;

        /// <summary>
        /// 车辆重量
        /// </summary>
        public decimal? VehicleWt { get; set; }

        /// <summary>
        /// 载重量
        /// </summary>
        public decimal? LoadWt { get; set; }

        /// <summary>
        /// 经营企业名称
        /// </summary>
        public string TradeName { get; set; } = string.Empty;
    }

    /// <summary>
    /// 车辆创建/更新请求模型
    /// </summary>
    public class VehicleRequest
    {
        /// <summary>
        /// 车牌号
        /// </summary>
        public string VehicleNo { get; set; } = string.Empty;

        /// <summary>
        /// 车辆类型/运输工具
        /// </summary>
        public string VehicleType { get; set; } = string.Empty;

        /// <summary>
        /// IC卡号
        /// </summary>
        public string IcCode { get; set; } = string.Empty;

        /// <summary>
        /// 电子车牌1
        /// </summary>
        public string EleNo1 { get; set; } = string.Empty;

        /// <summary>
        /// 电子车牌2
        /// </summary>
        public string EleNo2 { get; set; } = string.Empty;

        /// <summary>
        /// 电子车牌3
        /// </summary>
        public string EleNo3 { get; set; } = string.Empty;

        /// <summary>
        /// 车辆重量
        /// </summary>
        public decimal? VehicleWt { get; set; }

        /// <summary>
        /// 境外车牌号
        /// </summary>
        public string ForeignNo { get; set; } = string.Empty;

        /// <summary>
        /// 车辆性质，同:运输工具类型，待删
        /// </summary>
        public string VehicleNature { get; set; } = string.Empty;

        /// <summary>
        /// 使用性质
        /// </summary>
        public string UsedNature { get; set; } = string.Empty;

        /// <summary>
        /// 品牌型号
        /// </summary>
        public string BrandType { get; set; } = string.Empty;

        /// <summary>
        /// 发动机号码
        /// </summary>
        public string AmotorNo { get; set; } = string.Empty;

        /// <summary>
        /// 车辆识别代号
        /// </summary>
        public string DifferenceNo { get; set; } = string.Empty;

        /// <summary>
        /// 车辆国别
        /// </summary>
        public string VehicleNative { get; set; } = string.Empty;

        /// <summary>
        /// 载人范围，同载使用性质，待删
        /// </summary>
        public string Range { get; set; } = string.Empty;

        /// <summary>
        /// 车辆用途
        /// </summary>
        public string VehicleUsed { get; set; } = string.Empty;

        /// <summary>
        /// 许可证号
        /// </summary>
        public string LicenseNo { get; set; } = string.Empty;

        /// <summary>
        /// 载重量载
        /// </summary>
        public decimal? LoadWt { get; set; }

        /// <summary>
        /// 载客量
        /// </summary>
        public decimal? LoadPack { get; set; }

        /// <summary>
        /// 车辆颜色
        /// </summary>
        public string Colour { get; set; } = string.Empty;

        /// <summary>
        /// 证件有效期
        /// </summary>
        public DateTime? ValidityDate { get; set; }

        /// <summary>
        /// 备案日期
        /// </summary>
        public DateTime? RecordDate { get; set; }

        /// <summary>
        /// 注册登记日期
        /// </summary>
        public DateTime? RegisterDate { get; set; }

        /// <summary>
        /// 挂靠单位
        /// </summary>
        public string AttachedName { get; set; } = string.Empty;

        /// <summary>
        /// 经营企业编码
        /// </summary>
        public string TradeCode { get; set; } = string.Empty;

        /// <summary>
        /// 经营企业名称
        /// </summary>
        public string TradeName { get; set; } = string.Empty;

        /// <summary>
        /// 申请人
        /// </summary>
        public string AppPerson { get; set; } = string.Empty;

        /// <summary>
        /// 申请日期
        /// </summary>
        public DateTime? AppDate { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string Status { get; set; } = string.Empty;

        /// <summary>
        /// 海关编码
        /// </summary>
        public string CustomsCode { get; set; } = string.Empty;

        /// <summary>
        /// 备注
        /// </summary>
        public string Note { get; set; } = string.Empty;

        /// <summary>
        /// 区域代码
        /// </summary>
        public string AreaCode { get; set; } = string.Empty;

        /// <summary>
        /// 预留字段1
        /// </summary>
        public decimal? ExtendField1 { get; set; }

        /// <summary>
        /// 预留字段2
        /// </summary>
        public decimal? ExtendField2 { get; set; }

        /// <summary>
        /// 预留字段3
        /// </summary>
        public string ExtendField3 { get; set; } = string.Empty;

        /// <summary>
        /// 预留字段4
        /// </summary>
        public string ExtendField4 { get; set; } = string.Empty;

        /// <summary>
        /// 预留字段5
        /// </summary>
        public string ExtendField5 { get; set; } = string.Empty;
    }
}