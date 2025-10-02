using CustomsDeclaration.API.Models;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 系统参数服务接口
    /// </summary>
    public interface ISystemParameterService
    {
        /// <summary>
        /// 根据参数类型获取参数选项列表
        /// </summary>
        /// <param name="paraType">参数类型</param>
        /// <returns>参数选项列表</returns>
        Task<List<ParameterOption>> GetParameterOptionsAsync(string paraType);

        /// <summary>
        /// 获取所有系统参数
        /// </summary>
        /// <returns>系统参数列表</returns>
        Task<List<SystemParameter>> GetAllParametersAsync();

        /// <summary>
        /// 根据参数类型获取系统参数
        /// </summary>
        /// <param name="paraType">参数类型</param>
        /// <returns>系统参数列表</returns>
        Task<List<SystemParameter>> GetParametersByTypeAsync(string paraType);

        /// <summary>
        /// 根据企业编码获取账册号选项
        /// </summary>
        /// <param name="tradeCode">企业编码</param>
        /// <returns>账册号选项列表</returns>
        Task<List<ParameterOption>> GetBookOptionsAsync(string tradeCode);

        /// <summary>
        /// 获取计量单位选项
        /// </summary>
        /// <returns>计量单位选项列表</returns>
        Task<List<ParameterOption>> GetUnitOptionsAsync();

        /// <summary>
        /// 获取账册表体信息
        /// </summary>
        /// <param name="bookNo">账册号</param>
        /// <param name="itemNo">项号</param>
        /// <returns>账册表体信息</returns>
        Task<object?> GetBookItemInfoAsync(string bookNo, string itemNo);

        /// <summary>
        /// 获取币制选项
        /// </summary>
        /// <returns>币制选项列表</returns>
        Task<List<ParameterOption>> GetCurrencyOptionsAsync();
    }
}