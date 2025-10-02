using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Threading.Tasks;
using CustomsDeclaration.API.Data;
using CustomsDeclaration.API.Models;
using CustomsDeclaration.API.Models.DTOs;
using Microsoft.Extensions.Logging;

namespace CustomsDeclaration.API.Services;

public class DeclarationService : IDeclarationService
{
	private readonly DatabaseHelper _databaseHelper;

	private readonly IDbConnectionFactory _connectionFactory;

	private readonly IUserService _userService;

	private readonly IVehicleService _vehicleService;

	private readonly IJobNumberService _jobNumberService;

	private readonly ILogger<DeclarationService> _logger;

	public DeclarationService(DatabaseHelper databaseHelper, IDbConnectionFactory connectionFactory, IUserService userService, IVehicleService vehicleService, IJobNumberService jobNumberService, ILogger<DeclarationService> logger)
	{
		_databaseHelper = databaseHelper;
		_connectionFactory = connectionFactory;
		_userService = userService;
		_vehicleService = vehicleService;
		_jobNumberService = jobNumberService;
		_logger = logger;
	}

	public async Task<ApiResponse<string>> SaveEmptyVehicleDeclarationAsync(Declaration declaration, int userId)
	{
		try
		{
			User user = await _userService.GetUserByIdAsync(userId);
			if (user == null)
			{
				return ApiResponse<string>.Fail("�û�������");
			}
			string dischargedNo = await _jobNumberService.GetJobNumberAsync("KA10", user.CompanyCode, user.CustomsCode);
			Dictionary<string, object> parameters = new Dictionary<string, object>
			{
				["CUSTOMS_CODE"] = user.CustomsCode,
				["DISCHARGED_NO"] = dischargedNo,
				["CAR_NO"] = declaration.CarNo,
				["CAR_WT"] = declaration.CarWeight,
				["FACT_WEIGHT"] = declaration.CarWeight,
				["START_LAND"] = declaration.StartPlace,
				["GOAL_LAND"] = declaration.Destination,
				["AREA_CODE"] = declaration.AreaMark,
				["TRADE_CODE"] = user.CompanyCode,
				["TRADE_NAME"] = user.CompanyName,
				["INPUT_CODE"] = user.CompanyCode,
				["INPUT_NAME"] = user.CompanyName,
				["STEP_ID"] = "HFD100100",
				["CREATE_PERSON"] = user.Username,
				["CREATE_DATE"] = DateTime.Now,
				["BIZ_TYPE"] = "KA10",
				["BIZ_MODE"] = "KM10",
				["OPER_TYPE"] = "SAVE"
			};
			string sql = BuildInsertSql();
			if (await _databaseHelper.ExecuteNonQueryAsync(sql, parameters) > 0)
			{
				_logger.LogInformation("�ճ��˷ŵ�����ɹ�����ţ�" + dischargedNo + "���û���" + user.Username);
				try
				{
					await _vehicleService.CreateVehicleFromDeclarationAsync(declaration.CarNo, declaration.CarWeight, user.CompanyCode, user.CompanyName);
					_logger.LogInformation("�ճ��˷ŵ��������������ɣ����ƺţ�" + declaration.CarNo);
				}
				catch (Exception ex)
				{
					Exception vehicleEx = ex;
					_logger.LogWarning(vehicleEx, "�Զ�����������Ϣʧ�ܣ����ƺţ�" + declaration.CarNo + "������Ӱ��˷ŵ�����");
				}
				return ApiResponse<string>.Ok(dischargedNo, "����ɹ�");
			}
			return ApiResponse<string>.Fail("����ʧ��");
		}
		catch (Exception ex)
		{
			Exception ex2 = ex;
			_logger.LogError(ex2, $"����ճ��˷ŵ�ʧ�ܣ��û�ID��{userId}");
			return ApiResponse<string>.Fail("����ʧ�ܣ�" + ex2.Message);
		}
	}

	public async Task<ApiResponse<string>> SaveDeclarationAsync(Declaration declaration, int userId)
	{
		try
		{
			User user = await _userService.GetUserByIdAsync(userId);
			if (user == null)
			{
				return ApiResponse<string>.Fail("�û�������");
			}
			string gateJobNo = await _jobNumberService.GetJobNumberAsync("LF", user.CompanyCode, user.CustomsCode);
			Dictionary<string, object> headParameters = new Dictionary<string, object>
			{
				["CUSTOMS_CODE"] = user.CustomsCode,
				["DISCHARGED_NO"] = gateJobNo,
				["CAR_NO"] = declaration.CarNo,
				["CAR_WT"] = declaration.CarWeight,
				["FACT_WEIGHT"] = declaration.TotalWeight,
				["START_LAND"] = declaration.StartPlace,
				["GOAL_LAND"] = declaration.Destination,
				["AREA_CODE"] = declaration.AreaMark,
				["TRADE_CODE"] = user.CompanyCode,
				["TRADE_NAME"] = user.CompanyName,
				["INPUT_CODE"] = user.CompanyCode,
				["INPUT_NAME"] = user.CompanyName,
				["STEP_ID"] = "HFD100100",
				["CREATE_PERSON"] = user.Username,
				["CREATE_DATE"] = DateTime.Now,
				["BIZ_TYPE"] = ((declaration.IeMark == "I") ? "U" : "E"),
				["BIZ_MODE"] = ((declaration.IeMark == "I") ? "U01" : "E01"),
				["OPER_TYPE"] = "SAVE"
			};
			string headSql = BuildInsertSql();
			if (await _databaseHelper.ExecuteNonQueryAsync(headSql, headParameters) <= 0)
			{
				throw new Exception("�������뵥��ͷʧ��");
			}
			_logger.LogInformation("���뵥��ͷ����ɹ�����ţ�" + gateJobNo + "���û���" + user.Username);
			if (declaration.GoodsList != null && declaration.GoodsList.Count > 0)
			{
				foreach (DeclarationGoods goods in declaration.GoodsList)
				{
					string bodyAutoId = Guid.NewGuid().ToString("N");
					Dictionary<string, object> bodyParameters = new Dictionary<string, object>
					{
						["AUTO_ID"] = bodyAutoId,
						["GATEJOB_NO"] = gateJobNo,
						["ITEM_NO"] = declaration.GoodsList.IndexOf(goods) + 1,
						["G_NO"] = (string.IsNullOrEmpty(goods.ItemNo) ? DBNull.Value : ((object)Convert.ToInt32(goods.ItemNo))),
						["CODE_TS"] = goods.GoodsCode,
						["COUNTRY"] = DBNull.Value,
						["G_NAME"] = goods.GoodsName,
						["G_MODEL"] = goods.GoodsSpec,
						["APP_UNIT"] = goods.Unit,
						["UNIT_1"] = goods.Unit,
						["UNIT_2"] = DBNull.Value,
						["APP_QTY"] = goods.DeclareQty,
						["QTY_1"] = goods.DeclareQty,
						["QTY_2"] = DBNull.Value,
						["DEC_PRICE"] = goods.UnitPrice,
						["CURR"] = (string.IsNullOrEmpty(goods.Currency) ? "143" : goods.Currency),
						["TOTAL_PRICE"] = goods.TotalPrice,
						["M_P"] = (string.IsNullOrEmpty(goods.MaterialType) ? declaration.MaterialType : goods.MaterialType),
						["GOODS_FORM"] = DBNull.Value,
						["BELONG"] = DBNull.Value,
						["NOTE"] = goods.Remark,
						["OP_FLAG"] = "0"
					};
					string bodySql = BuildBodyInsertSql();
					if (await _databaseHelper.ExecuteNonQueryAsync(bodySql, bodyParameters) <= 0)
					{
						throw new Exception("������Ʒ����ʧ�ܣ���ţ�" + goods.ItemNo);
					}
				}
				_logger.LogInformation($"��Ʒ���屣��ɹ�����{declaration.GoodsList.Count}����¼�����뵥��ţ�{gateJobNo}");
			}
			try
			{
				await _vehicleService.CreateVehicleFromDeclarationAsync(declaration.CarNo, declaration.CarWeight, user.CompanyCode, user.CompanyName);
				_logger.LogInformation("�ǿճ��˷ŵ��������������ɣ����ƺţ�" + declaration.CarNo);
			}
			catch (Exception exception)
			{
				_logger.LogWarning(exception, "�Զ�����������Ϣʧ�ܣ����ƺţ�" + declaration.CarNo + "������Ӱ��˷ŵ�����");
			}
			_logger.LogInformation("�ǿճ��˷ŵ�������ɣ���ţ�" + gateJobNo + "���û���" + user.Username);
			return ApiResponse<string>.Ok(gateJobNo, "����ɹ�");
		}
		catch (Exception ex)
		{
			Exception ex2 = ex;
			_logger.LogError(ex2, $"����ǿճ��˷ŵ�ʧ�ܣ��û�ID��{userId}");
			return ApiResponse<string>.Fail("����ʧ�ܣ�" + ex2.Message);
		}
	}

	public async Task<ApiResponse<PagedResult<Declaration>>> GetDeclarationListAsync(DeclarationSearchRequest request, int userId)
	{
		try
		{
			User user = await _userService.GetUserByIdAsync(userId);
			if (user == null)
			{
				return ApiResponse<PagedResult<Declaration>>.Fail("�û�������");
			}
			List<string> whereClauses = new List<string> { "TRADE_CODE = @TradeCode" };
			Dictionary<string, object> parameters = new Dictionary<string, object> { ["TradeCode"] = user.CompanyCode };
			if (!string.IsNullOrEmpty(request.DischargedNo))
			{
				whereClauses.Add("DISCHARGED_NO LIKE @DischargedNo");
				parameters["DischargedNo"] = "%" + request.DischargedNo + "%";
			}
			if (!string.IsNullOrEmpty(request.CarNo))
			{
				whereClauses.Add("CAR_NO LIKE @CarNo");
				parameters["CarNo"] = "%" + request.CarNo + "%";
			}
			if (!string.IsNullOrEmpty(request.Status))
			{
				whereClauses.Add("STEP_ID = @Status");
				parameters["Status"] = request.Status;
			}
			if (request.StartDate.HasValue)
			{
				whereClauses.Add("CREATE_DATE >= @StartDate");
				parameters["StartDate"] = request.StartDate.Value;
			}
			if (request.EndDate.HasValue)
			{
				whereClauses.Add("CREATE_DATE <= @EndDate");
				parameters["EndDate"] = request.EndDate.Value.AddDays(1.0);
			}
			string whereClause = string.Join(" AND ", whereClauses);
			string countSql = "SELECT COUNT(*) FROM HF_HEAD_PRE WHERE " + whereClause;
			int total = Convert.ToInt32((await _databaseHelper.ExecuteQueryAsync(countSql, parameters)).Rows[0][0]);
			int offset = (request.Page - 1) * request.Size;
			string dataSql = BuildSelectSql(whereClause, offset, request.Size);
			DataTable dataResult = await _databaseHelper.ExecuteQueryAsync(dataSql, parameters);
			List<Declaration> declarations = new List<Declaration>();
			foreach (DataRow row in dataResult.Rows)
			{
				declarations.Add(MapDataRowToDeclaration(row));
			}
			PagedResult<Declaration> pagedResult = new PagedResult<Declaration>
			{
				Items = declarations,
				Total = total,
				Page = request.Page,
				Size = request.Size
			};
			return ApiResponse<PagedResult<Declaration>>.Ok(pagedResult);
		}
		catch (Exception ex)
		{
			Exception ex2 = ex;
			_logger.LogError(ex2, $"��ѯ�˷ŵ��б�ʧ�ܣ��û�ID��{userId}");
			return ApiResponse<PagedResult<Declaration>>.Fail("��ѯʧ�ܣ�" + ex2.Message);
		}
	}

	public async Task<ApiResponse<Declaration>> GetDeclarationByIdAsync(int id, int userId)
	{
		try
		{
			User user = await _userService.GetUserByIdAsync(userId);
			if (user == null)
			{
				return ApiResponse<Declaration>.Fail("�û�������");
			}
			string sql = "SELECT * FROM HF_HEAD_PRE WHERE ID = @Id AND TRADE_CODE = @TradeCode";
			Dictionary<string, object> parameters = new Dictionary<string, object>
			{
				["Id"] = id,
				["TradeCode"] = user.CompanyCode
			};
			DataTable result = await _databaseHelper.ExecuteQueryAsync(sql, parameters);
			if (result.Rows.Count == 0)
			{
				return ApiResponse<Declaration>.Fail("�˷ŵ������ڻ���Ȩ�޷���");
			}
			Declaration declaration = MapDataRowToDeclaration(result.Rows[0]);
			return ApiResponse<Declaration>.Ok(declaration);
		}
		catch (Exception ex)
		{
			Exception ex2 = ex;
			_logger.LogError(ex2, $"��ȡ�˷ŵ�����ʧ�ܣ�ID��{id}���û�ID��{userId}");
			return ApiResponse<Declaration>.Fail("��ȡʧ�ܣ�" + ex2.Message);
		}
	}

	private string BuildInsertSql()
	{
		string text = _connectionFactory.GetDatabaseProvider().ToLower();
		if (text == "oracle")
		{
			return "INSERT INTO HF_HEAD_PRE(\r\n                    CUSTOMS_CODE, DISCHARGED_NO, CAR_NO, CAR_WT, FACT_WEIGHT, START_LAND, GOAL_LAND, AREA_CODE,\r\n                    TRADE_CODE, TRADE_NAME, INPUT_CODE, INPUT_NAME, STEP_ID, CREATE_PERSON, CREATE_DATE,\r\n                    BIZ_TYPE, BIZ_MODE, OPER_TYPE\r\n                ) VALUES(\r\n                    :CUSTOMS_CODE, :DISCHARGED_NO, :CAR_NO, :CAR_WT, :FACT_WEIGHT, :START_LAND, :GOAL_LAND, :AREA_CODE,\r\n                    :TRADE_CODE, :TRADE_NAME, :INPUT_CODE, :INPUT_NAME, :STEP_ID, :CREATE_PERSON, :CREATE_DATE,\r\n                    :BIZ_TYPE, :BIZ_MODE, :OPER_TYPE\r\n                )";
		}
		return "INSERT INTO HF_HEAD_PRE(\r\n                    CUSTOMS_CODE, DISCHARGED_NO, CAR_NO, CAR_WT, FACT_WEIGHT, START_LAND, GOAL_LAND, AREA_CODE,\r\n                    TRADE_CODE, TRADE_NAME, INPUT_CODE, INPUT_NAME, STEP_ID, CREATE_PERSON, CREATE_DATE,\r\n                    BIZ_TYPE, BIZ_MODE, OPER_TYPE\r\n                ) VALUES(\r\n                    @CUSTOMS_CODE, @DISCHARGED_NO, @CAR_NO, @CAR_WT, @FACT_WEIGHT, @START_LAND, @GOAL_LAND, @AREA_CODE,\r\n                    @TRADE_CODE, @TRADE_NAME, @INPUT_CODE, @INPUT_NAME, @STEP_ID, @CREATE_PERSON, @CREATE_DATE,\r\n                    @BIZ_TYPE, @BIZ_MODE, @OPER_TYPE\r\n                )";
	}

	private string BuildNonEmptyInsertSql()
	{
		string text = _connectionFactory.GetDatabaseProvider().ToLower();
		if (text == "oracle")
		{
			return "INSERT INTO HF_HEAD_PRE(\r\n                    CUSTOMS_CODE, DISCHARGED_NO, CAR_NO, CAR_WT, FACT_WEIGHT, START_LAND, GOAL_LAND, AREA_CODE,\r\n                    TRADE_CODE, TRADE_NAME, INPUT_CODE, INPUT_NAME, STEP_ID, CREATE_PERSON, CREATE_DATE,\r\n                    BIZ_TYPE, BIZ_MODE, OPER_TYPE\r\n                ) VALUES(\r\n                    :CUSTOMS_CODE, :DISCHARGED_NO, :CAR_NO, :CAR_WT, :FACT_WEIGHT, :START_LAND, :GOAL_LAND, :AREA_CODE,\r\n                    :TRADE_CODE, :TRADE_NAME, :INPUT_CODE, :INPUT_NAME, :STEP_ID, :CREATE_PERSON, :CREATE_DATE,\r\n                    :BIZ_TYPE, :BIZ_MODE, :OPER_TYPE\r\n                )";
		}
		return "INSERT INTO HF_HEAD_PRE(\r\n                    CUSTOMS_CODE, DISCHARGED_NO, CAR_NO, CAR_WT, FACT_WEIGHT, START_LAND, GOAL_LAND, AREA_CODE,\r\n                    TRADE_CODE, TRADE_NAME, INPUT_CODE, INPUT_NAME, STEP_ID, CREATE_PERSON, CREATE_DATE,\r\n                    BIZ_TYPE, BIZ_MODE, OPER_TYPE\r\n                ) VALUES(\r\n                    @CUSTOMS_CODE, @DISCHARGED_NO, @CAR_NO, @CAR_WT, @FACT_WEIGHT, @START_LAND, @GOAL_LAND, @AREA_CODE,\r\n                    @TRADE_CODE, @TRADE_NAME, @INPUT_CODE, @INPUT_NAME, @STEP_ID, @CREATE_PERSON, @CREATE_DATE,\r\n                    @BIZ_TYPE, @BIZ_MODE, @OPER_TYPE\r\n                )";
	}

	private string BuildBodyInsertSql()
	{
		string text = _connectionFactory.GetDatabaseProvider().ToLower();
		if (text == "oracle")
		{
			return "INSERT INTO FBG_BODY_PRE(\r\n                    AUTO_ID, GATEJOB_NO, ITEM_NO, G_NO, CODE_TS, COUNTRY, G_NAME, G_MODEL, APP_UNIT, UNIT_1, UNIT_2,\r\n                    APP_QTY, QTY_1, QTY_2, DEC_PRICE, CURR, TOTAL_PRICE, M_P, GOODS_FORM, BELONG, NOTE, OP_FLAG\r\n                ) VALUES(\r\n                    :AUTO_ID, :GATEJOB_NO, :ITEM_NO, :G_NO, :CODE_TS, :COUNTRY, :G_NAME, :G_MODEL, :APP_UNIT, :UNIT_1, :UNIT_2,\r\n                    :APP_QTY, :QTY_1, :QTY_2, :DEC_PRICE, :CURR, :TOTAL_PRICE, :M_P, :GOODS_FORM, :BELONG, :NOTE, :OP_FLAG\r\n                )";
		}
		return "INSERT INTO FBG_BODY_PRE(\r\n                    AUTO_ID, GATEJOB_NO, ITEM_NO, G_NO, CODE_TS, COUNTRY, G_NAME, G_MODEL, APP_UNIT, UNIT_1, UNIT_2,\r\n                    APP_QTY, QTY_1, QTY_2, DEC_PRICE, CURR, TOTAL_PRICE, M_P, GOODS_FORM, BELONG, NOTE, OP_FLAG\r\n                ) VALUES(\r\n                    @AUTO_ID, @GATEJOB_NO, @ITEM_NO, @G_NO, @CODE_TS, @COUNTRY, @G_NAME, @G_MODEL, @APP_UNIT, @UNIT_1, @UNIT_2,\r\n                    @APP_QTY, @QTY_1, @QTY_2, @DEC_PRICE, @CURR, @TOTAL_PRICE, @M_P, @GOODS_FORM, @BELONG, @NOTE, @OP_FLAG\r\n                )";
	}

	private string BuildSelectSql(string whereClause, int offset, int size)
	{
		string text = _connectionFactory.GetDatabaseProvider().ToLower();
		if (!(text == "oracle"))
		{
			return $"SELECT * FROM HF_HEAD_PRE WHERE {whereClause} \r\n                         ORDER BY CREATE_DATE DESC \r\n                         OFFSET {offset} ROWS FETCH NEXT {size} ROWS ONLY";
		}
		return $"SELECT * FROM (\r\n                    SELECT ROWNUM RN, T.* FROM (\r\n                        SELECT * FROM HF_HEAD_PRE WHERE {whereClause} ORDER BY CREATE_DATE DESC\r\n                    ) T WHERE ROWNUM <= {offset + size}\r\n                ) WHERE RN > {offset}";
	}

	private Declaration MapDataRowToDeclaration(DataRow row)
	{
		return new Declaration
		{
			Id = Convert.ToInt32(row["ID"] ?? ((object)0)),
			DischargedNo = (row["DISCHARGED_NO"]?.ToString() ?? string.Empty),
			CarNo = (row["CAR_NO"]?.ToString() ?? string.Empty),
			CarWeight = Convert.ToDecimal(row["CAR_WT"] ?? ((object)0)),
			StartPlace = (row["START_LAND"]?.ToString() ?? string.Empty),
			Destination = (row["GOAL_LAND"]?.ToString() ?? string.Empty),
			AreaMark = (row["AREA_CODE"]?.ToString() ?? string.Empty),
			TotalWeight = Convert.ToDecimal(row["FACT_WEIGHT"] ?? ((object)0)),
			Status = (row["STEP_ID"]?.ToString() ?? string.Empty),
			CreateTime = Convert.ToDateTime(row["CREATE_DATE"] ?? ((object)DateTime.Now)),
			CreateUserId = 0,
			Remark = (row["REMARK"]?.ToString() ?? string.Empty)
		};
	}

	private void AddParameter(DbCommand command, string name, object value)
	{
		DbParameter dbParameter = command.CreateParameter();
		dbParameter.ParameterName = GetParameterName(name);
		dbParameter.Value = value ?? DBNull.Value;
		command.Parameters.Add(dbParameter);
	}

	private string GetParameterName(string parameterName)
	{
		string text = _connectionFactory.GetDatabaseProvider().ToLower();
		if (1 == 0)
		{
		}
		string result = ((!(text == "oracle")) ? ("@" + parameterName) : (":" + parameterName));
		if (1 == 0)
		{
		}
		return result;
	}

	public async Task<ApiResponse<string>> SaveApplicationAsync(SaveApplicationRequestDto request, int userId)
	{
		try
		{
			User user = await _userService.GetUserByIdAsync(userId);
			if (user == null)
			{
				return ApiResponse<string>.Fail("�û�������");
			}
			string gatejobNo = await _jobNumberService.GetJobNumberAsync("FBG", user.CompanyCode, user.CustomsCode);
			if (string.IsNullOrEmpty(gatejobNo))
			{
				return ApiResponse<string>.Fail("����ҵ�񵥺�ʧ��");
			}
			using (IDbConnection connection = _connectionFactory.CreateConnection())
			{
				DbConnection dbConnection = (DbConnection)connection;
				await dbConnection.OpenAsync();
				using DbTransaction transaction = dbConnection.BeginTransaction();
				try
				{
					await SaveApplicationHeaderAsync(dbConnection, transaction, request.Header, gatejobNo, user);
					if (request.GoodsItems != null && request.GoodsItems.Any())
					{
						await SaveApplicationGoodsAsync(dbConnection, transaction, request.GoodsItems, gatejobNo);
					}
					await transaction.CommitAsync();
					_logger.LogInformation("���뵥����ɹ�: " + gatejobNo);
					return ApiResponse<string>.Ok(gatejobNo, "���뵥����ɹ�");
				}
				catch (Exception ex)
				{
					await transaction.RollbackAsync();
					_logger.LogError(ex, "�������뵥ʧ��");
					return ApiResponse<string>.Fail("�������뵥ʧ��: " + ex.Message);
				}
			}
			IL_05b6:
			ApiResponse<string> result;
			return result;
		}
		catch (Exception ex2)
		{
			Exception ex3 = ex2;
			_logger.LogError(ex3, "�������뵥ʧ��");
			return ApiResponse<string>.Fail("�������뵥ʧ��: " + ex3.Message);
		}
	}

	public async Task<ApiResponse<string>> SaveCompleteDeclarationAsync(Declaration declaration, SaveApplicationRequestDto applicationData, int userId)
	{
		try
		{
			User user = await _userService.GetUserByIdAsync(userId);
			if (user == null)
			{
				return ApiResponse<string>.Fail("�û�������");
			}
			using (IDbConnection connection = _connectionFactory.CreateConnection())
			{
				DbConnection dbConnection = (DbConnection)connection;
				await dbConnection.OpenAsync();
				using DbTransaction transaction = dbConnection.BeginTransaction();
				try
				{
					string applicationGatejobNo = await _jobNumberService.GetJobNumberAsync("LF", user.CompanyCode, user.CustomsCode);
					if (string.IsNullOrEmpty(applicationGatejobNo))
					{
						return ApiResponse<string>.Fail("�������뵥ҵ�񵥺�ʧ��");
					}
					await SaveApplicationHeaderAsync(dbConnection, transaction, applicationData.Header, applicationGatejobNo, user);
					Dictionary<string, string> itemIdMapping = new Dictionary<string, string>();
					if (applicationData.GoodsItems != null && applicationData.GoodsItems.Any())
					{
						itemIdMapping = await SaveApplicationGoodsAsync(dbConnection, transaction, applicationData.GoodsItems, applicationGatejobNo);
					}
					string dischargedNo = (declaration.DischargedNo = await _jobNumberService.GetJobNumberAsync(declaration.BizType ?? "HF", user.CompanyCode, user.CustomsCode));
					await SaveDeclarationHeaderAsync(dbConnection, transaction, declaration, user);
					await SaveDeclarationBodyAsync(dbConnection, transaction, declaration, applicationData.GoodsItems ?? new List<GoodsItemDto>(), itemIdMapping, applicationGatejobNo);
					await transaction.CommitAsync();
					_logger.LogInformation("�����ǿպ˷ŵ�����ɹ�: " + dischargedNo);
					return ApiResponse<string>.Ok(dischargedNo, "�ǿպ˷ŵ�����ɹ�");
				}
				catch (Exception ex)
				{
					await transaction.RollbackAsync();
					_logger.LogError(ex, "���������ǿպ˷ŵ�ʧ��");
					return ApiResponse<string>.Fail("���������ǿպ˷ŵ�ʧ��: " + ex.Message);
				}
			}
			IL_07c2:
			ApiResponse<string> result;
			return result;
		}
		catch (Exception ex2)
		{
			Exception ex3 = ex2;
			_logger.LogError(ex3, "���������ǿպ˷ŵ�ʧ��");
			return ApiResponse<string>.Fail("���������ǿպ˷ŵ�ʧ��: " + ex3.Message);
		}
	}

	private async Task SaveApplicationHeaderAsync(DbConnection connection, DbTransaction transaction, ApplicationHeaderDto? header, string gatejobNo, User user)
	{
		if (header == null)
		{
			return;
		}
		string sql = BuildApplicationHeaderInsertSql();
		using DbCommand command = connection.CreateCommand();
		command.CommandText = sql;
		command.Transaction = transaction;
		AddParameter(command, "CUSTOMS_CODE", user.CustomsCode);
		AddParameter(command, "GATEJOB_NO", gatejobNo);
		AddParameter(command, "BIZ_TYPE", header.BizType ?? "U");
		AddParameter(command, "BIZ_MODE", header.BizMode ?? "U01");
		AddParameter(command, "GATEPASS_NO", DBNull.Value);
		AddParameter(command, "I_E_MARK", header.IEMark ?? "1");
		AddParameter(command, "GOODS_FLOW", header.GoodsFlow ?? "1");
		AddParameter(command, "EMS_NO", header.EmsNo);
		AddParameter(command, "M_P", header.MP ?? "3");
		AddParameter(command, "TRANSFER_MODE", header.TransferMode ?? "1");
		AddParameter(command, "GUARANTE_TYPE", header.GuaranteType ?? "3");
		AddParameter(command, "GUARANTE_NO", DBNull.Value);
		AddParameter(command, "GUARANTE_ID", DBNull.Value);
		AddParameter(command, "GUARANTE_PRICE", DBNull.Value);
		AddParameter(command, "GUARANTE_DESC", DBNull.Value);
		AddParameter(command, "TRADE_CODE", header.TradeCode ?? user.CompanyCode);
		AddParameter(command, "TRADE_NAME", header.TradeName ?? user.CompanyName);
		AddParameter(command, "PROVIDER_CODE", header.ProviderCode ?? user.CompanyCode);
		AddParameter(command, "PROVIDER_NAME", header.ProviderName ?? user.CompanyName);
		AddParameter(command, "AREA_CODE", header.AreaCode ?? "LF01");
		AddParameter(command, "NET_WEIGHT", header.NetWeight);
		AddParameter(command, "GROSS_WEIGHT", header.GrossWeight ?? 1m);
		AddParameter(command, "CORRESPOND_NO", DBNull.Value);
		AddParameter(command, "PACK_NO", header.PackNo ?? 2);
		AddParameter(command, "PACK_TYPE", header.PackType ?? "5");
		AddParameter(command, "LICENSE_PLATE", header.LicensePlate);
		AddParameter(command, "CREATE_PERSON", user.CompanyName);
		AddParameter(command, "CREATE_DATE", DateTime.Now);
		AddParameter(command, "NOTE", header.Note);
		AddParameter(command, "INPUT_CODE", user.CompanyCode);
		AddParameter(command, "INPUT_NAME", user.CompanyName);
		AddParameter(command, "OPER_TYPE", "SAVE");
		AddParameter(command, "STEP_ID", "FBG100100");
		await command.ExecuteNonQueryAsync();
	}

	private async Task<Dictionary<string, string>> SaveApplicationGoodsAsync(DbConnection connection, DbTransaction transaction, List<GoodsItemDto> goodsItems, string gatejobNo)
	{
		string sql = BuildApplicationGoodsInsertSql();
		Dictionary<string, string> itemIdMapping = new Dictionary<string, string>();
		foreach (GoodsItemDto item in goodsItems)
		{
			using DbCommand command = connection.CreateCommand();
			command.CommandText = sql;
			command.Transaction = transaction;
			string autoId = Guid.NewGuid().ToString();
			itemIdMapping[item.ItemNo ?? ""] = autoId;
			AddParameter(command, "AUTO_ID", autoId);
			AddParameter(command, "GATEJOB_NO", gatejobNo);
			AddParameter(command, "ITEM_NO", goodsItems.IndexOf(item) + 1);
			AddParameter(command, "G_NO", item.ItemNo);
			AddParameter(command, "CODE_TS", item.GoodsCode);
			AddParameter(command, "COUNTRY", "CHN");
			AddParameter(command, "G_NAME", item.GoodsName);
			AddParameter(command, "G_MODEL", item.Specification);
			AddParameter(command, "APP_UNIT", item.Unit);
			AddParameter(command, "UNIT_1", item.Unit);
			AddParameter(command, "UNIT_2", DBNull.Value);
			AddParameter(command, "APP_QTY", item.Quantity);
			AddParameter(command, "QTY_1", item.Quantity);
			AddParameter(command, "QTY_2", DBNull.Value);
			AddParameter(command, "DEC_PRICE", item.UnitPrice);
			AddParameter(command, "CURR", item.Currency ?? "CNY");
			AddParameter(command, "TOTAL_PRICE", item.TotalPrice);
			AddParameter(command, "M_P", item.MaterialProperty);
			AddParameter(command, "GOODS_FORM", DBNull.Value);
			AddParameter(command, "BELONG", DBNull.Value);
			AddParameter(command, "NOTE", item.Remark);
			AddParameter(command, "OP_FLAG", "A");
			await command.ExecuteNonQueryAsync();
		}
		return itemIdMapping;
	}

	private async Task SaveDeclarationHeaderAsync(DbConnection connection, DbTransaction transaction, Declaration declaration, User user)
	{
		string sql = BuildNonEmptyInsertSql();
		using DbCommand command = connection.CreateCommand();
		command.CommandText = sql;
		command.Transaction = transaction;
		AddParameter(command, "CUSTOMS_CODE", user.CustomsCode);
		AddParameter(command, "DISCHARGED_NO", declaration.DischargedNo);
		AddParameter(command, "CAR_NO", declaration.CarNo);
		AddParameter(command, "CAR_WT", declaration.CarWeight);
		AddParameter(command, "FACT_WEIGHT", declaration.TotalWeight);
		AddParameter(command, "START_LAND", declaration.StartPlace);
		AddParameter(command, "GOAL_LAND", declaration.Destination);
		AddParameter(command, "AREA_CODE", declaration.AreaMark);
		AddParameter(command, "TRADE_CODE", user.CompanyCode);
		AddParameter(command, "TRADE_NAME", user.CompanyName);
		AddParameter(command, "INPUT_CODE", user.CompanyCode);
		AddParameter(command, "INPUT_NAME", user.CompanyName);
		AddParameter(command, "STEP_ID", "HFD100100");
		AddParameter(command, "CREATE_PERSON", user.CompanyName);
		AddParameter(command, "CREATE_DATE", DateTime.Now);
		AddParameter(command, "BIZ_TYPE", declaration.BizType ?? "U");
		AddParameter(command, "BIZ_MODE", declaration.BizMode ?? "U01");
		AddParameter(command, "OPER_TYPE", "SAVE");
		await command.ExecuteNonQueryAsync();
	}

	private async Task SaveDeclarationBodyAsync(DbConnection connection, DbTransaction transaction, Declaration declaration, List<GoodsItemDto> goodsItems, Dictionary<string, string> itemIdMapping, string applicationGatejobNo)
	{
		string bodySQL = BuildHfBodyInsertSql();
		using DbCommand bodyCommand = connection.CreateCommand();
		bodyCommand.CommandText = bodySQL;
		bodyCommand.Transaction = transaction;
		AddParameter(bodyCommand, "GROSS_WEIGHT", declaration.GrossWeight);
		AddParameter(bodyCommand, "PACK_NO", declaration.PackageCount);
		AddParameter(bodyCommand, "GATEJOB_NO_REL", "");
		AddParameter(bodyCommand, "GATEJOB_NO", applicationGatejobNo);
		AddParameter(bodyCommand, "DISCHARGED_NO", declaration.DischargedNo);
		AddParameter(bodyCommand, "STATUS", "FBG100300");
		AddParameter(bodyCommand, "AUTO_ID", Guid.NewGuid().ToString("N"));
		AddParameter(bodyCommand, "LAST_CAR", "Y");
		await bodyCommand.ExecuteNonQueryAsync();
		await SaveDeclarationGoodsAsync(connection, transaction, goodsItems, applicationGatejobNo, declaration.DischargedNo ?? "", itemIdMapping);
	}

	private async Task SaveDeclarationGoodsAsync(DbConnection connection, DbTransaction transaction, List<GoodsItemDto> goodsItems, string applicationGatejobNo, string dischargedNo, Dictionary<string, string> itemIdMapping)
	{
		string sql = BuildHfGjgoodsInsertSql();
		foreach (GoodsItemDto item in goodsItems)
		{
			using DbCommand command = connection.CreateCommand();
			command.CommandText = sql;
			command.Transaction = transaction;
			string b2bAutoId = (itemIdMapping.ContainsKey(item.ItemNo ?? "") ? itemIdMapping[item.ItemNo ?? ""] : "");
			AddParameter(command, "AUTO_ID", Guid.NewGuid().ToString());
			AddParameter(command, "DISCHARGED_NO", dischargedNo);
			AddParameter(command, "GATEJOB_NO", applicationGatejobNo);
			AddParameter(command, "G_NO", int.Parse(item.ItemNo ?? "1"));
			AddParameter(command, "CODE_TS", item.GoodsCode);
			AddParameter(command, "G_NAME", item.GoodsName);
			AddParameter(command, "G_MODEL", item.Specification ?? "1");
			AddParameter(command, "APP_QTY", item.Quantity ?? 1m);
			AddParameter(command, "APP_UNIT", item.Unit ?? "006");
			AddParameter(command, "DEC_PRICE", item.UnitPrice ?? 100m);
			AddParameter(command, "CURR", item.Currency ?? "142");
			AddParameter(command, "M_P", item.MaterialProperty ?? "3");
			AddParameter(command, "B2B_AUTO_ID", b2bAutoId);
			await command.ExecuteNonQueryAsync();
		}
	}

	private string BuildApplicationHeaderInsertSql()
	{
		string text = _connectionFactory.GetDatabaseProvider().ToLower();
		if (text == "oracle")
		{
			return "INSERT INTO FBG_HEAD_PRE(\r\n                    CUSTOMS_CODE,GATEJOB_NO,BIZ_TYPE,BIZ_MODE,GATEPASS_NO,I_E_MARK,GOODS_FLOW,EMS_NO,M_P,TRANSFER_MODE,\r\n                    GUARANTE_TYPE,GUARANTE_NO,GUARANTE_ID,GUARANTE_PRICE,GUARANTE_DESC,TRADE_CODE,TRADE_NAME,\r\n                    PROVIDER_CODE,PROVIDER_NAME,AREA_CODE,NET_WEIGHT,GROSS_WEIGHT,CORRESPOND_NO,PACK_NO,PACK_TYPE,\r\n                    LICENSE_PLATE,CREATE_PERSON,CREATE_DATE,NOTE,INPUT_CODE,INPUT_NAME,OPER_TYPE,STEP_ID\r\n                ) VALUES(\r\n                    :CUSTOMS_CODE,:GATEJOB_NO,:BIZ_TYPE,:BIZ_MODE,:GATEPASS_NO,:I_E_MARK,:GOODS_FLOW,:EMS_NO,:M_P,:TRANSFER_MODE,\r\n                    :GUARANTE_TYPE,:GUARANTE_NO,:GUARANTE_ID,:GUARANTE_PRICE,:GUARANTE_DESC,:TRADE_CODE,:TRADE_NAME,\r\n                    :PROVIDER_CODE,:PROVIDER_NAME,:AREA_CODE,:NET_WEIGHT,:GROSS_WEIGHT,:CORRESPOND_NO,:PACK_NO,:PACK_TYPE,\r\n                    :LICENSE_PLATE,:CREATE_PERSON,:CREATE_DATE,:NOTE,:INPUT_CODE,:INPUT_NAME,:OPER_TYPE,:STEP_ID\r\n                )";
		}
		return "INSERT INTO FBG_HEAD_PRE(\r\n                    CUSTOMS_CODE,GATEJOB_NO,BIZ_TYPE,BIZ_MODE,GATEPASS_NO,I_E_MARK,GOODS_FLOW,EMS_NO,M_P,TRANSFER_MODE,\r\n                    GUARANTE_TYPE,GUARANTE_NO,GUARANTE_ID,GUARANTE_PRICE,GUARANTE_DESC,TRADE_CODE,TRADE_NAME,\r\n                    PROVIDER_CODE,PROVIDER_NAME,AREA_CODE,NET_WEIGHT,GROSS_WEIGHT,CORRESPOND_NO,PACK_NO,PACK_TYPE,\r\n                    LICENSE_PLATE,CREATE_PERSON,CREATE_DATE,NOTE,INPUT_CODE,INPUT_NAME,OPER_TYPE,STEP_ID\r\n                ) VALUES(\r\n                    @CUSTOMS_CODE,@GATEJOB_NO,@BIZ_TYPE,@BIZ_MODE,@GATEPASS_NO,@I_E_MARK,@GOODS_FLOW,@EMS_NO,@M_P,@TRANSFER_MODE,\r\n                    @GUARANTE_TYPE,@GUARANTE_NO,@GUARANTE_ID,@GUARANTE_PRICE,@GUARANTE_DESC,@TRADE_CODE,@TRADE_NAME,\r\n                    @PROVIDER_CODE,@PROVIDER_NAME,@AREA_CODE,@NET_WEIGHT,@GROSS_WEIGHT,@CORRESPOND_NO,@PACK_NO,@PACK_TYPE,\r\n                    @LICENSE_PLATE,@CREATE_PERSON,@CREATE_DATE,@NOTE,@INPUT_CODE,@INPUT_NAME,@OPER_TYPE,@STEP_ID\r\n                )";
	}

	private string BuildApplicationGoodsInsertSql()
	{
		string text = _connectionFactory.GetDatabaseProvider().ToLower();
		if (text == "oracle")
		{
			return "INSERT INTO FBG_BODY_PRE(\r\n                    AUTO_ID, GATEJOB_NO, ITEM_NO, G_NO, CODE_TS, COUNTRY, G_NAME, G_MODEL, APP_UNIT, UNIT_1, UNIT_2,\r\n                    APP_QTY, QTY_1, QTY_2, DEC_PRICE, CURR, TOTAL_PRICE, M_P, GOODS_FORM, BELONG, NOTE, OP_FLAG\r\n                ) VALUES(\r\n                    :AUTO_ID, :GATEJOB_NO, :ITEM_NO, :G_NO, :CODE_TS, :COUNTRY, :G_NAME, :G_MODEL, :APP_UNIT, :UNIT_1, :UNIT_2,\r\n                    :APP_QTY, :QTY_1, :QTY_2, :DEC_PRICE, :CURR, :TOTAL_PRICE, :M_P, :GOODS_FORM, :BELONG, :NOTE, :OP_FLAG\r\n                )";
		}
		return "INSERT INTO FBG_BODY_PRE(\r\n                    AUTO_ID, GATEJOB_NO, ITEM_NO, G_NO, CODE_TS, COUNTRY, G_NAME, G_MODEL, APP_UNIT, UNIT_1, UNIT_2,\r\n                    APP_QTY, QTY_1, QTY_2, DEC_PRICE, CURR, TOTAL_PRICE, M_P, GOODS_FORM, BELONG, NOTE, OP_FLAG\r\n                ) VALUES(\r\n                    @AUTO_ID, @GATEJOB_NO, @ITEM_NO, @G_NO, @CODE_TS, @COUNTRY, @G_NAME, @G_MODEL, @APP_UNIT, @UNIT_1, @UNIT_2,\r\n                    @APP_QTY, @QTY_1, @QTY_2, @DEC_PRICE, @CURR, @TOTAL_PRICE, @M_P, @GOODS_FORM, @BELONG, @NOTE, @OP_FLAG\r\n                )";
	}

	private string BuildHfBodyInsertSql()
	{
		string text = _connectionFactory.GetDatabaseProvider().ToLower();
		if (text == "oracle")
		{
			return "INSERT INTO HF_BODY_PRE(\r\n                    GROSS_WEIGHT,PACK_NO,GATEJOB_NO_REL,GATEJOB_NO,DISCHARGED_NO,STATUS,AUTO_ID,LAST_CAR\r\n                ) VALUES(\r\n                    :GROSS_WEIGHT,:PACK_NO,:GATEJOB_NO_REL,:GATEJOB_NO,:DISCHARGED_NO,:STATUS,:AUTO_ID,:LAST_CAR\r\n                )";
		}
		return "INSERT INTO HF_BODY_PRE(\r\n                    GROSS_WEIGHT,PACK_NO,GATEJOB_NO_REL,GATEJOB_NO,DISCHARGED_NO,STATUS,AUTO_ID,LAST_CAR\r\n                ) VALUES(\r\n                    @GROSS_WEIGHT,@PACK_NO,@GATEJOB_NO_REL,@GATEJOB_NO,@DISCHARGED_NO,@STATUS,@AUTO_ID,@LAST_CAR\r\n                )";
	}

	private string BuildHfGjgoodsInsertSql()
	{
		string text = _connectionFactory.GetDatabaseProvider().ToLower();
		if (text == "oracle")
		{
			return "INSERT INTO HF_GJGOODS_PRE(\r\n                    AUTO_ID,DISCHARGED_NO,GATEJOB_NO,G_NO,CODE_TS,G_NAME,G_MODEL,APP_QTY,APP_UNIT,DEC_PRICE,CURR,M_P,B2B_AUTO_ID\r\n                ) VALUES(\r\n                    :AUTO_ID,:DISCHARGED_NO,:GATEJOB_NO,:G_NO,:CODE_TS,:G_NAME,:G_MODEL,:APP_QTY,:APP_UNIT,:DEC_PRICE,:CURR,:M_P,:B2B_AUTO_ID\r\n                )";
		}
		return "INSERT INTO HF_GJGOODS_PRE(\r\n                    AUTO_ID,DISCHARGED_NO,GATEJOB_NO,G_NO,CODE_TS,G_NAME,G_MODEL,APP_QTY,APP_UNIT,DEC_PRICE,CURR,M_P,B2B_AUTO_ID\r\n                ) VALUES(\r\n                    @AUTO_ID,@DISCHARGED_NO,@GATEJOB_NO,@G_NO,@CODE_TS,@G_NAME,@G_MODEL,@APP_QTY,@APP_UNIT,@DEC_PRICE,@CURR,@M_P,@B2B_AUTO_ID\r\n                )";
	}

	public async Task<ApiResponse<PagedResult<UnifiedDeclarationListDto>>> GetUnifiedDeclarationListAsync(UnifiedDeclarationSearchRequestDto request, int userId)
	{
		try
		{
			User user = await _userService.GetUserByIdAsync(userId);
			if (user == null)
			{
				return ApiResponse<PagedResult<UnifiedDeclarationListDto>>.Fail("�û�������");
			}
			List<string> whereClauses = new List<string> { "hh.TRADE_CODE = @CompanyCode" };
			Dictionary<string, object> parameters = new Dictionary<string, object> { ["CompanyCode"] = user.CompanyCode };
			if (!string.IsNullOrEmpty(request.DischargedNo))
			{
				whereClauses.Add("hh.DISCHARGED_NO LIKE @DischargedNo");
				parameters["DischargedNo"] = "%" + request.DischargedNo + "%";
			}
			if (!string.IsNullOrEmpty(request.ApplicationNo))
			{
				whereClauses.Add("hb.GATEJOB_NO LIKE @ApplicationNo");
				parameters["ApplicationNo"] = "%" + request.ApplicationNo + "%";
			}
			if (!string.IsNullOrEmpty(request.CarNo))
			{
				whereClauses.Add("hh.CAR_NO LIKE @CarNo");
				parameters["CarNo"] = "%" + request.CarNo + "%";
			}
			if (!string.IsNullOrEmpty(request.Status))
			{
				whereClauses.Add("hh.STEP_ID = @Status");
				parameters["Status"] = request.Status;
			}
			if (request.StartDate.HasValue)
			{
				whereClauses.Add("hh.CREATE_DATE >= @StartDate");
				parameters["StartDate"] = request.StartDate.Value;
			}
			if (request.EndDate.HasValue)
			{
				whereClauses.Add("hh.CREATE_DATE <= @EndDate");
				parameters["EndDate"] = request.EndDate.Value.AddDays(1.0);
			}
			string whereClause = string.Join(" AND ", whereClauses);
			string countSql = BuildUnifiedDeclarationCountSql(whereClause);
			int total = Convert.ToInt32((await _databaseHelper.ExecuteQueryAsync(countSql, parameters)).Rows[0][0]);
			int offset = (request.Page - 1) * request.Size;
			parameters["Offset"] = offset;
			parameters["PageSize"] = request.Size;
			string dataSql = BuildUnifiedDeclarationListSql(whereClause);
			DataTable dataResult = await _databaseHelper.ExecuteQueryAsync(dataSql, parameters);
			List<UnifiedDeclarationListDto> declarations = new List<UnifiedDeclarationListDto>();
			foreach (DataRow row in dataResult.Rows)
			{
				declarations.Add(MapDataRowToUnifiedDeclarationListDto(row));
			}
			PagedResult<UnifiedDeclarationListDto> pagedResult = new PagedResult<UnifiedDeclarationListDto>
			{
				Items = declarations,
				Total = total,
				Page = request.Page,
				Size = request.Size
			};
			return ApiResponse<PagedResult<UnifiedDeclarationListDto>>.Ok(pagedResult);
		}
		catch (Exception ex)
		{
			Exception ex2 = ex;
			_logger.LogError(ex2, $"��ѯ��һ�걨�б�ʧ�ܣ��û�ID��{userId}");
			return ApiResponse<PagedResult<UnifiedDeclarationListDto>>.Fail("��ѯʧ�ܣ�" + ex2.Message);
		}
	}

	public async Task<ApiResponse<UnifiedDeclarationDetailDto>> GetUnifiedDeclarationDetailAsync(string dischargedNo, int userId)
	{
		try
		{
			User user = await _userService.GetUserByIdAsync(userId);
			if (user == null)
			{
				return ApiResponse<UnifiedDeclarationDetailDto>.Fail("�û�������");
			}
			UnifiedDeclarationDetailDto detail = new UnifiedDeclarationDetailDto();
			string hfSql = "SELECT * FROM HF_HEAD_PRE\r\n                            WHERE DISCHARGED_NO = @DischargedNo AND TRADE_CODE = @CompanyCode";
			Dictionary<string, object> hfParameters = new Dictionary<string, object>
			{
				["DischargedNo"] = dischargedNo,
				["CompanyCode"] = user.CompanyCode
			};
			DataTable hfResult = await _databaseHelper.ExecuteQueryAsync(hfSql, hfParameters);
			if (hfResult.Rows.Count == 0)
			{
				return ApiResponse<UnifiedDeclarationDetailDto>.Fail("�˷ŵ������ڻ���Ȩ�޷���");
			}
			detail.DischargedInfo = MapDataRowToDeclaration(hfResult.Rows[0]);
			string gatejobSql = "SELECT GATEJOB_NO FROM HF_BODY_PRE WHERE DISCHARGED_NO = @DischargedNo";
			DataTable gatejobResult = await _databaseHelper.ExecuteQueryAsync(gatejobSql, hfParameters);
			if (gatejobResult.Rows.Count > 0)
			{
				string gatejobNo = gatejobResult.Rows[0]["GATEJOB_NO"]?.ToString();
				if (!string.IsNullOrEmpty(gatejobNo))
				{
					string fbgSql = "SELECT * FROM FBG_HEAD_PRE WHERE GATEJOB_NO = @GatejobNo";
					Dictionary<string, object> fbgParameters = new Dictionary<string, object> { ["GatejobNo"] = gatejobNo };
					DataTable fbgResult = await _databaseHelper.ExecuteQueryAsync(fbgSql, fbgParameters);
					if (fbgResult.Rows.Count > 0)
					{
						detail.ApplicationHeader = MapDataRowToApplicationHeader(fbgResult.Rows[0]);
					}
					string goodsSql = "SELECT * FROM FBG_BODY_PRE WHERE GATEJOB_NO = @GatejobNo ORDER BY ITEM_NO";
					foreach (DataRow row in (await _databaseHelper.ExecuteQueryAsync(goodsSql, fbgParameters)).Rows)
					{
						detail.GoodsItems.Add(MapDataRowToGoodsItem(row));
					}
				}
			}
			return ApiResponse<UnifiedDeclarationDetailDto>.Ok(detail);
		}
		catch (Exception ex)
		{
			Exception ex2 = ex;
			_logger.LogError(ex2, $"��ȡ��һ�걨����ʧ�ܣ��˷ŵ��ţ�{dischargedNo}���û�ID��{userId}");
			return ApiResponse<UnifiedDeclarationDetailDto>.Fail("��ȡʧ�ܣ�" + ex2.Message);
		}
	}

	public async Task<ApiResponse<bool>> DeleteUnifiedDeclarationAsync(string dischargedNo, int userId)
	{
		try
		{
			User user = await _userService.GetUserByIdAsync(userId);
			if (user == null)
			{
				return ApiResponse<bool>.Fail("�û�������");
			}
			using (IDbConnection connection = _connectionFactory.CreateConnection())
			{
				DbConnection dbConnection = (DbConnection)connection;
				await dbConnection.OpenAsync();
				using DbTransaction transaction = dbConnection.BeginTransaction();
				try
				{
					string gatejobSql = "SELECT GATEJOB_NO FROM HF_BODY_PRE WHERE DISCHARGED_NO = @DischargedNo";
					using DbCommand gatejobCommand = dbConnection.CreateCommand();
					gatejobCommand.CommandText = gatejobSql;
					gatejobCommand.Transaction = transaction;
					AddParameter(gatejobCommand, "DischargedNo", dischargedNo);
					string gatejobNo = (await gatejobCommand.ExecuteScalarAsync()) as string;
					if (!string.IsNullOrEmpty(gatejobNo))
					{
						string deleteFbgBodySql = "DELETE FROM FBG_BODY_PRE\r\n                                                WHERE GATEJOB_NO = @GatejobNo\r\n                                                AND TRADE_CODE = @CompanyCode\r\n                                                AND EXISTS (SELECT 1 FROM FBG_HEAD_PRE\r\n                                                          WHERE FBG_HEAD_PRE.GATEJOB_NO = FBG_BODY_PRE.GATEJOB_NO\r\n                                                          AND FBG_HEAD_PRE.STEP_ID = 'FBG100100')";
						using DbCommand deleteFbgBodyCommand = dbConnection.CreateCommand();
						deleteFbgBodyCommand.CommandText = deleteFbgBodySql;
						deleteFbgBodyCommand.Transaction = transaction;
						AddParameter(deleteFbgBodyCommand, "GatejobNo", gatejobNo);
						AddParameter(deleteFbgBodyCommand, "CompanyCode", user.CompanyCode);
						await deleteFbgBodyCommand.ExecuteNonQueryAsync();
						string deleteFbgHeadSql = "DELETE FROM FBG_HEAD_PRE\r\n                                                WHERE GATEJOB_NO = @GatejobNo\r\n                                                AND TRADE_CODE = @CompanyCode\r\n                                                AND STEP_ID = 'FBG100100'";
						using DbCommand deleteFbgHeadCommand = dbConnection.CreateCommand();
						deleteFbgHeadCommand.CommandText = deleteFbgHeadSql;
						deleteFbgHeadCommand.Transaction = transaction;
						AddParameter(deleteFbgHeadCommand, "GatejobNo", gatejobNo);
						AddParameter(deleteFbgHeadCommand, "CompanyCode", user.CompanyCode);
						await deleteFbgHeadCommand.ExecuteNonQueryAsync();
					}
					string deleteHfGoodsSql = "DELETE FROM HF_GJGOODS_PRE WHERE DISCHARGED_NO = @DischargedNo";
					using DbCommand deleteHfGoodsCommand = dbConnection.CreateCommand();
					deleteHfGoodsCommand.CommandText = deleteHfGoodsSql;
					deleteHfGoodsCommand.Transaction = transaction;
					AddParameter(deleteHfGoodsCommand, "DischargedNo", dischargedNo);
					await deleteHfGoodsCommand.ExecuteNonQueryAsync();
					string deleteHfBodySql = "DELETE FROM HF_BODY_PRE WHERE DISCHARGED_NO = @DischargedNo";
					using DbCommand deleteHfBodyCommand = dbConnection.CreateCommand();
					deleteHfBodyCommand.CommandText = deleteHfBodySql;
					deleteHfBodyCommand.Transaction = transaction;
					AddParameter(deleteHfBodyCommand, "DischargedNo", dischargedNo);
					await deleteHfBodyCommand.ExecuteNonQueryAsync();
					string deleteHfHeadSql = "DELETE FROM HF_HEAD_PRE\r\n                                          WHERE DISCHARGED_NO = @DischargedNo\r\n                                          AND TRADE_CODE = @CompanyCode\r\n                                          AND STEP_ID = 'HFD100100'";
					using DbCommand deleteHfHeadCommand = dbConnection.CreateCommand();
					deleteHfHeadCommand.CommandText = deleteHfHeadSql;
					deleteHfHeadCommand.Transaction = transaction;
					AddParameter(deleteHfHeadCommand, "DischargedNo", dischargedNo);
					AddParameter(deleteHfHeadCommand, "CompanyCode", user.CompanyCode);
					if (await deleteHfHeadCommand.ExecuteNonQueryAsync() <= 0)
					{
						await transaction.RollbackAsync();
						return ApiResponse<bool>.Fail("ɾ��ʧ�ܣ��˷ŵ������ڻ����ύ�޷�ɾ��");
					}
					await transaction.CommitAsync();
					_logger.LogInformation("��һ�걨ɾ���ɹ����˷ŵ��ţ�" + dischargedNo + "���û���" + user.Username);
					return ApiResponse<bool>.Ok(data: true, "ɾ���ɹ�");
				}
				catch (Exception ex)
				{
					await transaction.RollbackAsync();
					_logger.LogError(ex, "ɾ����һ�걨ʧ��");
					return ApiResponse<bool>.Fail("ɾ��ʧ�ܣ�" + ex.Message);
				}
			}
			IL_0ae3:
			ApiResponse<bool> result;
			return result;
		}
		catch (Exception ex2)
		{
			Exception ex3 = ex2;
			_logger.LogError(ex3, $"ɾ����һ�걨ʧ�ܣ��˷ŵ��ţ�{dischargedNo}���û�ID��{userId}");
			return ApiResponse<bool>.Fail("ɾ��ʧ�ܣ�" + ex3.Message);
		}
	}

	private string BuildUnifiedDeclarationListSql(string whereClause)
	{
		string text = _connectionFactory.GetDatabaseProvider().ToLower();
		if (text == "oracle")
		{
			return "SELECT * FROM (\r\n                    SELECT\r\n                        ROWNUM AS RN,\r\n                        ROW_NUMBER() OVER (ORDER BY MAX(hh.CREATE_DATE) DESC) AS ���,\r\n                        hh.DISCHARGED_NO AS �˷ŵ���,\r\n                        hb.GATEJOB_NO AS ���뵥��,\r\n                        hh.CAR_NO AS ���ƺ���,\r\n                        LISTAGG(fbb.G_NO, ',') WITHIN GROUP (ORDER BY fbb.G_NO) AS ���,\r\n                        LISTAGG(fbb.G_NAME, ',') WITHIN GROUP (ORDER BY fbb.G_NO) AS ����Ʒ��,\r\n                        CASE\r\n                            WHEN fh.I_E_MARK = '1' THEN '����'\r\n                            WHEN fh.I_E_MARK = '2' THEN '����'\r\n                            ELSE 'δ֪'\r\n                        END AS ������־,\r\n                        MAX(hh.CREATE_DATE) AS ¼��ʱ��,\r\n                        MAX(hh.DECLARE_DATE) AS �걨ʱ��,\r\n                        CASE\r\n                            WHEN hh.STEP_ID IN ('HFD100300','HFD100500','HFD100600') AND hh.PORT_STATUS IN ('K03','K08') THEN '������'\r\n                            WHEN hh.STEP_ID IN ('HFD100500') THEN '������'\r\n                            ELSE\r\n                                CASE\r\n                                    WHEN hh.STEP_ID IN ('HFD100500', 'HFD100600') THEN '���ͨ��'\r\n                                    ELSE NVL((SELECT MAX(STEP_NAME) FROM SYS_STEP_PARAMETERS WHERE WORKFLOW_TYPE = 'HFD' AND STEP_ID = hh.STEP_ID), hh.STEP_ID)\r\n                                END\r\n                        END AS �˷ŵ�״̬,\r\n                        CASE\r\n                            WHEN fh.STEP_ID = 'FBG100100' THEN '�ݴ�'\r\n                            WHEN fh.STEP_ID = 'FBG100200' THEN '���걨'\r\n                            WHEN fh.STEP_ID = 'FBG100300' THEN '�����'\r\n                            ELSE NVL((SELECT MAX(STEP_NAME) FROM SYS_STEP_PARAMETERS WHERE WORKFLOW_TYPE = 'FBG' AND STEP_ID = fh.STEP_ID), fh.STEP_ID)\r\n                        END AS ���뵥״̬,\r\n                        MAX(hh.PORT_DATE) AS ����ʱ��,\r\n                        hh.FACT_WEIGHT AS ������,\r\n                        hh.CAR_WT AS ��������,\r\n                        (hh.FACT_WEIGHT - hh.CAR_WT) AS ��������,\r\n                        region.NAME AS �����־,\r\n                        0 AS �˷ŵ�ID,\r\n                        0 AS ���뵥ID\r\n                    FROM HF_HEAD_PRE hh\r\n                    LEFT JOIN HF_BODY_PRE hb ON hh.DISCHARGED_NO = hb.DISCHARGED_NO\r\n                    LEFT JOIN FBG_HEAD_PRE fh ON hb.GATEJOB_NO = fh.GATEJOB_NO\r\n                    LEFT JOIN FBG_BODY_PRE fbb ON fh.GATEJOB_NO = fbb.GATEJOB_NO\r\n                    LEFT JOIN BASE_REGION region ON region.CODE = hh.AREA_CODE\r\n                    WHERE " + whereClause + "\r\n                    GROUP BY hh.DISCHARGED_NO, hb.GATEJOB_NO, hh.CAR_NO, fh.I_E_MARK,\r\n                             hh.STEP_ID, hh.PORT_STATUS, fh.STEP_ID,\r\n                             hh.FACT_WEIGHT, hh.CAR_WT, region.NAME\r\n                    ORDER BY MAX(hh.CREATE_DATE) DESC\r\n                ) WHERE RN > :Offset AND RN <= (:Offset + :PageSize)";
		}
		return "SELECT\r\n                    ROW_NUMBER() OVER (ORDER BY MAX(hh.CREATE_DATE) DESC) AS ���,\r\n                    hh.DISCHARGED_NO AS �˷ŵ���,\r\n                    hb.GATEJOB_NO AS ���뵥��,\r\n                    hh.CAR_NO AS ���ƺ���,\r\n                    STRING_AGG(CAST(fbb.G_NO AS VARCHAR), ',') AS ���,\r\n                    STRING_AGG(fbb.G_NAME, ',') AS ����Ʒ��,\r\n                    CASE\r\n                        WHEN fh.I_E_MARK = '1' THEN '����'\r\n                        WHEN fh.I_E_MARK = '2' THEN '����'\r\n                        ELSE 'δ֪'\r\n                    END AS ������־,\r\n                    MAX(hh.CREATE_DATE) AS ¼��ʱ��,\r\n                    MAX(hh.DECLARE_DATE) AS �걨ʱ��,\r\n                    CASE\r\n                        WHEN hh.STEP_ID IN ('HFD100300','HFD100500','HFD100600') AND hh.PORT_STATUS IN ('K03','K08') THEN '������'\r\n                        WHEN hh.STEP_ID IN ('HFD100500') THEN '������'\r\n                        ELSE\r\n                            CASE\r\n                                WHEN hh.STEP_ID IN ('HFD100500', 'HFD100600') THEN '���ͨ��'\r\n                                ELSE ISNULL((SELECT MAX(STEP_NAME) FROM SYS_STEP_PARAMETERS WHERE WORKFLOW_TYPE = 'HFD' AND STEP_ID = hh.STEP_ID), hh.STEP_ID)\r\n                            END\r\n                    END AS �˷ŵ�״̬,\r\n                    CASE\r\n                        WHEN fh.STEP_ID = 'FBG100100' THEN '�ݴ�'\r\n                        WHEN fh.STEP_ID = 'FBG100200' THEN '���걨'\r\n                        WHEN fh.STEP_ID = 'FBG100300' THEN '�����'\r\n                        ELSE ISNULL((SELECT MAX(STEP_NAME) FROM SYS_STEP_PARAMETERS WHERE WORKFLOW_TYPE = 'FBG' AND STEP_ID = fh.STEP_ID), fh.STEP_ID)\r\n                    END AS ���뵥״̬,\r\n                    MAX(hh.PORT_DATE) AS ����ʱ��,\r\n                    hh.FACT_WEIGHT AS ������,\r\n                    hh.CAR_WT AS ��������,\r\n                    (hh.FACT_WEIGHT - hh.CAR_WT) AS ��������,\r\n                    region.NAME AS �����־,\r\n                    0 AS �˷ŵ�ID,\r\n                    0 AS ���뵥ID\r\n                FROM HF_HEAD_PRE hh\r\n                LEFT JOIN HF_BODY_PRE hb ON hh.DISCHARGED_NO = hb.DISCHARGED_NO\r\n                LEFT JOIN FBG_HEAD_PRE fh ON hb.GATEJOB_NO = fh.GATEJOB_NO\r\n                LEFT JOIN FBG_BODY_PRE fbb ON fh.GATEJOB_NO = fbb.GATEJOB_NO\r\n                LEFT JOIN BASE_REGION region ON region.CODE = hh.AREA_CODE\r\n                WHERE " + whereClause + "\r\n                GROUP BY hh.DISCHARGED_NO, hb.GATEJOB_NO, hh.CAR_NO, fh.I_E_MARK,\r\n                         hh.STEP_ID, hh.PORT_STATUS, fh.STEP_ID,\r\n                         hh.FACT_WEIGHT, hh.CAR_WT, region.NAME\r\n                ORDER BY MAX(hh.CREATE_DATE) DESC\r\n                OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";
	}

	private string BuildUnifiedDeclarationCountSql(string whereClause)
	{
		return "SELECT COUNT(DISTINCT hh.DISCHARGED_NO) AS TotalCount\r\n                FROM HF_HEAD_PRE hh\r\n                LEFT JOIN HF_BODY_PRE hb ON hh.DISCHARGED_NO = hb.DISCHARGED_NO\r\n                LEFT JOIN FBG_HEAD_PRE fh ON hb.GATEJOB_NO = fh.GATEJOB_NO\r\n                LEFT JOIN FBG_BODY_PRE fbb ON fh.GATEJOB_NO = fbb.GATEJOB_NO\r\n                LEFT JOIN BASE_REGION region ON region.CODE = hh.AREA_CODE\r\n                WHERE " + whereClause;
	}

	private UnifiedDeclarationListDto MapDataRowToUnifiedDeclarationListDto(DataRow row)
	{
		return new UnifiedDeclarationListDto
		{
			SerialNumber = Convert.ToInt32(row["���"] ?? ((object)0)),
			DischargedNo = (row["�˷ŵ���"]?.ToString() ?? string.Empty),
			ApplicationNo = (row["���뵥��"]?.ToString() ?? string.Empty),
			CarNo = (row["���ƺ���"]?.ToString() ?? string.Empty),
			ItemNos = (row["���"]?.ToString() ?? string.Empty),
			GoodsNames = (row["����Ʒ��"]?.ToString() ?? string.Empty),
			IEMark = (row["������־"]?.ToString() ?? string.Empty),
			CreateTime = ((row["¼��ʱ��"] == DBNull.Value) ? ((DateTime?)null) : new DateTime?(Convert.ToDateTime(row["¼��ʱ��"]))),
			DeclareTime = ((row["�걨ʱ��"] == DBNull.Value) ? ((DateTime?)null) : new DateTime?(Convert.ToDateTime(row["�걨ʱ��"]))),
			DischargedStatus = (row["�˷ŵ�״̬"]?.ToString() ?? string.Empty),
			ApplicationStatus = (row["���뵥״̬"]?.ToString() ?? string.Empty),
			PortTime = ((row["����ʱ��"] == DBNull.Value) ? ((DateTime?)null) : new DateTime?(Convert.ToDateTime(row["����ʱ��"]))),
			TotalWeight = Convert.ToDecimal(row["������"] ?? ((object)0)),
			CarWeight = Convert.ToDecimal(row["��������"] ?? ((object)0)),
			GoodsWeight = Convert.ToDecimal(row["��������"] ?? ((object)0)),
			AreaName = (row["�����־"]?.ToString() ?? string.Empty),
			DischargedId = Convert.ToInt32(row["�˷ŵ�ID"] ?? ((object)0)),
			ApplicationId = Convert.ToInt32(row["���뵥ID"] ?? ((object)0))
		};
	}

	private ApplicationHeaderDto MapDataRowToApplicationHeader(DataRow row)
	{
		return new ApplicationHeaderDto
		{
			BizType = row["BIZ_TYPE"]?.ToString(),
			BizMode = row["BIZ_MODE"]?.ToString(),
			IEMark = row["I_E_MARK"]?.ToString(),
			GoodsFlow = row["GOODS_FLOW"]?.ToString(),
			EmsNo = row["EMS_NO"]?.ToString(),
			MP = row["M_P"]?.ToString(),
			TransferMode = row["TRANSFER_MODE"]?.ToString(),
			GuaranteType = row["GUARANTE_TYPE"]?.ToString(),
			TradeCode = row["TRADE_CODE"]?.ToString(),
			TradeName = row["TRADE_NAME"]?.ToString(),
			ProviderCode = row["PROVIDER_CODE"]?.ToString(),
			ProviderName = row["PROVIDER_NAME"]?.ToString(),
			AreaCode = row["AREA_CODE"]?.ToString(),
			NetWeight = ((row["NET_WEIGHT"] == DBNull.Value) ? ((decimal?)null) : new decimal?(Convert.ToDecimal(row["NET_WEIGHT"]))),
			GrossWeight = ((row["GROSS_WEIGHT"] == DBNull.Value) ? ((decimal?)null) : new decimal?(Convert.ToDecimal(row["GROSS_WEIGHT"]))),
			PackNo = ((row["PACK_NO"] == DBNull.Value) ? ((int?)null) : new int?(Convert.ToInt32(row["PACK_NO"]))),
			PackType = row["PACK_TYPE"]?.ToString(),
			LicensePlate = row["LICENSE_PLATE"]?.ToString(),
			Note = row["NOTE"]?.ToString()
		};
	}

	private GoodsItemDto MapDataRowToGoodsItem(DataRow row)
	{
		return new GoodsItemDto
		{
			ItemNo = row["G_NO"]?.ToString(),
			GoodsCode = row["CODE_TS"]?.ToString(),
			GoodsName = row["G_NAME"]?.ToString(),
			Specification = row["G_MODEL"]?.ToString(),
			Quantity = ((row["APP_QTY"] == DBNull.Value) ? ((decimal?)null) : new decimal?(Convert.ToDecimal(row["APP_QTY"]))),
			Unit = row["APP_UNIT"]?.ToString(),
			UnitPrice = ((row["DEC_PRICE"] == DBNull.Value) ? ((decimal?)null) : new decimal?(Convert.ToDecimal(row["DEC_PRICE"]))),
			TotalPrice = ((row["TOTAL_PRICE"] == DBNull.Value) ? ((decimal?)null) : new decimal?(Convert.ToDecimal(row["TOTAL_PRICE"]))),
			Currency = row["CURR"]?.ToString(),
			MaterialProperty = row["M_P"]?.ToString(),
			Remark = row["NOTE"]?.ToString()
		};
	}
}
