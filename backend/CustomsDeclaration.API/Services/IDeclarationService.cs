using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Models.DTOs;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 核放单服务接口
    /// </summary>
    public interface IDeclarationService
    {
        /// <summary>
        /// 保存空车核放单
        /// </summary>
        /// <param name="declaration">核放单信息</param>
        /// <param name="userId">用户ID</param>
        /// <returns>保存结果</returns>
        Task<ApiResponse<string>> SaveEmptyVehicleDeclarationAsync(Declaration declaration, int userId);

        /// <summary>
        /// 保存非空车核放单
        /// </summary>
        /// <param name="declaration">核放单信息</param>
        /// <param name="userId">用户ID</param>
        /// <returns>保存结果</returns>
        Task<ApiResponse<string>> SaveDeclarationAsync(Declaration declaration, int userId);


        /// <summary>
        /// 查询核放单列表
        /// </summary>
        /// <param name="request">查询条件</param>
        /// <param name="userId">用户ID</param>
        /// <returns>核放单列表</returns>
        Task<ApiResponse<PagedResult<Declaration>>> GetDeclarationListAsync(DeclarationSearchRequest request, int userId);

        /// <summary>
        /// 根据ID获取核放单详情
        /// </summary>
        /// <param name="id">核放单ID</param>
        /// <param name="userId">用户ID</param>
        /// <returns>核放单详情</returns>
        Task<ApiResponse<Declaration>> GetDeclarationByIdAsync(int id, int userId);


        /// <summary>
        /// 保存申请单（包含表头和商品明细）
        /// </summary>
        /// <param name="request">申请单数据</param>
        /// <param name="userId">用户ID</param>
        /// <returns>申请单业务单号</returns>
        Task<ApiResponse<string>> SaveApplicationAsync(SaveApplicationRequestDto request, int userId);

        /// <summary>
        /// 保存完整非空核放单（申请单 + 核放单表头 + 核放单表体）
        /// </summary>
        /// <param name="declaration">核放单信息</param>
        /// <param name="applicationData">申请单数据</param>
        /// <param name="userId">用户ID</param>
        /// <returns>核放单号</returns>
        Task<ApiResponse<string>> SaveCompleteDeclarationAsync(Declaration declaration, SaveApplicationRequestDto applicationData, int userId);

        /// <summary>
        /// 获取单一申报列表
        /// </summary>
        /// <param name="request">查询条件</param>
        /// <param name="userId">用户ID</param>
        /// <returns>单一申报列表</returns>
        Task<ApiResponse<PagedResult<UnifiedDeclarationListDto>>> GetUnifiedDeclarationListAsync(UnifiedDeclarationSearchRequestDto request, int userId);

        /// <summary>
        /// 获取单一申报详情
        /// </summary>
        /// <param name="dischargedNo">核放单号</param>
        /// <param name="userId">用户ID</param>
        /// <returns>单一申报详情</returns>
        Task<ApiResponse<UnifiedDeclarationDetailDto>> GetUnifiedDeclarationDetailAsync(string dischargedNo, int userId);

        /// <summary>
        /// 删除单一申报
        /// </summary>
        /// <param name="dischargedNo">核放单号</param>
        /// <param name="userId">用户ID</param>
        /// <returns>删除结果</returns>
        Task<ApiResponse<bool>> DeleteUnifiedDeclarationAsync(string dischargedNo, int userId);
    }

    /// <summary>
    /// 分页结果
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class PagedResult<T>
    {
        /// <summary>
        /// 数据列表
        /// </summary>
        public List<T> Items { get; set; } = new();

        /// <summary>
        /// 总记录数
        /// </summary>
        public int Total { get; set; }

        /// <summary>
        /// 当前页码
        /// </summary>
        public int Page { get; set; }

        /// <summary>
        /// 页大小
        /// </summary>
        public int Size { get; set; }

        /// <summary>
        /// 总页数
        /// </summary>
        public int TotalPages => (int)Math.Ceiling((double)Total / Size);
    }
}