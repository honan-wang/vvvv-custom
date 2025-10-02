using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Models.DTOs;
using CustomsDeclaration.API.Services;
using System.Security.Claims;

namespace CustomsDeclaration.API.Controllers
{
    /// <summary>
    /// 核放单管理控制器
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class DeclarationController : ControllerBase
    {
        private readonly IDeclarationService _declarationService;
        private readonly IJobNumberService _jobNumberService;
        private readonly ILogger<DeclarationController> _logger;

        public DeclarationController(
            IDeclarationService declarationService,
            IJobNumberService jobNumberService,
            ILogger<DeclarationController> logger)
        {
            _declarationService = declarationService;
            _jobNumberService = jobNumberService;
            _logger = logger;
        }

        /// <summary>
        /// 保存空车核放单
        /// </summary>
        /// <param name="declaration">核放单信息</param>
        /// <returns>保存结果</returns>
        [HttpPost("save-empty-vehicle")]
        public async Task<ActionResult<ApiResponse<string>>> SaveEmptyVehicleDeclaration([FromBody] Declaration declaration)
        {
            try
            {
                // 记录接收到的数据用于调试
                _logger.LogInformation($"接收到空车核放单数据: CarNo={declaration?.CarNo}, CarWeight={declaration?.CarWeight}, StartPlace={declaration?.StartPlace}, Destination={declaration?.Destination}, AreaMark={declaration?.AreaMark}");
                
                // 检查模型状态
                if (!ModelState.IsValid)
                {
                    var errors = ModelState
                        .Where(x => x.Value.Errors.Count > 0)
                        .Select(x => new { Field = x.Key, Errors = x.Value.Errors.Select(e => e.ErrorMessage) })
                        .ToList();
                    _logger.LogWarning($"模型验证失败: {string.Join(", ", errors.Select(e => $"{e.Field}: [{string.Join(", ", e.Errors)}]"))}");
                    return BadRequest(ModelState);
                }
                
                // 临时使用固定用户ID用于测试
                var userId = 1; // GetCurrentUserId();
                // if (userId == 0)
                // {
                //     return Unauthorized(ApiResponse<string>.Fail("用户未登录"));
                // }

                // 验证必填字段
                if (string.IsNullOrEmpty(declaration.CarNo))
                {
                    return BadRequest(ApiResponse<string>.Fail("车牌号不能为空"));
                }

                if (declaration.CarWeight <= 0)
                {
                    return BadRequest(ApiResponse<string>.Fail("车重必须大于0"));
                }

                if (string.IsNullOrEmpty(declaration.StartPlace))
                {
                    return BadRequest(ApiResponse<string>.Fail("起始地不能为空"));
                }

                if (string.IsNullOrEmpty(declaration.Destination))
                {
                    return BadRequest(ApiResponse<string>.Fail("目的地不能为空"));
                }

                if (string.IsNullOrEmpty(declaration.AreaMark))
                {
                    return BadRequest(ApiResponse<string>.Fail("区域标志不能为空"));
                }

                var result = await _declarationService.SaveEmptyVehicleDeclarationAsync(declaration, userId);
                
                if (result.Success)
                {
                    _logger.LogInformation($"空车核放单保存成功，编号：{result.Data}，用户ID：{userId}");
                    return Ok(result);
                }
                else
                {
                    _logger.LogWarning($"空车核放单保存失败，用户ID：{userId}，错误：{result.Message}");
                    return BadRequest(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "保存空车核放单时发生异常");
                return StatusCode(500, ApiResponse<string>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 获取核放单列表
        /// </summary>
        /// <param name="request">查询条件</param>
        /// <returns>核放单列表</returns>
        [HttpPost("list")]
        public async Task<ActionResult<ApiResponse<PagedResult<Declaration>>>> GetDeclarationList([FromBody] DeclarationSearchRequest request)
        {
            try
            {
                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<PagedResult<Declaration>>.Fail("用户未登录"));
                }

                var result = await _declarationService.GetDeclarationListAsync(request, userId);
                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取核放单列表时发生异常");
                return StatusCode(500, ApiResponse<PagedResult<Declaration>>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 获取核放单详情
        /// </summary>
        /// <param name="id">核放单ID</param>
        /// <returns>核放单详情</returns>
        [HttpGet("{id}")]
        public async Task<ActionResult<ApiResponse<Declaration>>> GetDeclarationById(int id)
        {
            try
            {
                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<Declaration>.Fail("用户未登录"));
                }

                var result = await _declarationService.GetDeclarationByIdAsync(id, userId);
                
                if (result.Success)
                {
                    return Ok(result);
                }
                else
                {
                    return NotFound(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"获取核放单详情时发生异常，ID：{id}");
                return StatusCode(500, ApiResponse<Declaration>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 删除核放单
        /// </summary>
        /// <param name="id">核放单ID</param>
        /// <returns>删除结果</returns>
        [HttpDelete("{id}")]
        public async Task<ActionResult<ApiResponse<bool>>> DeleteDeclaration(int id)
        {
            try
            {
                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<bool>.Fail("用户未登录"));
                }

                var result = await _declarationService.DeleteUnifiedDeclarationAsync($"HF{id:D8}", userId);
                
                if (result.Success)
                {
                    _logger.LogInformation($"核放单删除成功，ID：{id}，用户ID：{userId}");
                    return Ok(result);
                }
                else
                {
                    return BadRequest(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"删除核放单时发生异常，ID：{id}");
                return StatusCode(500, ApiResponse<bool>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 保存非空车核放单
        /// </summary>
        /// <param name="declaration">核放单信息</param>
        /// <returns>保存结果</returns>
        [HttpPost("save")]
        public async Task<ActionResult<ApiResponse<string>>> SaveDeclaration([FromBody] Declaration declaration)
        {
            try
            {
                // 记录接收到的数据用于调试
                _logger.LogInformation($"接收到非空车核放单数据: CarNo={declaration?.CarNo}, CarWeight={declaration?.CarWeight}, GrossWeight={declaration?.GrossWeight}, PackageCount={declaration?.PackageCount}");
                
                // 检查模型状态
                if (!ModelState.IsValid)
                {
                    var errors = ModelState
                        .Where(x => x.Value.Errors.Count > 0)
                        .Select(x => new { Field = x.Key, Errors = x.Value.Errors.Select(e => e.ErrorMessage) })
                        .ToList();
                    _logger.LogWarning($"模型验证失败: {string.Join(", ", errors.Select(e => $"{e.Field}: [{string.Join(", ", e.Errors)}]"))}");
                    return BadRequest(ModelState);
                }
                
                // 临时使用固定用户ID用于测试
                var userId = 1; // GetCurrentUserId();

                // 验证必填字段
                if (string.IsNullOrEmpty(declaration.CarNo))
                {
                    return BadRequest(ApiResponse<string>.Fail("车牌号不能为空"));
                }

                if (declaration.CarWeight <= 0)
                {
                    return BadRequest(ApiResponse<string>.Fail("车重必须大于0"));
                }

                if (string.IsNullOrEmpty(declaration.StartPlace))
                {
                    return BadRequest(ApiResponse<string>.Fail("起始地不能为空"));
                }

                if (string.IsNullOrEmpty(declaration.Destination))
                {
                    return BadRequest(ApiResponse<string>.Fail("目的地不能为空"));
                }

                if (string.IsNullOrEmpty(declaration.AreaMark))
                {
                    return BadRequest(ApiResponse<string>.Fail("区域标志不能为空"));
                }

                // 非空车核放单额外验证
                if (declaration.GrossWeight <= 0)
                {
                    return BadRequest(ApiResponse<string>.Fail("毛重必须大于0"));
                }

                if (declaration.PackageCount <= 0)
                {
                    return BadRequest(ApiResponse<string>.Fail("包装件数必须大于0"));
                }

                if (string.IsNullOrEmpty(declaration.PackageType))
                {
                    return BadRequest(ApiResponse<string>.Fail("包装种类不能为空"));
                }

                if (string.IsNullOrEmpty(declaration.IeMark))
                {
                    return BadRequest(ApiResponse<string>.Fail("进出标志不能为空"));
                }

                if (string.IsNullOrEmpty(declaration.MaterialType))
                {
                    return BadRequest(ApiResponse<string>.Fail("料件性质不能为空"));
                }

                if (string.IsNullOrEmpty(declaration.BookNo))
                {
                    return BadRequest(ApiResponse<string>.Fail("账册号不能为空"));
                }

                var result = await _declarationService.SaveDeclarationAsync(declaration, userId);
                
                if (result.Success)
                {
                    _logger.LogInformation($"非空车核放单保存成功，编号：{result.Data}，用户ID：{userId}");
                    return Ok(result);
                }
                else
                {
                    _logger.LogWarning($"非空车核放单保存失败，用户ID：{userId}，错误：{result.Message}");
                    return BadRequest(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "保存非空车核放单时发生异常");
                return StatusCode(500, ApiResponse<string>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 生成核放单编号（供前端预览使用）
        /// </summary>
        /// <param name="bizType">业务类型</param>
        /// <returns>核放单编号</returns>
        [HttpGet("generate-no")]
        public async Task<ActionResult<ApiResponse<string>>> GenerateDischargedNo(string bizType = "KA10")
        {
            try
            {
                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<string>.Fail("用户未登录"));
                }

                // 这里需要获取用户信息来获取企业代码和海关代码
                // 简化处理，实际应该从UserService获取
                var userClaims = User.Claims.ToList();
                var companyCode = userClaims.FirstOrDefault(c => c.Type == "CompanyCode")?.Value ?? "";
                var customsCode = userClaims.FirstOrDefault(c => c.Type == "CustomsCode")?.Value ?? "";

                if (string.IsNullOrEmpty(companyCode) || string.IsNullOrEmpty(customsCode))
                {
                    return BadRequest(ApiResponse<string>.Fail("用户企业信息不完整"));
                }

                var dischargedNo = await _jobNumberService.GetJobNumberAsync(bizType, companyCode, customsCode);
                
                return Ok(ApiResponse<string>.Ok(dischargedNo));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "生成核放单编号时发生异常");
                return StatusCode(500, ApiResponse<string>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 保存申请单（包含表头和商品明细）
        /// </summary>
        /// <param name="request">申请单数据</param>
        /// <returns>申请单业务单号</returns>
        [HttpPost("application")]
        public async Task<ActionResult<ApiResponse<string>>> SaveApplication([FromBody] SaveApplicationRequestDto request)
        {
            try
            {
                _logger.LogInformation($"接收到申请单保存请求");
                
                // 检查模型状态
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                
                var userId = 1; // 临时使用固定用户ID用于测试
                
                var result = await _declarationService.SaveApplicationAsync(request, userId);
                
                if (result.Success)
                {
                    _logger.LogInformation($"申请单保存成功，业务单号：{result.Data}");
                    return Ok(result);
                }
                else
                {
                    _logger.LogWarning($"申请单保存失败：{result.Message}");
                    return BadRequest(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "保存申请单时发生异常");
                return StatusCode(500, ApiResponse<string>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 保存完整非空核放单（申请单 + 核放单表头 + 核放单表体）
        /// </summary>
        /// <param name="request">完整申报数据</param>
        /// <returns>核放单号</returns>
        [HttpPost("complete")]
        public async Task<ActionResult<ApiResponse<string>>> SaveCompleteDeclaration([FromBody] CompleteDeclarationRequestDto request)
        {
            try
            {
                _logger.LogInformation($"接收到完整非空核放单保存请求");
                
                // 检查模型状态
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                
                var userId = 1; // 临时使用固定用户ID用于测试
                
                var result = await _declarationService.SaveCompleteDeclarationAsync(request.Declaration, request.ApplicationData, userId);
                
                if (result.Success)
                {
                    _logger.LogInformation($"完整非空核放单保存成功，核放单号：{result.Data}");
                    return Ok(result);
                }
                else
                {
                    _logger.LogWarning($"完整非空核放单保存失败：{result.Message}");
                    return BadRequest(result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "保存完整非空核放单时发生异常");
                return StatusCode(500, ApiResponse<string>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 复制上一票核放单（获取最新的核放单信息用于复制）
        /// </summary>
        /// <returns>最新的核放单信息</returns>
        [HttpGet("copy-last")]
        public async Task<ActionResult<ApiResponse<Declaration>>> CopyLastDeclaration()
        {
            try
            {
                var userId = GetCurrentUserId();
                if (userId == 0)
                {
                    return Unauthorized(ApiResponse<Declaration>.Fail("用户未登录"));
                }

                // 查询最新的一条核放单记录
                var searchRequest = new DeclarationSearchRequest
                {
                    Page = 1,
                    Size = 1
                };

                var result = await _declarationService.GetDeclarationListAsync(searchRequest, userId);
                
                if (result.Success && result.Data.Items.Count > 0)
                {
                    var lastDeclaration = result.Data.Items[0];
                    
                    // 清空一些不应该复制的字段
                    lastDeclaration.Id = 0;
                    lastDeclaration.DischargedNo = string.Empty;
                    lastDeclaration.Status = "draft";
                    lastDeclaration.CreateTime = DateTime.Now;
                    lastDeclaration.UpdateTime = null;
                    
                    return Ok(ApiResponse<Declaration>.Ok(lastDeclaration));
                }
                else
                {
                    return NotFound(ApiResponse<Declaration>.Fail("没有找到可复制的核放单"));
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "复制上一票核放单时发生异常");
                return StatusCode(500, ApiResponse<Declaration>.Fail("系统内部错误"));
            }
        }

        /// <summary>
        /// 获取当前登录用户ID
        /// </summary>
        /// <returns>用户ID</returns>
        private int GetCurrentUserId()
        {
            // 暂时硬编码用于测试，实际应从JWT令牌中获取
            return 1;
            
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim != null && int.TryParse(userIdClaim.Value, out int userId))
            {
                return userId;
            }
            return 0;
        }
    }
}