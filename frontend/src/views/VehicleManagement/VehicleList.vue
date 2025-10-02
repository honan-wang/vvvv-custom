<template>
  <div class="vehicle-management">
    <!-- 页面标题 -->
    <div class="page-header">
      <h1>车辆管理</h1>
      <el-button 
        type="primary" 
        @click="showAddDialog = true"
        v-if="canManageVehicles"
      >
        <el-icon><Plus /></el-icon>
        新增车辆
      </el-button>
    </div>

    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-form :model="searchForm" inline>
        <el-form-item label="车牌号">
          <el-input 
            v-model="searchForm.vehicleNo" 
            placeholder="请输入车牌号"
            clearable
            style="width: 200px"
          />
        </el-form-item>
        <el-form-item label="车辆类型">
          <el-select 
            v-model="searchForm.vehicleType" 
            placeholder="请选择车辆类型"
            clearable
            style="width: 200px"
          >
            <el-option label="货车" value="货车" />
            <el-option label="客车" value="客车" />
            <el-option label="专用车" value="专用车" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select 
            v-model="searchForm.status" 
            placeholder="请选择状态"
            clearable
            style="width: 200px"
          >
            <el-option label="正常" value="正常" />
            <el-option label="维修" value="维修" />
            <el-option label="停用" value="停用" />
          </el-select>
        </el-form-item>
        <el-form-item label="企业名称" v-if="isAdmin">
          <el-input 
            v-model="searchForm.tradeName" 
            placeholder="请输入企业名称"
            clearable
            style="width: 200px"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="searchVehicles">
            <el-icon><Search /></el-icon>
            搜索
          </el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 车辆列表 -->
    <el-card class="table-card">
      <el-table 
        :data="vehicleList" 
        v-loading="loading"
        row-key="autoId"
        border
        stripe
      >
        <el-table-column type="index" label="序号" width="60" align="center" />
        <el-table-column prop="vehicleNo" label="车牌号" width="120" show-overflow-tooltip />
        <el-table-column prop="vehicleType" label="车辆类型" width="100" />
        <el-table-column prop="brandType" label="品牌型号" width="150" show-overflow-tooltip />
        <el-table-column prop="vehicleWt" label="车辆重量(KG)" width="120" align="right" />
        <el-table-column prop="loadWt" label="载重量(KG)" width="120" align="right" />
        <el-table-column prop="colour" label="颜色" width="80" />
        <el-table-column prop="tradeName" label="经营企业" width="200" show-overflow-tooltip />
        <el-table-column prop="status" label="状态" width="80" align="center">
          <template #default="scope">
            <el-tag 
              :type="getStatusType(scope.row.status)"
              size="small"
            >
              {{ scope.row.status || '未知' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="recordDate" label="备案日期" width="120" align="center">
          <template #default="scope">
            {{ formatDate(scope.row.recordDate) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180" align="center" fixed="right">
          <template #default="scope">
            <el-button 
              type="text" 
              size="small" 
              @click="viewVehicle(scope.row)"
            >
              查看
            </el-button>
            <el-button 
              type="text" 
              size="small" 
              @click="editVehicle(scope.row)"
              v-if="canEditVehicle(scope.row)"
            >
              编辑
            </el-button>
            <el-button 
              type="text" 
              size="small" 
              @click="deleteVehicle(scope.row)"
              style="color: #f56c6c"
              v-if="canEditVehicle(scope.row)"
            >
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination-wrapper">
        <el-pagination
          v-model:current-page="pagination.page"
          v-model:page-size="pagination.size"
          :page-sizes="[10, 20, 50, 100]"
          :small="false"
          :disabled="loading"
          :background="true"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pagination.total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>

    <!-- 新增/编辑车辆对话框 -->
    <VehicleDialog
      v-model:visible="showAddDialog"
      :vehicle-data="currentVehicle"
      :is-edit="isEdit"
      @save-success="handleSaveSuccess"
    />

    <!-- 车辆详情对话框 -->
    <VehicleDetailDialog
      v-model:visible="showDetailDialog"
      :vehicle-data="currentVehicle"
    />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import { vehicleAPI } from '@/api/vehicle'
import VehicleDialog from './components/VehicleDialog.vue'
import VehicleDetailDialog from './components/VehicleDetailDialog.vue'

const userStore = useUserStore()

// 响应式数据
const loading = ref(false)
const vehicleList = ref([])
const showAddDialog = ref(false)
const showDetailDialog = ref(false)
const isEdit = ref(false)
const currentVehicle = ref(null)

// 搜索表单
const searchForm = reactive({
  vehicleNo: '',
  vehicleType: '',
  status: '',
  tradeName: ''
})

// 分页信息
const pagination = reactive({
  page: 1,
  size: 20,
  total: 0
})

// 计算属性
const isAdmin = computed(() => userStore.user?.role === '管理员')
const canManageVehicles = computed(() => 
  userStore.user?.role === '管理员' || userStore.user?.role === '申报员'
)

// 检查是否可以编辑车辆
const canEditVehicle = (vehicle) => {
  if (userStore.user?.role === '管理员') return true
  return vehicle.tradeCode === userStore.user?.tradeCode
}

// 获取状态类型
const getStatusType = (status) => {
  switch (status) {
    case '正常': return 'success'
    case '维修': return 'warning'
    case '停用': return 'danger'
    default: return 'info'
  }
}

// 格式化日期
const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleDateString('zh-CN')
}

// 获取车辆列表
const getVehicleList = async () => {
  try {
    loading.value = true
    
    const params = {
      page: pagination.page,
      size: pagination.size,
      vehicleNo: searchForm.vehicleNo || '',
      vehicleType: searchForm.vehicleType || '',
      status: searchForm.status || '',
      tradeName: searchForm.tradeName || ''
    }

    // 如果不是管理员，只获取可管理的车辆
    const response = isAdmin.value 
      ? await vehicleAPI.getVehicles(params)
      : await vehicleAPI.getManageableVehicles(params)

    if (response.success) {
      vehicleList.value = response.data.list || []
      pagination.total = response.data.total || 0
    } else {
      ElMessage.error(response.message || '获取车辆列表失败')
    }
  } catch (error) {
    console.error('获取车辆列表失败:', error)
    ElMessage.error('获取车辆列表失败')
  } finally {
    loading.value = false
  }
}

// 搜索车辆
const searchVehicles = () => {
  pagination.page = 1
  getVehicleList()
}

// 重置搜索
const resetSearch = () => {
  Object.keys(searchForm).forEach(key => {
    searchForm[key] = ''
  })
  pagination.page = 1
  getVehicleList()
}

// 查看车辆详情
const viewVehicle = (vehicle) => {
  currentVehicle.value = vehicle
  showDetailDialog.value = true
}

// 编辑车辆
const editVehicle = (vehicle) => {
  currentVehicle.value = { ...vehicle }
  isEdit.value = true
  showAddDialog.value = true
}

// 删除车辆
const deleteVehicle = (vehicle) => {
  ElMessageBox.confirm(
    `确定要删除车辆 ${vehicle.vehicleNo} 吗？`,
    '确认删除',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }
  ).then(async () => {
    try {
      const response = await vehicleAPI.deleteVehicle(vehicle.autoId)
      if (response.success) {
        ElMessage.success('删除成功')
        getVehicleList()
      } else {
        ElMessage.error(response.message || '删除失败')
      }
    } catch (error) {
      console.error('删除车辆失败:', error)
      ElMessage.error('删除失败')
    }
  }).catch(() => {
    // 用户取消删除
  })
}

// 处理保存成功
const handleSaveSuccess = () => {
  showAddDialog.value = false
  currentVehicle.value = null
  isEdit.value = false
  getVehicleList()
}

// 处理页大小变化
const handleSizeChange = (size) => {
  pagination.size = size
  pagination.page = 1
  getVehicleList()
}

// 处理页码变化
const handleCurrentChange = (page) => {
  pagination.page = page
  getVehicleList()
}

// 组件挂载后获取数据
onMounted(() => {
  getVehicleList()
})
</script>

<style scoped>
.vehicle-management {
  padding: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.page-header h1 {
  margin: 0;
  font-size: 24px;
  color: #303133;
}

.search-card {
  margin-bottom: 20px;
}

.table-card {
  margin-bottom: 20px;
}

.pagination-wrapper {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

:deep(.el-table th) {
  background-color: #f5f7fa;
}

:deep(.el-form-item) {
  margin-bottom: 0;
}
</style>