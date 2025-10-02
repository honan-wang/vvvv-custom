namespace CustomsDeclaration.API.Models.Enums
{
    /// <summary>
    /// 核放单状态枚举（海关系统标准状态码）
    /// </summary>
    public enum DischargeStatus
    {
        /// <summary>
        /// 预录入 - HFD100100
        /// </summary>
        PreEntry = 100100,

        /// <summary>
        /// 待审核 - HFD100200
        /// </summary>
        PendingReview = 100200,

        /// <summary>
        /// 审核通过 - HFD100300
        /// </summary>
        Approved = 100300,

        /// <summary>
        /// 退回 - HFD100400
        /// </summary>
        Rejected = 100400,

        /// <summary>
        /// 审核通过（另一状态码）- HFD100500
        /// </summary>
        ApprovedAlt = 100500,

        /// <summary>
        /// 查验通过 - HFD100600
        /// </summary>
        InspectionPassed = 100600
    }

    /// <summary>
    /// 核放单状态扩展方法
    /// </summary>
    public static class DischargeStatusExtensions
    {
        /// <summary>
        /// 获取状态代码
        /// </summary>
        public static string GetStatusCode(this DischargeStatus status)
        {
            return status switch
            {
                DischargeStatus.PreEntry => "HFD100100",
                DischargeStatus.PendingReview => "HFD100200",
                DischargeStatus.Approved => "HFD100300",
                DischargeStatus.Rejected => "HFD100400",
                DischargeStatus.ApprovedAlt => "HFD100500",
                DischargeStatus.InspectionPassed => "HFD100600",
                _ => "UNKNOWN"
            };
        }

        /// <summary>
        /// 获取状态描述
        /// </summary>
        public static string GetDescription(this DischargeStatus status)
        {
            return status switch
            {
                DischargeStatus.PreEntry => "预录入",
                DischargeStatus.PendingReview => "待审核",
                DischargeStatus.Approved => "审核通过",
                DischargeStatus.Rejected => "退回",
                DischargeStatus.ApprovedAlt => "审核通过",
                DischargeStatus.InspectionPassed => "查验通过",
                _ => "未知状态"
            };
        }

        /// <summary>
        /// 从状态代码解析状态
        /// </summary>
        public static DischargeStatus FromStatusCode(string statusCode)
        {
            return statusCode switch
            {
                "HFD100100" => DischargeStatus.PreEntry,
                "HFD100200" => DischargeStatus.PendingReview,
                "HFD100300" => DischargeStatus.Approved,
                "HFD100400" => DischargeStatus.Rejected,
                "HFD100500" => DischargeStatus.ApprovedAlt,
                "HFD100600" => DischargeStatus.InspectionPassed,
                _ => DischargeStatus.PreEntry
            };
        }

        /// <summary>
        /// 判断是否为审核通过状态
        /// </summary>
        public static bool IsApproved(this DischargeStatus status)
        {
            return status == DischargeStatus.Approved ||
                   status == DischargeStatus.ApprovedAlt ||
                   status == DischargeStatus.InspectionPassed;
        }

        /// <summary>
        /// 判断是否为可完成状态
        /// </summary>
        public static bool CanComplete(this DischargeStatus status)
        {
            return status.IsApproved();
        }

        /// <summary>
        /// 判断是否为等待状态
        /// </summary>
        public static bool IsPending(this DischargeStatus status)
        {
            return status == DischargeStatus.PendingReview;
        }

        /// <summary>
        /// 判断是否为被退回状态
        /// </summary>
        public static bool IsRejected(this DischargeStatus status)
        {
            return status == DischargeStatus.Rejected;
        }

        /// <summary>
        /// 判断是否为最终状态（不可再变更）
        /// </summary>
        public static bool IsFinalStatus(this DischargeStatus status)
        {
            return status == DischargeStatus.InspectionPassed;
        }

        /// <summary>
        /// 获取状态对应的Element UI标签类型
        /// </summary>
        public static string GetTagType(this DischargeStatus status)
        {
            return status switch
            {
                DischargeStatus.PreEntry => "info",
                DischargeStatus.PendingReview => "warning",
                DischargeStatus.Approved => "success",
                DischargeStatus.Rejected => "danger",
                DischargeStatus.ApprovedAlt => "success",
                DischargeStatus.InspectionPassed => "success",
                _ => "info"
            };
        }
    }

    /// <summary>
    /// 核放单状态工具类
    /// </summary>
    public static class DischargeStatusHelper
    {
        /// <summary>
        /// 获取所有状态选项（用于下拉框）
        /// </summary>
        public static List<(string Code, string Name)> GetAllStatusOptions()
        {
            return new List<(string Code, string Name)>
            {
                ("HFD100100", "预录入"),
                ("HFD100200", "待审核"),
                ("HFD100300,HFD100500", "审核通过"),
                ("HFD100400", "退回"),
                ("HFD100600", "查验通过")
            };
        }

        /// <summary>
        /// 检查状态代码是否为审核通过
        /// </summary>
        public static bool IsApprovedStatusCode(string statusCode)
        {
            return statusCode == "HFD100300" ||
                   statusCode == "HFD100500" ||
                   statusCode == "HFD100600";
        }

        /// <summary>
        /// 获取状态代码对应的描述
        /// </summary>
        public static string GetStatusDescription(string statusCode)
        {
            return statusCode switch
            {
                "HFD100100" => "预录入",
                "HFD100200" => "待审核",
                "HFD100300" => "审核通过",
                "HFD100400" => "退回",
                "HFD100500" => "审核通过",
                "HFD100600" => "查验通过",
                _ => "未知状态"
            };
        }

        /// <summary>
        /// 获取状态代码对应的标签类型
        /// </summary>
        public static string GetStatusTagType(string statusCode)
        {
            return statusCode switch
            {
                "HFD100100" => "info",
                "HFD100200" => "warning",
                "HFD100300" => "success",
                "HFD100400" => "danger",
                "HFD100500" => "success",
                "HFD100600" => "success",
                _ => "info"
            };
        }
    }
}