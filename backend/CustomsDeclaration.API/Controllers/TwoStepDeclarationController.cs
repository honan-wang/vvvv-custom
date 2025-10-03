using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Models.Enums;
using CustomsDeclaration.API.Services;
using System.Security.Claims;

namespace CustomsDeclaration.API.Controllers
{
    /// <summary>
    /// 两步申报流程控制器
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class TwoStepDeclarationController : ControllerBase
    {
        private readonly ITwoStepDeclarationService _twoStepService;
        private readonly ILogger<TwoStepDeclarationController> _logger;

        public TwoStepDeclarationController(
            ITwoStepDeclarationService twoStepService,
            ILogger<TwoStepDeclarationController> logger)
        {
            _twoStepService = twoStepService;
            _logger = logger;
        }

        /// <summary>
        /// 开始申报流程（第一步：提交申请单）
        /// </summary>
        /// <param name="applicationNo">申请单号</param>
        /// <returns>申报结果</returns>
        [HttpPost("start/{applicationNo}")]
        public async Task<ActionResult<ApiResponse<string>>> StartDeclaration(string applicationNo)
        {
            try
            {
                _logger.LogInformation($"开始申报流程，申请单号：{applicationNo}");

                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<string>.Fail("用户未登录"));
                }

                var result = await _twoStepService.SubmitApplicationAsync(applicationNo, userId);

                if (result.Success)
                {
                    _logger.LogInformation($"申报流程启动成功，申请单号：{applicationNo}");
                    return Ok(result);
                }
                else
                {
                    _logger.LogWarning($"申报流程启动失败，申请单号：{applicationNo}，错误：{result.Message}");
                    return BadRequest(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"启动申报流程时发生异常，申请单号：{applicationNo}");
                return StatusCode(500, ApiResponse<string>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 重新申报（被退回后）
        /// </summary>
        /// <param name="applicationNo">申请单号</param>
        /// <returns>申报结果</returns>
        [HttpPost("resubmit/{applicationNo}")]
        public async Task<ActionResult<ApiResponse<string>>> ResubmitDeclaration(string applicationNo)
        {
            try
            {
                _logger.LogInformation($"重新申报，申请单号：{applicationNo}");

                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<string>.Fail("用户未登录"));
                }

                var result = await _twoStepService.ResubmitDeclarationAsync(applicationNo, userId);

                if (result.Success)
                {
                    _logger.LogInformation($"重新申报成功，申请单号：{applicationNo}");
                    return Ok(result);
                }
                else
                {
                    _logger.LogWarning($"重新申报失败，申请单号：{applicationNo}，错误：{result.Message}");
                    return BadRequest(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"重新申报时发生异常，申请单号：{applicationNo}");
                return StatusCode(500, ApiResponse<string>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 获取申报状态
        /// </summary>
        /// <param name="dischargedNo">核放单号</param>
        /// <returns>申报状态</returns>
        [HttpGet("status/{dischargedNo}")]
        public async Task<ActionResult<ApiResponse<DeclarationStatusDto>>> GetDeclarationStatus(string dischargedNo)
        {
            try
            {
                var result = await _twoStepService.GetDeclarationStatusAsync(dischargedNo);

                if (result.Success)
                {
                    var statusDto = new DeclarationStatusDto
                    {
                        Status = result.Data,
                        StatusDescription = result.Data.GetDescription(),
                        CanProceedToNext = result.Data.CanProceedToNext(),
                        IsPending = result.Data.IsPending(),
                        IsCompleted = result.Data.IsCompleted(),
                        IsRejected = result.Data.IsRejected()
                    };

                    return Ok(ApiResponse<DeclarationStatusDto>.Ok(statusDto));
                }
                else
                {
                    return NotFound(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"获取申报状态时发生异常，核放单号：{dischargedNo}");
                return StatusCode(500, ApiResponse<DeclarationStatusDto>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 手动触发第二步（仅用于测试）
        /// </summary>
        /// <param name="dischargedNo">核放单号</param>
        /// <returns>申报结果</returns>
        [HttpPost("submit-discharge/{dischargedNo}")]
        public async Task<ActionResult<ApiResponse<string>>> ManualSubmitDischarge(string dischargedNo)
        {
            try
            {
                _logger.LogInformation($"手动触发第二步申报，核放单号：{dischargedNo}");

                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<string>.Fail("用户未登录"));
                }

                var result = await _twoStepService.SubmitDischargePermitAsync(dischargedNo, userId);

                if (result.Success)
                {
                    _logger.LogInformation($"手动触发第二步申报成功，核放单号：{dischargedNo}");
                    return Ok(result);
                }
                else
                {
                    _logger.LogWarning($"手动触发第二步申报失败，核放单号：{dischargedNo}，错误：{result.Message}");
                    return BadRequest(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"手动触发第二步申报时发生异常，核放单号：{dischargedNo}");
                return StatusCode(500, ApiResponse<string>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 直接申报核放单（空车核放单一步申报）
        /// </summary>
        /// <param name="dischargedNo">核放单号</param>
        /// <returns>申报结果</returns>
        [HttpPost("submit-discharge-directly/{dischargedNo}")]
        public async Task<ActionResult<ApiResponse<string>>> SubmitDischargeDirectly(string dischargedNo)
        {
            try
            {
                _logger.LogInformation($"直接申报核放单（空车核放单），核放单号：{dischargedNo}");

                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<string>.Fail("用户未登录"));
                }

                var result = await _twoStepService.SubmitDischargeDirectlyAsync(dischargedNo, userId);

                if (result.Success)
                {
                    _logger.LogInformation($"空车核放单直接申报成功，核放单号：{dischargedNo}");
                    return Ok(result);
                }
                else
                {
                    _logger.LogWarning($"空车核放单直接申报失败，核放单号：{dischargedNo}，错误：{result.Message}");
                    return BadRequest(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"直接申报核放单时发生异常，核放单号：{dischargedNo}");
                return StatusCode(500, ApiResponse<string>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 获取当前登录用户ID
        /// </summary>
        /// <returns>用户ID</returns>
        private int GetCurrentUserId()
        {
            // 从JWT令牌中获取用户ID，支持多种claim类型
            var userIdClaim = User.FindFirst("userId")?.Value
                              ?? User.FindFirst("sub")?.Value
                              ?? User.FindFirst("id")?.Value
                              ?? User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (int.TryParse(userIdClaim, out int userId))
            {
                return userId;
            }

            _logger.LogWarning("无法从JWT令牌中获取有效的用户ID");
            throw new UnauthorizedAccessException("用户身份验证失败");
        }
    }

    /// <summary>
    /// 申报状态响应DTO
    /// </summary>
    public class DeclarationStatusDto
    {
        /// <summary>
        /// 状态枚举值
        /// </summary>
        public DeclarationStatus Status { get; set; }

        /// <summary>
        /// 状态描述
        /// </summary>
        public string StatusDescription { get; set; } = string.Empty;

        /// <summary>
        /// 是否可以进行下一步操作
        /// </summary>
        public bool CanProceedToNext { get; set; }

        /// <summary>
        /// 是否正在等待审批
        /// </summary>
        public bool IsPending { get; set; }

        /// <summary>
        /// 是否已完成
        /// </summary>
        public bool IsCompleted { get; set; }

        /// <summary>
        /// 是否被退回
        /// </summary>
        public bool IsRejected { get; set; }
    }
}