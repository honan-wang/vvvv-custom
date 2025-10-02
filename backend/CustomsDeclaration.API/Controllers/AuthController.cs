using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CustomsDeclaration.API.Controllers
{
    /// <summary>
    /// 认证控制器
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly ILogger<AuthController> _logger;

        public AuthController(IUserService userService, ILogger<AuthController> logger)
        {
            _userService = userService;
            _logger = logger;
        }

        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="request">登录请求</param>
        /// <returns>登录响应</returns>
        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse<LoginResponse>>> Login([FromBody] LoginRequest request)
        {
            try
            {
                if (string.IsNullOrEmpty(request.Username) || string.IsNullOrEmpty(request.Password))
                {
                    return BadRequest(ApiResponse<LoginResponse>.Fail("用户名和密码不能为空"));
                }

                var loginResponse = await _userService.LoginAsync(request);
                
                if (loginResponse == null)
                {
                    return Unauthorized(ApiResponse<LoginResponse>.Fail("用户名或密码错误"));
                }

                // 记录登录日志
                var ipAddress = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Unknown";
                await _userService.LogLoginAsync(loginResponse.UserInfo.Id, ipAddress);

                _logger.LogInformation("用户 {Username} 登录成功", request.Username);
                
                return Ok(ApiResponse<LoginResponse>.Ok(loginResponse, "登录成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "用户登录失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<LoginResponse>.Fail("登录失败，请稍后重试"));
            }
        }

        /// <summary>
        /// 获取当前用户信息
        /// </summary>
        /// <returns>用户信息</returns>
        [HttpGet("profile")]
        // [Authorize] // 暂时注释掉便于前期功能测试
        public async Task<ActionResult<ApiResponse<UserInfo>>> GetProfile()
        {
            try
            {
                var userIdClaim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier);
                if (userIdClaim == null || !int.TryParse(userIdClaim.Value, out var userId))
                {
                    return Unauthorized(ApiResponse<UserInfo>.Fail("用户认证失败"));
                }

                var user = await _userService.GetUserByIdAsync(userId);
                if (user == null)
                {
                    return NotFound(ApiResponse<UserInfo>.Fail("用户不存在"));
                }

                var userInfo = new UserInfo
                {
                    Id = user.Id,
                    Username = user.Username,
                    Role = user.Role,
                    CustomsCode = user.CustomsCode,
                    CustomsName = user.CustomsName,
                    CompanyCode = user.CompanyCode,
                    CompanyName = user.CompanyName
                };

                return Ok(ApiResponse<UserInfo>.Ok(userInfo));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取用户信息失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<UserInfo>.Fail("获取用户信息失败"));
            }
        }

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="request">修改密码请求</param>
        /// <returns>修改结果</returns>
        [HttpPost("change-password")]
        // [Authorize] // 暂时注释掉便于前期功能测试
        public async Task<ActionResult<ApiResponse<bool>>> ChangePassword([FromBody] ChangePasswordRequest request)
        {
            try
            {
                if (string.IsNullOrEmpty(request.CurrentPassword) || string.IsNullOrEmpty(request.NewPassword))
                {
                    return BadRequest(ApiResponse<bool>.Fail("当前密码和新密码不能为空"));
                }

                // 从token中获取用户ID（目前暂时使用请求中的用户ID）
                var user = await _userService.GetUserByIdAsync(request.UserId);
                if (user == null)
                {
                    return NotFound(ApiResponse<bool>.Fail("用户不存在"));
                }

                // 验证当前密码
                if (user.PasswordHash != request.CurrentPassword)
                {
                    return BadRequest(ApiResponse<bool>.Fail("当前密码不正确"));
                }

                // 更新密码
                user.PasswordHash = request.NewPassword;
                var result = await _userService.UpdateUserAsync(user);
                
                if (!result)
                {
                    return BadRequest(ApiResponse<bool>.Fail("修改密码失败"));
                }

                _logger.LogInformation("用户密码修改成功，用户ID: {UserId}", request.UserId);
                return Ok(ApiResponse<bool>.Ok(true, "密码修改成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "修改密码失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<bool>.Fail("修改密码失败"));
            }
        }

        /// <summary>
        /// 用户退出登录
        /// </summary>
        /// <returns>退出结果</returns>
        [HttpPost("logout")]
        // [Authorize] // 暂时注释掉便于前期功能测试
        public ActionResult<ApiResponse<object>> Logout()
        {
            try
            {
                // 在实际应用中，可以在这里处理JWT令牌的黑名单逻辑
                _logger.LogInformation("用户退出登录");
                return Ok(ApiResponse<object>.Ok(null, "退出成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "用户退出失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<object>.Fail("退出失败"));
            }
        }
    }

    /// <summary>
    /// 修改密码请求模型
    /// </summary>
    public class ChangePasswordRequest
    {
        /// <summary>
        /// 用户ID
        /// </summary>
        public int UserId { get; set; }

        /// <summary>
        /// 当前密码
        /// </summary>
        public string CurrentPassword { get; set; } = string.Empty;

        /// <summary>
        /// 新密码
        /// </summary>
        public string NewPassword { get; set; } = string.Empty;
    }
}