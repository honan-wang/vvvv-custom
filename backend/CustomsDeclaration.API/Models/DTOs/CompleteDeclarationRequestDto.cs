using CustomsDeclaration.API.Models;

namespace CustomsDeclaration.API.Models.DTOs
{
    /// <summary>
    /// 完整非空核放单保存请求DTO
    /// </summary>
    public class CompleteDeclarationRequestDto
    {
        /// <summary>
        /// 核放单信息
        /// </summary>
        public Declaration Declaration { get; set; } = new();

        /// <summary>
        /// 申请单数据（表头和商品明细）
        /// </summary>
        public SaveApplicationRequestDto ApplicationData { get; set; } = new();
    }
}