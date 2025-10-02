using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace CustomsDeclaration.API.Controllers
{
    /// <summary>
    /// 车辆管理控制器
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    [Authorize] // 需要登录才能访问
    public class VehicleController : ControllerBase
    {
        private readonly IVehicleService _vehicleService;
        private readonly ILogger<VehicleController> _logger;

        public VehicleController(IVehicleService vehicleService, ILogger<VehicleController> logger)
        {
            _vehicleService = vehicleService;
            _logger = logger;
        }

        /// <summary>
        /// 获取所有车辆列表（管理员可查看所有，普通用户只能查看自己企业的）
        /// </summary>
        /// <param name="request">查询请求</param>
        /// <returns>车辆列表</returns>
        [HttpGet]
        public async Task<ActionResult<ApiResponse<PagedResponse<Vehicle>>>> GetVehicles([FromQuery] VehicleSearchRequest request)
        {
            try
            {
                var userRole = User.FindFirst(ClaimTypes.Role)?.Value;
                var userTradeCode = User.FindFirst("TradeCode")?.Value ?? "";

                // 手动处理前端错误的参数格式 params[xxx]
                if (string.IsNullOrEmpty(request.VehicleNo))
                {
                    request.VehicleNo = Request.Query["params[vehicleNo]"].FirstOrDefault();
                }
                if (string.IsNullOrEmpty(request.VehicleType))
                {
                    request.VehicleType = Request.Query["params[vehicleType]"].FirstOrDefault();
                }
                if (string.IsNullOrEmpty(request.Status))
                {
                    request.Status = Request.Query["params[status]"].FirstOrDefault();
                }
                if (string.IsNullOrEmpty(request.TradeName))
                {
                    request.TradeName = Request.Query["params[tradeName]"].FirstOrDefault();
                }
                if (request.Page <= 0)
                {
                    var pageParam = Request.Query["params[page]"].FirstOrDefault();
                    if (int.TryParse(pageParam, out var page)) request.Page = page;
                }
                if (request.Size <= 0)
                {
                    var sizeParam = Request.Query["params[size]"].FirstOrDefault();
                    if (int.TryParse(sizeParam, out var size)) request.Size = size;
                }

                PagedResponse<Vehicle> result;

                // 如果是管理员，可以查看所有车辆；否则只能查看自己企业的车辆
                if (userRole == "管理员")
                {
                    result = await _vehicleService.GetVehiclesAsync(request);
                }
                else
                {
                    result = await _vehicleService.GetManageableVehiclesAsync(request, userTradeCode);
                }

                return Ok(ApiResponse<PagedResponse<Vehicle>>.Ok(result));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取车辆列表失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<PagedResponse<Vehicle>>.Fail("获取车辆列表失败"));
            }
        }

        /// <summary>
        /// 获取用户可管理的车辆列表（只显示自己企业的车辆）
        /// </summary>
        /// <param name="request">查询请求</param>
        /// <returns>车辆列表</returns>
        [HttpGet("manageable")]
        public async Task<ActionResult<ApiResponse<PagedResponse<Vehicle>>>> GetManageableVehicles([FromQuery] VehicleSearchRequest request)
        {
            try
            {
                var userTradeCode = User.FindFirst("TradeCode")?.Value ?? "";
                
                // 手动处理前端错误的参数格式 params[xxx]
                if (string.IsNullOrEmpty(request.VehicleNo))
                {
                    request.VehicleNo = Request.Query["params[vehicleNo]"].FirstOrDefault();
                }
                if (string.IsNullOrEmpty(request.VehicleType))
                {
                    request.VehicleType = Request.Query["params[vehicleType]"].FirstOrDefault();
                }
                if (string.IsNullOrEmpty(request.Status))
                {
                    request.Status = Request.Query["params[status]"].FirstOrDefault();
                }
                if (string.IsNullOrEmpty(request.TradeName))
                {
                    request.TradeName = Request.Query["params[tradeName]"].FirstOrDefault();
                }
                if (request.Page <= 0)
                {
                    var pageParam = Request.Query["params[page]"].FirstOrDefault();
                    if (int.TryParse(pageParam, out var page)) request.Page = page;
                }
                if (request.Size <= 0)
                {
                    var sizeParam = Request.Query["params[size]"].FirstOrDefault();
                    if (int.TryParse(sizeParam, out var size)) request.Size = size;
                }
                
                _logger.LogInformation("GetManageableVehicles请求参数: Page={Page}, Size={Size}, VehicleNo={VehicleNo}, UserTradeCode={UserTradeCode}", 
                    request.Page, request.Size, request.VehicleNo, userTradeCode);
                
                var result = await _vehicleService.GetManageableVehiclesAsync(request, userTradeCode);
                _logger.LogInformation("查询结果: Total={Total}, List.Count={Count}", result.Total, result.List.Count);
                
                return Ok(ApiResponse<PagedResponse<Vehicle>>.Ok(result));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取可管理车辆列表失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<PagedResponse<Vehicle>>.Fail("获取可管理车辆列表失败"));
            }
        }

        /// <summary>
        /// 根据AutoId获取车辆详情
        /// </summary>
        /// <param name="autoId">车辆AutoId</param>
        /// <returns>车辆详情</returns>
        [HttpGet("{autoId}")]
        public async Task<ActionResult<ApiResponse<Vehicle>>> GetVehicle(string autoId)
        {
            try
            {
                var vehicle = await _vehicleService.GetVehicleByIdAsync(autoId);
                
                if (vehicle == null)
                {
                    return NotFound(ApiResponse<Vehicle>.Fail("车辆不存在"));
                }

                // 权限检查：普通用户只能查看自己企业的车辆
                var userRole = User.FindFirst(ClaimTypes.Role)?.Value;
                var userTradeCode = User.FindFirst("TradeCode")?.Value ?? "";
                
                if (userRole != "管理员" && vehicle.TradeCode != userTradeCode)
                {
                    return Forbid("无权限查看其他企业的车辆");
                }

                return Ok(ApiResponse<Vehicle>.Ok(vehicle));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取车辆详情失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<Vehicle>.Fail("获取车辆详情失败"));
            }
        }

        /// <summary>
        /// 根据车牌号获取车辆信息
        /// </summary>
        /// <param name="vehicleNo">车牌号</param>
        /// <returns>车辆信息</returns>
        [HttpGet("by-vehicle-no/{vehicleNo}")]
        [AllowAnonymous] // 申报时需要快速查询车辆信息，不需要认证
        public async Task<ActionResult<ApiResponse<Vehicle>>> GetVehicleByVehicleNo(string vehicleNo)
        {
            try
            {
                var vehicle = await _vehicleService.GetVehicleByVehicleNoAsync(vehicleNo);
                
                if (vehicle == null)
                {
                    return NotFound(ApiResponse<Vehicle>.Fail("车辆不存在"));
                }

                return Ok(ApiResponse<Vehicle>.Ok(vehicle));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "根据车牌号获取车辆信息失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<Vehicle>.Fail("获取车辆信息失败"));
            }
        }

        /// <summary>
        /// 创建车辆
        /// </summary>
        /// <param name="request">车辆信息</param>
        /// <returns>创建结果</returns>
        [HttpPost]
        [Authorize(Roles = "管理员,申报员")]
        public async Task<ActionResult<ApiResponse<object>>> CreateVehicle([FromBody] VehicleRequest request)
        {
            try
            {
                // 验证必填字段
                if (string.IsNullOrEmpty(request.VehicleNo))
                {
                    return BadRequest(ApiResponse<object>.Fail("车牌号不能为空"));
                }

                var userTradeCode = User.FindFirst("TradeCode")?.Value ?? "";

                // 检查车牌号是否已存在
                var exists = await _vehicleService.IsVehicleNoExistsAsync(request.VehicleNo);
                if (exists)
                {
                    return BadRequest(ApiResponse<object>.Fail("车牌号已存在"));
                }

                var result = await _vehicleService.CreateVehicleAsync(request, userTradeCode);
                
                if (result)
                {
                    _logger.LogInformation("车辆创建成功: {VehicleNo}", request.VehicleNo);
                    return Ok(ApiResponse<object>.Ok(null, "车辆创建成功"));
                }
                else
                {
                    return StatusCode(500, ApiResponse<object>.Fail("车辆创建失败"));
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "创建车辆失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<object>.Fail("创建车辆失败"));
            }
        }

        /// <summary>
        /// 更新车辆
        /// </summary>
        /// <param name="autoId">车辆AutoId</param>
        /// <param name="request">车辆信息</param>
        /// <returns>更新结果</returns>
        [HttpPut("{autoId}")]
        [Authorize(Roles = "管理员,申报员")]
        public async Task<ActionResult<ApiResponse<object>>> UpdateVehicle(string autoId, [FromBody] VehicleRequest request)
        {
            try
            {
                // 验证必填字段
                if (string.IsNullOrEmpty(request.VehicleNo))
                {
                    return BadRequest(ApiResponse<object>.Fail("车牌号不能为空"));
                }

                var userTradeCode = User.FindFirst("TradeCode")?.Value ?? "";

                // 检查车辆是否存在
                var existingVehicle = await _vehicleService.GetVehicleByIdAsync(autoId);
                if (existingVehicle == null)
                {
                    return NotFound(ApiResponse<object>.Fail("车辆不存在"));
                }

                // 检查车牌号是否已被其他车辆使用
                var plateExists = await _vehicleService.IsVehicleNoExistsAsync(request.VehicleNo, autoId);
                if (plateExists)
                {
                    return BadRequest(ApiResponse<object>.Fail("车牌号已被其他车辆使用"));
                }

                var result = await _vehicleService.UpdateVehicleAsync(autoId, request, userTradeCode);
                
                if (result)
                {
                    _logger.LogInformation("车辆更新成功: {AutoId} - {VehicleNo}", autoId, request.VehicleNo);
                    return Ok(ApiResponse<object>.Ok(null, "车辆更新成功"));
                }
                else
                {
                    return StatusCode(500, ApiResponse<object>.Fail("车辆更新失败或无权限修改"));
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "更新车辆失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<object>.Fail("更新车辆失败"));
            }
        }

        /// <summary>
        /// 删除车辆
        /// </summary>
        /// <param name="autoId">车辆AutoId</param>
        /// <returns>删除结果</returns>
        [HttpDelete("{autoId}")]
        [Authorize(Roles = "管理员,申报员")]
        public async Task<ActionResult<ApiResponse<object>>> DeleteVehicle(string autoId)
        {
            try
            {
                var userTradeCode = User.FindFirst("TradeCode")?.Value ?? "";

                // 检查车辆是否存在
                var existingVehicle = await _vehicleService.GetVehicleByIdAsync(autoId);
                if (existingVehicle == null)
                {
                    return NotFound(ApiResponse<object>.Fail("车辆不存在"));
                }

                var result = await _vehicleService.DeleteVehicleAsync(autoId, userTradeCode);
                
                if (result)
                {
                    _logger.LogInformation("车辆删除成功: {AutoId} - {VehicleNo}", autoId, existingVehicle.VehicleNo);
                    return Ok(ApiResponse<object>.Ok(null, "车辆删除成功"));
                }
                else
                {
                    return StatusCode(500, ApiResponse<object>.Fail("车辆删除失败或无权限删除"));
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "删除车辆失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<object>.Fail("删除车辆失败"));
            }
        }

        /// <summary>
        /// 检查车牌号是否存在
        /// </summary>
        /// <param name="vehicleNo">车牌号</param>
        /// <param name="excludeAutoId">排除的车辆AutoId</param>
        /// <returns>检查结果</returns>
        [HttpGet("check-vehicle-no/{vehicleNo}")]
        public async Task<ActionResult<ApiResponse<bool>>> CheckVehicleNo(string vehicleNo, [FromQuery] string? excludeAutoId = null)
        {
            try
            {
                var exists = await _vehicleService.IsVehicleNoExistsAsync(vehicleNo, excludeAutoId);
                return Ok(ApiResponse<bool>.Ok(exists));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "检查车牌号失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<bool>.Fail("检查车牌号失败"));
            }
        }

        /// <summary>
        /// 根据车牌号模糊搜索车辆列表（用于自动完成）
        /// </summary>
        /// <param name="keyword">车牌号关键词</param>
        /// <param name="limit">返回数量限制，默认10条</param>
        /// <returns>车辆列表</returns>
        [HttpGet("search")]
        [AllowAnonymous] // 申报时需要搜索车辆信息，不需要认证
        public async Task<ActionResult<ApiResponse<List<VehicleSearchResult>>>> SearchVehicles([FromQuery] string? keyword = null, [FromQuery] int limit = 10)
        {
            try
            {
                // 手动处理前端错误的参数格式 params[xxx]
                if (string.IsNullOrEmpty(keyword))
                {
                    keyword = Request.Query["params[keyword]"].FirstOrDefault();
                }
                if (limit <= 0)
                {
                    var limitParam = Request.Query["params[limit]"].FirstOrDefault();
                    if (int.TryParse(limitParam, out var parsedLimit)) limit = parsedLimit;
                    if (limit <= 0) limit = 10; // 默认值
                }

                if (string.IsNullOrEmpty(keyword))
                {
                    return Ok(ApiResponse<List<VehicleSearchResult>>.Ok(new List<VehicleSearchResult>()));
                }

                var vehicles = await _vehicleService.SearchVehiclesByVehicleNoAsync(keyword, limit);
                return Ok(ApiResponse<List<VehicleSearchResult>>.Ok(vehicles));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "搜索车辆失败: {Message}", ex.Message);
                return StatusCode(500, ApiResponse<List<VehicleSearchResult>>.Fail("搜索车辆失败"));
            }
        }
    }
}