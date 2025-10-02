using CustomsDeclaration.API.Models;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// JWT服务接口
    /// </summary>
    public interface IJwtService
    {
        /// <summary>
        /// 生成访问令牌
        /// </summary>
        /// <param name="user">用户信息</param>
        /// <returns>JWT令牌</returns>
        string GenerateAccessToken(User user);

        /// <summary>
        /// 验证令牌
        /// </summary>
        /// <param name="token">令牌</param>
        /// <returns>是否有效</returns>
        bool ValidateToken(string token);

        /// <summary>
        /// 从令牌获取用户ID
        /// </summary>
        /// <param name="token">令牌</param>
        /// <returns>用户ID</returns>
        int GetUserIdFromToken(string token);
    }
}