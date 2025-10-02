<template>
  <div class="user-management">
    <div class="page-header">
      <h1 class="page-title">用户管理</h1>
      <p class="page-desc">管理系统用户，包括用户的创建、编辑、删除和状态管理</p>
    </div>

    <!-- 查询条件 -->
    <div class="search-section">
      <el-form
        ref="searchFormRef"
        :model="searchForm"
        :inline="true"
        class="search-form"
      >
        <el-form-item label="关键字">
          <el-input
            v-model="searchForm.keyword"
            placeholder="用户名/企业名称/海关关区名称"
            clearable
            style="width: 250px"
          />
        </el-form-item>
        <el-form-item label="状态">
          <el-select
            v-model="searchForm.status"
            placeholder="请选择状态"
            clearable
            style="width: 120px"
          >
            <el-option label="启用" :value="1" />
            <el-option label="禁用" :value="0" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">
            <el-icon><Search /></el-icon>
            查询
          </el-button>
          <el-button @click="handleReset">
            <el-icon><Refresh /></el-icon>
            重置
          </el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- 操作栏 -->
    <div class="action-section">
      <el-button type="primary" @click="handleAdd">
        <el-icon><Plus /></el-icon>
        新增用户
      </el-button>
      <el-button 
        type="danger" 
        :disabled="!selectedUsers.length"
        @click="handleBatchDelete"
      >
        <el-icon><Delete /></el-icon>
        批量删除
      </el-button>
    </div>

    <!-- 用户列表 -->
    <div class="table-section">
      <el-table
        v-loading="loading"
        :data="tableData"
        style="width: 100%"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" />
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="username" label="用户名" width="120" />
        <el-table-column prop="companyCode" label="企业代码" width="120" />
        <el-table-column prop="companyName" label="企业名称" min-width="180" />
        <el-table-column prop="customsCode" label="海关关区代码" width="130" />
        <el-table-column prop="customsName" label="海关关区名称" min-width="150" />
        <el-table-column prop="createTime" label="创建日期" width="120" />
        <el-table-column prop="status" label="状态" width="80">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <div class="action-buttons">
              <el-button type="primary" size="small" @click="handleEdit(row)">
                编辑
              </el-button>
              <el-button 
                :type="row.status === 1 ? 'warning' : 'success'" 
                size="small"
                @click="handleToggleStatus(row)"
              >
                {{ row.status === 1 ? '禁用' : '启用' }}
              </el-button>
              <el-button type="danger" size="small" @click="handleDelete(row)">
                删除
              </el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination-section">
        <el-pagination
          v-model:current-page="pagination.currentPage"
          v-model:page-size="pagination.pageSize"
          :page-sizes="[10, 20, 50, 100]"
          :total="pagination.total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </div>

    <!-- 用户表单对话框 -->
    <UserFormDialog
      v-model:visible="dialogVisible"
      :form-data="currentUser"
      :is-edit="isEdit"
      @success="handleFormSuccess"
    />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import UserFormDialog from './components/UserFormDialog.vue'
import { 
  getUserList, 
  getUserById,
  createUser, 
  updateUser, 
  deleteUser, 
  batchDeleteUsers
} from '@/api/user'

// 响应式数据
const loading = ref(false)
const dialogVisible = ref(false)
const isEdit = ref(false)
const selectedUsers = ref([])

// 搜索表单
const searchForm = reactive({
  keyword: '',
  status: null
})

// 分页
const pagination = reactive({
  currentPage: 1,
  pageSize: 10,
  total: 0
})

// 表格数据
const tableData = ref([])

// 当前编辑的用户
const currentUser = ref({})

// 方法
const fetchUserList = async () => {
  loading.value = true
  try {
    const requestData = {
      page: pagination.currentPage,
      pageSize: pagination.pageSize,
      keyword: searchForm.keyword || undefined,
      status: searchForm.status
    }
    
    const response = await getUserList(requestData)
    
    // 响应拦截器已经处理了success检查，直接使用返回的数据
    if (response && response.success) {
      const result = response.data
      tableData.value = result.list || []
      pagination.total = result.total || 0
      
      // 格式化日期显示
      tableData.value = tableData.value.map(user => ({
        ...user,
        createTime: user.createTime ? new Date(user.createTime).toLocaleDateString() : '-'
      }))
    } else {
      throw new Error(response?.message || '获取用户列表失败')
    }
  } catch (error) {
    console.error('获取用户列表失败:', error)
    ElMessage.error(error.message || '获取用户列表失败')
    tableData.value = []
    pagination.total = 0
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  pagination.currentPage = 1
  fetchUserList()
}

const handleReset = () => {
  Object.assign(searchForm, {
    keyword: '',
    status: null
  })
  pagination.currentPage = 1
  fetchUserList()
}

const handleAdd = () => {
  currentUser.value = {}
  isEdit.value = false
  dialogVisible.value = true
}

const handleEdit = async (row) => {
  try {
    // 获取完整的用户信息
    const response = await getUserById(row.id)
    if (response && response.success) {
      currentUser.value = response.data
      isEdit.value = true
      dialogVisible.value = true
    } else {
      throw new Error(response?.message || '获取用户信息失败')
    }
  } catch (error) {
    console.error('获取用户信息失败:', error)
    ElMessage.error(error.message || '获取用户信息失败')
  }
}

const handleDelete = async (row) => {
  try {
    await ElMessageBox.confirm(
      `确定要删除用户"${row.username}"吗？`,
      '删除确认',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )
    
    const response = await deleteUser(row.id)
    if (response && response.success) {
      ElMessage.success('删除成功')
      fetchUserList()
    } else {
      throw new Error(response?.message || '删除用户失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('删除用户失败:', error)
      ElMessage.error(error.message || '删除用户失败')
    }
  }
}

const handleBatchDelete = async () => {
  try {
    await ElMessageBox.confirm(
      `确定要删除选中的 ${selectedUsers.value.length} 个用户吗？`,
      '批量删除确认',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )
    
    const userIds = selectedUsers.value.map(user => user.id)
    const response = await batchDeleteUsers(userIds)
    
    if (response && response.success) {
      ElMessage.success(response.message || '批量删除成功')
      selectedUsers.value = []
      fetchUserList()
    } else {
      throw new Error(response?.message || '批量删除用户失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('批量删除用户失败:', error)
      ElMessage.error(error.message || '批量删除用户失败')
    }
  }
}

const handleToggleStatus = async (row) => {
  const action = row.status === 1 ? '禁用' : '启用'
  try {
    await ElMessageBox.confirm(
      `确定要${action}用户"${row.username}"吗？`,
      `${action}确认`,
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )
    
    // 获取完整的用户信息确保数据完整性
    const userDetailResponse = await getUserById(row.id)
    if (!userDetailResponse || !userDetailResponse.success) {
      throw new Error('获取用户详细信息失败')
    }
    
    const userDetail = userDetailResponse.data
    
    // 更新用户状态 - 确保所有必需字段都有值
    const updateData = {
      role: userDetail.role || row.role || 'user', // 提供默认角色
      customsCode: userDetail.customsCode || row.customsCode || '',
      customsName: userDetail.customsName || row.customsName || '',
      companyCode: userDetail.companyCode || row.companyCode || '',
      companyName: userDetail.companyName || row.companyName || '',
      status: row.status === 1 ? 0 : 1
    }
    
    console.log('状态切换 - 原始数据:', row)
    console.log('状态切换 - 用户详情:', userDetail)
    console.log('状态切换 - 发送数据:', updateData)
    
    const response = await updateUser(row.id, updateData)
    if (response && response.success) {
      ElMessage.success(`${action}成功`)
      fetchUserList()
    } else {
      throw new Error(response?.message || `${action}用户失败`)
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error(`${action}用户失败:`, error)
      ElMessage.error(error.message || `${action}用户失败`)
    }
  }
}

const handleSelectionChange = (selection) => {
  selectedUsers.value = selection
}

const handleSizeChange = (size) => {
  pagination.pageSize = size
  pagination.currentPage = 1
  fetchUserList()
}

const handleCurrentChange = (page) => {
  pagination.currentPage = page
  fetchUserList()
}

const handleFormSuccess = () => {
  dialogVisible.value = false
  fetchUserList()
}

// 初始化
onMounted(() => {
  fetchUserList()
})
</script>

<style scoped>
.user-management {
  padding: 20px;
  background: #fff;
  border-radius: 4px;
}

.page-header {
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid #e4e7ed;
}

.page-title {
  margin: 0 0 8px 0;
  font-size: 20px;
  font-weight: 600;
  color: #303133;
}

.page-desc {
  margin: 0;
  font-size: 14px;
  color: #909399;
}

.search-section {
  margin-bottom: 16px;
  padding: 16px;
  background: #fafafa;
  border-radius: 4px;
}

.search-form {
  margin: 0;
}

.action-section {
  margin-bottom: 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.table-section {
  border: 1px solid #ebeef5;
  border-radius: 4px;
}

.pagination-section {
  padding: 16px;
  display: flex;
  justify-content: flex-end;
  border-top: 1px solid #ebeef5;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .user-management {
    padding: 16px;
  }
  
  .search-form {
    display: block;
  }
  
  .search-form .el-form-item {
    display: block;
    margin-bottom: 16px;
  }
  
  .action-section {
    flex-direction: column;
    gap: 12px;
    align-items: stretch;
  }
  
  .pagination-section {
    padding: 12px;
  }
  
  :deep(.el-pagination) {
    text-align: center;
  }
}

/* 操作按钮样式 */
.action-buttons {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
  justify-content: flex-start;
}

.action-buttons .el-button {
  margin-left: 0;
  margin-right: 0;
}

/* 移动端操作按钮优化 */
@media (max-width: 768px) {
  .action-buttons {
    flex-direction: column;
    gap: 4px;
  }
  
  .action-buttons .el-button {
    width: 60px;
    padding: 4px 8px;
    font-size: 12px;
  }
}
</style>