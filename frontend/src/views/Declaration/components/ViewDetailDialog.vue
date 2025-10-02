<template>
  <el-dialog
    v-model="visible"
    title="申报详情"
    width="90%"
    :close-on-click-modal="false"
    :destroy-on-close="true"
    @close="handleClose"
  >
    <div v-loading="loading" class="detail-container">
      <!-- 核放单表头信息 -->
      <el-card class="section-card" shadow="never">
        <template #header>
          <div class="card-header">
            <span class="card-title">核放单信息</span>
          </div>
        </template>
        <el-descriptions :column="3" border>
          <el-descriptions-item label="核放单号">
            {{ detailData.dischargedNo }}
          </el-descriptions-item>
          <el-descriptions-item label="申请单号">
            {{ detailData.applicationNo }}
          </el-descriptions-item>
          <el-descriptions-item label="车牌号码">
            {{ detailData.carNo }}
          </el-descriptions-item>
          <el-descriptions-item label="车辆自重">
            {{ detailData.carWeight }} kg
          </el-descriptions-item>
          <el-descriptions-item label="起始地">
            {{ detailData.startPlace }}
          </el-descriptions-item>
          <el-descriptions-item label="目的地">
            {{ detailData.endPlace }}
          </el-descriptions-item>
          <el-descriptions-item label="区域标志">
            {{ detailData.areaName }}
          </el-descriptions-item>
          <el-descriptions-item label="总重量">
            {{ detailData.totalWeight }} kg
          </el-descriptions-item>
          <el-descriptions-item label="包装件数">
            {{ detailData.packNumber }}
          </el-descriptions-item>
          <el-descriptions-item label="毛重">
            {{ detailData.grossWeight }} kg
          </el-descriptions-item>
          <el-descriptions-item label="包装种类">
            {{ detailData.packName }}
          </el-descriptions-item>
          <el-descriptions-item label="进出标志">
            <el-tag :type="detailData.ieMark === '进口' ? 'success' : 'warning'">
              {{ detailData.ieMark }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="料件性质">
            {{ detailData.materialNatureName }}
          </el-descriptions-item>
          <el-descriptions-item label="账册号">
            {{ detailData.bookNo }}
          </el-descriptions-item>
          <el-descriptions-item label="核放单状态">
            <el-tag :type="getStatusType(detailData.dischargedStatus)">
              {{ detailData.dischargedStatus }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="申请单状态">
            <el-tag :type="getStatusType(detailData.applicationStatus)">
              {{ detailData.applicationStatus }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="录入时间" :span="3">
            {{ formatDate(detailData.createTime) }}
          </el-descriptions-item>
          <el-descriptions-item label="申报时间" :span="3">
            {{ formatDate(detailData.declareTime) }}
          </el-descriptions-item>
          <el-descriptions-item label="过卡时间" :span="3">
            {{ formatDate(detailData.portTime) }}
          </el-descriptions-item>
          <el-descriptions-item label="备注" :span="3">
            {{ detailData.remark || '-' }}
          </el-descriptions-item>
        </el-descriptions>
      </el-card>

      <!-- 商品明细信息 -->
      <el-card class="section-card" shadow="never">
        <template #header>
          <div class="card-header">
            <span class="card-title">商品明细</span>
            <span class="card-subtitle">共 {{ goodsList.length }} 项商品</span>
          </div>
        </template>
        <el-table
          :data="goodsList"
          border
          stripe
          :header-cell-style="{ backgroundColor: '#f5f7fa', color: '#606266' }"
          max-height="400"
        >
          <el-table-column type="index" label="序号" width="60" align="center" />
          <el-table-column prop="itemNo" label="项号" width="80" align="center" />
          <el-table-column prop="goodsName" label="商品名称" width="180" show-overflow-tooltip />
          <el-table-column prop="goodsCode" label="商品编码" width="120" />
          <el-table-column prop="goodsSpec" label="商品规格" width="150" show-overflow-tooltip />
          <el-table-column prop="declareQty" label="申报数量" width="100" align="right">
            <template #default="{ row }">
              {{ row.declareQty }}
            </template>
          </el-table-column>
          <el-table-column prop="unitName" label="计量单位" width="100" align="center" />
          <el-table-column prop="declarePrice" label="商品单价" width="120" align="right">
            <template #default="{ row }">
              {{ row.declarePrice ? row.declarePrice.toFixed(2) : '0.00' }}
            </template>
          </el-table-column>
          <el-table-column prop="declareTotalPrice" label="商品总价" width="120" align="right">
            <template #default="{ row }">
              {{ row.declareTotalPrice ? row.declareTotalPrice.toFixed(2) : '0.00' }}
            </template>
          </el-table-column>
          <el-table-column prop="currency" label="币制" width="80" align="center" />
          <el-table-column prop="materialNatureName" label="料件性质" width="100" />
          <el-table-column prop="remark" label="备注" min-width="150" show-overflow-tooltip />
        </el-table>
      </el-card>
    </div>

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="handleClose">关闭</el-button>
        <el-button type="primary" @click="handleEdit" v-if="canEdit">编辑</el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { ElMessage } from 'element-plus'
import { formatDate } from '@/utils/date'
import { getUnifiedDeclarationDetail } from '@/api/unifiedDeclaration'

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

const emit = defineEmits(['update:modelValue', 'edit'])

const visible = computed({
  get() {
    return props.modelValue
  },
  set(value) {
    emit('update:modelValue', value)
  }
})

const loading = ref(false)
const detailData = ref({})
const goodsList = ref([])

// 判断是否可编辑
const canEdit = computed(() => {
  const dischargedStatus = detailData.value.dischargedStatus || ''
  const applicationStatus = detailData.value.applicationStatus || ''

  const dischargedEditable = dischargedStatus.includes('暂存') ||
                              dischargedStatus.includes('草稿') ||
                              dischargedStatus.includes('预录入') ||
                              dischargedStatus === ''

  const applicationEditable = applicationStatus === '' ||
                               applicationStatus.includes('暂存') ||
                               applicationStatus.includes('退回')

  return dischargedEditable && applicationEditable
})

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
const loadDetail = async () => {
  if (!props.dischargedNo) return

  loading.value = true
  try {
    const response = await getUnifiedDeclarationDetail(props.dischargedNo)
    if (response.success) {
      detailData.value = response.data.head || {}
      goodsList.value = response.data.goods || []
    } else {
      ElMessage.error(response.message || '获取详情失败')
    }
  } catch (error) {
    console.error('获取详情失败:', error)
    ElMessage.error('获取详情失败')
  } finally {
    loading.value = false
  }
}

// 监听弹窗打开
watch(() => props.modelValue, (newVal) => {
  if (newVal && props.dischargedNo) {
    loadDetail()
  }
})

// 关闭弹窗
const handleClose = () => {
  visible.value = false
}

// 编辑
const handleEdit = () => {
  emit('edit', detailData.value)
  handleClose()
}
</script>

<style scoped>
.detail-container {
  padding: 10px 0;
}

.section-card {
  margin-bottom: 20px;
}

.section-card:last-child {
  margin-bottom: 0;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-title {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
}

.card-subtitle {
  font-size: 14px;
  color: #909399;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

:deep(.el-descriptions__label) {
  width: 120px;
  font-weight: 500;
}

:deep(.el-card__header) {
  padding: 15px 20px;
  border-bottom: 1px solid #ebeef5;
}

:deep(.el-card__body) {
  padding: 20px;
}
</style>
