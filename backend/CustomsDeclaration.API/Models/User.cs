using System.ComponentModel.DataAnnotations;

namespace CustomsDeclaration.API.Models
{
    /// <summary>
    /// 用户实体类
    /// </summary>
    public class User
    {
        /// <summary>
        /// 用户ID
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// 用户名
        /// </summary>
        public string Username { get; set; } = string.Empty;

        /// <summary>
        /// 密码（哈希值）
        /// </summary>
        public string PasswordHash { get; set; } = string.Empty;

        /// <summary>
        /// 角色
        /// </summary>
        public string Role { get; set; } = string.Empty;

        /// <summary>
        /// 状态（启用/禁用）
        /// </summary>
        public bool IsActive { get; set; } = true;

        /// <summary>
        /// 企业海关关区代码
        /// </summary>
        public string CustomsCode { get; set; } = string.Empty;

        /// <summary>
        /// 企业海关关区名称
        /// </summary>
        public string CustomsName { get; set; } = string.Empty;

        /// <summary>
        /// 企业10位注册编码
        /// </summary>
        public string CompanyCode { get; set; } = string.Empty;

        /// <summary>
        /// 企业名称
        /// </summary>
        public string CompanyName { get; set; } = string.Empty;

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; } = DateTime.Now;

        /// <summary>
        /// 最后登录时间
        /// </summary>
        public DateTime? LastLoginTime { get; set; }
    }

    /// <summary>
    /// 登录请求模型
    /// </summary>
    public class LoginRequest
    {
        /// <summary>
        /// 用户名
        /// </summary>
        public string Username { get; set; } = string.Empty;

        /// <summary>
        /// 密码
        /// </summary>
        public string Password { get; set; } = string.Empty;
    }

    /// <summary>
    /// 登录响应模型
    /// </summary>
    public class LoginResponse
    {
        /// <summary>
        /// 访问令牌
        /// </summary>
        public string AccessToken { get; set; } = string.Empty;

        /// <summary>
        /// 令牌类型
        /// </summary>
        public string TokenType { get; set; } = "Bearer";

        /// <summary>
        /// 过期时间（秒）
        /// </summary>
        public int ExpiresIn { get; set; }

        /// <summary>
        /// 用户信息
        /// </summary>
        public UserInfo UserInfo { get; set; } = new();
    }

    /// <summary>
    /// 用户信息模型
    /// </summary>
    public class UserInfo
    {
        /// <summary>
        /// 用户ID
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// 用户名
        /// </summary>
        public string Username { get; set; } = string.Empty;

        /// <summary>
        /// 角色
        /// </summary>
        public string Role { get; set; } = string.Empty;

        /// <summary>
        /// 企业海关关区代码
        /// </summary>
        public string CustomsCode { get; set; } = string.Empty;

        /// <summary>
        /// 企业海关关区名称
        /// </summary>
        public string CustomsName { get; set; } = string.Empty;

        /// <summary>
        /// 企业10位注册编码
        /// </summary>
        public string CompanyCode { get; set; } = string.Empty;

        /// <summary>
        /// 企业名称
        /// </summary>
        public string CompanyName { get; set; } = string.Empty;
    }

    /// <summary>
    /// 用户创建请求模型
    /// </summary>
    public class CreateUserRequest
    {
        /// <summary>
        /// 用户名
        /// </summary>
        [Required(ErrorMessage = "用户名不能为空")]
        [StringLength(50, ErrorMessage = "用户名长度不能超过50个字符")]
        public string Username { get; set; } = string.Empty;

        /// <summary>
        /// 密码
        /// </summary>
        [Required(ErrorMessage = "密码不能为空")]
        [MinLength(6, ErrorMessage = "密码长度不能少于6位")]
        public string Password { get; set; } = string.Empty;

        /// <summary>
        /// 角色
        /// </summary>
        [Required(ErrorMessage = "角色不能为空")]
        public string Role { get; set; } = string.Empty;

        /// <summary>
        /// 企业海关关区代码
        /// </summary>
        [Required(ErrorMessage = "企业海关关区代码不能为空")]
        [StringLength(10, ErrorMessage = "企业海关关区代码长度不能超过10个字符")]
        public string CustomsCode { get; set; } = string.Empty;

        /// <summary>
        /// 企业海关关区名称
        /// </summary>
        [Required(ErrorMessage = "企业海关关区名称不能为空")]
        [StringLength(100, ErrorMessage = "企业海关关区名称长度不能超过100个字符")]
        public string CustomsName { get; set; } = string.Empty;

        /// <summary>
        /// 企业10位注册编码
        /// </summary>
        [Required(ErrorMessage = "企业注册编码不能为空")]
        [StringLength(10, MinimumLength = 10, ErrorMessage = "企业注册编码必须为10位")]
        public string CompanyCode { get; set; } = string.Empty;

        /// <summary>
        /// 企业名称
        /// </summary>
        [Required(ErrorMessage = "企业名称不能为空")]
        [StringLength(200, ErrorMessage = "企业名称长度不能超过200个字符")]
        public string CompanyName { get; set; } = string.Empty;

        /// <summary>
        /// 状态（1启用/0禁用）
        /// </summary>
        [Range(0, 1, ErrorMessage = "状态值必须为0或1")]
        public int Status { get; set; } = 1;
    }

    /// <summary>
    /// 用户更新请求模型
    /// </summary>
    public class UpdateUserRequest
    {
        /// <summary>
        /// 角色
        /// </summary>
        public string Role { get; set; } = string.Empty;

        /// <summary>
        /// 企业海关关区代码
        /// </summary>
        public string CustomsCode { get; set; } = string.Empty;

        /// <summary>
        /// 企业海关关区名称
        /// </summary>
        public string CustomsName { get; set; } = string.Empty;

        /// <summary>
        /// 企业10位注册编码
        /// </summary>
        public string CompanyCode { get; set; } = string.Empty;

        /// <summary>
        /// 企业名称
        /// </summary>
        public string CompanyName { get; set; } = string.Empty;

        /// <summary>
        /// 状态（1启用/0禁用）
        /// </summary>
        public int Status { get; set; } = 1;
    }

    /// <summary>
    /// 用户列表响应模型
    /// </summary>
    public class UserListResponse
    {
        /// <summary>
        /// 用户ID
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// 用户名
        /// </summary>
        public string Username { get; set; } = string.Empty;

        /// <summary>
        /// 角色
        /// </summary>
        public string Role { get; set; } = string.Empty;

        /// <summary>
        /// 企业海关关区代码
        /// </summary>
        public string CustomsCode { get; set; } = string.Empty;

        /// <summary>
        /// 企业海关关区名称
        /// </summary>
        public string CustomsName { get; set; } = string.Empty;

        /// <summary>
        /// 企业10位注册编码
        /// </summary>
        public string CompanyCode { get; set; } = string.Empty;

        /// <summary>
        /// 企业名称
        /// </summary>
        public string CompanyName { get; set; } = string.Empty;

        /// <summary>
        /// 状态（1启用/0禁用）
        /// </summary>
        public int Status { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 最后登录时间
        /// </summary>
        public DateTime? LastLoginTime { get; set; }
    }

    /// <summary>
    /// 分页查询请求
    /// </summary>
    public class PagedRequest
    {
        /// <summary>
        /// 页码
        /// </summary>
        public int Page { get; set; } = 1;

        /// <summary>
        /// 页大小
        /// </summary>
        public int PageSize { get; set; } = 10;

        /// <summary>
        /// 搜索关键字
        /// </summary>
        public string? Keyword { get; set; }

        /// <summary>
        /// 状态筛选
        /// </summary>
        public int? Status { get; set; }
    }

}