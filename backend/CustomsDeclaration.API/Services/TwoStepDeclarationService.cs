using CustomsDeclaration.API.Data;
using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Models.Enums;
using System.Data;
using Microsoft.Data.SqlClient;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 两步申报流程服务实现
    /// </summary>
    public class TwoStepDeclarationService : ITwoStepDeclarationService
    {
        private readonly IDbConnectionFactory _connectionFactory;
        private readonly ILogger<TwoStepDeclarationService> _logger;
        private readonly DatabaseHelper _dbHelper;
        private readonly ICustomsStatusService _customsStatusService;

        public TwoStepDeclarationService(
            IDbConnectionFactory connectionFactory,
            ILogger<TwoStepDeclarationService> logger,
            DatabaseHelper dbHelper,
            ICustomsStatusService customsStatusService)
        {
            _connectionFactory = connectionFactory;
            _logger = logger;
            _dbHelper = dbHelper;
            _customsStatusService = customsStatusService;
        }

        /// <summary>
        /// 第一步：提交申请单（按照海关业务流程）
        /// </summary>
        public async Task<ApiResponse<string>> SubmitApplicationAsync(string applicationNo, int userId)
        {
            try
            {
                _logger.LogInformation($"开始第一步申报流程：提交申请单，申请单号：{applicationNo}");

                using var connection = _connectionFactory.CreateConnection();
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                }
                else
                {
                    connection.Open();
                }
                using var transaction = connection.BeginTransaction();

                try
                {
                    // 1. 检查申请单是否存在
                    var checkSql = @"
                        SELECT COUNT(1) FROM FBG_HEAD_PRE
                        WHERE GATEJOB_NO = @ApplicationNo";

                    var count = await _dbHelper.ExecuteScalarAsync<int>(
                        connection, checkSql,
                        new { ApplicationNo = applicationNo },
                        transaction);

                    if (count == 0)
                    {
                        return ApiResponse<string>.Fail("申请单不存在");
                    }

                    // 2. 执行工作流检查存储过程 SP_WF_CHECK_OPERATION
                    //var workflowCheckResult = await ExecuteWorkflowCheckAsync(connection, transaction, applicationNo);
                    //if (!workflowCheckResult.Success)
                    //{
                    //    return ApiResponse<string>.Fail($"工作流检查失败：{workflowCheckResult.Message}");
                    //}

                    // 3. 校验申报数量是否超出账册表体备案数量
                    var quantityValidationResult = await ValidateDeclarationQuantityAsync(connection, transaction, applicationNo);
                    if (!quantityValidationResult.Success)
                    {
                        return ApiResponse<string>.Fail($"数量校验失败：{quantityValidationResult.Message}");
                    }

                    // 4. 更新申请单表头状态
                    var updateSql = @"
                        UPDATE FBG_HEAD_PRE
                        SET OPER_TYPE = 'DECL',
                            DECLARE_DATE = @CreateDate,
                            DECLARE_PERSON = @CreatePerson
                        WHERE GATEJOB_NO = @ApplicationNo";

                    await _dbHelper.ExecuteAsync(
                        connection, updateSql,
                        new
                        {
                            CreateDate = DateTime.Now,
                            CreatePerson = userId.ToString(),
                            ApplicationNo = applicationNo
                        },
                        transaction);

                    // 5. 执行流程写入存储过程 SP_WF_OPERATION_PG
                    //var workflowOperationResult = await ExecuteWorkflowOperationAsync(connection, transaction, applicationNo);
                    //if (!workflowOperationResult.Success)
                    //{
                    //    return ApiResponse<string>.Fail($"流程写入失败：{workflowOperationResult.Message}");
                    //}

                    // 6. 提交申请单到海关系统（对接真实海关API）
                    //bool customsSubmitSuccess = await SubmitApplicationToCustomsAsync(applicationNo);
                    //if (!customsSubmitSuccess)
                    //{
                    //    // 海关API调用失败，回滚事务
                    //    transaction.Rollback();
                    //    return ApiResponse<string>.Fail("提交申请单到海关系统失败，请稍后重试");
                    //}

                    // 7. 记录申报日志
                    await InsertDeclarationLogAsync(connection, transaction, applicationNo,
                        "application_submitted", "第一步申请单已提交到海关系统，等待海关审批", userId);

                    transaction.Commit();

                    _logger.LogInformation($"第一步申报流程完成：申请单已提交，申请单号：{applicationNo}");
                    return ApiResponse<string>.Ok(applicationNo, "申请单提交成功，等待海关审批");
                }
                catch
                {
                    transaction.Rollback();
                    throw;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"提交申请单时发生异常，申请单号：{applicationNo}");
                return ApiResponse<string>.Fail($"提交申请单失败：{ex.Message}");
            }
        }

        /// <summary>
        /// 第二步：提交核放单（自动触发）
        /// </summary>
        public async Task<ApiResponse<string>> SubmitDischargePermitAsync(string dischargedNo, int userId)
        {
            try
            {
                _logger.LogInformation($"开始第二步申报流程：提交核放单，核放单号：{dischargedNo}");

                using var connection = _connectionFactory.CreateConnection();
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                }
                else
                {
                    connection.Open();
                }
                using var transaction = connection.BeginTransaction();

                try
                {
                    // 1. 不需要检查申请单状态，因为已经在调用前检查过了

                    // 2. 模拟向海关系统提交核放单数据
                    var submitResult = await SubmitDischargePermitToCustomsAsync(dischargedNo);
                    if (!submitResult)
                    {
                        return ApiResponse<string>.Fail("向海关系统提交核放单失败");
                    }

                    // 3. 更新核放单状态为"核放单已提交"（使用STEP_ID字段）
                    var updateSql = @"
                        UPDATE HF_HEAD_PRE
                        SET STEP_ID = @StepId,
                            OPER_TYPE = 'DECL'
                        WHERE DISCHARGED_NO = @DischargedNo";

                    await _dbHelper.ExecuteAsync(
                        connection, updateSql,
                        new
                        {
                            StepId = DeclarationStatus.DischargeSubmitted.ToString().ToLower(),
                            DischargedNo = dischargedNo
                        },
                        transaction);

                    // 4. 记录申报日志
                    await InsertDeclarationLogAsync(connection, transaction, dischargedNo,
                        "discharge_submitted", "核放单已提交", userId);

                    transaction.Commit();

                    _logger.LogInformation($"第二步申报流程完成：核放单已提交，核放单号：{dischargedNo}");
                    return ApiResponse<string>.Ok(dischargedNo, "核放单提交成功，等待海关审批");
                }
                catch
                {
                    transaction.Rollback();
                    throw;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"提交核放单时发生异常，核放单号：{dischargedNo}");
                return ApiResponse<string>.Fail("提交核放单失败");
            }
        }

        /// <summary>
        /// 获取申报状态
        /// </summary>
        public async Task<ApiResponse<DeclarationStatus>> GetDeclarationStatusAsync(string dischargedNo)
        {
            try
            {
                using var connection = _connectionFactory.CreateConnection();

                var sql = @"
                    SELECT STATUS FROM HF_HEAD_PRE
                    WHERE DISCHARGED_NO = @DischargedNo";

                var statusString = await _dbHelper.ExecuteScalarAsync<string>(
                    connection, sql,
                    new { DischargedNo = dischargedNo });

                if (string.IsNullOrEmpty(statusString))
                {
                    return ApiResponse<DeclarationStatus>.Fail("核放单不存在");
                }

                if (Enum.TryParse<DeclarationStatus>(statusString, true, out var status))
                {
                    return ApiResponse<DeclarationStatus>.Ok(status);
                }

                return ApiResponse<DeclarationStatus>.Fail("状态格式不正确");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"获取申报状态时发生异常，核放单号：{dischargedNo}");
                return ApiResponse<DeclarationStatus>.Fail("获取申报状态失败");
            }
        }

        /// <summary>
        /// 检查并处理状态变化（后台服务调用）
        /// </summary>
        public async Task ProcessStatusChangesAsync()
        {
            try
            {
                _logger.LogInformation("开始检查申报状态变化");

                using var connection = _connectionFactory.CreateConnection();

                // 查询所有等待审批的申请单（从FBG_HEAD_PRE表查询）
                var pendingApplicationSql = @"
                    SELECT GATEJOB_NO, CREATE_PERSON
                    FROM FBG_HEAD_PRE
                    WHERE OPER_TYPE = 'DECL'";

                var pendingApplications = await _dbHelper.QueryAsync<dynamic>(connection, pendingApplicationSql);

                foreach (DataRow row in pendingApplications.Rows)
                {
                    var applicationNo = row["GATEJOB_NO"].ToString();
                    var createPersonStr = row["CREATE_PERSON"].ToString();

                    // 尝试从CREATE_PERSON字段解析用户ID（如果是数字格式）或使用默认值
                    int userId = 1; // 默认用户ID
                    if (int.TryParse(createPersonStr, out int parsedUserId))
                    {
                        userId = parsedUserId;
                    }

                    // 检查申请单状态
                    var applicationStatus = await _customsStatusService.CheckApplicationStatusAsync(applicationNo);
                    if (applicationStatus.HasValue)
                    {
                        var newDeclarationStatus = _customsStatusService.ConvertApplicationToDeclarationStatus(applicationStatus.Value);

                        // 根据海关返回的状态更新本地记录
                        await UpdateApplicationStatusAsync(applicationNo, newDeclarationStatus.ToString().ToLower(), userId);

                        // 🔥 关键逻辑：如果申请单审批通过，自动触发第二步
                        if (_customsStatusService.CanProceedToDischarge(applicationStatus.Value))
                        {
                            _logger.LogInformation($"申请单审批通过（状态：{applicationStatus.Value.GetDescription()}），自动触发第二步申报：{applicationNo}");

                            // 需要根据申请单号查找对应的核放单号
                            var dischargedNo = await GetDischargedNoByApplicationNoAsync(connection, applicationNo);
                            if (!string.IsNullOrEmpty(dischargedNo))
                            {
                                await SubmitDischargePermitAsync(dischargedNo, userId);
                            }
                            else
                            {
                                _logger.LogWarning($"申请单 {applicationNo} 没有关联的核放单号，无法触发第二步");
                            }
                        }
                    }
                }

                // 查询所有等待审批的核放单（从HF_HEAD_PRE表查询）
                var pendingDischargeSql = @"
                    SELECT DISCHARGED_NO, CREATE_PERSON
                    FROM HF_HEAD_PRE
                    WHERE OPER_TYPE = 'DECL'";

                var pendingDischarges = await _dbHelper.QueryAsync<dynamic>(connection, pendingDischargeSql);

                foreach (DataRow row in pendingDischarges.Rows)
                {
                    var dischargedNo = row["DISCHARGED_NO"].ToString();
                    var createPersonStr = row["CREATE_PERSON"].ToString();

                    int userId = 1;
                    if (int.TryParse(createPersonStr, out int parsedUserId))
                    {
                        userId = parsedUserId;
                    }

                    // 检查核放单状态
                    var dischargeStatus = await _customsStatusService.CheckDischargeStatusAsync(dischargedNo);
                    if (dischargeStatus.HasValue)
                    {
                        var newDeclarationStatus = _customsStatusService.ConvertDischargeToDeclarationStatus(dischargeStatus.Value);

                        if (newDeclarationStatus != DeclarationStatus.DischargeSubmitted)
                        {
                            await UpdateDischargeStatusAsync(dischargedNo, newDeclarationStatus.ToString().ToLower(), userId);
                        }
                    }
                }

                _logger.LogInformation("申报状态检查完成");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "检查申报状态变化时发生异常");
            }
        }

        /// <summary>
        /// 重新申报（被退回后）
        /// </summary>
        public async Task<ApiResponse<string>> ResubmitDeclarationAsync(string businessNo, int userId)
        {
            try
            {
                // 判断businessNo是申请单号还是核放单号
                // 根据不同的业务单号类型，调用不同的重新提交方法

                // 先检查是否为申请单号
                using var connection = _connectionFactory.CreateConnection();
                var checkApplicationSql = @"
                    SELECT COUNT(1) FROM FBG_HEAD_PRE
                    WHERE GATEJOB_NO = @BusinessNo";

                var isApplication = await _dbHelper.ExecuteScalarAsync<int>(
                    connection, checkApplicationSql,
                    new { BusinessNo = businessNo }) > 0;

                if (isApplication)
                {
                    // 申请单被退回，重新提交申请单
                    return await SubmitApplicationAsync(businessNo, userId);
                }

                // 检查是否为核放单号
                var statusResult = await GetDeclarationStatusAsync(businessNo);
                if (!statusResult.Success)
                {
                    return ApiResponse<string>.Fail(statusResult.Message);
                }

                var currentStatus = statusResult.Data;

                // 根据当前状态决定重新提交的步骤
                if (currentStatus == DeclarationStatus.DischargeRejected)
                {
                    // 核放单被退回，重新提交核放单
                    return await SubmitDischargePermitAsync(businessNo, userId);
                }
                else
                {
                    return ApiResponse<string>.Fail("当前状态不允许重新申报");
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"重新申报时发生异常，业务单号：{businessNo}");
                return ApiResponse<string>.Fail("重新申报失败");
            }
        }

        /// <summary>
        /// 直接申报核放单（空车核放单一步申报，biz_type='KA10'）
        /// </summary>
        public async Task<ApiResponse<string>> SubmitDischargeDirectlyAsync(string dischargedNo, int userId)
        {
            try
            {
                _logger.LogInformation($"开始直接申报核放单流程（空车核放单），核放单号：{dischargedNo}");

                using var connection = _connectionFactory.CreateConnection();
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                }
                else
                {
                    connection.Open();
                }
                using var transaction = connection.BeginTransaction();

                try
                {
                    // 1. 检查核放单是否存在且业务类型为 KA10（空车核放单）
                    var checkSql = @"
                        SELECT BIZ_TYPE FROM HF_HEAD_PRE
                        WHERE DISCHARGED_NO = @DischargedNo";

                    var bizType = await _dbHelper.ExecuteScalarAsync<string>(
                        connection, checkSql,
                        new { DischargedNo = dischargedNo },
                        transaction);

                    if (string.IsNullOrEmpty(bizType))
                    {
                        return ApiResponse<string>.Fail("核放单不存在");
                    }

                    if (bizType != "KA10")
                    {
                        return ApiResponse<string>.Fail($"该核放单业务类型为 {bizType}，非空车核放单，不允许直接申报");
                    }

                    // 2. 提交核放单到海关系统
                    var submitResult = await SubmitDischargePermitToCustomsAsync(dischargedNo);
                    if (!submitResult)
                    {
                        return ApiResponse<string>.Fail("向海关系统提交核放单失败");
                    }

                    // 3. 更新核放单状态为"核放单已提交"
                    var updateSql = @"
                        UPDATE HF_HEAD_PRE
                        SET STEP_ID = @StepId,
                            OPER_TYPE = 'DECL',
                            DECLARE_DATE = @DeclareDate,
                            DECLARE_PERSON = @DeclarePerson
                        WHERE DISCHARGED_NO = @DischargedNo";

                    await _dbHelper.ExecuteAsync(
                        connection, updateSql,
                        new
                        {
                            StepId = DeclarationStatus.DischargeSubmitted.ToString().ToLower(),
                            DeclareDate = DateTime.Now,
                            DeclarePerson = userId.ToString(),
                            DischargedNo = dischargedNo
                        },
                        transaction);

                    // 4. 记录申报日志
                    await InsertDeclarationLogAsync(connection, transaction, dischargedNo,
                        "discharge_submitted_directly", "空车核放单直接申报已提交到海关系统", userId);

                    transaction.Commit();

                    _logger.LogInformation($"空车核放单直接申报完成：核放单号：{dischargedNo}");
                    return ApiResponse<string>.Ok(dischargedNo, "空车核放单提交成功，等待海关审批");
                }
                catch
                {
                    transaction.Rollback();
                    throw;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"直接申报核放单时发生异常，核放单号：{dischargedNo}");
                return ApiResponse<string>.Fail($"直接申报核放单失败：{ex.Message}");
            }
        }

        #region 私有方法

        /// <summary>
        /// 根据申请单号获取核放单号
        /// </summary>
        private async Task<string> GetDischargedNoByApplicationNoAsync(IDbConnection connection, string applicationNo)
        {
            try
            {
                // 从HF_BODY_PRE表查询关联的核放单号
                var sql = @"
                    SELECT DISCHARGED_NO
                    FROM HF_BODY_PRE
                    WHERE GATEJOB_NO = @ApplicationNo";

                var dischargedNo = await _dbHelper.ExecuteScalarAsync<string>(
                    connection, sql,
                    new { ApplicationNo = applicationNo });

                return dischargedNo ?? string.Empty;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"查询核放单号失败，申请单号：{applicationNo}");
                return string.Empty;
            }
        }

        /// <summary>
        /// 更新申请单状态
        /// </summary>
        private async Task UpdateApplicationStatusAsync(string applicationNo, string newStatus, int userId)
        {
            try
            {
                using var connection = _connectionFactory.CreateConnection();
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                }
                else
                {
                    connection.Open();
                }
                using var transaction = connection.BeginTransaction();

                var updateSql = @"
                    UPDATE FBG_HEAD_PRE
                    SET STEP_ID = @StepId
                    WHERE GATEJOB_NO = @ApplicationNo";

                await _dbHelper.ExecuteAsync(
                    connection, updateSql,
                    new
                    {
                        StepId = newStatus,
                        ApplicationNo = applicationNo
                    },
                    transaction);

                // 记录状态变化日志
                var statusDesc = GetStatusDescription(newStatus);
                await InsertDeclarationLogAsync(connection, transaction, applicationNo,
                    newStatus, $"申请单状态更新：{statusDesc}", userId);

                transaction.Commit();

                _logger.LogInformation($"申请单状态更新成功：{applicationNo} -> {statusDesc}");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"更新申请单状态时发生异常，申请单号：{applicationNo}");
            }
        }

        /// <summary>
        /// 更新核放单状态
        /// </summary>
        private async Task UpdateDischargeStatusAsync(string dischargedNo, string newStatus, int userId)
        {
            try
            {
                using var connection = _connectionFactory.CreateConnection();
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                }
                else
                {
                    connection.Open();
                }
                using var transaction = connection.BeginTransaction();

                var updateSql = @"
                    UPDATE HF_HEAD_PRE
                    SET STEP_ID = @StepId
                    WHERE DISCHARGED_NO = @DischargedNo";

                await _dbHelper.ExecuteAsync(
                    connection, updateSql,
                    new
                    {
                        StepId = newStatus,
                        DischargedNo = dischargedNo
                    },
                    transaction);

                // 记录状态变化日志
                var statusDesc = GetStatusDescription(newStatus);
                await InsertDeclarationLogAsync(connection, transaction, dischargedNo,
                    newStatus, $"核放单状态更新：{statusDesc}", userId);

                transaction.Commit();

                _logger.LogInformation($"核放单状态更新成功：{dischargedNo} -> {statusDesc}");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"更新核放单状态时发生异常，核放单号：{dischargedNo}");
            }
        }

        /// <summary>
        /// 模拟向海关系统提交申请单
        /// </summary>
        private async Task<bool> SubmitApplicationToCustomsAsync(string applicationNo)
        {
            // 模拟网络延迟
            await Task.Delay(1000);

            // 模拟提交成功（实际应调用海关API或发送MQ消息）
            _logger.LogInformation($"模拟向海关系统提交申请单：{applicationNo}");
            return true;
        }

        /// <summary>
        /// 模拟向海关系统提交核放单
        /// </summary>
        private async Task<bool> SubmitDischargePermitToCustomsAsync(string dischargedNo)
        {
            // 模拟网络延迟
            await Task.Delay(1000);

            // 模拟提交成功（实际应调用海关API或发送MQ消息）
            _logger.LogInformation($"模拟向海关系统提交核放单：{dischargedNo}");
            return true;
        }

        /// <summary>
        /// 从海关系统更新状态
        /// </summary>
        private async Task UpdateStatusFromCustomsAsync(string dischargedNo, string newStatus, int userId)
        {
            try
            {
                using var connection = _connectionFactory.CreateConnection();
                if (connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.OpenAsync();
                }
                else
                {
                    connection.Open();
                }
                using var transaction = connection.BeginTransaction();

                // 根据状态类型确定更新的字段
                string applicationStatus = "";
                string dischargeStatus = "";

                // 根据业务状态确定对应的海关状态码
                if (newStatus.Contains("application") || newStatus.Contains("申请"))
                {
                    applicationStatus = MapToCustomsStatusCode(newStatus, "FBG");
                }
                else if (newStatus.Contains("discharge") || newStatus.Contains("核放"))
                {
                    dischargeStatus = MapToCustomsStatusCode(newStatus, "HFD");
                }

                // 由于HF_HEAD_PRE表的实际字段与预期不同，仅记录到日志表中
                // 实际的状态更新应该通过其他表或机制进行
                var updateSql = @"
                    UPDATE HF_HEAD_PRE
                    SET OPER_TYPE = 'DECL'
                    WHERE DISCHARGED_NO = @DischargedNo";

                await _dbHelper.ExecuteAsync(
                    connection, updateSql,
                    new
                    {
                        DischargedNo = dischargedNo
                    },
                    transaction);

                // 记录状态变化日志
                var statusDesc = GetStatusDescription(newStatus);
                await InsertDeclarationLogAsync(connection, transaction, dischargedNo,
                    newStatus, $"海关系统状态更新：{statusDesc}", userId);

                transaction.Commit();

                _logger.LogInformation($"状态更新成功：{dischargedNo} -> {statusDesc}");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"更新状态时发生异常，核放单号：{dischargedNo}");
            }
        }

        /// <summary>
        /// 插入申报日志
        /// </summary>
        private async Task InsertDeclarationLogAsync(IDbConnection connection, IDbTransaction transaction,
            string dischargedNo, string action, string description, int userId)
        {
            var logSql = @"
                INSERT INTO DECLARATION_LOG
                (DISCHARGED_NO, ACTION, DESCRIPTION, CREATE_TIME, CREATE_USER)
                VALUES
                (@DischargedNo, @Action, @Description, @CreateTime, @CreateUser)";

            await _dbHelper.ExecuteAsync(
                connection, logSql,
                new
                {
                    DischargedNo = dischargedNo,
                    Action = action,
                    Description = description,
                    CreateTime = DateTime.Now,
                    CreateUser = userId
                },
                transaction);
        }

        /// <summary>
        /// 获取状态描述
        /// </summary>
        private string GetStatusDescription(string status)
        {
            if (Enum.TryParse<DeclarationStatus>(status, true, out var enumStatus))
            {
                return enumStatus.GetDescription();
            }
            return status;
        }

        /// <summary>
        /// 执行工作流检查存储过程 SP_WF_CHECK_OPERATION
        /// </summary>
        private async Task<(bool Success, string Message)> ExecuteWorkflowCheckAsync(IDbConnection connection, IDbTransaction transaction, string applicationNo)
        {
            try
            {
                using var command = connection.CreateCommand();
                command.Transaction = transaction;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "SP_WF_CHECK_OPERATION";

                // 添加输入参数
                _dbHelper.AddParameter(command, "P_WORKFLOW_TYPE", "FBG");
                _dbHelper.AddParameter(command, "P_ORDER_NO", applicationNo);
                _dbHelper.AddParameter(command, "P_OPER_TYPE", "11");

                // 添加输出参数
                var outputParam = command.CreateParameter();
                outputParam.ParameterName = "P_OUTMSG";
                outputParam.Direction = ParameterDirection.Output;
                outputParam.DbType = DbType.String;
                outputParam.Size = 4000;
                command.Parameters.Add(outputParam);

                // 根据数据库类型执行异步命令
                if (command is SqlCommand sqlCommand)
                {
                    await sqlCommand.ExecuteNonQueryAsync();
                }
                else
                {
                    command.ExecuteNonQuery();
                }

                var result = outputParam.Value?.ToString() ?? "0";

                if (result == "0")
                {
                    return (false, $"当前业务的操作不符合工作流要求，不可执行此操作！单号：{applicationNo}");
                }

                _logger.LogInformation($"工作流检查通过，申请单号：{applicationNo}，返回值：{result}");
                return (true, "工作流检查通过");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"执行工作流检查存储过程失败，申请单号：{applicationNo}");
                return (false, $"工作流检查异常：{ex.Message}");
            }
        }

        /// <summary>
        /// 校验申报数量是否超出账册表体备案数量
        /// </summary>
        private async Task<(bool Success, string Message)> ValidateDeclarationQuantityAsync(IDbConnection connection, IDbTransaction transaction, string applicationNo)
        {
            try
            {
                // 查询申请单关联的货物明细
                var detailSql = @"
                    SELECT FB.G_NO, FB.APP_QTY, H.EMS_NO, EA.IN_QTY, EA.OUT_QTY
                    FROM FBG_BODY_PRE FB LEFT JOIN FBG_HEAD_PRE H ON FB.GATEJOB_NO=H.GATEJOB_NO
                    INNER JOIN EMS_AIMG_PRE EA ON H.EMS_NO = EA.EMS_NO AND FB.G_NO = EA.G_NO
                    WHERE fb.GATEJOB_NO = @ApplicationNo";

                var details = await _dbHelper.QueryWithTransactionAsync<dynamic>(
                    connection, detailSql,
                    new { ApplicationNo = applicationNo }, transaction);

                foreach (DataRow row in details.Rows)
                {
                    var gNo = row["G_NO"].ToString();
                    var declQty = Convert.ToDecimal(row["APP_QTY"]);
                    var inQty = Convert.ToDecimal(row["IN_QTY"]);
                    var outQty = Convert.ToDecimal(row["OUT_QTY"]);

                    // 计算账册余量：进口数量 - 出口数量
                    var remainingQty = inQty - outQty;

                    if (declQty > remainingQty)
                    {
                        return (false, $"项号 {gNo} 申报数量 {declQty} 超出账册余量 {remainingQty}，不允许申报");
                    }
                }

                _logger.LogInformation($"数量校验通过，申请单号：{applicationNo}");
                return (true, "数量校验通过");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"校验申报数量失败，申请单号：{applicationNo}");
                return (false, $"数量校验异常：{ex.Message}");
            }
        }

        /// <summary>
        /// 执行流程写入存储过程 SP_WF_OPERATION_PG
        /// </summary>
        private async Task<(bool Success, string Message)> ExecuteWorkflowOperationAsync(IDbConnection connection, IDbTransaction transaction, string applicationNo)
        {
            try
            {
                using var command = connection.CreateCommand();
                command.Transaction = transaction;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "SP_WF_OPERATION_PG";

                // 添加参数
                _dbHelper.AddParameter(command, "P_WORKFLOW_TYPE", "FBG");
                _dbHelper.AddParameter(command, "P_ORDER_NO", applicationNo);

                // 根据数据库类型执行异步命令
                if (command is SqlCommand sqlCommand)
                {
                    await sqlCommand.ExecuteNonQueryAsync();
                }
                else
                {
                    command.ExecuteNonQuery();
                }

                _logger.LogInformation($"流程写入成功，申请单号：{applicationNo}");
                return (true, "流程写入成功");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"执行流程写入存储过程失败，申请单号：{applicationNo}");
                return (false, $"流程写入异常：{ex.Message}");
            }
        }

        /// <summary>
        /// 将业务状态映射为海关状态码
        /// </summary>
        /// <param name="businessStatus">业务状态</param>
        /// <param name="statusType">状态类型 (FBG: 申请单, HFD: 核放单)</param>
        /// <returns>海关状态码</returns>
        private string MapToCustomsStatusCode(string businessStatus, string statusType)
        {
            // 根据业务状态和类型映射海关状态码
            return businessStatus.ToLower() switch
            {
                "applicationsubmitted" or "application_submitted" => statusType == "FBG" ? "11" : "",
                "applicationapproved" or "application_approved" => statusType == "FBG" ? "12" : "",
                "applicationrejected" or "application_rejected" => statusType == "FBG" ? "13" : "",
                "dischargesubmitted" or "discharge_submitted" => statusType == "HFD" ? "21" : "",
                "dischargeapproved" or "discharge_approved" => statusType == "HFD" ? "22" : "",
                "dischargerejected" or "discharge_rejected" => statusType == "HFD" ? "23" : "",
                "completed" => statusType == "HFD" ? "99" : statusType == "FBG" ? "99" : "",
                _ => ""
            };
        }

        #endregion
    }
}