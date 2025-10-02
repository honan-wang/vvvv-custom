using CustomsDeclaration.API.Data;
using CustomsDeclaration.API.Models;
using System.Data;
using System.Security.Cryptography;
using System.Text;

namespace CustomsDeclaration.API.Services
{
    /// <summary>
    /// 用户服务实现类
    /// </summary>
    public class UserService : IUserService
    {
        private readonly DatabaseHelper _databaseHelper;
        private readonly IJwtService _jwtService;
        private readonly IConfiguration _configuration;
        private readonly ILogger<UserService> _logger;

        public UserService(DatabaseHelper databaseHelper, IJwtService jwtService, IConfiguration configuration, ILogger<UserService> logger)
        {
            _databaseHelper = databaseHelper;
            _jwtService = jwtService;
            _configuration = configuration;
            _logger = logger;
        }

        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="request">登录请求</param>
        /// <returns>登录响应</returns>
        public async Task<LoginResponse?> LoginAsync(LoginRequest request)
        {
            _logger.LogInformation("开始用户登录，用户名: {Username}", request.Username);
            
            var user = await GetUserByUsernameAsync(request.Username);
            
            if (user == null)
            {
                _logger.LogWarning("用户不存在: {Username}", request.Username);
                return null;
            }
            
            _logger.LogInformation("找到用户: {Username}, 状态: {IsActive}", user.Username, user.IsActive);
            
            if (!user.IsActive)
            {
                _logger.LogWarning("用户未激活: {Username}", request.Username);
                return null;
            }
            
            var passwordVerified = VerifyPassword(request.Password, user.PasswordHash);
            _logger.LogInformation("密码验证结果: {PasswordVerified} for user: {Username}", passwordVerified, request.Username);
            
            if (!passwordVerified)
            {
                _logger.LogWarning("密码验证失败: {Username}", request.Username);
                return null;
            }

            // 更新最后登录时间
            await UpdateLastLoginTimeAsync(user.Id);

            var token = _jwtService.GenerateAccessToken(user);
            var expiryMinutes = int.Parse(_configuration["JwtSettings:ExpiryMinutes"] ?? "60");

            _logger.LogInformation("用户登录成功: {Username}", request.Username);
            
            return new LoginResponse
            {
                AccessToken = token,
                ExpiresIn = expiryMinutes * 60,
                UserInfo = new UserInfo
                {
                    Id = user.Id,
                    Username = user.Username,
                    Role = user.Role,
                    CustomsCode = user.CustomsCode,
                    CustomsName = user.CustomsName,
                    CompanyCode = user.CompanyCode,
                    CompanyName = user.CompanyName
                }
            };
        }

        /// <summary>
        /// 根据用户名获取用户
        /// </summary>
        /// <param name="username">用户名</param>
        /// <returns>用户信息</returns>
        public async Task<User?> GetUserByUsernameAsync(string username)
        {
            var sql = "SELECT * FROM SYS_USERS WHERE Username = @Username AND IsDeleted = 0";
            var parameters = new Dictionary<string, object> { { "Username", username } };
            
            var dataTable = await _databaseHelper.ExecuteQueryAsync(sql, parameters);
            
            return dataTable.Rows.Count > 0 ? MapToUser(dataTable.Rows[0]) : null;
        }

        /// <summary>
        /// 根据用户ID获取用户
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <returns>用户信息</returns>
        public async Task<User?> GetUserByIdAsync(int userId)
        {
            var sql = "SELECT * FROM SYS_USERS WHERE Id = @Id AND IsDeleted = 0";
            var parameters = new Dictionary<string, object> { { "Id", userId } };
            
            var dataTable = await _databaseHelper.ExecuteQueryAsync(sql, parameters);
            
            return dataTable.Rows.Count > 0 ? MapToUser(dataTable.Rows[0]) : null;
        }

        /// <summary>
        /// 创建用户
        /// </summary>
        /// <param name="user">用户信息</param>
        /// <returns>创建结果</returns>
        public async Task<bool> CreateUserAsync(User user)
        {
            var sql = @"INSERT INTO SYS_USERS 
                       (Username, PasswordHash, Role, IsActive, CustomsCode, CustomsName, CompanyCode, CompanyName, CreateTime) 
                       VALUES (@Username, @PasswordHash, @Role, @IsActive, @CustomsCode, @CustomsName, @CompanyCode, @CompanyName, @CreateTime)";
            
            var parameters = new Dictionary<string, object>
            {
                { "Username", user.Username },
                { "PasswordHash", HashPassword(user.PasswordHash) },
                { "Role", user.Role },
                { "IsActive", user.IsActive },
                { "CustomsCode", user.CustomsCode },
                { "CustomsName", user.CustomsName },
                { "CompanyCode", user.CompanyCode },
                { "CompanyName", user.CompanyName },
                { "CreateTime", DateTime.Now }
            };

            var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
            return result > 0;
        }

        /// <summary>
        /// 创建用户（使用请求模型）
        /// </summary>
        /// <param name="request">创建用户请求</param>
        /// <returns>创建结果</returns>
        public async Task<bool> CreateUserAsync(CreateUserRequest request)
        {
            // 检查用户名是否已存在
            var existingUser = await GetUserByUsernameAsync(request.Username);
            if (existingUser != null)
            {
                return false;
            }

            var sql = @"INSERT INTO SYS_USERS 
                       (Username, PasswordHash, Role, IsActive, CustomsCode, CustomsName, CompanyCode, CompanyName, CreateTime) 
                       VALUES (@Username, @PasswordHash, @Role, @IsActive, @CustomsCode, @CustomsName, @CompanyCode, @CompanyName, @CreateTime)";
            
            var parameters = new Dictionary<string, object>
            {
                { "Username", request.Username },
                { "PasswordHash", HashPassword(request.Password) },
                { "Role", request.Role },
                { "IsActive", request.Status == 1 },
                { "CustomsCode", request.CustomsCode },
                { "CustomsName", request.CustomsName },
                { "CompanyCode", request.CompanyCode },
                { "CompanyName", request.CompanyName },
                { "CreateTime", DateTime.Now }
            };

            var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
            return result > 0;
        }

        /// <summary>
        /// 更新用户
        /// </summary>
        /// <param name="user">用户信息</param>
        /// <returns>更新结果</returns>
        public async Task<bool> UpdateUserAsync(User user)
        {
            var sql = @"UPDATE SYS_USERS SET 
                       Role = @Role, IsActive = @IsActive, CustomsCode = @CustomsCode, 
                       CustomsName = @CustomsName, CompanyCode = @CompanyCode, CompanyName = @CompanyName 
                       WHERE Id = @Id";
            
            var parameters = new Dictionary<string, object>
            {
                { "Id", user.Id },
                { "Role", user.Role },
                { "IsActive", user.IsActive },
                { "CustomsCode", user.CustomsCode },
                { "CustomsName", user.CustomsName },
                { "CompanyCode", user.CompanyCode },
                { "CompanyName", user.CompanyName }
            };

            var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
            return result > 0;
        }

        /// <summary>
        /// 更新用户（使用请求模型）
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="request">更新用户请求</param>
        /// <returns>更新结果</returns>
        public async Task<bool> UpdateUserAsync(int userId, UpdateUserRequest request)
        {
            var sql = @"UPDATE SYS_USERS SET 
                       Role = @Role, IsActive = @IsActive, CustomsCode = @CustomsCode, 
                       CustomsName = @CustomsName, CompanyCode = @CompanyCode, CompanyName = @CompanyName 
                       WHERE Id = @Id";
            
            var parameters = new Dictionary<string, object>
            {
                { "Id", userId },
                { "Role", request.Role },
                { "IsActive", request.Status == 1 },
                { "CustomsCode", request.CustomsCode },
                { "CustomsName", request.CustomsName },
                { "CompanyCode", request.CompanyCode },
                { "CompanyName", request.CompanyName }
            };

            var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
            return result > 0;
        }

        /// <summary>
        /// 删除用户
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <returns>删除结果</returns>
        public async Task<bool> DeleteUserAsync(int userId)
        {
            var sql = "UPDATE SYS_USERS SET IsDeleted = 1 WHERE Id = @Id";
            var parameters = new Dictionary<string, object> { { "Id", userId } };

            var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
            return result > 0;
        }

        /// <summary>
        /// 获取用户列表
        /// </summary>
        /// <param name="request">分页查询请求</param>
        /// <returns>用户列表</returns>
        public async Task<PagedResponse<UserListResponse>> GetUsersAsync(PagedRequest request)
        {
            // 模拟数据用于测试
            var mockUsers = new List<UserListResponse>
            {
                new UserListResponse
                {
                    Id = 1,
                    Username = "admin",
                    Role = "Admin",
                    CustomsCode = "1234567890",
                    CustomsName = "北京海关",
                    CompanyCode = "SYS001",
                    CompanyName = "系统管理",
                    Status = 1,
                    CreateTime = DateTime.Now.AddDays(-30),
                    LastLoginTime = DateTime.Now.AddHours(-2)
                },
                new UserListResponse
                {
                    Id = 2,
                    Username = "testuser",
                    Role = "User",
                    CustomsCode = "0987654321", 
                    CustomsName = "上海海关",
                    CompanyCode = "TEST01",
                    CompanyName = "测试企业",
                    Status = 1,
                    CreateTime = DateTime.Now.AddDays(-15),
                    LastLoginTime = DateTime.Now.AddDays(-1)
                },
                new UserListResponse
                {
                    Id = 3,
                    Username = "user001",
                    Role = "User",
                    CustomsCode = "1111111111",
                    CustomsName = "广州海关",
                    CompanyCode = "COM001",
                    CompanyName = "广州贸易公司",
                    Status = 0,
                    CreateTime = DateTime.Now.AddDays(-10),
                    LastLoginTime = null
                }
            };

            // 过滤数据
            var filteredUsers = mockUsers.AsQueryable();
            
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                filteredUsers = filteredUsers.Where(u => 
                    u.Username.Contains(request.Keyword) ||
                    u.CompanyName.Contains(request.Keyword) ||
                    u.CustomsName.Contains(request.Keyword));
            }

            if (request.Status.HasValue)
            {
                filteredUsers = filteredUsers.Where(u => u.Status == request.Status.Value);
            }

            var totalCount = filteredUsers.Count();
            var pagedUsers = filteredUsers
                .Skip((request.Page - 1) * request.PageSize)
                .Take(request.PageSize)
                .ToList();

            await Task.Delay(100); // 模拟异步操作

            return new PagedResponse<UserListResponse>
            {
                List = pagedUsers,
                Total = totalCount,
                Page = request.Page,
                Size = request.PageSize
            };
        }

        /// <summary>
        /// 验证密码
        /// </summary>
        /// <param name="password">明文密码</param>
        /// <param name="hash">密码哈希</param>
        /// <returns>是否匹配</returns>
        public bool VerifyPassword(string password, string hash)
        {
            return BCrypt.Net.BCrypt.Verify(password, hash);
        }

        /// <summary>
        /// 生成密码哈希
        /// </summary>
        /// <param name="password">明文密码</param>
        /// <returns>密码哈希</returns>
        public string HashPassword(string password)
        {
            return BCrypt.Net.BCrypt.HashPassword(password);
        }

        /// <summary>
        /// 记录登录日志
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="ipAddress">IP地址</param>
        /// <returns>记录结果</returns>
        public async Task<bool> LogLoginAsync(int userId, string ipAddress)
        {
            var sql = @"INSERT INTO SYS_LOGIN_LOGS 
                       (UserId, IpAddress, LoginTime) 
                       VALUES (@UserId, @IpAddress, @LoginTime)";
            
            var parameters = new Dictionary<string, object>
            {
                { "UserId", userId },
                { "IpAddress", ipAddress },
                { "LoginTime", DateTime.Now }
            };

            var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
            return result > 0;
        }

        /// <summary>
        /// 更新最后登录时间
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <returns>更新结果</returns>
        private async Task<bool> UpdateLastLoginTimeAsync(int userId)
        {
            var sql = "UPDATE SYS_USERS SET LastLoginTime = @LastLoginTime WHERE Id = @Id";
            var parameters = new Dictionary<string, object>
            {
                { "Id", userId },
                { "LastLoginTime", DateTime.Now }
            };

            var result = await _databaseHelper.ExecuteNonQueryAsync(sql, parameters);
            return result > 0;
        }

        /// <summary>
        /// 将数据行映射为用户对象
        /// </summary>
        /// <param name="row">数据行</param>
        /// <returns>用户对象</returns>
        private static User MapToUser(DataRow row)
        {
            return new User
            {
                Id = Convert.ToInt32(row["Id"]),
                Username = row["Username"].ToString() ?? string.Empty,
                PasswordHash = row["PasswordHash"].ToString() ?? string.Empty,
                Role = row["Role"].ToString() ?? string.Empty,
                IsActive = Convert.ToBoolean(row["IsActive"]),
                CustomsCode = row["CustomsCode"].ToString() ?? string.Empty,
                CustomsName = row["CustomsName"].ToString() ?? string.Empty,
                CompanyCode = row["CompanyCode"].ToString() ?? string.Empty,
                CompanyName = row["CompanyName"].ToString() ?? string.Empty,
                CreateTime = Convert.ToDateTime(row["CreateTime"]),
                LastLoginTime = row["LastLoginTime"] == DBNull.Value ? null : Convert.ToDateTime(row["LastLoginTime"])
            };
        }

        /// <summary>
        /// 将数据行映射为用户列表响应对象
        /// </summary>
        /// <param name="row">数据行</param>
        /// <returns>用户列表响应对象</returns>
        private static UserListResponse MapToUserListResponse(DataRow row)
        {
            return new UserListResponse
            {
                Id = Convert.ToInt32(row["Id"]),
                Username = row["Username"].ToString() ?? string.Empty,
                Role = row["Role"].ToString() ?? string.Empty,
                CustomsCode = row["CustomsCode"].ToString() ?? string.Empty,
                CustomsName = row["CustomsName"].ToString() ?? string.Empty,
                CompanyCode = row["CompanyCode"].ToString() ?? string.Empty,
                CompanyName = row["CompanyName"].ToString() ?? string.Empty,
                Status = Convert.ToBoolean(row["IsActive"]) ? 1 : 0,
                CreateTime = Convert.ToDateTime(row["CreateTime"]),
                LastLoginTime = row["LastLoginTime"] == DBNull.Value ? null : Convert.ToDateTime(row["LastLoginTime"])
            };
        }
    }
}