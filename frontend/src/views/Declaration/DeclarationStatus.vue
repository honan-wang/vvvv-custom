<template>
  <div class="declaration-status-page">
    <!-- 页面标题 -->
    <div class="page-header">
      <div class="header-left">
        <el-button icon="ArrowLeft" @click="goBack">返回</el-button>
        <div class="header-title">
          <h2>申报状态</h2>
          <p>核放单号：{{ dischargedNo }}</p>
        </div>
      </div>
      <div class="header-right">
        <el-button icon="Refresh" @click="refreshAll">刷新</el-button>
      </div>
    </div>

    <!-- 申报状态组件 -->
    <DeclarationStatus
      :dischargedNo="dischargedNo"
      :autoRefresh="true"
      @statusChange="handleStatusChange"
    />

    <!-- 申报信息详情 -->
    <el-card class="detail-card" shadow="never" v-if="declarationDetail">
      <template #header>
        <span>申报详情</span>
      </template>

      <el-descriptions :column="3" border>
        <el-descriptions-item label="核放单号">
          {{ declarationDetail.dischargedNo }}
        </el-descriptions-item>
        <el-descriptions-item label="申请单号">
          {{ declarationDetail.applicationNo }}
        </el-descriptions-item>
        <el-descriptions-item label="车牌号码">
          {{ declarationDetail.carNo }}
        </el-descriptions-item>
        <el-descriptions-item label="货物名称">
          {{ declarationDetail.goodsNames }}
        </el-descriptions-item>
        <el-descriptions-item label="进出标志">
          <el-tag :type="declarationDetail.ieMark === '进口' ? 'success' : 'warning'">
            {{ declarationDetail.ieMark }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="总重量">
          {{ declarationDetail.totalWeight }} kg
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">
          {{ formatDate(declarationDetail.createTime) }}
        </el-descriptions-item>
        <el-descriptions-item label="申报时间">
          {{ formatDate(declarationDetail.declareTime) }}
        </el-descriptions-item>
        <el-descriptions-item label="过卡时间">
          {{ formatDate(declarationDetail.portTime) }}
        </el-descriptions-item>
      </el-descriptions>
    </el-card>

    <!-- 操作记录 -->
    <el-card class="log-card" shadow="never" v-if="operationLogs.length > 0">
      <template #header>
        <span>操作记录</span>
      </template>

      <el-table :data="operationLogs" stripe>
        <el-table-column prop="action" label="操作" width="120" />
        <el-table-column prop="description" label="描述" />
        <el-table-column prop="createTime" label="时间" width="180">
          <template #default="{ row }">
            {{ formatDate(row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column prop="createUser" label="操作人" width="100" />
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { formatDate } from '@/utils/date'
import { getUnifiedDeclarationDetail } from '@/api/unifiedDeclaration'
import DeclarationStatus from '@/components/DeclarationStatus.vue'

const route = useRoute()
const router = useRouter()

// 响应式数据
const dischargedNo = ref(route.params.dischargedNo)
const declarationDetail = ref(null)
const operationLogs = ref([])

// 方法
const goBack = () => {
  router.go(-1)
}

const refreshAll = () => {
  fetchDeclarationDetail()
  // DeclarationStatus组件会自动刷新
}

const handleStatusChange = (statusInfo) => {
  console.log('状态变化:', statusInfo)
  // 可以在这里处理状态变化的逻辑
}

const fetchDeclarationDetail = async () => {
  try {
    // 这里需要实现获取申报详情的API
    // const response = await getUnifiedDeclarationDetail(dischargedNo.value)
    // if (response.success) {
    //   declarationDetail.value = response.data
    // }

    // 模拟数据
    declarationDetail.value = {
      dischargedNo: dischargedNo.value,
      applicationNo: 'APP2024001001',
      carNo: '粤A12345',
      goodsNames: '电子产品，机械配件',
      ieMark: '进口',
      totalWeight: 15000,
      createTime: '2024-01-15 10:30:00',
      declareTime: '2024-01-15 14:20:00',
      portTime: null
    }
  } catch (error) {
    console.error('获取申报详情失败:', error)
    ElMessage.error('获取申报详情失败')
  }
}

const fetchOperationLogs = async () => {
  try {
    // 这里需要实现获取操作记录的API
    // const response = await getDeclarationLogs(dischargedNo.value)
    // if (response.success) {
    //   operationLogs.value = response.data
    // }

    // 模拟数据
    operationLogs.value = [
      {
        action: '创建',
        description: '创建申报单据',
        createTime: '2024-01-15 10:30:00',
        createUser: '张三'
      },
      {
        action: '保存',
        description: '保存申报数据',
        createTime: '2024-01-15 12:15:00',
        createUser: '张三'
      }
    ]
  } catch (error) {
    console.error('获取操作记录失败:', error)
  }
}

// 组件挂载时获取数据
onMounted(() => {
  fetchDeclarationDetail()
  fetchOperationLogs()
})
</script>

<style scoped>
.declaration-status-page {
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

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
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

.detail-card,
.log-card {
  margin-top: 20px;
  background: white;
  border-radius: 8px;
}

:deep(.el-card__body) {
  padding: 24px;
}

:deep(.el-descriptions__label) {
  font-weight: 600;
  color: #303133;
}

:deep(.el-table) {
  border-radius: 8px;
}
</style>