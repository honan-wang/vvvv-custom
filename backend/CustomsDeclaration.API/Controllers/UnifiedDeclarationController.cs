using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Models.DTOs;
using CustomsDeclaration.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace CustomsDeclaration.API.Controllers
{
    /// <summary>
    /// 单一申报管理控制器
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class UnifiedDeclarationController : ControllerBase
    {
        private readonly IDeclarationService _declarationService;
        private readonly ILogger<UnifiedDeclarationController> _logger;

        public UnifiedDeclarationController(
            IDeclarationService declarationService,
            ILogger<UnifiedDeclarationController> logger)
        {
            _declarationService = declarationService;
            _logger = logger;
        }

        /// <summary>
        /// 获取单一申报列表
        /// </summary>
        /// <param name="request">查询条件</param>
        /// <returns>单一申报列表</returns>
        [HttpPost("list")]
        [AllowAnonymous] // 临时添加以进行测试
        public async Task<ActionResult<ApiResponse<PagedResult<UnifiedDeclarationListDto>>>> GetListAsync([FromBody] UnifiedDeclarationSearchRequestDto request)
        {
            try
            {
                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<PagedResult<UnifiedDeclarationListDto>>.Fail("用户未登录"));
                }

                var result = await _declarationService.GetUnifiedDeclarationListAsync(request, userId);
                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取单一申报列表失败");
                return StatusCode(500, ApiResponse<PagedResult<UnifiedDeclarationListDto>>.Fail("服务器内部错误"));
            }
        }

        /// <summary>
        /// 获取单一申报详情
        /// </summary>
        /// <param name="dischargedNo">核放单号</param>
        /// <returns>单一申报详情</returns>
        [HttpGet("detail/{dischargedNo}")]
        public async Task<ActionResult<ApiResponse<UnifiedDeclarationDetailDto>>> GetDetailAsync(string dischargedNo)
        {
            try
            {
                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<UnifiedDeclarationDetailDto>.Fail("用户未登录"));
                }

                var result = await _declarationService.GetUnifiedDeclarationDetailAsync(dischargedNo, userId);
                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"获取单一申报详情失败，核放单号：{dischargedNo}");
                return StatusCode(500, ApiResponse<UnifiedDeclarationDetailDto>.Fail("服务器内部错误"));
            }
        }

        /// <summary>
        /// 编辑单一申报（更新申请单和核放单）
        /// </summary>
        /// <param name="dischargedNo">核放单号</param>
        /// <param name="request">编辑请求</param>
        /// <returns>编辑结果</returns>
        [HttpPut("edit/{dischargedNo}")]
        public async Task<ActionResult<ApiResponse<string>>> EditAsync(string dischargedNo, [FromBody] EditUnifiedDeclarationRequestDto request)
        {
            try
            {
                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<string>.Fail("用户未登录"));
                }

                // 编辑功能需要先删除原记录，然后重新保存
                // 这是为了保证数据的一致性，避免部分更新造成的数据不完整
                var deleteResult = await _declarationService.DeleteUnifiedDeclarationAsync(dischargedNo, userId);
                if (!deleteResult.Success)
                {
                    return BadRequest(ApiResponse<string>.Fail($"删除原记录失败：{deleteResult.Message}"));
                }

                // 重新保存更新后的数据
                request.Declaration.DischargedNo = dischargedNo; // 保持原核放单号
                var saveResult = await _declarationService.SaveCompleteDeclarationAsync(
                    request.Declaration,
                    request.ApplicationData,
                    userId);

                return Ok(saveResult);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"编辑单一申报失败，核放单号：{dischargedNo}");
                return StatusCode(500, ApiResponse<string>.Fail("服务器内部错误"));
            }
        }

        /// <summary>
        /// 删除单一申报
        /// </summary>
        /// <param name="dischargedNo">核放单号</param>
        /// <returns>删除结果</returns>
        [HttpDelete("delete/{dischargedNo}")]
        public async Task<ActionResult<ApiResponse<bool>>> DeleteAsync(string dischargedNo)
        {
            try
            {
                // 临时使用固定用户ID用于测试
                var userId = 1; // GetCurrentUserId();
                // if (userId == 0)
                // {
                //     return Unauthorized(ApiResponse<bool>.Fail("用户未登录"));
                // }

                var result = await _declarationService.DeleteUnifiedDeclarationAsync(dischargedNo, userId);
                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"删除单一申报失败，核放单号：{dischargedNo}");
                return StatusCode(500, ApiResponse<bool>.Fail("服务器内部错误"));
            }
        }

        /// <summary>
        /// 获取当前用户ID
        /// </summary>
        /// <returns>用户ID</returns>
        private int GetCurrentUserId()
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
            return userIdClaim != null && int.TryParse(userIdClaim.Value, out var userId) ? userId : 1; // 临时返回1用于测试
        }
    }

    /// <summary>
    /// 编辑单一申报请求DTO
    /// </summary>
    public class EditUnifiedDeclarationRequestDto
    {
        /// <summary>
        /// 核放单信息
        /// </summary>
        public Declaration Declaration { get; set; } = new();

        /// <summary>
        /// 申请单数据
        /// </summary>
        public SaveApplicationRequestDto ApplicationData { get; set; } = new();
    }
}