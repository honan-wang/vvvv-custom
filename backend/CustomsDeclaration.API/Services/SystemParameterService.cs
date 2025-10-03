using System.Data;
using CustomsDeclaration.API.Data;
using CustomsDeclaration.API.Models;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 系统参数服务实现
    /// </summary>
    public class SystemParameterService : ISystemParameterService
    {
        private readonly DatabaseHelper _dbHelper;
        private readonly ILogger<SystemParameterService> _logger;

        public SystemParameterService(DatabaseHelper dbHelper, ILogger<SystemParameterService> logger)
        {
            _dbHelper = dbHelper;
            _logger = logger;
        }

        /// <summary>
        /// 根据参数类型获取参数选项列表
        /// </summary>
        /// <param name="paraType">参数类型</param>
        /// <returns>参数选项列表</returns>
        public async Task<List<ParameterOption>> GetParameterOptionsAsync(string paraType)
        {
            try
            {
                string sql;
                Dictionary<string, object> parameters;
                
                // 特殊处理区域标志，从BASE_REGION表获取数据
                if (paraType.Equals("REGION", StringComparison.OrdinalIgnoreCase))
                {
                    // BASE_REGION表的flag字段存储的是海关代码，获取所有有效数据
                    sql = "SELECT code, name FROM BASE_REGION WHERE flag IS NOT NULL AND flag != '' ORDER BY code";
                    parameters = new Dictionary<string, object>();
                }
                // 特殊处理包装种类，从BASE_WRAP_TYPE表获取数据
                else if (paraType.Equals("WRAP_TYPE", StringComparison.OrdinalIgnoreCase))
                {
                    // BASE_WRAP_TYPE表，获取所有数据（flag字段为空，所以不过滤）
                    sql = "SELECT code, name FROM BASE_WRAP_TYPE ORDER BY code";
                    parameters = new Dictionary<string, object>();
                }
                else
                {
                    // 其他参数类型从SYS_PARAMETERS表获取
                    sql = "SELECT PARA_CODE, PARA_NAME, REMARK FROM SYS_PARAMETERS WHERE USED_FLAG = '1' AND PARA_TYPE = @paraType ORDER BY PARA_INDEX, PARA_CODE";
                    parameters = new Dictionary<string, object>
                    {
                        { "paraType", paraType }
                    };
                }

                var dataTable = await _dbHelper.ExecuteQueryAsync(sql, parameters);
                _logger.LogInformation("查询结果返回行数: {RowCount}", dataTable.Rows.Count);
                var options = new List<ParameterOption>();

                foreach (DataRow row in dataTable.Rows)
                {
                    if (paraType.Equals("REGION", StringComparison.OrdinalIgnoreCase))
                    {
                        options.Add(new ParameterOption
                        {
                            Value = row["code"]?.ToString() ?? "",
                            Label = row["name"]?.ToString() ?? ""
                        });
                    }
                    else if (paraType.Equals("WRAP_TYPE", StringComparison.OrdinalIgnoreCase))
                    {
                        options.Add(new ParameterOption
                        {
                            Value = row["code"]?.ToString() ?? "",
                            Label = row["name"]?.ToString() ?? ""
                        });
                    }
                    else
                    {
                        options.Add(new ParameterOption
                        {
                            Value = row["PARA_CODE"]?.ToString() ?? "",
                            Label = row["PARA_NAME"]?.ToString() ?? "",
                            Remark = row.Table.Columns.Contains("REMARK") ? row["REMARK"]?.ToString() : null
                        });
                    }
                }

                _logger.LogInformation("成功获取参数类型 {ParaType} 的选项，共 {Count} 条", paraType, options.Count);
                return options;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取参数选项失败，参数类型: {ParaType}", paraType);
                throw;
            }
        }

        /// <summary>
        /// 获取所有系统参数
        /// </summary>
        /// <returns>系统参数列表</returns>
        public async Task<List<SystemParameter>> GetAllParametersAsync()
        {
            try
            {
                var sql = "SELECT PARA_CODE, PARA_NAME, PARA_TYPE, USED_FLAG, PARA_INDEX, REMARK FROM SYS_PARAMETERS ORDER BY PARA_TYPE, PARA_INDEX, PARA_CODE";
                
                var dataTable = await _dbHelper.ExecuteQueryAsync(sql);
                var parameters = new List<SystemParameter>();

                foreach (DataRow row in dataTable.Rows)
                {
                    parameters.Add(new SystemParameter
                    {
                        ParaCode = row["PARA_CODE"]?.ToString() ?? "",
                        ParaName = row["PARA_NAME"]?.ToString() ?? "",
                        ParaType = row["PARA_TYPE"]?.ToString() ?? "",
                        UsedFlag = row["USED_FLAG"]?.ToString() ?? "",
                        SortOrder = row["PARA_INDEX"] as int?,
                        Remark = row["REMARK"]?.ToString()
                    });
                }

                _logger.LogInformation("成功获取所有系统参数，共 {Count} 条", parameters.Count);
                return parameters;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取所有系统参数失败");
                throw;
            }
        }

        /// <summary>
        /// 根据参数类型获取系统参数
        /// </summary>
        /// <param name="paraType">参数类型</param>
        /// <returns>系统参数列表</returns>
        public async Task<List<SystemParameter>> GetParametersByTypeAsync(string paraType)
        {
            try
            {
                var sql = "SELECT PARA_CODE, PARA_NAME, PARA_TYPE, USED_FLAG, PARA_INDEX, REMARK FROM SYS_PARAMETERS WHERE PARA_TYPE = @paraType ORDER BY PARA_INDEX, PARA_CODE";
                var parameters = new Dictionary<string, object>
                {
                    { "paraType", paraType }
                };

                var dataTable = await _dbHelper.ExecuteQueryAsync(sql, parameters);
                var result = new List<SystemParameter>();

                foreach (DataRow row in dataTable.Rows)
                {
                    result.Add(new SystemParameter
                    {
                        ParaCode = row["PARA_CODE"]?.ToString() ?? "",
                        ParaName = row["PARA_NAME"]?.ToString() ?? "",
                        ParaType = row["PARA_TYPE"]?.ToString() ?? "",
                        UsedFlag = row["USED_FLAG"]?.ToString() ?? "",
                        SortOrder = row["PARA_INDEX"] as int?,
                        Remark = row["REMARK"]?.ToString()
                    });
                }

                _logger.LogInformation("成功获取参数类型 {ParaType} 的参数，共 {Count} 条", paraType, result.Count);
                return result;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "根据类型获取系统参数失败，参数类型: {ParaType}", paraType);
                throw;
            }
        }

        /// <summary>
        /// 根据企业编码获取账册号选项
        /// </summary>
        /// <param name="tradeCode">企业编码</param>
        /// <returns>账册号选项列表</returns>
        public async Task<List<ParameterOption>> GetBookOptionsAsync(string tradeCode)
        {
            try
            {
                var sql = "SELECT a.ems_no FROM EMS_HEAD a WHERE A.USED_FLAG='1' AND A.STEP_ID in ('ZC100300','ZC200300') AND A.TRADE_CODE = @tradeCode ORDER BY a.ems_no";
                var parameters = new Dictionary<string, object>
                {
                    { "tradeCode", tradeCode }
                };

                var dataTable = await _dbHelper.ExecuteQueryAsync(sql, parameters);
                _logger.LogInformation("查询结果返回行数: {RowCount}", dataTable.Rows.Count);
                var options = new List<ParameterOption>();

                foreach (DataRow row in dataTable.Rows)
                {
                    var emsNo = row["ems_no"]?.ToString() ?? "";
                    options.Add(new ParameterOption
                    {
                        Value = emsNo,
                        Label = emsNo
                    });
                }

                _logger.LogInformation("成功获取企业 {TradeCode} 的账册号选项，共 {Count} 条", tradeCode, options.Count);
                return options;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取账册号选项失败，企业编码: {TradeCode}", tradeCode);
                throw;
            }
        }

        /// <summary>
        /// 获取计量单位选项
        /// </summary>
        /// <returns>计量单位选项列表</returns>
        public async Task<List<ParameterOption>> GetUnitOptionsAsync()
        {
            try
            {
                var sql = "SELECT code, name FROM BASE_UNIT ORDER BY code";
                var parameters = new Dictionary<string, object>();

                var dataTable = await _dbHelper.ExecuteQueryAsync(sql, parameters);
                _logger.LogInformation("查询结果返回行数: {RowCount}", dataTable.Rows.Count);
                var options = new List<ParameterOption>();

                foreach (DataRow row in dataTable.Rows)
                {
                    options.Add(new ParameterOption
                    {
                        Value = row["code"]?.ToString() ?? "",
                        Label = row["name"]?.ToString() ?? ""
                    });
                }

                _logger.LogInformation("成功获取计量单位选项，共 {Count} 条", options.Count);
                return options;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取计量单位选项失败");
                throw;
            }
        }

        /// <summary>
        /// 获取账册表体信息
        /// </summary>
        /// <param name="bookNo">账册号</param>
        /// <param name="itemNo">项号</param>
        /// <returns>账册表体信息</returns>
        public async Task<object?> GetBookItemInfoAsync(string bookNo, string itemNo)
        {
            try
            {
                var sql = @"SELECT A.G_NO,A.EMS_NO,A.CODE_TS,A.G_NAME,A.UNIT,A.UNIT_1,A.UNIT_2,A.IN_QTY,A.OUT_QTY,A.G_MODEL,A.CURR
                           FROM EMS_AIMG_PRE A
                           WHERE 1=1
                           AND A.EMS_NO=@bookNo
                           AND A.G_NO=@itemNo
                           AND A.STEP_ID IN ('GBGX100300','GBGX200100','GBGX200300','GBGX200400')
                           AND A.MODIFY_MARK != '2'";
                
                var parameters = new Dictionary<string, object>
                {
                    { "bookNo", bookNo },
                    { "itemNo", itemNo }
                };

                var dataTable = await _dbHelper.ExecuteQueryAsync(sql, parameters);
                _logger.LogInformation("查询账册表体信息结果返回行数: {RowCount}", dataTable.Rows.Count);

                if (dataTable.Rows.Count == 0)
                {
                    _logger.LogInformation("未找到账册号 {BookNo} 项号 {ItemNo} 的表体信息", bookNo, itemNo);
                    return null;
                }

                var row = dataTable.Rows[0];
                var result = new
                {
                    G_NO = row["G_NO"]?.ToString() ?? "",
                    EMS_NO = row["EMS_NO"]?.ToString() ?? "",
                    CODE_TS = row["CODE_TS"]?.ToString() ?? "",
                    G_NAME = row["G_NAME"]?.ToString() ?? "",
                    UNIT = row["UNIT"]?.ToString() ?? "",
                    UNIT_1 = row["UNIT_1"]?.ToString() ?? "",
                    UNIT_2 = row["UNIT_2"]?.ToString() ?? "",
                    IN_QTY = row["IN_QTY"],
                    OUT_QTY = row["OUT_QTY"],
                    G_MODEL = row["G_MODEL"]?.ToString() ?? "",
                    CURR = row["CURR"]?.ToString() ?? "",
                    // 兼容前端字段名
                    goodsName = row["G_NAME"]?.ToString() ?? "",
                    goodsCode = row["CODE_TS"]?.ToString() ?? "",
                    goodsSpec = row["G_MODEL"]?.ToString() ?? "",
                    currency = row["CURR"]?.ToString() ?? ""
                };

                _logger.LogInformation("成功获取账册号 {BookNo} 项号 {ItemNo} 的表体信息", bookNo, itemNo);
                return result;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取账册表体信息失败，账册号: {BookNo}, 项号: {ItemNo}", bookNo, itemNo);
                throw;
            }
        }

        /// <summary>
        /// 获取币制选项
        /// </summary>
        /// <returns>币制选项列表</returns>
        public async Task<List<ParameterOption>> GetCurrencyOptionsAsync()
        {
            try
            {
                var sql = "SELECT code, name FROM BASE_CURR ORDER BY code";
                var parameters = new Dictionary<string, object>();

                var dataTable = await _dbHelper.ExecuteQueryAsync(sql, parameters);
                _logger.LogInformation("查询结果返回行数: {RowCount}", dataTable.Rows.Count);
                var options = new List<ParameterOption>();

                foreach (DataRow row in dataTable.Rows)
                {
                    options.Add(new ParameterOption
                    {
                        Value = row["code"]?.ToString() ?? "",
                        Label = row["name"]?.ToString() ?? ""
                    });
                }

                _logger.LogInformation("成功获取币制选项，共 {Count} 条", options.Count);
                return options;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "获取币制选项失败");
                throw;
            }
        }
    }
}