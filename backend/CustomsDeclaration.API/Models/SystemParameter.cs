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
    /// 参数选项（用于下拉框）
    /// </summary>
    public class ParameterOption
    {
        /// <summary>
        /// 选项值
        /// </summary>
        public string Value { get; set; } = string.Empty;

        /// <summary>
        /// 选项标签
        /// </summary>
        public string Label { get; set; } = string.Empty;
    }
}