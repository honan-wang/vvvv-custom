using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Services;
using System.ComponentModel.DataAnnotations;

namespace CustomsDeclaration.API.Controllers
{
    /// <summary>
    /// 用户管理控制器
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    //[Authorize] // 临时移除认证以便测试
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly ILogger<UserController> _logger;

        public UserController(IUserService userService, ILogger<UserController> logger)
        {
            _userService = userService;
            _logger = logger;
        }

        /// <summary>
        /// 获取用户列表（分页）
        /// </summary>
        /// <param name="request">分页查询请求</param>
        /// <returns>用户列表</returns>
        [HttpPost("list")]
        public async Task<ActionResult<ApiResponse<PagedResponse<UserListResponse>>>> GetUsers([FromBody] PagedRequest request)
        {
            try
            {
                var result = await _userService.GetUsersAsync(request);
                return Ok(ApiResponse<PagedResponse<UserListResponse>>.Ok(result));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取用户列表失败");
                return StatusCode(500, ApiResponse<PagedResponse<UserListResponse>>.Fail("获取用户列表失败"));
            }
        }

        /// <summary>
        /// 根据ID获取用户详情
        /// </summary>
        /// <param name="id">用户ID</param>
        /// <returns>用户详情</returns>
        [HttpGet("{id:int}")]
        public async Task<ActionResult<ApiResponse<UserListResponse>>> GetUser(int id)
        {
            try
            {
                var user = await _userService.GetUserByIdAsync(id);
                if (user == null)
                {
                    return NotFound(ApiResponse<UserListResponse>.Fail("用户不存在"));
                }

                var userResponse = new UserListResponse
                {
                    Id = user.Id,
                    Username = user.Username,
                    Role = user.Role,
                    CustomsCode = user.CustomsCode,
                    CustomsName = user.CustomsName,
                    CompanyCode = user.CompanyCode,
                    CompanyName = user.CompanyName,
                    Status = user.IsActive ? 1 : 0,
                    CreateTime = user.CreateTime,
                    LastLoginTime = user.LastLoginTime
                };

                return Ok(ApiResponse<UserListResponse>.Ok(userResponse));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取用户详情失败，用户ID: {UserId}", id);
                return StatusCode(500, ApiResponse<UserListResponse>.Fail("获取用户详情失败"));
            }
        }

        /// <summary>
        /// 创建用户
        /// </summary>
        /// <param name="request">创建用户请求</param>
        /// <returns>创建结果</returns>
        [HttpPost]
        public async Task<ActionResult<ApiResponse<bool>>> CreateUser([FromBody] CreateUserRequest request)
        {
            try
            {
                // 验证输入
                if (!ModelState.IsValid)
                {
                    var errors = string.Join("; ", ModelState.Values
                        .SelectMany(v => v.Errors)
                        .Select(e => e.ErrorMessage));
                    return BadRequest(ApiResponse<bool>.Fail(errors));
                }

                var result = await _userService.CreateUserAsync(request);
                if (!result)
                {
                    return BadRequest(ApiResponse<bool>.Fail("用户名已存在或创建失败"));
                }

                _logger.LogInformation("用户创建成功，用户名: {Username}", request.Username);
                return Ok(ApiResponse<bool>.Ok(true, "用户创建成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "创建用户失败，用户名: {Username}", request.Username);
                return StatusCode(500, ApiResponse<bool>.Fail("创建用户失败"));
            }
        }

        /// <summary>
        /// 更新用户
        /// </summary>
        /// <param name="id">用户ID</param>
        /// <param name="request">更新用户请求</param>
        /// <returns>更新结果</returns>
        [HttpPut("{id:int}")]
        public async Task<ActionResult<ApiResponse<bool>>> UpdateUser(int id, [FromBody] UpdateUserRequest request)
        {
            try
            {
                // 验证输入
                if (!ModelState.IsValid)
                {
                    var errors = string.Join("; ", ModelState.Values
                        .SelectMany(v => v.Errors)
                        .Select(e => e.ErrorMessage));
                    return BadRequest(ApiResponse<bool>.Fail(errors));
                }

                // 检查用户是否存在
                var existingUser = await _userService.GetUserByIdAsync(id);
                if (existingUser == null)
                {
                    return NotFound(ApiResponse<bool>.Fail("用户不存在"));
                }

                var result = await _userService.UpdateUserAsync(id, request);
                if (!result)
                {
                    return BadRequest(ApiResponse<bool>.Fail("更新用户失败"));
                }

                _logger.LogInformation("用户更新成功，用户ID: {UserId}", id);
                return Ok(ApiResponse<bool>.Ok(true, "用户更新成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "更新用户失败，用户ID: {UserId}", id);
                return StatusCode(500, ApiResponse<bool>.Fail("更新用户失败"));
            }
        }

        /// <summary>
        /// 删除用户
        /// </summary>
        /// <param name="id">用户ID</param>
        /// <returns>删除结果</returns>
        [HttpDelete("{id:int}")]
        public async Task<ActionResult<ApiResponse<bool>>> DeleteUser(int id)
        {
            try
            {
                // 检查用户是否存在
                var existingUser = await _userService.GetUserByIdAsync(id);
                if (existingUser == null)
                {
                    return NotFound(ApiResponse<bool>.Fail("用户不存在"));
                }

                // 防止删除管理员账户
                if (existingUser.Role.Equals("admin", StringComparison.OrdinalIgnoreCase))
                {
                    return BadRequest(ApiResponse<bool>.Fail("不能删除管理员账户"));
                }

                var result = await _userService.DeleteUserAsync(id);
                if (!result)
                {
                    return BadRequest(ApiResponse<bool>.Fail("删除用户失败"));
                }

                _logger.LogInformation("用户删除成功，用户ID: {UserId}", id);
                return Ok(ApiResponse<bool>.Ok(true, "用户删除成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "删除用户失败，用户ID: {UserId}", id);
                return StatusCode(500, ApiResponse<bool>.Fail("删除用户失败"));
            }
        }

        /// <summary>
        /// 批量删除用户
        /// </summary>
        /// <param name="ids">用户ID列表</param>
        /// <returns>删除结果</returns>
        [HttpDelete("batch")]
        public async Task<ActionResult<ApiResponse<bool>>> BatchDeleteUsers([FromBody] List<int> ids)
        {
            try
            {
                if (ids == null || !ids.Any())
                {
                    return BadRequest(ApiResponse<bool>.Fail("请提供要删除的用户ID"));
                }

                var successCount = 0;
                var failedUsers = new List<string>();

                foreach (var id in ids)
                {
                    var user = await _userService.GetUserByIdAsync(id);
                    if (user == null)
                    {
                        failedUsers.Add($"用户ID {id} 不存在");
                        continue;
                    }

                    // 防止删除管理员账户
                    if (user.Role.Equals("admin", StringComparison.OrdinalIgnoreCase))
                    {
                        failedUsers.Add($"用户 {user.Username} 是管理员，不能删除");
                        continue;
                    }

                    var result = await _userService.DeleteUserAsync(id);
                    if (result)
                    {
                        successCount++;
                    }
                    else
                    {
                        failedUsers.Add($"删除用户ID {id} 失败");
                    }
                }

                var message = $"成功删除 {successCount} 个用户";
                if (failedUsers.Any())
                {
                    message += $"，失败 {failedUsers.Count} 个：{string.Join("; ", failedUsers)}";
                }

                _logger.LogInformation("批量删除用户完成，成功: {SuccessCount}，失败: {FailedCount}", successCount, failedUsers.Count);
                return Ok(ApiResponse<bool>.Ok(true, message));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "批量删除用户失败");
                return StatusCode(500, ApiResponse<bool>.Fail("批量删除用户失败"));
            }
        }

        /// <summary>
        /// 重置用户密码
        /// </summary>
        /// <param name="id">用户ID</param>
        /// <param name="request">重置密码请求</param>
        /// <returns>重置结果</returns>
        [HttpPost("{id:int}/reset-password")]
        public async Task<ActionResult<ApiResponse<bool>>> ResetPassword(int id, [FromBody] ResetPasswordRequest request)
        {
            try
            {
                // 检查用户是否存在
                var user = await _userService.GetUserByIdAsync(id);
                if (user == null)
                {
                    return NotFound(ApiResponse<bool>.Fail("用户不存在"));
                }

                // 更新密码
                user.PasswordHash = request.NewPassword;
                var result = await _userService.UpdateUserAsync(user);
                
                if (!result)
                {
                    return BadRequest(ApiResponse<bool>.Fail("重置密码失败"));
                }

                _logger.LogInformation("用户密码重置成功，用户ID: {UserId}", id);
                return Ok(ApiResponse<bool>.Ok(true, "密码重置成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "重置密码失败，用户ID: {UserId}", id);
                return StatusCode(500, ApiResponse<bool>.Fail("重置密码失败"));
            }
        }
    }

    /// <summary>
    /// 重置密码请求模型
    /// </summary>
    public class ResetPasswordRequest
    {
        /// <summary>
        /// 新密码
        /// </summary>
        [Required(ErrorMessage = "新密码不能为空")]
        [MinLength(6, ErrorMessage = "密码长度不能少于6位")]
        public string NewPassword { get; set; } = string.Empty;
    }
}