using CustomsDeclaration.API.Data;
using CustomsDeclaration.API.Models.Enums;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 海关状态码处理服务实现
    /// </summary>
    public class CustomsStatusService : ICustomsStatusService
    {
        private readonly IDbConnectionFactory _connectionFactory;
        private readonly ILogger<CustomsStatusService> _logger;
        private readonly DatabaseHelper _dbHelper;

        public CustomsStatusService(
            IDbConnectionFactory connectionFactory,
            ILogger<CustomsStatusService> logger,
            DatabaseHelper dbHelper)
        {
            _connectionFactory = connectionFactory;
            _logger = logger;
            _dbHelper = dbHelper;
        }

        /// <summary>
        /// 检查海关系统申请单状态
        /// </summary>
        public async Task<ApplicationStatus?> CheckApplicationStatusAsync(string applicationNo)
        {
            try
            {
                using var connection = _connectionFactory.CreateConnection();

                // 查询申请单状态（从FBG_HEAD_PRE表，根据STEP_ID判断状态）
                var sql = @"
                    SELECT STEP_ID FROM FBG_HEAD_PRE
                    WHERE GATEJOB_NO = @ApplicationNo";

                var stepId = await _dbHelper.ExecuteScalarAsync<string>(
                    connection, sql,
                    new { ApplicationNo = applicationNo });

                if (string.IsNullOrEmpty(stepId))
                {
                    return null;
                }

                // 实际项目中这里应该调用海关API获取最新状态
                // 这里模拟状态检查逻辑
                var currentStatus = await SimulateCustomsApiCheck(stepId);

                return ApplicationStatusExtensions.FromStatusCode(currentStatus);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"检查申请单状态失败，申请单号：{applicationNo}");
                return null;
            }
        }

        /// <summary>
        /// 检查海关系统核放单状态
        /// </summary>
        public async Task<DischargeStatus?> CheckDischargeStatusAsync(string dischargedNo)
        {
            try
            {
                using var connection = _connectionFactory.CreateConnection();

                // 查询核放单状态（从HF_HEAD_PRE表，根据STEP_ID判断状态）
                var sql = @"
                    SELECT STEP_ID FROM HF_HEAD_PRE
                    WHERE DISCHARGED_NO = @DischargedNo";

                var stepId = await _dbHelper.ExecuteScalarAsync<string>(
                    connection, sql,
                    new { DischargedNo = dischargedNo });

                if (string.IsNullOrEmpty(stepId))
                {
                    return null;
                }

                // 实际项目中这里应该调用海关API获取最新状态
                var currentStatus = await SimulateCustomsApiCheck(stepId);

                return DischargeStatusExtensions.FromStatusCode(currentStatus);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"检查核放单状态失败，核放单号：{dischargedNo}");
                return null;
            }
        }

        /// <summary>
        /// 判断申请单状态是否允许进行下一步
        /// </summary>
        public bool CanProceedToDischarge(ApplicationStatus status)
        {
            // 审核通过、审核通过（另一状态码）、查验通过 都可以进行下一步
            return status.IsApproved();
        }

        /// <summary>
        /// 判断核放单状态是否完成
        /// </summary>
        public bool IsDischargeCompleted(DischargeStatus status)
        {
            return status.IsApproved();
        }

        /// <summary>
        /// 将申请单状态转换为申报状态
        /// </summary>
        public DeclarationStatus ConvertApplicationToDeclarationStatus(ApplicationStatus applicationStatus)
        {
            return applicationStatus switch
            {
                ApplicationStatus.PreEntry => DeclarationStatus.Draft,
                ApplicationStatus.PendingReview => DeclarationStatus.ApplicationSubmitted,
                ApplicationStatus.Approved => DeclarationStatus.ApplicationApproved,
                ApplicationStatus.ApprovedAlt => DeclarationStatus.ApplicationApproved,
                ApplicationStatus.Rejected => DeclarationStatus.ApplicationRejected,
                ApplicationStatus.InspectionPassed => DeclarationStatus.ApplicationApproved,
                ApplicationStatus.Cancelled => DeclarationStatus.ApplicationRejected,
                _ => DeclarationStatus.Draft
            };
        }

        /// <summary>
        /// 将核放单状态转换为申报状态
        /// </summary>
        public DeclarationStatus ConvertDischargeToDeclarationStatus(DischargeStatus dischargeStatus)
        {
            return dischargeStatus switch
            {
                DischargeStatus.PreEntry => DeclarationStatus.DischargeSubmitted,
                DischargeStatus.PendingReview => DeclarationStatus.DischargeSubmitted,
                DischargeStatus.Approved => DeclarationStatus.DischargeApproved,
                DischargeStatus.ApprovedAlt => DeclarationStatus.DischargeApproved,
                DischargeStatus.Rejected => DeclarationStatus.DischargeRejected,
                DischargeStatus.InspectionPassed => DeclarationStatus.DischargeApproved,
                _ => DeclarationStatus.DischargeSubmitted
            };
        }

        #region 私有方法

        /// <summary>
        /// 模拟海关API状态检查
        /// 实际项目中应该调用真实的海关API
        /// </summary>
        private async Task<string> SimulateCustomsApiCheck(string currentStatusCode)
        {
            // 模拟网络延迟
            await Task.Delay(500);

            // 模拟状态变化逻辑
            var random = new Random();
            var changeChance = random.Next(1, 100);

            // 10% 概率状态发生变化
            if (changeChance <= 10)
            {
                return currentStatusCode switch
                {
                    "FBG100100" => "FBG100200", // 预录入 -> 待审核
                    "FBG100200" => changeChance <= 5 ? "FBG100400" : "FBG100300", // 待审核 -> 退回/审核通过
                    _ => currentStatusCode
                };
            }

            return currentStatusCode;
        }

        #endregion
    }
}