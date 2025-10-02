namespace CustomsDeclaration.API.Models.Enums
{
    /// <summary>
    /// 申报状态枚举
    /// </summary>
    public enum DeclarationStatus
    {
        /// <summary>
        /// 草稿状态
        /// </summary>
        Draft = 0,

        /// <summary>
        /// 申请单已提交
        /// </summary>
        ApplicationSubmitted = 1,

        /// <summary>
        /// 申请单审批通过
        /// </summary>
        ApplicationApproved = 2,

        /// <summary>
        /// 核放单已提交
        /// </summary>
        DischargeSubmitted = 3,

        /// <summary>
        /// 核放单审批通过（申报完成）
        /// </summary>
        DischargeApproved = 4,

        /// <summary>
        /// 申请单被退回
        /// </summary>
        ApplicationRejected = -1,

        /// <summary>
        /// 核放单被退回
        /// </summary>
        DischargeRejected = -2
    }

    /// <summary>
    /// 申报状态扩展方法
    /// </summary>
    public static class DeclarationStatusExtensions
    {
        /// <summary>
        /// 获取状态描述
        /// </summary>
        public static string GetDescription(this DeclarationStatus status)
        {
            return status switch
            {
                DeclarationStatus.Draft => "草稿",
                DeclarationStatus.ApplicationSubmitted => "申请单已提交",
                DeclarationStatus.ApplicationApproved => "申请单审批通过",
                DeclarationStatus.DischargeSubmitted => "核放单已提交",
                DeclarationStatus.DischargeApproved => "申报完成",
                DeclarationStatus.ApplicationRejected => "申请单被退回",
                DeclarationStatus.DischargeRejected => "核放单被退回",
                _ => "未知状态"
            };
        }

        /// <summary>
        /// 判断是否可以进行下一步操作
        /// </summary>
        public static bool CanProceedToNext(this DeclarationStatus status)
        {
            return status switch
            {
                DeclarationStatus.Draft => true,
                DeclarationStatus.ApplicationApproved => true,
                DeclarationStatus.ApplicationRejected => true,
                DeclarationStatus.DischargeRejected => true,
                _ => false
            };
        }

        /// <summary>
        /// 判断是否正在等待审批
        /// </summary>
        public static bool IsPending(this DeclarationStatus status)
        {
            return status == DeclarationStatus.ApplicationSubmitted ||
                   status == DeclarationStatus.DischargeSubmitted;
        }

        /// <summary>
        /// 判断是否已完成
        /// </summary>
        public static bool IsCompleted(this DeclarationStatus status)
        {
            return status == DeclarationStatus.DischargeApproved;
        }

        /// <summary>
        /// 判断是否被退回
        /// </summary>
        public static bool IsRejected(this DeclarationStatus status)
        {
            return status == DeclarationStatus.ApplicationRejected ||
                   status == DeclarationStatus.DischargeRejected;
        }
    }
}