using CustomsDeclaration.API.Models.Enums;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 海关状态码处理服务接口
    /// </summary>
    public interface ICustomsStatusService
    {
        /// <summary>
        /// 检查海关系统申请单状态
        /// </summary>
        Task<ApplicationStatus?> CheckApplicationStatusAsync(string dischargedNo);

        /// <summary>
        /// 检查海关系统核放单状态
        /// </summary>
        Task<DischargeStatus?> CheckDischargeStatusAsync(string dischargedNo);

        /// <summary>
        /// 判断申请单状态是否允许进行下一步
        /// </summary>
        bool CanProceedToDischarge(ApplicationStatus status);

        /// <summary>
        /// 判断核放单状态是否完成
        /// </summary>
        bool IsDischargeCompleted(DischargeStatus status);

        /// <summary>
        /// 将申请单状态转换为申报状态
        /// </summary>
        DeclarationStatus ConvertApplicationToDeclarationStatus(ApplicationStatus applicationStatus);

        /// <summary>
        /// 将核放单状态转换为申报状态
        /// </summary>
        DeclarationStatus ConvertDischargeToDeclarationStatus(DischargeStatus dischargeStatus);
    }
}