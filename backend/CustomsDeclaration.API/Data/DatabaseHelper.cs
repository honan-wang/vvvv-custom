using System.Data;
using System.Data.Common;
using Microsoft.Data.SqlClient;
using Oracle.ManagedDataAccess.Client;

namespace CustomsDeclaration.API.Data
{
    /// <summary>
    /// 数据库操作帮助类
    /// </summary>
    public class DatabaseHelper
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public DatabaseHelper(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        /// <summary>
        /// 执行查询并返回DataTable
        /// </summary>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>查询结果</returns>
        public async Task<DataTable> ExecuteQueryAsync(string sql, Dictionary<string, object>? parameters = null)
        {
            using var connection = _connectionFactory.CreateConnection();
            using var command = connection.CreateCommand();
            
            command.CommandText = sql;
            
            if (parameters != null)
            {
                foreach (var parameter in parameters)
                {
                    var dbParameter = command.CreateParameter();
                    dbParameter.ParameterName = GetParameterName(parameter.Key);
                    dbParameter.Value = parameter.Value ?? DBNull.Value;
                    command.Parameters.Add(dbParameter);
                }
            }

            // 使用具体的连接类型来支持异步操作
            if (connection is SqlConnection sqlConnection)
            {
                await sqlConnection.OpenAsync();
                using var reader = await ((SqlCommand)command).ExecuteReaderAsync();
                var dataTable = new DataTable();
                dataTable.Load(reader);
                return dataTable;
            }
            else if (connection is OracleConnection oracleConnection)
            {
                await oracleConnection.OpenAsync();
                using var reader = await ((OracleCommand)command).ExecuteReaderAsync();
                var dataTable = new DataTable();
                dataTable.Load(reader);
                return dataTable;
            }
            else
            {
                // 回退到同步操作
                connection.Open();
                using var reader = command.ExecuteReader();
                var dataTable = new DataTable();
                dataTable.Load(reader);
                return dataTable;
            }
        }

        /// <summary>
        /// 执行非查询SQL语句
        /// </summary>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>受影响的行数</returns>
        public async Task<int> ExecuteNonQueryAsync(string sql, Dictionary<string, object>? parameters = null)
        {
            using var connection = _connectionFactory.CreateConnection();
            using var command = connection.CreateCommand();
            
            command.CommandText = sql;
            
            if (parameters != null)
            {
                foreach (var parameter in parameters)
                {
                    var dbParameter = command.CreateParameter();
                    dbParameter.ParameterName = GetParameterName(parameter.Key);
                    dbParameter.Value = parameter.Value ?? DBNull.Value;
                    command.Parameters.Add(dbParameter);
                }
            }

            // 使用具体的连接类型来支持异步操作
            if (connection is SqlConnection sqlConnection)
            {
                await sqlConnection.OpenAsync();
                return await ((SqlCommand)command).ExecuteNonQueryAsync();
            }
            else if (connection is OracleConnection oracleConnection)
            {
                await oracleConnection.OpenAsync();
                return await ((OracleCommand)command).ExecuteNonQueryAsync();
            }
            else
            {
                // 回退到同步操作
                connection.Open();
                return command.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// 执行存储过程
        /// </summary>
        /// <param name="procedureName">存储过程名称</param>
        /// <param name="parameters">参数</param>
        /// <returns>查询结果</returns>
        public async Task<DataTable> ExecuteStoredProcedureAsync(string procedureName, Dictionary<string, object>? parameters = null)
        {
            using var connection = _connectionFactory.CreateConnection();
            using var command = connection.CreateCommand();
            
            command.CommandText = procedureName;
            command.CommandType = CommandType.StoredProcedure;
            
            if (parameters != null)
            {
                foreach (var parameter in parameters)
                {
                    var dbParameter = command.CreateParameter();
                    dbParameter.ParameterName = GetParameterName(parameter.Key);
                    dbParameter.Value = parameter.Value ?? DBNull.Value;
                    command.Parameters.Add(dbParameter);
                }
            }

            // 使用具体的连接类型来支持异步操作
            if (connection is SqlConnection sqlConnection)
            {
                await sqlConnection.OpenAsync();
                using var reader = await ((SqlCommand)command).ExecuteReaderAsync();
                var dataTable = new DataTable();
                dataTable.Load(reader);
                return dataTable;
            }
            else if (connection is OracleConnection oracleConnection)
            {
                await oracleConnection.OpenAsync();
                using var reader = await ((OracleCommand)command).ExecuteReaderAsync();
                var dataTable = new DataTable();
                dataTable.Load(reader);
                return dataTable;
            }
            else
            {
                // 回退到同步操作
                connection.Open();
                using var reader = command.ExecuteReader();
                var dataTable = new DataTable();
                dataTable.Load(reader);
                return dataTable;
            }
        }

        /// <summary>
        /// 执行事务
        /// </summary>
        /// <param name="operations">事务操作列表</param>
        /// <returns>是否成功</returns>
        public async Task<bool> ExecuteTransactionAsync(List<(string sql, Dictionary<string, object>? parameters)> operations)
        {
            using var connection = _connectionFactory.CreateConnection();
            
            // 使用具体的连接类型来支持异步操作
            if (connection is SqlConnection sqlConnection)
            {
                await sqlConnection.OpenAsync();
                using var transaction = sqlConnection.BeginTransaction();
                
                try
                {
                    foreach (var (sql, parameters) in operations)
                    {
                        using var command = new SqlCommand(sql, sqlConnection, transaction);
                        
                        if (parameters != null)
                        {
                            foreach (var parameter in parameters)
                            {
                                command.Parameters.AddWithValue(GetParameterName(parameter.Key), parameter.Value ?? DBNull.Value);
                            }
                        }
                        
                        await command.ExecuteNonQueryAsync();
                    }
                    
                    transaction.Commit();
                    return true;
                }
                catch (Exception)
                {
                    transaction.Rollback();
                    throw;
                }
            }
            else if (connection is OracleConnection oracleConnection)
            {
                await oracleConnection.OpenAsync();
                using var transaction = oracleConnection.BeginTransaction();
                
                try
                {
                    foreach (var (sql, parameters) in operations)
                    {
                        using var command = new OracleCommand(sql, oracleConnection);
                        command.Transaction = transaction;
                        
                        if (parameters != null)
                        {
                            foreach (var parameter in parameters)
                            {
                                var oracleParam = new OracleParameter(GetParameterName(parameter.Key), parameter.Value ?? DBNull.Value);
                                command.Parameters.Add(oracleParam);
                            }
                        }
                        
                        await command.ExecuteNonQueryAsync();
                    }
                    
                    transaction.Commit();
                    return true;
                }
                catch (Exception)
                {
                    transaction.Rollback();
                    throw;
                }
            }
            else
            {
                // 回退到同步操作
                connection.Open();
                using var transaction = connection.BeginTransaction();
                
                try
                {
                    foreach (var (sql, parameters) in operations)
                    {
                        using var command = connection.CreateCommand();
                        command.Transaction = transaction;
                        command.CommandText = sql;
                        
                        if (parameters != null)
                        {
                            foreach (var parameter in parameters)
                            {
                                var dbParameter = command.CreateParameter();
                                dbParameter.ParameterName = GetParameterName(parameter.Key);
                                dbParameter.Value = parameter.Value ?? DBNull.Value;
                                command.Parameters.Add(dbParameter);
                            }
                        }
                        
                        command.ExecuteNonQuery();
                    }
                    
                    transaction.Commit();
                    return true;
                }
                catch (Exception)
                {
                    transaction.Rollback();
                    throw;
                }
            }
        }

        /// <summary>
        /// 执行标量查询并返回单个值
        /// </summary>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>查询结果</returns>
        public async Task<object?> ExecuteScalarAsync(string sql, Dictionary<string, object>? parameters = null)
        {
            using var connection = _connectionFactory.CreateConnection();
            using var command = connection.CreateCommand();

            command.CommandText = sql;

            if (parameters != null)
            {
                foreach (var parameter in parameters)
                {
                    var dbParameter = command.CreateParameter();
                    dbParameter.ParameterName = GetParameterName(parameter.Key);
                    dbParameter.Value = parameter.Value ?? DBNull.Value;
                    command.Parameters.Add(dbParameter);
                }
            }

            // 使用具体的连接类型来支持异步操作
            if (connection is SqlConnection sqlConnection)
            {
                await sqlConnection.OpenAsync();
                return await ((SqlCommand)command).ExecuteScalarAsync();
            }
            else if (connection is OracleConnection oracleConnection)
            {
                await oracleConnection.OpenAsync();
                return await ((OracleCommand)command).ExecuteScalarAsync();
            }
            else
            {
                // 回退到同步操作
                connection.Open();
                return command.ExecuteScalar();
            }
        }

        /// <summary>
        /// 执行标量查询并返回单个值（泛型版本）
        /// </summary>
        /// <typeparam name="T">返回值类型</typeparam>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>查询结果</returns>
        public async Task<T?> ExecuteScalarAsync<T>(string sql, Dictionary<string, object>? parameters = null)
        {
            var result = await ExecuteScalarAsync(sql, parameters);
            if (result == null || result == DBNull.Value)
                return default(T);

            return (T)Convert.ChangeType(result, typeof(T));
        }

        /// <summary>
        /// 执行标量查询并返回单个值（带连接参数的泛型版本）
        /// </summary>
        /// <typeparam name="T">返回值类型</typeparam>
        /// <param name="connection">数据库连接</param>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数对象</param>
        /// <returns>查询结果</returns>
        public async Task<T?> ExecuteScalarAsync<T>(IDbConnection connection, string sql, object? parameters = null)
        {
            using var command = connection.CreateCommand();
            command.CommandText = sql;

            if (parameters != null)
            {
                var props = parameters.GetType().GetProperties();
                foreach (var prop in props)
                {
                    var dbParameter = command.CreateParameter();
                    dbParameter.ParameterName = GetParameterName(prop.Name);
                    dbParameter.Value = prop.GetValue(parameters) ?? DBNull.Value;
                    command.Parameters.Add(dbParameter);
                }
            }

            object? result;
            if (connection.State != ConnectionState.Open)
            {
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                    result = await ((SqlCommand)command).ExecuteScalarAsync();
                }
                else if (connection is OracleConnection oracleConnection)
                {
                    await oracleConnection.OpenAsync();
                    result = await ((OracleCommand)command).ExecuteScalarAsync();
                }
                else
                {
                    connection.Open();
                    result = command.ExecuteScalar();
                }
            }
            else
            {
                if (command is SqlCommand sqlCommand)
                {
                    result = await sqlCommand.ExecuteScalarAsync();
                }
                else if (command is OracleCommand oracleCommand)
                {
                    result = await oracleCommand.ExecuteScalarAsync();
                }
                else
                {
                    result = command.ExecuteScalar();
                }
            }

            if (result == null || result == DBNull.Value)
                return default(T);

            return (T)Convert.ChangeType(result, typeof(T));
        }

        /// <summary>
        /// 执行标量查询并返回单个值（带事务参数的泛型版本）
        /// </summary>
        /// <typeparam name="T">返回值类型</typeparam>
        /// <param name="connection">数据库连接</param>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数对象</param>
        /// <param name="transaction">事务</param>
        /// <returns>查询结果</returns>
        public async Task<T?> ExecuteScalarAsync<T>(IDbConnection connection, string sql, object? parameters, IDbTransaction? transaction)
        {
            using var command = connection.CreateCommand();
            command.CommandText = sql;
            command.Transaction = transaction;

            if (parameters != null)
            {
                var props = parameters.GetType().GetProperties();
                foreach (var prop in props)
                {
                    var dbParameter = command.CreateParameter();
                    dbParameter.ParameterName = GetParameterName(prop.Name);
                    dbParameter.Value = prop.GetValue(parameters) ?? DBNull.Value;
                    command.Parameters.Add(dbParameter);
                }
            }

            object? result;
            if (connection.State != ConnectionState.Open)
            {
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                    result = await ((SqlCommand)command).ExecuteScalarAsync();
                }
                else if (connection is OracleConnection oracleConnection)
                {
                    await oracleConnection.OpenAsync();
                    result = await ((OracleCommand)command).ExecuteScalarAsync();
                }
                else
                {
                    connection.Open();
                    result = command.ExecuteScalar();
                }
            }
            else
            {
                if (command is SqlCommand sqlCommand)
                {
                    result = await sqlCommand.ExecuteScalarAsync();
                }
                else if (command is OracleCommand oracleCommand)
                {
                    result = await oracleCommand.ExecuteScalarAsync();
                }
                else
                {
                    result = command.ExecuteScalar();
                }
            }

            if (result == null || result == DBNull.Value)
                return default(T);

            return (T)Convert.ChangeType(result, typeof(T));
        }

        /// <summary>
        /// 执行SQL语句（ExecuteAsync的别名）
        /// </summary>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>受影响的行数</returns>
        public async Task<int> ExecuteAsync(string sql, Dictionary<string, object>? parameters = null)
        {
            return await ExecuteNonQueryAsync(sql, parameters);
        }

        /// <summary>
        /// 执行SQL语句（带连接参数的重载）
        /// </summary>
        /// <param name="connection">数据库连接</param>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数对象</param>
        /// <returns>受影响的行数</returns>
        public async Task<int> ExecuteAsync(IDbConnection connection, string sql, object? parameters = null)
        {
            using var command = connection.CreateCommand();
            command.CommandText = sql;

            if (parameters != null)
            {
                var props = parameters.GetType().GetProperties();
                foreach (var prop in props)
                {
                    var dbParameter = command.CreateParameter();
                    dbParameter.ParameterName = GetParameterName(prop.Name);
                    dbParameter.Value = prop.GetValue(parameters) ?? DBNull.Value;
                    command.Parameters.Add(dbParameter);
                }
            }

            if (connection.State != ConnectionState.Open)
            {
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                    return await ((SqlCommand)command).ExecuteNonQueryAsync();
                }
                else if (connection is OracleConnection oracleConnection)
                {
                    await oracleConnection.OpenAsync();
                    return await ((OracleCommand)command).ExecuteNonQueryAsync();
                }
                else
                {
                    connection.Open();
                    return command.ExecuteNonQuery();
                }
            }
            else
            {
                if (command is SqlCommand sqlCommand)
                {
                    return await sqlCommand.ExecuteNonQueryAsync();
                }
                else if (command is OracleCommand oracleCommand)
                {
                    return await oracleCommand.ExecuteNonQueryAsync();
                }
                else
                {
                    return command.ExecuteNonQuery();
                }
            }
        }

        /// <summary>
        /// 执行SQL语句（带事务参数的重载）
        /// </summary>
        /// <param name="connection">数据库连接</param>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数对象</param>
        /// <param name="transaction">事务</param>
        /// <returns>受影响的行数</returns>
        public async Task<int> ExecuteAsync(IDbConnection connection, string sql, object? parameters, IDbTransaction? transaction)
        {
            using var command = connection.CreateCommand();
            command.CommandText = sql;
            command.Transaction = transaction;

            if (parameters != null)
            {
                var props = parameters.GetType().GetProperties();
                foreach (var prop in props)
                {
                    var dbParameter = command.CreateParameter();
                    dbParameter.ParameterName = GetParameterName(prop.Name);
                    dbParameter.Value = prop.GetValue(parameters) ?? DBNull.Value;
                    command.Parameters.Add(dbParameter);
                }
            }

            if (connection.State != ConnectionState.Open)
            {
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                    return await ((SqlCommand)command).ExecuteNonQueryAsync();
                }
                else if (connection is OracleConnection oracleConnection)
                {
                    await oracleConnection.OpenAsync();
                    return await ((OracleCommand)command).ExecuteNonQueryAsync();
                }
                else
                {
                    connection.Open();
                    return command.ExecuteNonQuery();
                }
            }
            else
            {
                if (command is SqlCommand sqlCommand)
                {
                    return await sqlCommand.ExecuteNonQueryAsync();
                }
                else if (command is OracleCommand oracleCommand)
                {
                    return await oracleCommand.ExecuteNonQueryAsync();
                }
                else
                {
                    return command.ExecuteNonQuery();
                }
            }
        }

        /// <summary>
        /// 执行查询并返回结果集（QueryAsync的别名）
        /// </summary>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>查询结果</returns>
        public async Task<DataTable> QueryAsync(string sql, Dictionary<string, object>? parameters = null)
        {
            return await ExecuteQueryAsync(sql, parameters);
        }

        /// <summary>
        /// 执行查询并返回结果集（泛型版本）
        /// </summary>
        /// <typeparam name="T">返回值类型</typeparam>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数</param>
        /// <returns>查询结果</returns>
        public async Task<DataTable> QueryAsync<T>(string sql, Dictionary<string, object>? parameters = null)
        {
            return await ExecuteQueryAsync(sql, parameters);
        }

        /// <summary>
        /// 执行查询并返回结果集（带连接参数的泛型版本）
        /// </summary>
        /// <typeparam name="T">返回值类型</typeparam>
        /// <param name="connection">数据库连接</param>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数对象</param>
        /// <returns>查询结果</returns>
        public async Task<DataTable> QueryAsync<T>(IDbConnection connection, string sql, object? parameters = null)
        {
            using var command = connection.CreateCommand();
            command.CommandText = sql;

            if (parameters != null)
            {
                var props = parameters.GetType().GetProperties();
                foreach (var prop in props)
                {
                    var dbParameter = command.CreateParameter();
                    dbParameter.ParameterName = GetParameterName(prop.Name);
                    dbParameter.Value = prop.GetValue(parameters) ?? DBNull.Value;
                    command.Parameters.Add(dbParameter);
                }
            }

            if (connection.State != ConnectionState.Open)
            {
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                    using var reader = await ((SqlCommand)command).ExecuteReaderAsync();
                    var dataTable = new DataTable();
                    dataTable.Load(reader);
                    return dataTable;
                }
                else if (connection is OracleConnection oracleConnection)
                {
                    await oracleConnection.OpenAsync();
                    using var reader = await ((OracleCommand)command).ExecuteReaderAsync();
                    var dataTable = new DataTable();
                    dataTable.Load(reader);
                    return dataTable;
                }
                else
                {
                    connection.Open();
                    using var reader = command.ExecuteReader();
                    var dataTable = new DataTable();
                    dataTable.Load(reader);
                    return dataTable;
                }
            }
            else
            {
                if (command is SqlCommand sqlCommand)
                {
                    using var reader = await sqlCommand.ExecuteReaderAsync();
                    var dataTable = new DataTable();
                    dataTable.Load(reader);
                    return dataTable;
                }
                else if (command is OracleCommand oracleCommand)
                {
                    using var reader = await oracleCommand.ExecuteReaderAsync();
                    var dataTable = new DataTable();
                    dataTable.Load(reader);
                    return dataTable;
                }
                else
                {
                    using var reader = command.ExecuteReader();
                    var dataTable = new DataTable();
                    dataTable.Load(reader);
                    return dataTable;
                }
            }
        }

        /// <summary>
        /// 获取参数名称（根据数据库类型调整格式）
        /// </summary>
        /// <param name="parameterName">参数名称</param>
        /// <returns>格式化后的参数名称</returns>
        private string GetParameterName(string parameterName)
        {
            var provider = _connectionFactory.GetDatabaseProvider().ToLower();

            return provider switch
            {
                "oracle" => $":{parameterName}",
                "sqlserver" or _ => $"@{parameterName}"
            };
        }

        /// <summary>
        /// 在指定连接和事务上执行查询并返回DataTable
        /// </summary>
        /// <param name="connection">数据库连接</param>
        /// <param name="sql">SQL语句</param>
        /// <param name="parameters">参数</param>
        /// <param name="transaction">事务</param>
        /// <returns>查询结果</returns>
        public async Task<DataTable> QueryWithTransactionAsync<T>(IDbConnection connection, string sql, object? parameters = null, IDbTransaction? transaction = null)
        {
            using var command = connection.CreateCommand();
            command.CommandText = sql;
            command.Transaction = transaction;

            if (parameters != null)
            {
                var props = parameters.GetType().GetProperties();
                foreach (var prop in props)
                {
                    var dbParameter = command.CreateParameter();
                    dbParameter.ParameterName = GetParameterName(prop.Name);
                    dbParameter.Value = prop.GetValue(parameters) ?? DBNull.Value;
                    command.Parameters.Add(dbParameter);
                }
            }

            if (command is SqlCommand sqlCommand)
            {
                using var reader = await sqlCommand.ExecuteReaderAsync();
                var dataTable = new DataTable();
                dataTable.Load(reader);
                return dataTable;
            }
            else if (command is OracleCommand oracleCommand)
            {
                using var reader = await oracleCommand.ExecuteReaderAsync();
                var dataTable = new DataTable();
                dataTable.Load(reader);
                return dataTable;
            }
            else
            {
                using var reader = command.ExecuteReader();
                var dataTable = new DataTable();
                dataTable.Load(reader);
                return dataTable;
            }
        }

        /// <summary>
        /// 添加参数到DbCommand
        /// </summary>
        /// <param name="command">DbCommand对象</param>
        /// <param name="name">参数名称</param>
        /// <param name="value">参数值</param>
        public void AddParameter(IDbCommand command, string name, object value)
        {
            var parameter = command.CreateParameter();
            parameter.ParameterName = GetParameterName(name);
            parameter.Value = value ?? DBNull.Value;
            command.Parameters.Add(parameter);
        }
    }
}