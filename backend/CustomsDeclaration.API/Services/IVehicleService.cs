using CustomsDeclaration.API.Models;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 车辆服务接口
    /// </summary>
    public interface IVehicleService
    {
        /// <summary>
        /// 获取车辆列表
        /// </summary>
        /// <param name="request">查询请求</param>
        /// <returns>车辆列表</returns>
        Task<PagedResponse<Vehicle>> GetVehiclesAsync(VehicleSearchRequest request);

        /// <summary>
        /// 根据AutoId获取车辆信息
        /// </summary>
        /// <param name="autoId">车辆AutoId</param>
        /// <returns>车辆信息</returns>
        Task<Vehicle?> GetVehicleByIdAsync(string autoId);

        /// <summary>
        /// 根据车牌号获取车辆信息
        /// </summary>
        /// <param name="vehicleNo">车牌号</param>
        /// <returns>车辆信息</returns>
        Task<Vehicle?> GetVehicleByVehicleNoAsync(string vehicleNo);

        /// <summary>
        /// 创建车辆
        /// </summary>
        /// <param name="request">车辆信息</param>
        /// <param name="userTradeCode">当前用户企业代码</param>
        /// <returns>创建结果</returns>
        Task<bool> CreateVehicleAsync(VehicleRequest request, string userTradeCode);

        /// <summary>
        /// 更新车辆
        /// </summary>
        /// <param name="autoId">车辆AutoId</param>
        /// <param name="request">车辆信息</param>
        /// <param name="userTradeCode">当前用户企业代码</param>
        /// <returns>更新结果</returns>
        Task<bool> UpdateVehicleAsync(string autoId, VehicleRequest request, string userTradeCode);

        /// <summary>
        /// 删除车辆
        /// </summary>
        /// <param name="autoId">车辆AutoId</param>
        /// <param name="userTradeCode">当前用户企业代码</param>
        /// <returns>删除结果</returns>
        Task<bool> DeleteVehicleAsync(string autoId, string userTradeCode);

        /// <summary>
        /// 检查车牌号是否已存在
        /// </summary>
        /// <param name="vehicleNo">车牌号</param>
        /// <param name="excludeAutoId">排除的车辆AutoId（用于更新时检查）</param>
        /// <returns>是否存在</returns>
        Task<bool> IsVehicleNoExistsAsync(string vehicleNo, string? excludeAutoId = null);

        /// <summary>
        /// 根据车牌号模糊搜索车辆（用于自动完成）
        /// </summary>
        /// <param name="keyword">车牌号关键词</param>
        /// <param name="limit">返回数量限制</param>
        /// <returns>车辆搜索结果列表</returns>
        Task<List<VehicleSearchResult>> SearchVehiclesByVehicleNoAsync(string keyword, int limit = 10);

        /// <summary>
        /// 获取用户可管理的车辆列表（基于企业代码权限控制）
        /// </summary>
        /// <param name="request">查询请求</param>
        /// <param name="userTradeCode">当前用户企业代码</param>
        /// <returns>车辆列表</returns>
        Task<PagedResponse<Vehicle>> GetManageableVehiclesAsync(VehicleSearchRequest request, string userTradeCode);

        /// <summary>
        /// 从申报信息自动创建车辆信息
        /// </summary>
        /// <param name="vehicleNo">车牌号</param>
        /// <param name="vehicleWeight">车辆自重</param>
        /// <param name="tradeCode">企业代码</param>
        /// <param name="tradeName">企业名称</param>
        /// <returns>创建结果</returns>
        Task<bool> CreateVehicleFromDeclarationAsync(string vehicleNo, decimal vehicleWeight, string tradeCode, string tradeName);
    }
}