using CustomsDeclaration.API.Services;

namespace CustomsDeclaration.API.BackgroundServices
{
    /// <summary>
    /// 申报状态监控后台服务
    /// </summary>
    public class DeclarationStatusMonitorService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;
        private readonly ILogger<DeclarationStatusMonitorService> _logger;
        private readonly TimeSpan _checkInterval = TimeSpan.FromMinutes(1); // 每分钟检查一次

        public DeclarationStatusMonitorService(
            IServiceProvider serviceProvider,
            ILogger<DeclarationStatusMonitorService> logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("申报状态监控服务已启动");

            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    await ProcessDeclarationStatusChanges();
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "处理申报状态变化时发生异常");
                }

                // 等待下一次检查
                await Task.Delay(_checkInterval, stoppingToken);
            }

            _logger.LogInformation("申报状态监控服务已停止");
        }

        /// <summary>
        /// 处理申报状态变化
        /// </summary>
        private async Task ProcessDeclarationStatusChanges()
        {
            using var scope = _serviceProvider.CreateScope();
            var twoStepService = scope.ServiceProvider.GetRequiredService<ITwoStepDeclarationService>();

            await twoStepService.ProcessStatusChangesAsync();
        }

        public override async Task StopAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("正在停止申报状态监控服务...");
            await base.StopAsync(stoppingToken);
        }
    }
}