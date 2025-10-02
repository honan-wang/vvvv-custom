using CustomsDeclaration.API.Data;
using CustomsDeclaration.API.Models;
using System.Data;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 车辆服务实现类
    /// </summary>
    public class VehicleService : IVehicleService
    {
        private readonly DatabaseHelper _databaseHelper;
        private readonly ILogger<VehicleService> _logger;

        public VehicleService(DatabaseHelper databaseHelper, ILogger<VehicleService> logger)
        {
            _databaseHelper = databaseHelper;
            _logger = logger;
        }

        /// <summary>
        /// 获取车辆列表
        /// </summary>
        /// <param name="request">查询请求</param>
        /// <returns>车辆列表</returns>
        public async Task<PagedResponse<Vehicle>> GetVehiclesAsync(VehicleSearchRequest request)
        {
            var whereClause = "WHERE 1=1";
            var parameters = new Dictionary<string, object>();

            // 构建查询条件
            if (!string.IsNullOrEmpty(request.VehicleNo))
            {
                whereClause += " AND vehicle_no LIKE @VehicleNo";
                parameters.Add("VehicleNo", $"%{request.VehicleNo}%");
            }

            if (!string.IsNullOrEmpty(request.VehicleType))
            {
                whereClause += " AND vehicle_type = @VehicleType";
                parameters.Add("VehicleType", request.VehicleType);
            }

            if (!string.IsNullOrEmpty(request.Status))
            {
                whereClause += " AND status = @Status";
                parameters.Add("Status", request.Status);
            }

            if (!string.IsNullOrEmpty(request.TradeCode))
            {
                whereClause += " AND trade_code = @TradeCode";
                parameters.Add("TradeCode", request.TradeCode);
            }

            if (!string.IsNullOrEmpty(request.TradeName))
            {
                whereClause += " AND trade_name LIKE @TradeName";
                parameters.Add("TradeName", $"%{request.TradeName}%");
            }

            // 获取总数
            var countSql = $"SELECT COUNT(*) FROM BASE_VEHICLE {whereClause}";
            var countTable = await _databaseHelper.ExecuteQueryAsync(countSql, parameters);
            var total = Convert.ToInt32(countTable.Rows[0][0]);

            // 获取分页数据
            var offset = (request.Page - 1) * request.Size;
            var dataSql = $@"SELECT * FROM BASE_VEHICLE {whereClause} 
                           ORDER BY record_date DESC 
                           OFFSET @Offset ROWS FETCH NEXT @Size ROWS ONLY";
            
            parameters.Add("Offset", offset);
            parameters.Add("Size", request.Size);

            var dataTable = await _databaseHelper.ExecuteQueryAsync(dataSql, parameters);
            var vehicles = new List<Vehicle>();

            foreach (DataRow row in dataTable.Rows)
            {
                vehicles.Add(MapToVehicle(row));
            }

            return new PagedResponse<Vehicle>
            {
                List = vehicles,
                Total = total,
                Page = request.Page,
                Size = request.Size
            };
        }

        /// <summary>
        /// 根据AutoId获取车辆信息
        /// </summary>
        /// <param name="autoId">车辆AutoId</param>
        /// <returns>车辆信息</returns>
        public async Task<Vehicle?> GetVehicleByIdAsync(string autoId)
        {
            var sql = "SELECT * FROM BASE_VEHICLE WHERE auto_id = @AutoId";
            var parameters = new Dictionary<string, object> { { "AutoId", autoId } };
            
            var dataTable = await _databaseHelper.ExecuteQueryAsync(sql, parameters);
            
            return dataTable.Rows.Count > 0 ? MapToVehicle(dataTable.Rows[0]) : null;
        }

        /// <summary>
        /// 根据车牌号获取车辆信息
        /// </summary>
        /// <param name="vehicleNo">车牌号</param>
        /// <returns>车辆信息</returns>
        public async Task<Vehicle?> GetVehicleByVehicleNoAsync(string vehicleNo)
        {
            _logger.LogInformation("查询车辆，车牌号: {VehicleNo}", vehicleNo);
            
            var sql = "SELECT * FROM BASE_VEHICLE WHERE vehicle_no = @VehicleNo";
            var parameters = new Dictionary<string, object> { { "VehicleNo", vehicleNo } };
            
            _logger.LogInformation("执行SQL: {Sql}, 参数: {Parameters}", sql, string.Join(", ", parameters.Select(p => $"{p.Key}={p.Value}")));
            
            var dataTable = await _databaseHelper.ExecuteQueryAsync(sql, parameters);
            
            _logger.LogInformation("查询结果行数: {RowCount}", dataTable.Rows.Count);
            
            return dataTable.Rows.Count > 0 ? MapToVehicle(dataTable.Rows[0]) : null;
        }

        /// <summary>
        /// 创建车辆
        /// </summary>
        /// <param name="request">车辆信息</param>
        /// <param name="userTradeCode">当前用户企业代码</param>
        /// <returns>创建结果</returns>
        public async Task<bool> CreateVehicleAsync(VehicleRequest request, string userTradeCode)
        {
            var sql = @"INSERT INTO BASE_VEHICLE 
                       (vehicle_no, vehicle_type, ic_code, ele_no1, ele_no2, ele_no3, 
                        vehicle_wt, foreign_no, vehicle_nature, used_nature, brand_type, 
                        amotor_no, difference_no, vehicle_native, range, vehicle_used, 
                        license_no, load_wt, load_pack, colour, validity_date, 
                        record_date, register_date, attached_name, trade_code, trade_name, 
                        app_person, app_date, status, customs_code, note, area_code,
                        extend_field_1, extend_field_2, extend_field_3, extend_field_4, extend_field_5) 
                       VALUES 
                       (@VehicleNo, @VehicleType, @IcCode, @EleNo1, @EleNo2, @EleNo3, 
                        @VehicleWt, @ForeignNo, @VehicleNature, @UsedNature, @BrandType, 
                        @AmotorNo, @DifferenceNo, @VehicleNative, @Range, @VehicleUsed, 
                        @LicenseNo, @LoadWt, @LoadPack, @Colour, @ValidityDate, 
                        @RecordDate, @RegisterDate, @AttachedName, @TradeCode, @TradeName, 
                        @AppPerson, @AppDate, @Status, @CustomsCode, @Note, @AreaCode,
                        @ExtendField1, @ExtendField2, @ExtendField3, @ExtendField4, @ExtendField5)";
            
            var parameters = new Dictionary<string, object>
            {
                { "VehicleNo", request.VehicleNo },
                { "VehicleType", request.VehicleType },
                { "IcCode", request.IcCode },
                { "EleNo1", request.EleNo1 },
                { "EleNo2", request.EleNo2 },
                { "EleNo3", request.EleNo3 },
                { "VehicleWt", (object?)request.VehicleWt ?? DBNull.Value },
                { "ForeignNo", request.ForeignNo },
                { "VehicleNature", request.VehicleNature },
                { "UsedNature", request.UsedNature },
                { "BrandType", request.BrandType },
                { "AmotorNo", request.AmotorNo },
                { "DifferenceNo", request.DifferenceNo },
                { "VehicleNative", request.VehicleNative },
                { "Range", request.Range },
                { "VehicleUsed", request.VehicleUsed },
                { "LicenseNo", request.LicenseNo },
                { "LoadWt", (object?)request.LoadWt ?? DBNull.Value },
                { "LoadPack", (object?)request.LoadPack ?? DBNull.Value },
                { "Colour", request.Colour },
                { "ValidityDate", (object?)request.ValidityDate ?? DBNull.Value },
                { "RecordDate", (object?)request.RecordDate ?? DateTime.Now },
                { "RegisterDate", (object?)request.RegisterDate ?? DBNull.Value },
                { "AttachedName", request.AttachedName },
                { "TradeCode", userTradeCode }, // 使用当前用户的企业代码
                { "TradeName", request.TradeName },
                { "AppPerson", request.AppPerson },
                { "AppDate", (object?)request.AppDate ?? DateTime.Now },
                { "Status", request.Status },
                { "CustomsCode", request.CustomsCode },
                { "Note", request.Note },
                { "AreaCode", request.AreaCode },
                { "ExtendField1", (object?)request.ExtendField1 ?? DBNull.Value },
                { "ExtendField2", (object?)request.ExtendField2 ?? DBNull.Value },
                { "ExtendField3", request.ExtendField3 },
                { "ExtendField4", request.ExtendField4 },
                { "ExtendField5", request.ExtendField5 }
            };

            var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
            return result > 0;
        }

        /// <summary>
        /// 更新车辆
        /// </summary>
        /// <param name="autoId">车辆AutoId</param>
        /// <param name="request">车辆信息</param>
        /// <param name="userTradeCode">当前用户企业代码</param>
        /// <returns>更新结果</returns>
        public async Task<bool> UpdateVehicleAsync(string autoId, VehicleRequest request, string userTradeCode)
        {
            // 首先检查权限：只能修改自己企业的车辆
            var checkSql = "SELECT trade_code FROM BASE_VEHICLE WHERE auto_id = @AutoId";
            var checkParams = new Dictionary<string, object> { { "AutoId", autoId } };
            var checkTable = await _databaseHelper.ExecuteQueryAsync(checkSql, checkParams);
            
            if (checkTable.Rows.Count == 0)
            {
                return false; // 车辆不存在
            }

            var vehicleTradeCode = checkTable.Rows[0]["trade_code"].ToString();
            if (vehicleTradeCode != userTradeCode)
            {
                return false; // 无权限修改其他企业的车辆
            }

            var sql = @"UPDATE BASE_VEHICLE SET 
                       vehicle_no = @VehicleNo, vehicle_type = @VehicleType, ic_code = @IcCode, 
                       ele_no1 = @EleNo1, ele_no2 = @EleNo2, ele_no3 = @EleNo3, 
                       vehicle_wt = @VehicleWt, foreign_no = @ForeignNo, vehicle_nature = @VehicleNature, 
                       used_nature = @UsedNature, brand_type = @BrandType, amotor_no = @AmotorNo, 
                       difference_no = @DifferenceNo, vehicle_native = @VehicleNative, range = @Range, 
                       vehicle_used = @VehicleUsed, license_no = @LicenseNo, load_wt = @LoadWt, 
                       load_pack = @LoadPack, colour = @Colour, validity_date = @ValidityDate, 
                       record_date = @RecordDate, register_date = @RegisterDate, attached_name = @AttachedName, 
                       trade_name = @TradeName, app_person = @AppPerson, app_date = @AppDate, 
                       status = @Status, customs_code = @CustomsCode, note = @Note, area_code = @AreaCode,
                       extend_field_1 = @ExtendField1, extend_field_2 = @ExtendField2, 
                       extend_field_3 = @ExtendField3, extend_field_4 = @ExtendField4, extend_field_5 = @ExtendField5
                       WHERE auto_id = @AutoId";
            
            var parameters = new Dictionary<string, object>
            {
                { "AutoId", autoId },
                { "VehicleNo", request.VehicleNo },
                { "VehicleType", request.VehicleType },
                { "IcCode", request.IcCode },
                { "EleNo1", request.EleNo1 },
                { "EleNo2", request.EleNo2 },
                { "EleNo3", request.EleNo3 },
                { "VehicleWt", (object?)request.VehicleWt ?? DBNull.Value },
                { "ForeignNo", request.ForeignNo },
                { "VehicleNature", request.VehicleNature },
                { "UsedNature", request.UsedNature },
                { "BrandType", request.BrandType },
                { "AmotorNo", request.AmotorNo },
                { "DifferenceNo", request.DifferenceNo },
                { "VehicleNative", request.VehicleNative },
                { "Range", request.Range },
                { "VehicleUsed", request.VehicleUsed },
                { "LicenseNo", request.LicenseNo },
                { "LoadWt", (object?)request.LoadWt ?? DBNull.Value },
                { "LoadPack", (object?)request.LoadPack ?? DBNull.Value },
                { "Colour", request.Colour },
                { "ValidityDate", (object?)request.ValidityDate ?? DBNull.Value },
                { "RecordDate", (object?)request.RecordDate ?? DBNull.Value },
                { "RegisterDate", (object?)request.RegisterDate ?? DBNull.Value },
                { "AttachedName", request.AttachedName },
                { "TradeName", request.TradeName },
                { "AppPerson", request.AppPerson },
                { "AppDate", (object?)request.AppDate ?? DBNull.Value },
                { "Status", request.Status },
                { "CustomsCode", request.CustomsCode },
                { "Note", request.Note },
                { "AreaCode", request.AreaCode },
                { "ExtendField1", (object?)request.ExtendField1 ?? DBNull.Value },
                { "ExtendField2", (object?)request.ExtendField2 ?? DBNull.Value },
                { "ExtendField3", request.ExtendField3 },
                { "ExtendField4", request.ExtendField4 },
                { "ExtendField5", request.ExtendField5 }
            };

            var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
            return result > 0;
        }

        /// <summary>
        /// 删除车辆
        /// </summary>
        /// <param name="autoId">车辆AutoId</param>
        /// <param name="userTradeCode">当前用户企业代码</param>
        /// <returns>删除结果</returns>
        public async Task<bool> DeleteVehicleAsync(string autoId, string userTradeCode)
        {
            // 首先检查权限：只能删除自己企业的车辆
            var checkSql = "SELECT trade_code FROM BASE_VEHICLE WHERE auto_id = @AutoId";
            var checkParams = new Dictionary<string, object> { { "AutoId", autoId } };
            var checkTable = await _databaseHelper.ExecuteQueryAsync(checkSql, checkParams);
            
            if (checkTable.Rows.Count == 0)
            {
                return false; // 车辆不存在
            }

            var vehicleTradeCode = checkTable.Rows[0]["trade_code"].ToString();
            if (vehicleTradeCode != userTradeCode)
            {
                return false; // 无权限删除其他企业的车辆
            }

            // 物理删除，也可以改为软删除
            var sql = "DELETE FROM BASE_VEHICLE WHERE auto_id = @AutoId";
            var parameters = new Dictionary<string, object> { { "AutoId", autoId } };

            var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
            return result > 0;
        }

        /// <summary>
        /// 检查车牌号是否已存在
        /// </summary>
        /// <param name="vehicleNo">车牌号</param>
        /// <param name="excludeAutoId">排除的车辆AutoId（用于更新时检查）</param>
        /// <returns>是否存在</returns>
        public async Task<bool> IsVehicleNoExistsAsync(string vehicleNo, string? excludeAutoId = null)
        {
            var sql = "SELECT COUNT(*) FROM BASE_VEHICLE WHERE vehicle_no = @VehicleNo";
            var parameters = new Dictionary<string, object> { { "VehicleNo", vehicleNo } };

            if (!string.IsNullOrEmpty(excludeAutoId))
            {
                sql += " AND auto_id != @ExcludeAutoId";
                parameters.Add("ExcludeAutoId", excludeAutoId);
            }

            var dataTable = await _databaseHelper.ExecuteQueryAsync(sql, parameters);
            var count = Convert.ToInt32(dataTable.Rows[0][0]);

            return count > 0;
        }

        /// <summary>
        /// 根据车牌号模糊搜索车辆（用于自动完成）
        /// </summary>
        /// <param name="keyword">车牌号关键词</param>
        /// <param name="limit">返回数量限制</param>
        /// <returns>车辆搜索结果列表</returns>
        public async Task<List<VehicleSearchResult>> SearchVehiclesByVehicleNoAsync(string keyword, int limit = 10)
        {
            var sql = @"SELECT TOP(@Limit) 
                           auto_id, 
                           vehicle_no, 
                           vehicle_type, 
                           vehicle_wt, 
                           load_wt, 
                           trade_name
                       FROM BASE_VEHICLE 
                       WHERE vehicle_no LIKE @Keyword 
                       ORDER BY vehicle_no";
            
            var parameters = new Dictionary<string, object>
            {
                { "Keyword", $"%{keyword}%" },
                { "Limit", limit }
            };

            var dataTable = await _databaseHelper.ExecuteQueryAsync(sql, parameters);
            var results = new List<VehicleSearchResult>();

            foreach (DataRow row in dataTable.Rows)
            {
                results.Add(new VehicleSearchResult
                {
                    AutoId = row["auto_id"].ToString() ?? string.Empty,
                    VehicleNo = row["vehicle_no"].ToString() ?? string.Empty,
                    VehicleType = row["vehicle_type"].ToString() ?? string.Empty,
                    VehicleWt = row["vehicle_wt"] == DBNull.Value ? null : Convert.ToDecimal(row["vehicle_wt"]),
                    LoadWt = row["load_wt"] == DBNull.Value ? null : Convert.ToDecimal(row["load_wt"]),
                    TradeName = row["trade_name"].ToString() ?? string.Empty
                });
            }

            return results;
        }

        /// <summary>
        /// 获取用户可管理的车辆列表（基于企业代码权限控制）
        /// </summary>
        /// <param name="request">查询请求</param>
        /// <param name="userTradeCode">当前用户企业代码</param>
        /// <returns>车辆列表</returns>
        public async Task<PagedResponse<Vehicle>> GetManageableVehiclesAsync(VehicleSearchRequest request, string userTradeCode)
        {
            var whereClause = "WHERE trade_code = @UserTradeCode";
            var parameters = new Dictionary<string, object> { { "UserTradeCode", userTradeCode } };

            // 构建查询条件
            if (!string.IsNullOrEmpty(request.VehicleNo))
            {
                whereClause += " AND vehicle_no LIKE @VehicleNo";
                parameters.Add("VehicleNo", $"%{request.VehicleNo}%");
            }

            if (!string.IsNullOrEmpty(request.VehicleType))
            {
                whereClause += " AND vehicle_type = @VehicleType";
                parameters.Add("VehicleType", request.VehicleType);
            }

            if (!string.IsNullOrEmpty(request.Status))
            {
                whereClause += " AND status = @Status";
                parameters.Add("Status", request.Status);
            }

            // 获取总数
            var countSql = $"SELECT COUNT(*) FROM BASE_VEHICLE {whereClause}";
            var countTable = await _databaseHelper.ExecuteQueryAsync(countSql, parameters);
            var total = Convert.ToInt32(countTable.Rows[0][0]);

            // 获取分页数据
            var offset = (request.Page - 1) * request.Size;
            var dataSql = $@"SELECT * FROM BASE_VEHICLE {whereClause} 
                           ORDER BY record_date DESC 
                           OFFSET @Offset ROWS FETCH NEXT @Size ROWS ONLY";
            
            parameters.Add("Offset", offset);
            parameters.Add("Size", request.Size);

            var dataTable = await _databaseHelper.ExecuteQueryAsync(dataSql, parameters);
            var vehicles = new List<Vehicle>();

            foreach (DataRow row in dataTable.Rows)
            {
                vehicles.Add(MapToVehicle(row));
            }

            return new PagedResponse<Vehicle>
            {
                List = vehicles,
                Total = total,
                Page = request.Page,
                Size = request.Size
            };
        }

        /// <summary>
        /// 从申报信息自动创建车辆信息
        /// </summary>
        /// <param name="vehicleNo">车牌号</param>
        /// <param name="vehicleWeight">车辆自重</param>
        /// <param name="tradeCode">企业代码</param>
        /// <param name="tradeName">企业名称</param>
        /// <returns>创建结果</returns>
        public async Task<bool> CreateVehicleFromDeclarationAsync(string vehicleNo, decimal vehicleWeight, string tradeCode, string tradeName)
        {
            try
            {
                // 检查车辆是否已存在
                var existingVehicle = await GetVehicleByVehicleNoAsync(vehicleNo);
                if (existingVehicle != null)
                {
                    _logger.LogInformation($"车辆 {vehicleNo} 已存在，跳过自动创建");
                    return true; // 已存在，返回成功
                }

                var sql = @"INSERT INTO BASE_VEHICLE 
                           (vehicle_no, vehicle_wt, trade_code, trade_name, status, record_date, app_date) 
                           VALUES 
                           (@VehicleNo, @VehicleWt, @TradeCode, @TradeName, @Status, @RecordDate, @AppDate)";
                
                var parameters = new Dictionary<string, object>
                {
                    { "VehicleNo", vehicleNo },
                    { "VehicleWt", vehicleWeight },
                    { "TradeCode", tradeCode },
                    { "TradeName", tradeName },
                    { "Status", "正常" }, // 默认状态
                    { "RecordDate", DateTime.Now },
                    { "AppDate", DateTime.Now }
                };

                var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
                
                if (result > 0)
                {
                    _logger.LogInformation($"从申报信息自动创建车辆成功：{vehicleNo}，企业：{tradeName}");
                    return true;
                }
                else
                {
                    _logger.LogWarning($"从申报信息自动创建车辆失败：{vehicleNo}");
                    return false;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"从申报信息自动创建车辆异常：{vehicleNo}");
                return false;
            }
        }

        /// <summary>
        /// 将数据行映射为车辆对象
        /// </summary>
        /// <param name="row">数据行</param>
        /// <returns>车辆对象</returns>
        private static Vehicle MapToVehicle(DataRow row)
        {
            return new Vehicle
            {
                AutoId = row["auto_id"].ToString() ?? string.Empty,
                VehicleNo = row["vehicle_no"].ToString() ?? string.Empty,
                VehicleType = row["vehicle_type"].ToString() ?? string.Empty,
                IcCode = row["ic_code"].ToString() ?? string.Empty,
                EleNo1 = row["ele_no1"].ToString() ?? string.Empty,
                EleNo2 = row["ele_no2"].ToString() ?? string.Empty,
                EleNo3 = row["ele_no3"].ToString() ?? string.Empty,
                VehicleWt = row["vehicle_wt"] == DBNull.Value ? null : Convert.ToDecimal(row["vehicle_wt"]),
                ForeignNo = row["foreign_no"].ToString() ?? string.Empty,
                VehicleNature = row["vehicle_nature"].ToString() ?? string.Empty,
                UsedNature = row["used_nature"].ToString() ?? string.Empty,
                BrandType = row["brand_type"].ToString() ?? string.Empty,
                AmotorNo = row["amotor_no"].ToString() ?? string.Empty,
                DifferenceNo = row["difference_no"].ToString() ?? string.Empty,
                VehicleNative = row["vehicle_native"].ToString() ?? string.Empty,
                Range = row["range"].ToString() ?? string.Empty,
                VehicleUsed = row["vehicle_used"].ToString() ?? string.Empty,
                LicenseNo = row["license_no"].ToString() ?? string.Empty,
                LoadWt = row["load_wt"] == DBNull.Value ? null : Convert.ToDecimal(row["load_wt"]),
                LoadPack = row["load_pack"] == DBNull.Value ? null : Convert.ToDecimal(row["load_pack"]),
                Colour = row["colour"].ToString() ?? string.Empty,
                ValidityDate = row["validity_date"] == DBNull.Value ? null : Convert.ToDateTime(row["validity_date"]),
                RecordDate = row["record_date"] == DBNull.Value ? null : Convert.ToDateTime(row["record_date"]),
                RegisterDate = row["register_date"] == DBNull.Value ? null : Convert.ToDateTime(row["register_date"]),
                AttachedName = row["attached_name"].ToString() ?? string.Empty,
                TradeCode = row["trade_code"].ToString() ?? string.Empty,
                TradeName = row["trade_name"].ToString() ?? string.Empty,
                AppPerson = row["app_person"].ToString() ?? string.Empty,
                AppDate = row["app_date"] == DBNull.Value ? null : Convert.ToDateTime(row["app_date"]),
                Status = row["status"].ToString() ?? string.Empty,
                CustomsCode = row["customs_code"].ToString() ?? string.Empty,
                Note = row["note"].ToString() ?? string.Empty,
                AreaCode = row["area_code"].ToString() ?? string.Empty,
                ExtendField1 = row["extend_field_1"] == DBNull.Value ? null : Convert.ToDecimal(row["extend_field_1"]),
                ExtendField2 = row["extend_field_2"] == DBNull.Value ? null : Convert.ToDecimal(row["extend_field_2"]),
                ExtendField3 = row["extend_field_3"].ToString() ?? string.Empty,
                ExtendField4 = row["extend_field_4"].ToString() ?? string.Empty,
                ExtendField5 = row["extend_field_5"].ToString() ?? string.Empty
            };
        }
    }
}