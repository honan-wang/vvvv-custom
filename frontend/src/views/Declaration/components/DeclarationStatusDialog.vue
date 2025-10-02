<template>
  <el-dialog
    v-model="visible"
    title="申报状态"
    width="90%"
    :close-on-click-modal="false"
    :destroy-on-close="true"
    @close="handleClose"
  >
    <template #header>
      <div class="dialog-header">
        <span class="header-title">申报状态</span>
        <span class="header-subtitle">核放单号：{{ dischargedNo }}</span>
      </div>
    </template>

    <div v-loading="loading" class="status-container">
      <!-- 申报状态组件 -->
      <DeclarationStatus
        v-if="dischargedNo"
        :dischargedNo="dischargedNo"
        :autoRefresh="visible"
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
          <el-descriptions-item label="货物名称" :span="3">
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
          <el-descriptions-item label="核放单状态">
            <el-tag :type="getStatusType(declarationDetail.dischargedStatus)">
              {{ declarationDetail.dischargedStatus }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="申请单状态" :span="3">
            <el-tag :type="getStatusType(declarationDetail.applicationStatus)">
              {{ declarationDetail.applicationStatus }}
            </el-tag>
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
    </div>

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="handleRefresh" icon="Refresh">刷新</el-button>
        <el-button type="primary" @click="handleClose">关闭</el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { ElMessage } from 'element-plus'
import { formatDate } from '@/utils/date'
import { getUnifiedDeclarationDetail } from '@/api/unifiedDeclaration'
import DeclarationStatus from '@/components/DeclarationStatus.vue'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  dischargedNo: {
    type: String,
    default: ''
  }
})

const emit = defineEmits(['update:modelValue', 'refresh'])

const visible = computed({
  get() {
    return props.modelValue
  },
  set(value) {
    emit('update:modelValue', value)
  }
})

const loading = ref(false)
const declarationDetail = ref(null)

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

// 加载详情数据
const fetchDeclarationDetail = async () => {
  if (!props.dischargedNo) return

  loading.value = true
  try {
    const response = await getUnifiedDeclarationDetail(props.dischargedNo)
    if (response.success) {
      declarationDetail.value = response.data.head || {}
    } else {
      ElMessage.error(response.message || '获取申报详情失败')
    }
  } catch (error) {
    console.error('获取申报详情失败:', error)
    ElMessage.error('获取申报详情失败')
  } finally {
    loading.value = false
  }
}

// 监听弹窗打开
watch(() => props.modelValue, (newVal) => {
  if (newVal && props.dischargedNo) {
    fetchDeclarationDetail()
  }
})

// 关闭弹窗
const handleClose = () => {
  visible.value = false
}

// 刷新
const handleRefresh = () => {
  fetchDeclarationDetail()
  emit('refresh')
}

// 状态变化回调
const handleStatusChange = (statusInfo) => {
  console.log('状态变化:', statusInfo)
  // 状态变化时刷新详情
  fetchDeclarationDetail()
}
</script>

<style scoped>
.dialog-header {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.header-title {
  font-size: 18px;
  font-weight: 600;
  color: #303133;
}

.header-subtitle {
  font-size: 14px;
  color: #909399;
}

.status-container {
  padding: 10px 0;
}

.detail-card {
  margin-top: 20px;
  background: white;
  border-radius: 8px;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

:deep(.el-card__header) {
  padding: 15px 20px;
  border-bottom: 1px solid #ebeef5;
}

:deep(.el-card__body) {
  padding: 20px;
}

:deep(.el-descriptions__label) {
  width: 120px;
  font-weight: 500;
}
</style>
