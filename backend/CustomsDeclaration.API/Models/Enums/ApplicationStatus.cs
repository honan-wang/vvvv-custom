namespace CustomsDeclaration.API.Models.Enums
{
    /// <summary>
    /// 申请单状态枚举（海关系统标准状态码）
    /// </summary>
    public enum ApplicationStatus
    {
        /// <summary>
        /// 预录入 - FBG100100
        /// </summary>
        PreEntry = 100100,

        /// <summary>
        /// 待审核 - FBG100200
        /// </summary>
        PendingReview = 100200,

        /// <summary>
        /// 审核通过 - FBG100300
        /// </summary>
        Approved = 100300,

        /// <summary>
        /// 退回 - FBG100400
        /// </summary>
        Rejected = 100400,

        /// <summary>
        /// 审核通过（另一状态码）- FBG100500
        /// </summary>
        ApprovedAlt = 100500,

        /// <summary>
        /// 查验通过 - FBG100600
        /// </summary>
        InspectionPassed = 100600,

        /// <summary>
        /// 作废 - FBG100900
        /// </summary>
        Cancelled = 100900
    }

    /// <summary>
    /// 申请单状态扩展方法
    /// </summary>
    public static class ApplicationStatusExtensions
    {
        /// <summary>
        /// 获取状态代码
        /// </summary>
        public static string GetStatusCode(this ApplicationStatus status)
        {
            return status switch
            {
                ApplicationStatus.PreEntry => "FBG100100",
                ApplicationStatus.PendingReview => "FBG100200",
                ApplicationStatus.Approved => "FBG100300",
                ApplicationStatus.Rejected => "FBG100400",
                ApplicationStatus.ApprovedAlt => "FBG100500",
                ApplicationStatus.InspectionPassed => "FBG100600",
                ApplicationStatus.Cancelled => "FBG100900",
                _ => "UNKNOWN"
            };
        }

        /// <summary>
        /// 获取状态描述
        /// </summary>
        public static string GetDescription(this ApplicationStatus status)
        {
            return status switch
            {
                ApplicationStatus.PreEntry => "预录入",
                ApplicationStatus.PendingReview => "待审核",
                ApplicationStatus.Approved => "审核通过",
                ApplicationStatus.Rejected => "退回",
                ApplicationStatus.ApprovedAlt => "审核通过",
                ApplicationStatus.InspectionPassed => "查验通过",
                ApplicationStatus.Cancelled => "作废",
                _ => "未知状态"
            };
        }

        /// <summary>
        /// 从状态代码解析状态
        /// </summary>
        public static ApplicationStatus FromStatusCode(string statusCode)
        {
            return statusCode switch
            {
                "FBG100100" => ApplicationStatus.PreEntry,
                "FBG100200" => ApplicationStatus.PendingReview,
                "FBG100300" => ApplicationStatus.Approved,
                "FBG100400" => ApplicationStatus.Rejected,
                "FBG100500" => ApplicationStatus.ApprovedAlt,
                "FBG100600" => ApplicationStatus.InspectionPassed,
                "FBG100900" => ApplicationStatus.Cancelled,
                _ => ApplicationStatus.PreEntry
            };
        }

        /// <summary>
        /// 判断是否为审核通过状态
        /// </summary>
        public static bool IsApproved(this ApplicationStatus status)
        {
            return status == ApplicationStatus.Approved ||
                   status == ApplicationStatus.ApprovedAlt ||
                   status == ApplicationStatus.InspectionPassed;
        }

        /// <summary>
        /// 判断是否为可继续处理的状态
        /// </summary>
        public static bool CanProceed(this ApplicationStatus status)
        {
            return status.IsApproved();
        }

        /// <summary>
        /// 判断是否为等待状态
        /// </summary>
        public static bool IsPending(this ApplicationStatus status)
        {
            return status == ApplicationStatus.PendingReview;
        }

        /// <summary>
        /// 判断是否为被退回状态
        /// </summary>
        public static bool IsRejected(this ApplicationStatus status)
        {
            return status == ApplicationStatus.Rejected;
        }

        /// <summary>
        /// 判断是否为最终状态（不可再变更）
        /// </summary>
        public static bool IsFinalStatus(this ApplicationStatus status)
        {
            return status == ApplicationStatus.InspectionPassed ||
                   status == ApplicationStatus.Cancelled;
        }

        /// <summary>
        /// 获取状态对应的Element UI标签类型
        /// </summary>
        public static string GetTagType(this ApplicationStatus status)
        {
            return status switch
            {
                ApplicationStatus.PreEntry => "info",
                ApplicationStatus.PendingReview => "warning",
                ApplicationStatus.Approved => "success",
                ApplicationStatus.Rejected => "danger",
                ApplicationStatus.ApprovedAlt => "success",
                ApplicationStatus.InspectionPassed => "success",
                ApplicationStatus.Cancelled => "info",
                _ => "info"
            };
        }
    }

    /// <summary>
    /// 申请单状态工具类
    /// </summary>
    public static class ApplicationStatusHelper
    {
        /// <summary>
        /// 获取所有状态选项（用于下拉框）
        /// </summary>
        public static List<(string Code, string Name)> GetAllStatusOptions()
        {
            return new List<(string Code, string Name)>
            {
                ("FBG100100", "预录入"),
                ("FBG100200", "待审核"),
                ("FBG100300,FBG100500", "审核通过"),
                ("FBG100400", "退回"),
                ("FBG100600", "查验通过"),
                ("FBG100900", "作废")
            };
        }

        /// <summary>
        /// 检查状态代码是否为审核通过
        /// </summary>
        public static bool IsApprovedStatusCode(string statusCode)
        {
            return statusCode == "FBG100300" ||
                   statusCode == "FBG100500" ||
                   statusCode == "FBG100600";
        }

        /// <summary>
        /// 获取状态代码对应的描述
        /// </summary>
        public static string GetStatusDescription(string statusCode)
        {
            return statusCode switch
            {
                "FBG100100" => "预录入",
                "FBG100200" => "待审核",
                "FBG100300" => "审核通过",
                "FBG100400" => "退回",
                "FBG100500" => "审核通过",
                "FBG100600" => "查验通过",
                "FBG100900" => "作废",
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
                "FBG100100" => "info",
                "FBG100200" => "warning",
                "FBG100300" => "success",
                "FBG100400" => "danger",
                "FBG100500" => "success",
                "FBG100600" => "success",
                "FBG100900" => "info",
                _ => "info"
            };
        }
    }
}