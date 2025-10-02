<template>
  <div class="declaration-container">
    <!-- 页面标题和操作按钮 -->
    <div class="page-header">
      <div class="header-title">
        <h2>单一申报</h2>
        <p>核放单数据录入与管理</p>
      </div>
      <div class="header-actions">
        <el-button type="success" icon="Plus" @click="handleCreateImport">
          新建进口申报单
        </el-button>
        <el-button type="warning" icon="Plus" @click="handleCreateExport">
          新建出口申报单
        </el-button>
        <el-button icon="Download" @click="handleExport">
          导出数据
        </el-button>
      </div>
    </div>
    
    <!-- 查询条件 -->
    <el-card class="search-card" shadow="never">
      <el-form 
        ref="searchFormRef"
        :model="searchForm" 
        :inline="true" 
        label-width="100px"
        class="search-form"
      >
        <el-form-item label="核放单号">
          <el-input
            v-model="searchForm.dischargedNo"
            placeholder="请输入核放单号"
            clearable
          />
        </el-form-item>
        <el-form-item label="申请单号">
          <el-input
            v-model="searchForm.applicationNo"
            placeholder="请输入申请单号"
            clearable
          />
        </el-form-item>
        <el-form-item label="车牌号码">
          <el-input
            v-model="searchForm.carNo"
            placeholder="请输入车牌号码"
            clearable
          />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="searchForm.status" placeholder="请选择状态" clearable style="width: 120px;">
            <el-option label="全部" value="" />
            <el-option label="草稿" value="draft" />
            <el-option label="已提交" value="submitted" />
            <el-option label="审核中" value="reviewing" />
            <el-option label="已通过" value="approved" />
            <el-option label="已退回" value="rejected" />
          </el-select>
        </el-form-item>
        <el-form-item label="申报日期">
          <el-date-picker
            v-model="dateRange"
            type="datetimerange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            format="YYYY-MM-DD HH:mm:ss"
            value-format="YYYY-MM-DDTHH:mm:ss"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleSearch">
            查询
          </el-button>
          <el-button icon="Refresh" @click="handleReset">
            重置
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>
    
    <!-- 数据表格 -->
    <el-card class="table-card" shadow="never">
      <el-table 
        v-loading="loading"
        :data="tableData" 
        stripe 
        border
        :header-cell-style="{ backgroundColor: '#f5f7fa', color: '#606266' }"
        @sort-change="handleSortChange"
      >
        <el-table-column type="index" label="序号" width="60" align="center" fixed="left" />

        <el-table-column
          prop="dischargedNo"
          label="核放单号"
          width="140"
          sortable="custom"
          fixed="left"
        >
          <template #default="{ row }">
            <el-link
              type="primary"
              @click="handleView(row)"
              :underline="false"
            >
              {{ row.dischargedNo }}
            </el-link>
          </template>
        </el-table-column>

        <el-table-column prop="applicationNo" label="申请单号" width="140" fixed="left" />
        <el-table-column prop="carNo" label="车辆号码" width="120" fixed="left" />
        <el-table-column prop="itemNos" label="项号" width="80">
          <template #default="{ row }">
            <el-tooltip :content="row.itemNos" placement="top" :disabled="!row.itemNos || row.itemNos.length <= 8">
              <span>
                {{ row.itemNos && row.itemNos.length > 8 ? row.itemNos.substring(0, 8) + '...' : row.itemNos }}
              </span>
            </el-tooltip>
          </template>
        </el-table-column>

        <el-table-column prop="goodsNames" label="货物品名" width="150">
          <template #default="{ row }">
            <el-tooltip :content="row.goodsNames" placement="top" :disabled="!row.goodsNames || row.goodsNames.length <= 20">
              <span>
                {{ row.goodsNames && row.goodsNames.length > 20 ? row.goodsNames.substring(0, 20) + '...' : row.goodsNames }}
              </span>
            </el-tooltip>
          </template>
        </el-table-column>

        <el-table-column prop="ieMark" label="进出标志" width="90" align="center">
          <template #default="{ row }">
            <el-tag :type="row.ieMark === '进口' ? 'success' : 'warning'">
              {{ row.ieMark }}
            </el-tag>
          </template>
        </el-table-column>

        <el-table-column prop="createTime" label="录入时间" width="160" sortable="custom">
          <template #default="{ row }">
            {{ formatDate(row.createTime) }}
          </template>
        </el-table-column>

        <el-table-column prop="declareTime" label="申报时间" width="160" sortable="custom">
          <template #default="{ row }">
            {{ formatDate(row.declareTime) }}
          </template>
        </el-table-column>

        <el-table-column prop="dischargedStatus" label="核放单状态" width="120" align="center">
          <template #default="{ row }">
            <el-link
              type="primary"
              @click="handleViewDeclarationStatus(row)"
              :underline="false"
            >
              <el-tag :type="getStatusType(row.dischargedStatus)">
                {{ row.dischargedStatus }}
              </el-tag>
            </el-link>
          </template>
        </el-table-column>

        <el-table-column prop="applicationStatus" label="申请单状态" width="120" align="center">
          <template #default="{ row }">
            <el-tag :type="getStatusType(row.applicationStatus)">
              {{ row.applicationStatus }}
            </el-tag>
          </template>
        </el-table-column>

        <el-table-column prop="portTime" label="过卡时间" width="160">
          <template #default="{ row }">
            {{ formatDate(row.portTime) }}
          </template>
        </el-table-column>

        <el-table-column prop="totalWeight" label="总重量" width="100" align="right">
          <template #default="{ row }">
            {{ row.totalWeight }} kg
          </template>
        </el-table-column>

        <el-table-column prop="carWeight" label="车辆自重" width="100" align="right">
          <template #default="{ row }">
            {{ row.carWeight }} kg
          </template>
        </el-table-column>

        <el-table-column prop="goodsWeight" label="货物重量" width="100" align="right">
          <template #default="{ row }">
            {{ row.goodsWeight }} kg
          </template>
        </el-table-column>

        <el-table-column prop="areaName" label="区域标志" width="120" />
        
        <el-table-column label="操作" width="250" align="center" fixed="right">
          <template #default="{ row }">
            <!-- 申报相关按钮 -->
            <el-button
              type="success"
              size="small"
              link
              icon="Upload"
              @click="handleStartDeclaration(row)"
              :loading="row.declaring"
              :disabled="!canStartDeclaration(row)"
            >
              开始申报
            </el-button>
            <el-button
              v-if="canResubmitDeclaration(row)"
              type="warning"
              size="small"
              link
              icon="RefreshRight"
              @click="handleResubmitDeclaration(row)"
              :loading="row.declaring"
            >
              重新申报
            </el-button>
            <el-button
              v-else-if="isDeclarationPending(row)"
              type="info"
              size="small"
              link
              icon="Clock"
              @click="handleViewStatus(row)"
              :loading="row.checkingStatus"
            >
              查看状态
            </el-button>
            <el-button
              v-else-if="isDeclarationCompleted(row)"
              type="success"
              size="small"
              link
              icon="SuccessFilled"
              @click="handleViewStatus(row)"
            >
              已完成
            </el-button>

            <!-- 编辑按钮 -->
            <el-button
              type="primary"
              size="small"
              link
              icon="Edit"
              @click="handleEdit(row)"
              :disabled="!canEdit(row)"
            >
              编辑
            </el-button>
            <el-popconfirm
              title="确定要删除这条申报记录吗？删除后核放单和关联的申请单数据将一并删除，此操作不可恢复！"
              confirm-button-text="确定删除"
              cancel-button-text="取消"
              confirm-button-type="danger"
              icon="warning"
              icon-color="orange"
              width="300"
              @confirm="handleDelete(row)"
            >
              <template #reference>
                <el-button
                  type="danger"
                  size="small"
                  link
                  icon="Delete"
                  :disabled="!canDelete(row)"
                >
                  删除
                </el-button>
              </template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
      
      <!-- 分页组件 -->
      <div class="pagination-container">
        <el-pagination
          v-model:current-page="pagination.current"
          v-model:page-size="pagination.size"
          :page-sizes="[10, 20, 50, 100]"
          :total="pagination.total"
          layout="total, sizes, prev, pager, next, jumper"
          :prev-text="'上一页'"
          :next-text="'下一页'"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>
    
    <!-- 新建申报单弹窗 -->
    <CreateDialog
      v-model="createDialogVisible"
      :type="createType"
      @success="handleCreateSuccess"
      @close="handleCloseCreateDialog"
    />

    <!-- 查看详情弹窗 -->
    <ViewDetailDialog
      v-model="detailDialogVisible"
      :dischargedNo="currentDischargedNo"
      @edit="handleEditFromDetail"
    />

    <!-- 申报状态弹窗 -->
    <DeclarationStatusDialog
      v-model="statusDialogVisible"
      :dischargedNo="currentDischargedNo"
      @refresh="fetchTableData"
    />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed, watch } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { formatDate } from '@/utils/date'
import { getUnifiedDeclarationList, deleteUnifiedDeclaration } from '@/api/unifiedDeclaration'
import { startDeclaration, resubmitDeclaration, getDeclarationStatus } from '@/api/twoStepDeclaration'
import CreateDialog from './components/CreateDialog.vue'
import ViewDetailDialog from './components/ViewDetailDialog.vue'
import DeclarationStatusDialog from './components/DeclarationStatusDialog.vue'

const router = useRouter()

// 响应式数据
const loading = ref(false)
const searchFormRef = ref(null)
const tableData = ref([])

// 搜索表单
const searchForm = reactive({
  dischargedNo: '',
  applicationNo: '',
  carNo: '',
  status: '', // 默认为全部
  startDate: '',
  endDate: ''
})

// 日期范围
const dateRange = ref([])

// 分页数据
const pagination = reactive({
  current: 1,
  size: 20,
  total: 0
})

// 排序参数
const sortParams = reactive({
  field: '',
  order: ''
})

// 计算属性
const searchParams = computed(() => {
  const params = { ...searchForm }
  if (dateRange.value && dateRange.value.length === 2) {
    params.startDate = dateRange.value[0]
    params.endDate = dateRange.value[1]
  }
  return params
})

// 监听日期范围变化
watch(dateRange, (newVal) => {
  if (newVal && newVal.length === 2) {
    searchForm.startDate = newVal[0]
    searchForm.endDate = newVal[1]
  } else {
    searchForm.startDate = ''
    searchForm.endDate = ''
  }
})

// 获取表格数据
const fetchTableData = async () => {
  // 防止重复调用 - 如果已经在加载中，直接返回
  if (loading.value) {
    console.log('fetchTableData called but already loading, ignoring duplicate call')
    return
  }

  console.log('fetchTableData called with stack:', new Error().stack)
  loading.value = true
  try {
    const params = {
      ...searchParams.value,
      page: pagination.current,
      size: pagination.size
    }

    // 处理空字符串的日期字段，转换为null
    if (params.startDate === '') {
      params.startDate = null
    }
    if (params.endDate === '') {
      params.endDate = null
    }

    const response = await getUnifiedDeclarationList(params)
    if (response.success) {
      tableData.value = response.data.items || []
      pagination.total = response.data.total || 0
    } else {
      ElMessage.error(response.message || '获取数据失败')
    }
  } catch (error) {
    console.error('获取数据失败:', error)
    ElMessage.error('获取数据失败')
  } finally {
    loading.value = false
  }
}

// 处理搜索
const handleSearch = () => {
  pagination.current = 1
  fetchTableData()
}

// 处理重置
const handleReset = () => {
  searchFormRef.value?.resetFields()
  Object.keys(searchForm).forEach(key => {
    searchForm[key] = ''
  })
  dateRange.value = []
  pagination.current = 1
  fetchTableData()
}

// 处理排序
const handleSortChange = ({ prop, order }) => {
  sortParams.field = prop || ''
  sortParams.order = order === 'ascending' ? 'asc' : order === 'descending' ? 'desc' : ''
  fetchTableData()
}

// 处理分页大小变化
const handleSizeChange = (size) => {
  pagination.size = size
  pagination.current = 1
  fetchTableData()
}

// 处理页码变化
const handleCurrentChange = (page) => {
  pagination.current = page
  fetchTableData()
}

// 弹窗相关状态
const createDialogVisible = ref(false)
const createType = ref('import') // 'import' 或 'export'
const detailDialogVisible = ref(false)
const statusDialogVisible = ref(false)
const currentDischargedNo = ref('')

// 处理新建进口申报单
const handleCreateImport = () => {
  createType.value = 'import'
  createDialogVisible.value = true
}

// 处理新建出口申报单
const handleCreateExport = () => {
  createType.value = 'export'
  createDialogVisible.value = true
}

// 关闭新建弹窗
const handleCloseCreateDialog = () => {
  createDialogVisible.value = false
}

// 新建成功后的回调
const handleCreateSuccess = () => {
  createDialogVisible.value = false
  fetchTableData() // 刷新列表
  ElMessage.success('申报单创建成功')
}

// 处理查看详情
const handleView = (row) => {
  // 打开详情弹窗
  currentDischargedNo.value = row.dischargedNo
  detailDialogVisible.value = true
}

// 处理查看申报状态
const handleViewDeclarationStatus = (row) => {
  // 打开申报状态弹窗
  currentDischargedNo.value = row.dischargedNo
  statusDialogVisible.value = true
}

// 处理编辑
const handleEdit = (row) => {
  // 跳转到编辑页面
  router.push(`/declaration/edit/${row.dischargedNo}`)
}

// 处理复制
const handleCopy = async (row) => {
  try {
    // 跳转到新建页面并传递复制的数据
    router.push({
      path: '/declaration/create',
      query: { copy: row.dischargedNo }
    })
    ElMessage.success('已复制，请修改后保存')
  } catch (error) {
    console.error('复制失败:', error)
    ElMessage.error('复制失败')
  }
}

// 处理删除
const handleDelete = async (row) => {
  try {
    const response = await deleteUnifiedDeclaration(row.dischargedNo)
    if (response.success) {
      ElMessage.success('删除成功')
      fetchTableData()
    } else {
      ElMessage.error(response.message || '删除失败')
    }
  } catch (error) {
    console.error('删除失败:', error)
    ElMessage.error('删除失败')
  }
}

// 处理导出
const handleExport = () => {
  ElMessage.info('导出功能开发中...')
}

// 获取状态类型
const getStatusType = (status) => {
  if (!status) return 'info'

  if (status.includes('暂存') || status.includes('草稿')) return 'info'
  if (status.includes('申报') || status.includes('提交')) return 'warning'
  if (status.includes('审核') || status.includes('处理中')) return 'primary'
  if (status.includes('通过') || status.includes('成功') || status.includes('至卡口')) return 'success'
  if (status.includes('退回') || status.includes('失败')) return 'danger'

  return 'info'
}

// 判断是否可编辑
const canEdit = (row) => {
  const dischargedStatus = row.dischargedStatus || ''
  const applicationStatus = row.applicationStatus || ''

  // 核放单状态为初始状态，且申请单状态不是已审核或已提交
  const dischargedEditable = dischargedStatus.includes('暂存') ||
                              dischargedStatus.includes('草稿') ||
                              dischargedStatus.includes('预录入') ||
                              dischargedStatus === ''

  const applicationEditable = applicationStatus === '' ||
                               applicationStatus.includes('暂存') ||
                               applicationStatus.includes('退回')

  return dischargedEditable && applicationEditable
}

// 判断是否可删除（核放单状态为预录入时可以删除）
const canDelete = (row) => {
  if (!row || !row.dischargedStatus) return false
  // 核放单状态为预录入时可以删除
  return row.dischargedStatus.includes('预录入') ||
         row.dischargedStatus.includes('暂存') ||
         row.dischargedStatus.includes('草稿')
}

// 申报状态判断方法
const canStartDeclaration = (row) => {
  // 必须同时满足：核放单状态和申请单状态都是初始状态
  const dischargedStatus = row.dischargedStatus || ''
  const applicationStatus = row.applicationStatus || ''

  // 核放单状态必须是初始状态
  const dischargedIsInitial = dischargedStatus.includes('草稿') ||
                               dischargedStatus.includes('暂存') ||
                               dischargedStatus.includes('预录入') ||
                               dischargedStatus === ''

  // 申请单状态必须是初始状态(空或暂存)
  const applicationIsInitial = applicationStatus.includes('暂存') ||
                                applicationStatus === ''

  return dischargedIsInitial && applicationIsInitial
}

const canResubmitDeclaration = (row) => {
  const applicationStatus = row.applicationStatus || ''
  const dischargedStatus = row.dischargedStatus || ''

  // 申请单或核放单任一被退回都可以重新申报
  return applicationStatus.includes('退回') ||
         applicationStatus.includes('被退回') ||
         dischargedStatus.includes('退回') ||
         dischargedStatus.includes('被退回')
}

const isDeclarationPending = (row) => {
  const applicationStatus = row.applicationStatus || ''
  const dischargedStatus = row.dischargedStatus || ''

  // 申请单或核放单任一在处理中状态
  return applicationStatus.includes('已提交') ||
         applicationStatus.includes('申报中') ||
         applicationStatus.includes('审核中') ||
         applicationStatus.includes('处理中') ||
         dischargedStatus.includes('已提交') ||
         dischargedStatus.includes('申报中') ||
         dischargedStatus.includes('审核中') ||
         dischargedStatus.includes('处理中')
}

const isDeclarationCompleted = (row) => {
  const dischargedStatus = row.dischargedStatus || ''

  // 只有核放单状态为完成才算真正完成
  return dischargedStatus.includes('已完成') ||
         dischargedStatus.includes('审核通过') ||
         dischargedStatus.includes('申报完成') ||
         dischargedStatus.includes('至卡口')
}

// 申报操作方法
const handleStartDeclaration = async (row) => {
  try {
    // 检查申请单号是否存在
    if (!row.applicationNo) {
      ElMessage.error('申请单号不存在，无法申报')
      return
    }

    // 设置申报中状态
    row.declaring = true

    ElMessage.info('正在提交申请单...')

    const response = await startDeclaration(row.applicationNo)

    if (response.success) {
      ElMessage.success('申请单提交成功，等待海关审批')
      // 刷新数据
      await fetchTableData()
    } else {
      ElMessage.error(response.message || '申报失败')
    }
  } catch (error) {
    console.error('申报失败:', error)
    ElMessage.error('申报失败：' + (error.message || '网络错误'))
  } finally {
    row.declaring = false
  }
}

const handleResubmitDeclaration = async (row) => {
  try {
    // 确认重新申报
    await ElMessageBox.confirm(
      '确定要重新申报吗？系统将根据当前状态自动选择申报步骤。',
      '确认重新申报',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )

    row.declaring = true
    ElMessage.info('正在重新申报...')

    // 优先使用申请单号,如果没有则使用核放单号
    const businessNo = row.applicationNo || row.dischargedNo
    const response = await resubmitDeclaration(businessNo)

    if (response.success) {
      ElMessage.success('重新申报成功')
      // 刷新数据
      await fetchTableData()
    } else {
      ElMessage.error(response.message || '重新申报失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('重新申报失败:', error)
      ElMessage.error('重新申报失败：' + (error.message || '网络错误'))
    }
  } finally {
    row.declaring = false
  }
}

const handleViewStatus = (row) => {
  // 打开详情弹窗，而不是跳转页面
  currentDischargedNo.value = row.dischargedNo
  detailDialogVisible.value = true
}

// 从详情页编辑
const handleEditFromDetail = (row) => {
  router.push(`/declaration/edit/${row.dischargedNo}`)
}

const handleCheckStatus = async (row) => {
  try {
    row.checkingStatus = true

    const response = await getDeclarationStatus(row.dischargedNo)

    if (response.success) {
      const statusInfo = response.data
      ElMessage.success(`当前状态：${statusInfo.statusDescription}`)

      // 如果状态有变化，刷新列表
      if (statusInfo.status !== row.status) {
        await fetchTableData()
      }
    } else {
      ElMessage.error(response.message || '查询状态失败')
    }
  } catch (error) {
    console.error('查询状态失败:', error)
    ElMessage.error('查询状态失败：' + (error.message || '网络错误'))
  } finally {
    row.checkingStatus = false
  }
}

// 组件挂载时获取数据
onMounted(() => {
  fetchTableData()
})
</script>

<style scoped>
.declaration-container {
  padding: 20px;
  min-height: 100vh;
  background-color: #f5f7fa;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 0 4px;
}

.header-title h2 {
  margin: 0 0 4px 0;
  font-size: 24px;
  font-weight: 600;
  color: #303133;
}

.header-title p {
  margin: 0;
  color: #909399;
  font-size: 14px;
}

.header-actions {
  display: flex;
  gap: 12px;
}

.search-card {
  margin-bottom: 20px;
}

.search-form {
  margin-bottom: -18px;
}

.table-card {
  background: white;
  border-radius: 8px;
}

.pagination-container {
  display: flex;
  justify-content: center;
  margin-top: 20px;
  padding: 20px 0;
}

:deep(.el-table) {
  border-radius: 8px;
}

:deep(.el-card__body) {
  padding: 20px;
}

:deep(.el-form-item) {
  margin-bottom: 18px;
}
</style>