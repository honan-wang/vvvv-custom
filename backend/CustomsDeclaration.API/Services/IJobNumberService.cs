namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 业务单号生成服务接口
    /// </summary>
    public interface IJobNumberService
    {
        /// <summary>
        /// 获取业务单号
        /// 调用存储过程 SP_GET_JOB_NO
        /// </summary>
        /// <param name="bizType">业务类型，如KA10、LF、U、E等</param>
        /// <param name="tradeCode">企业代码</param>
        /// <param name="customsCode">海关代码</param>
        /// <returns>业务单号</returns>
        Task<string> GetJobNumberAsync(string bizType = "HF", string? tradeCode = null, string? customsCode = null);

        /// <summary>
        /// 获取业务单号（兼容原方法）
        /// </summary>
        /// <returns>业务单号</returns>
        Task<string> GetJobNumberAsync();
    }
}