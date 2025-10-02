using CustomsDeclaration.API.Models;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 用户服务接口
    /// </summary>
    public interface IUserService
    {
        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="request">登录请求</param>
        /// <returns>登录响应</returns>
        Task<LoginResponse?> LoginAsync(LoginRequest request);

        /// <summary>
        /// 根据用户名获取用户
        /// </summary>
        /// <param name="username">用户名</param>
        /// <returns>用户信息</returns>
        Task<User?> GetUserByUsernameAsync(string username);

        /// <summary>
        /// 根据用户ID获取用户
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <returns>用户信息</returns>
        Task<User?> GetUserByIdAsync(int userId);

        /// <summary>
        /// 创建用户
        /// </summary>
        /// <param name="user">用户信息</param>
        /// <returns>创建结果</returns>
        Task<bool> CreateUserAsync(User user);

        /// <summary>
        /// 更新用户
        /// </summary>
        /// <param name="user">用户信息</param>
        /// <returns>更新结果</returns>
        Task<bool> UpdateUserAsync(User user);

        /// <summary>
        /// 删除用户
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <returns>删除结果</returns>
        Task<bool> DeleteUserAsync(int userId);

        /// <summary>
        /// 获取用户列表
        /// </summary>
        /// <param name="request">分页查询请求</param>
        /// <returns>用户列表</returns>
        Task<PagedResponse<UserListResponse>> GetUsersAsync(PagedRequest request);

        /// <summary>
        /// 创建用户（使用请求模型）
        /// </summary>
        /// <param name="request">创建用户请求</param>
        /// <returns>创建结果</returns>
        Task<bool> CreateUserAsync(CreateUserRequest request);

        /// <summary>
        /// 更新用户（使用请求模型）
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="request">更新用户请求</param>
        /// <returns>更新结果</returns>
        Task<bool> UpdateUserAsync(int userId, UpdateUserRequest request);

        /// <summary>
        /// 验证密码
        /// </summary>
        /// <param name="password">明文密码</param>
        /// <param name="hash">密码哈希</param>
        /// <returns>是否匹配</returns>
        bool VerifyPassword(string password, string hash);

        /// <summary>
        /// 生成密码哈希
        /// </summary>
        /// <param name="password">明文密码</param>
        /// <returns>密码哈希</returns>
        string HashPassword(string password);

        /// <summary>
        /// 记录登录日志
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="ipAddress">IP地址</param>
        /// <returns>记录结果</returns>
        Task<bool> LogLoginAsync(int userId, string ipAddress);
    }
}