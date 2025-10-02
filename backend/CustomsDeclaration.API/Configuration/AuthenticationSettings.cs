namespace CustomsDeclaration.API.Configuration
{
    /// <summary>
    /// 认证相关配置
    /// </summary>
    public class AuthenticationSettings
    {
        /// <summary>
        /// 是否启用认证
        /// 开发环境可设置为false以便测试
        /// 生产环境必须为true
        /// </summary>
        public bool EnableAuthentication { get; set; } = true;
        
        /// <summary>
        /// 测试模式下允许匿名访问的控制器
        /// </summary>
        public string[] AllowAnonymousControllers { get; set; } = Array.Empty<string>();
    }
}