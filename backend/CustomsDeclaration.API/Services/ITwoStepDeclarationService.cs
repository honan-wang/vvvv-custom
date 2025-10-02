using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Models.Enums;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 两步申报流程服务接口
    /// </summary>
    public interface ITwoStepDeclarationService
    {
        /// <summary>
        /// 第一步：提交申请单
        /// </summary>
        Task<ApiResponse<string>> SubmitApplicationAsync(string applicationNo, int userId);

        /// <summary>
        /// 第二步：提交核放单（自动触发）
        /// </summary>
        Task<ApiResponse<string>> SubmitDischargePermitAsync(string dischargedNo, int userId);

        /// <summary>
        /// 获取申报状态
        /// </summary>
        Task<ApiResponse<DeclarationStatus>> GetDeclarationStatusAsync(string dischargedNo);

        /// <summary>
        /// 检查并处理状态变化（后台服务调用）
        /// </summary>
        Task ProcessStatusChangesAsync();

        /// <summary>
        /// 重新申报（被退回后）
        /// </summary>
        Task<ApiResponse<string>> ResubmitDeclarationAsync(string businessNo, int userId);
    }
}