using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace CustomsDeclaration.API.Controllers
{
    /// <summary>
    /// 系统参数控制器
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    // [Authorize] // 暂时注释掉便于前期功能测试
    public class SystemParameterController : ControllerBase
    {
        private readonly ISystemParameterService _parameterService;
        private readonly ILogger<SystemParameterController> _logger;

        public SystemParameterController(ISystemParameterService parameterService, ILogger<SystemParameterController> logger)
        {
            _parameterService = parameterService;
            _logger = logger;
        }

        /// <summary>
        /// 根据参数类型获取参数选项列表（用于下拉框）
        /// </summary>
        /// <param name="paraType">参数类型，如：PORT_KA（港口代码）</param>
        /// <returns>参数选项列表</returns>
        [HttpGet("options/{paraType}")]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse<List<ParameterOption>>>> GetParameterOptions(string paraType)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(paraType))
                {
                    return BadRequest(ApiResponse<List<ParameterOption>>.Fail("参数类型不能为空"));
                }

                var options = await _parameterService.GetParameterOptionsAsync(paraType);
                return Ok(ApiResponse<List<ParameterOption>>.Ok(options));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取参数选项失败，参数类型: {ParaType}", paraType);
                return StatusCode(500, ApiResponse<List<ParameterOption>>.Fail("获取参数选项失败"));
            }
        }

        /// <summary>
        /// 获取港口代码选项（起始地、目的地专用）
        /// </summary>
        /// <returns>港口代码选项列表</returns>
        [HttpGet("ports")]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse<List<ParameterOption>>>> GetPortOptions()
        {
            try
            {
                var options = await _parameterService.GetParameterOptionsAsync("PORT_KA");
                return Ok(ApiResponse<List<ParameterOption>>.Ok(options, "获取港口代码成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取港口代码选项失败");
                return StatusCode(500, ApiResponse<List<ParameterOption>>.Fail("获取港口代码失败"));
            }
        }

        /// <summary>
        /// 获取区域标志选项
        /// </summary>
        /// <returns>区域标志选项列表</returns>
        [HttpGet("regions")]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse<List<ParameterOption>>>> GetRegionOptions()
        {
            try
            {
                var options = await _parameterService.GetParameterOptionsAsync("REGION");
                return Ok(ApiResponse<List<ParameterOption>>.Ok(options, "获取区域标志成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取区域标志选项失败");
                return StatusCode(500, ApiResponse<List<ParameterOption>>.Fail("获取区域标志失败"));
            }
        }

        /// <summary>
        /// 获取包装种类选项
        /// </summary>
        /// <returns>包装种类选项列表</returns>
        [HttpGet("wrap-types")]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse<List<ParameterOption>>>> GetWrapTypeOptions()
        {
            try
            {
                var options = await _parameterService.GetParameterOptionsAsync("WRAP_TYPE");
                return Ok(ApiResponse<List<ParameterOption>>.Ok(options, "获取包装种类成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取包装种类选项失败");
                return StatusCode(500, ApiResponse<List<ParameterOption>>.Fail("获取包装种类失败"));
            }
        }

        /// <summary>
        /// 获取账册号选项
        /// </summary>
        /// <returns>账册号选项列表</returns>
        [HttpGet("books")]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse<List<ParameterOption>>>> GetBookOptions()
        {
            try
            {
                // 调试信息：检查认证状态
                _logger.LogInformation("用户认证状态: {IsAuthenticated}", User.Identity?.IsAuthenticated);
                if (User.Identity?.IsAuthenticated == true)
                {
                    _logger.LogInformation("用户Claims数量: {ClaimsCount}", User.Claims?.Count() ?? 0);
                    var tradeCodeClaim = User.FindFirst("TradeCode");
                    _logger.LogInformation("TradeCode Claim: {TradeCodeClaim}", tradeCodeClaim?.Value ?? "null");
                }
                
                // 从JWT Token Claims中获取当前用户的企业编码
                string tradeCode = "";
                
                if (User.Identity?.IsAuthenticated == true)
                {
                    // 从JWT claims中获取企业编码
                    tradeCode = User.FindFirst("TradeCode")?.Value ?? "";
                    _logger.LogInformation("从JWT Token获取到企业编码: {TradeCode}", tradeCode);
                }
                else
                {
                    _logger.LogWarning("用户未认证，无法获取企业编码，将返回空的账册列表");
                }
                
                var options = await _parameterService.GetBookOptionsAsync(tradeCode);
                return Ok(ApiResponse<List<ParameterOption>>.Ok(options, "获取账册号成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取账册号选项失败");
                return StatusCode(500, ApiResponse<List<ParameterOption>>.Fail("获取账册号失败"));
            }
        }

        /// <summary>
        /// 获取计量单位选项
        /// </summary>
        /// <returns>计量单位选项列表</returns>
        [HttpGet("units")]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse<List<ParameterOption>>>> GetUnitOptions()
        {
            try
            {
                var options = await _parameterService.GetUnitOptionsAsync();
                return Ok(ApiResponse<List<ParameterOption>>.Ok(options, "获取计量单位成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取计量单位选项失败");
                return StatusCode(500, ApiResponse<List<ParameterOption>>.Fail("获取计量单位失败"));
            }
        }

        /// <summary>
        /// 获取币制选项
        /// </summary>
        /// <returns>币制选项列表</returns>
        [HttpGet("currencies")]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse<List<ParameterOption>>>> GetCurrencyOptions()
        {
            try
            {
                var options = await _parameterService.GetCurrencyOptionsAsync();
                return Ok(ApiResponse<List<ParameterOption>>.Ok(options, "获取币制成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取币制选项失败");
                return StatusCode(500, ApiResponse<List<ParameterOption>>.Fail("获取币制失败"));
            }
        }

        /// <summary>
        /// 获取所有系统参数
        /// </summary>
        /// <returns>系统参数列表</returns>
        [HttpGet]
        public async Task<ActionResult<ApiResponse<List<SystemParameter>>>> GetAllParameters()
        {
            try
            {
                var parameters = await _parameterService.GetAllParametersAsync();
                return Ok(ApiResponse<List<SystemParameter>>.Ok(parameters));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取所有系统参数失败");
                return StatusCode(500, ApiResponse<List<SystemParameter>>.Fail("获取系统参数失败"));
            }
        }

        /// <summary>
        /// 根据参数类型获取系统参数
        /// </summary>
        /// <param name="paraType">参数类型</param>
        /// <returns>系统参数列表</returns>
        [HttpGet("type/{paraType}")]
        public async Task<ActionResult<ApiResponse<List<SystemParameter>>>> GetParametersByType(string paraType)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(paraType))
                {
                    return BadRequest(ApiResponse<List<SystemParameter>>.Fail("参数类型不能为空"));
                }

                var parameters = await _parameterService.GetParametersByTypeAsync(paraType);
                return Ok(ApiResponse<List<SystemParameter>>.Ok(parameters));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "根据类型获取系统参数失败，参数类型: {ParaType}", paraType);
                return StatusCode(500, ApiResponse<List<SystemParameter>>.Fail("获取系统参数失败"));
            }
        }

        /// <summary>
        /// 获取账册表体信息
        /// </summary>
        /// <param name="bookNo">账册号</param>
        /// <param name="itemNo">项号</param>
        /// <returns>账册表体信息</returns>
        [HttpGet("book-item/{bookNo}/{itemNo}")]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse<object>>> GetBookItemInfo(string bookNo, string itemNo)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(bookNo))
                {
                    return BadRequest(ApiResponse<object>.Fail("账册号不能为空"));
                }

                if (string.IsNullOrWhiteSpace(itemNo))
                {
                    return BadRequest(ApiResponse<object>.Fail("项号不能为空"));
                }

                var itemInfo = await _parameterService.GetBookItemInfoAsync(bookNo, itemNo);
                
                if (itemInfo == null)
                {
                    return Ok(ApiResponse<object>.Fail("未找到对应的项号信息"));
                }

                return Ok(ApiResponse<object>.Ok(itemInfo, "获取账册表体信息成功"));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取账册表体信息失败，账册号: {BookNo}, 项号: {ItemNo}", bookNo, itemNo);
                return StatusCode(500, ApiResponse<object>.Fail("获取账册表体信息失败"));
            }
        }
    }
}