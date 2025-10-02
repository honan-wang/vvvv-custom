using CustomsDeclaration.API.Data;
using Microsoft.Data.SqlClient;
using Oracle.ManagedDataAccess.Client;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 业务单号生成服务实现
    /// </summary>
    public class JobNumberService : IJobNumberService
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public JobNumberService(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        /// <summary>
        /// 获取业务单号
        /// 调用存储过程 SP_GET_JOB_NO
        /// </summary>
        /// <param name="bizType">业务类型，如KA10、LF、U、E等</param>
        /// <param name="tradeCode">企业代码</param>
        /// <param name="customsCode">海关代码</param>
        /// <returns>业务单号</returns>
        public async Task<string> GetJobNumberAsync(string bizType = "HF", string? tradeCode = null, string? customsCode = null)
        {
            try
            {
                var provider = _connectionFactory.GetDatabaseProvider().ToLower();
                if (provider == "sqlserver")
                {
                    return await GetJobNumberFromSqlServerAsync(bizType, tradeCode, customsCode);
                }
                else
                {
                    return await GetJobNumberFromOracleAsync(bizType, tradeCode, customsCode);
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"获取业务单号失败: {ex.Message}", ex);
            }
        }

        /// <summary>
        /// 获取业务单号（兼容原方法）
        /// </summary>
        /// <returns>业务单号</returns>
        public async Task<string> GetJobNumberAsync()
        {
            return await GetJobNumberAsync("HF", null, null);
        }

        /// <summary>
        /// 从 SQL Server 获取业务单号
        /// </summary>
        private async Task<string> GetJobNumberFromSqlServerAsync(string bizType, string? tradeCode, string? customsCode)
        {
            // 暂时使用模拟单号，格式：bizType + 日期 + 随机数
            var dateStr = DateTime.Now.ToString("yyyyMMdd");
            var random = new Random().Next(1000, 9999);
            var jobNo = $"{bizType}{dateStr}{random}";

            // 模拟异步操作
            await Task.Delay(10);

            return jobNo;

            // TODO: 后续启用真实存储过程调用
            /*
            using var connection = _connectionFactory.CreateConnection();
            var sqlConnection = (SqlConnection)connection;
            using var command = new SqlCommand("SP_GET_JOB_NO", sqlConnection)
            {
                CommandType = System.Data.CommandType.StoredProcedure
            };

            // 添加输入参数
            command.Parameters.Add(new SqlParameter("@P_TYPE", System.Data.SqlDbType.VarChar, 10) { Value = "HF" });
            command.Parameters.Add(new SqlParameter("@P_BIZ_TYPE", System.Data.SqlDbType.VarChar, 10) { Value = bizType });
            command.Parameters.Add(new SqlParameter("@P_IE_MARK", System.Data.SqlDbType.VarChar, 1) { Value = DBNull.Value });
            command.Parameters.Add(new SqlParameter("@P_TRADE_CODE", System.Data.SqlDbType.VarChar, 20) { Value = tradeCode ?? (object)DBNull.Value });
            command.Parameters.Add(new SqlParameter("@P_CUSTOMS_CODE", System.Data.SqlDbType.VarChar, 20) { Value = customsCode ?? (object)DBNull.Value });

            // 添加输出参数
            var outputParam = new SqlParameter("@P_JOB_NO", System.Data.SqlDbType.NVarChar, 50)
            {
                Direction = System.Data.ParameterDirection.Output
            };
            command.Parameters.Add(outputParam);

            await sqlConnection.OpenAsync();
            await command.ExecuteNonQueryAsync();

            return outputParam.Value?.ToString() ?? string.Empty;
            */
        }

        /// <summary>
        /// 从 Oracle 获取业务单号
        /// </summary>
        private async Task<string> GetJobNumberFromOracleAsync(string bizType, string? tradeCode, string? customsCode)
        {
            // 暂时使用模拟单号，格式：bizType + 日期 + 随机数
            var dateStr = DateTime.Now.ToString("yyyyMMdd");
            var random = new Random().Next(1000, 9999);
            var jobNo = $"{bizType}{dateStr}{random}";

            // 模拟异步操作
            await Task.Delay(10);

            return jobNo;

            // TODO: 后续启用真实存储过程调用
            /*
            using var connection = _connectionFactory.CreateConnection();
            var oracleConnection = (OracleConnection)connection;
            using var command = new OracleCommand("SP_GET_JOB_NO", oracleConnection)
            {
                CommandType = System.Data.CommandType.StoredProcedure
            };

            // 添加输入参数
            command.Parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2, 10) { Value = "HF" });
            command.Parameters.Add(new OracleParameter("P_BIZ_TYPE", OracleDbType.Varchar2, 10) { Value = bizType });
            command.Parameters.Add(new OracleParameter("P_IE_MARK", OracleDbType.Varchar2, 1) { Value = DBNull.Value });
            command.Parameters.Add(new OracleParameter("P_TRADE_CODE", OracleDbType.Varchar2, 20) { Value = tradeCode ?? (object)DBNull.Value });
            command.Parameters.Add(new OracleParameter("P_CUSTOMS_CODE", OracleDbType.Varchar2, 20) { Value = customsCode ?? (object)DBNull.Value });

            // 添加输出参数
            var outputParam = new OracleParameter("P_JOB_NO", OracleDbType.Varchar2, 50)
            {
                Direction = System.Data.ParameterDirection.Output
            };
            command.Parameters.Add(outputParam);

            await oracleConnection.OpenAsync();
            await command.ExecuteNonQueryAsync();

            return outputParam.Value?.ToString() ?? string.Empty;
            */
        }
    }
}