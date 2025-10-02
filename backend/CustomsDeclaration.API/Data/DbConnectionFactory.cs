using System.Data;
using Microsoft.Data.SqlClient;
using Oracle.ManagedDataAccess.Client;

namespace CustomsDeclaration.API.Data
{
    /// <summary>
    /// 数据库连接工厂实现类
    /// </summary>
    public class DbConnectionFactory : IDbConnectionFactory
    {
        private readonly IConfiguration _configuration;
        private readonly string _databaseProvider;

        public DbConnectionFactory(IConfiguration configuration)
        {
            _configuration = configuration;
            _databaseProvider = _configuration["DatabaseProvider"] ?? "SqlServer";
        }

        /// <summary>
        /// 创建数据库连接
        /// </summary>
        /// <returns>数据库连接实例</returns>
        public IDbConnection CreateConnection()
        {
            return _databaseProvider.ToLower() switch
            {
                "oracle" => new OracleConnection(_configuration.GetConnectionString("OracleConnection")),
                "sqlserver" or _ => new SqlConnection(_configuration.GetConnectionString("DefaultConnection"))
            };
        }

        /// <summary>
        /// 获取数据库提供程序类型
        /// </summary>
        /// <returns>数据库提供程序类型</returns>
        public string GetDatabaseProvider()
        {
            return _databaseProvider;
        }
    }
}