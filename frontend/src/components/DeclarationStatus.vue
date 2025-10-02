<template>
  <div class="declaration-status">
    <!-- 进度条 -->
    <el-steps :active="activeStep" align-center class="status-steps">
      <el-step
        title="数据准备"
        description="完善申报数据"
        icon="Document"
      />
      <el-step
        title="申请单申报"
        :description="applicationStepDesc"
        :icon="applicationStepIcon"
        :status="applicationStepStatus"
      />
      <el-step
        title="核放单申报"
        :description="dischargeStepDesc"
        :icon="dischargeStepIcon"
        :status="dischargeStepStatus"
      />
      <el-step
        title="申报完成"
        description="审批通过"
        icon="SuccessFilled"
      />
    </el-steps>

    <!-- 状态详情 -->
    <el-card class="status-detail" shadow="never">
      <div class="status-info">
        <div class="status-badge">
          <el-tag :type="statusTagType" size="large">
            {{ statusDescription }}
          </el-tag>
        </div>

        <div class="status-actions">
          <!-- 申报按钮 -->
          <el-button
            v-if="canStartDeclaration"
            type="primary"
            size="large"
            icon="Upload"
            :loading="submitting"
            @click="handleStartDeclaration"
          >
            开始申报
          </el-button>

          <!-- 重新申报按钮 -->
          <el-button
            v-if="canResubmit"
            type="warning"
            size="large"
            icon="RefreshRight"
            :loading="submitting"
            @click="handleResubmit"
          >
            重新申报
          </el-button>

          <!-- 刷新状态按钮 -->
          <el-button
            v-if="isPending"
            type="primary"
            size="large"
            icon="Refresh"
            :loading="refreshing"
            @click="refreshStatus"
            plain
          >
            刷新状态
          </el-button>
        </div>
      </div>

      <!-- 时间线 -->
      <div class="timeline-section" v-if="showTimeline">
        <h4>申报进度</h4>
        <el-timeline>
          <el-timeline-item
            v-for="item in timeline"
            :key="item.id"
            :timestamp="item.timestamp"
            :type="item.type"
          >
            {{ item.content }}
          </el-timeline-item>
        </el-timeline>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, watch } from 'vue'
import { ElMessage } from 'element-plus'
import { startDeclaration, resubmitDeclaration, getDeclarationStatus } from '@/api/twoStepDeclaration'

const props = defineProps({
  dischargedNo: {
    type: String,
    required: false
  },
  applicationNo: {
    type: String,
    required: false
  },
  autoRefresh: {
    type: Boolean,
    default: true
  }
})

const emit = defineEmits(['statusChange'])

// 响应式数据
const submitting = ref(false)
const refreshing = ref(false)
const currentStatus = ref(null)
const statusInfo = reactive({
  status: 'Draft',
  statusDescription: '草稿',
  canProceedToNext: false,
  isPending: false,
  isCompleted: false,
  isRejected: false
})

// 时间线数据
const timeline = ref([])
const showTimeline = ref(false)

// 自动刷新定时器
let refreshTimer = null

// 计算属性
const activeStep = computed(() => {
  switch (statusInfo.status) {
    case 'Draft':
      return 0
    case 'ApplicationSubmitted':
      return 1
    case 'ApplicationApproved':
      return 2
    case 'DischargeSubmitted':
      return 2
    case 'DischargeApproved':
      return 3
    default:
      return 0
  }
})

const statusTagType = computed(() => {
  if (statusInfo.isCompleted) return 'success'
  if (statusInfo.isRejected) return 'danger'
  if (statusInfo.isPending) return 'warning'
  return 'info'
})

const canStartDeclaration = computed(() => {
  return statusInfo.status === 'Draft' && statusInfo.canProceedToNext
})

const canResubmit = computed(() => {
  return statusInfo.isRejected && statusInfo.canProceedToNext
})

const isPending = computed(() => {
  return statusInfo.isPending
})

const statusDescription = computed(() => {
  return statusInfo.statusDescription
})

// 申请单步骤状态
const applicationStepDesc = computed(() => {
  switch (statusInfo.status) {
    case 'ApplicationSubmitted':
      return '等待审批中...'
    case 'ApplicationApproved':
      return '审批通过'
    case 'ApplicationRejected':
      return '被退回'
    default:
      return '等待提交'
  }
})

const applicationStepIcon = computed(() => {
  switch (statusInfo.status) {
    case 'ApplicationSubmitted':
      return 'Loading'
    case 'ApplicationApproved':
      return 'SuccessFilled'
    case 'ApplicationRejected':
      return 'CircleClose'
    default:
      return 'Document'
  }
})

const applicationStepStatus = computed(() => {
  switch (statusInfo.status) {
    case 'ApplicationSubmitted':
      return 'process'
    case 'ApplicationApproved':
      return 'success'
    case 'ApplicationRejected':
      return 'error'
    default:
      return 'wait'
  }
})

// 核放单步骤状态
const dischargeStepDesc = computed(() => {
  switch (statusInfo.status) {
    case 'DischargeSubmitted':
      return '等待审批中...'
    case 'DischargeApproved':
      return '审批通过'
    case 'DischargeRejected':
      return '被退回'
    default:
      return '等待提交'
  }
})

const dischargeStepIcon = computed(() => {
  switch (statusInfo.status) {
    case 'DischargeSubmitted':
      return 'Loading'
    case 'DischargeApproved':
      return 'SuccessFilled'
    case 'DischargeRejected':
      return 'CircleClose'
    default:
      return 'Document'
  }
})

const dischargeStepStatus = computed(() => {
  switch (statusInfo.status) {
    case 'DischargeSubmitted':
      return 'process'
    case 'DischargeApproved':
      return 'success'
    case 'DischargeRejected':
      return 'error'
    default:
      return 'wait'
  }
})

// 方法
const handleStartDeclaration = async () => {
  submitting.value = true
  try {
    // 优先使用申请单号
    const businessNo = props.applicationNo || props.dischargedNo
    if (!businessNo) {
      ElMessage.error('申请单号或核放单号不存在')
      return
    }

    const response = await startDeclaration(businessNo)
    if (response.success) {
      ElMessage.success('申报已提交，等待海关审批')
      await refreshStatus()
      updateTimeline('开始申报', '申请单已提交，等待海关审批')
    } else {
      ElMessage.error(response.message || '申报失败')
    }
  } catch (error) {
    console.error('申报失败:', error)
    ElMessage.error('申报失败')
  } finally {
    submitting.value = false
  }
}

const handleResubmit = async () => {
  submitting.value = true
  try {
    // 优先使用申请单号,如果没有则使用核放单号
    const businessNo = props.applicationNo || props.dischargedNo
    if (!businessNo) {
      ElMessage.error('申请单号或核放单号不存在')
      return
    }

    const response = await resubmitDeclaration(businessNo)
    if (response.success) {
      ElMessage.success('重新申报已提交')
      await refreshStatus()
      updateTimeline('重新申报', '已重新提交申报')
    } else {
      ElMessage.error(response.message || '重新申报失败')
    }
  } catch (error) {
    console.error('重新申报失败:', error)
    ElMessage.error('重新申报失败')
  } finally {
    submitting.value = false
  }
}

const refreshStatus = async () => {
  refreshing.value = true
  try {
    const response = await getDeclarationStatus(props.dischargedNo)
    if (response.success) {
      const oldStatus = statusInfo.status
      Object.assign(statusInfo, response.data)

      // 如果状态发生变化，更新时间线
      if (oldStatus !== statusInfo.status) {
        updateTimeline('状态更新', statusInfo.statusDescription)
        emit('statusChange', statusInfo)
      }
    }
  } catch (error) {
    console.error('获取状态失败:', error)
  } finally {
    refreshing.value = false
  }
}

const updateTimeline = (action, description) => {
  timeline.value.unshift({
    id: Date.now(),
    content: `${action}: ${description}`,
    timestamp: new Date().toLocaleString(),
    type: 'primary'
  })
  showTimeline.value = true
}

const startAutoRefresh = () => {
  if (props.autoRefresh && statusInfo.isPending) {
    refreshTimer = setInterval(() => {
      refreshStatus()
    }, 30000) // 每30秒刷新一次
  }
}

const stopAutoRefresh = () => {
  if (refreshTimer) {
    clearInterval(refreshTimer)
    refreshTimer = null
  }
}

// 监听状态变化，控制自动刷新
watch(() => statusInfo.isPending, (newVal) => {
  if (newVal) {
    startAutoRefresh()
  } else {
    stopAutoRefresh()
  }
})

// 组件挂载时获取状态
onMounted(async () => {
  await refreshStatus()
})

// 组件卸载时清理定时器
onUnmounted(() => {
  stopAutoRefresh()
})
</script>

<style scoped>
.declaration-status {
  padding: 20px;
}

.status-steps {
  margin-bottom: 30px;
}

.status-detail {
  background: #f8f9fa;
}

.status-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.status-badge {
  display: flex;
  align-items: center;
  gap: 10px;
}

.status-actions {
  display: flex;
  gap: 12px;
}

.timeline-section {
  border-top: 1px solid #e4e7ed;
  padding-top: 20px;
  margin-top: 20px;
}

.timeline-section h4 {
  margin: 0 0 15px 0;
  color: #303133;
  font-size: 16px;
  font-weight: 600;
}

:deep(.el-steps) {
  --el-step-border-radius: 6px;
}

:deep(.el-step__title) {
  font-weight: 600;
}

:deep(.el-card__body) {
  padding: 24px;
}
</style>