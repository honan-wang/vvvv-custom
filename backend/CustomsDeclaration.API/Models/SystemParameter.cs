namespace CustomsDeclaration.API.Models
{
    /// <summary>
    /// 系统参数模型
    /// </summary>
    public class SystemParameter
    {
        /// <summary>
        /// 参数代码
        /// </summary>
        public string ParaCode { get; set; } = string.Empty;

        /// <summary>
        /// 参数名称
        /// </summary>
        public string ParaName { get; set; } = string.Empty;

        /// <summary>
        /// 参数类型
        /// </summary>
        public string ParaType { get; set; } = string.Empty;

        /// <summary>
        /// 使用标志 (1:启用, 0:禁用)
        /// </summary>
        public string UsedFlag { get; set; } = string.Empty;

        /// <summary>
        /// 排序号
        /// </summary>
        public int? SortOrder { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string? Remark { get; set; }
    }

    /// <summary>
    /// Parameter option for dropdown selections.
    /// </summary>
    public class ParameterOption
    {
        /// <summary>
        /// Option value.
        /// </summary>
        public string Value { get; set; } = string.Empty;

        /// <summary>
        /// Option label.
        /// </summary>
        public string Label { get; set; } = string.Empty;

        /// <summary>
        /// Optional remark (used to distinguish import/export ports).
        /// </summary>
        public string? Remark { get; set; }
    }
}
