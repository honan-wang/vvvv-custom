using System.Data;

namespace CustomsDeclaration.API.Data
{
    /// <summary>
    /// 数据库连接工厂接口
    /// </summary>
    public interface IDbConnectionFactory
    {
        /// <summary>
        /// 创建数据库连接
        /// </summary>
        /// <returns>数据库连接实例</returns>
        IDbConnection CreateConnection();
        
        /// <summary>
        /// 获取数据库提供程序类型
        /// </summary>
        /// <returns>数据库提供程序类型</returns>
        string GetDatabaseProvider();
    }
}