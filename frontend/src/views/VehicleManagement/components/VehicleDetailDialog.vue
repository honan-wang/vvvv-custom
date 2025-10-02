<template>
  <el-dialog
    :model-value="visible"
    @update:model-value="$emit('update:visible', $event)"
    title="车辆详情"
    width="800px"
    :close-on-click-modal="false"
  >
    <div v-if="vehicleData" class="vehicle-detail">
      <!-- 基本信息 -->
      <el-card class="detail-card">
        <template #header>
          <div class="card-header">
            <span>基本信息</span>
          </div>
        </template>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>车牌号：</label>
              <span>{{ vehicleData.vehicleNo || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>车辆类型：</label>
              <span>{{ vehicleData.vehicleType || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>品牌型号：</label>
              <span>{{ vehicleData.brandType || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>车辆颜色：</label>
              <span>{{ vehicleData.colour || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>车辆重量：</label>
              <span>{{ formatWeight(vehicleData.vehicleWt) }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>载重量：</label>
              <span>{{ formatWeight(vehicleData.loadWt) }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>载客量：</label>
              <span>{{ vehicleData.loadPack ? `${vehicleData.loadPack}人` : '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>状态：</label>
              <el-tag 
                :type="getStatusType(vehicleData.status)"
                size="small"
              >
                {{ vehicleData.status || '未知' }}
              </el-tag>
            </div>
          </el-col>
        </el-row>
      </el-card>

      <!-- 证件信息 -->
      <el-card class="detail-card">
        <template #header>
          <div class="card-header">
            <span>证件信息</span>
          </div>
        </template>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>IC卡号：</label>
              <span>{{ vehicleData.icCode || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>许可证号：</label>
              <span>{{ vehicleData.licenseNo || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="8">
            <div class="detail-item">
              <label>电子车牌1：</label>
              <span>{{ vehicleData.eleNo1 || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="8">
            <div class="detail-item">
              <label>电子车牌2：</label>
              <span>{{ vehicleData.eleNo2 || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="8">
            <div class="detail-item">
              <label>电子车牌3：</label>
              <span>{{ vehicleData.eleNo3 || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>发动机号码：</label>
              <span>{{ vehicleData.amotorNo || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>车辆识别代号：</label>
              <span>{{ vehicleData.differenceNo || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>境外车牌号：</label>
              <span>{{ vehicleData.foreignNo || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>证件有效期：</label>
              <span>{{ formatDate(vehicleData.validityDate) }}</span>
            </div>
          </el-col>
        </el-row>
      </el-card>

      <!-- 企业信息 -->
      <el-card class="detail-card">
        <template #header>
          <div class="card-header">
            <span>企业信息</span>
          </div>
        </template>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>经营企业编码：</label>
              <span>{{ vehicleData.tradeCode || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>经营企业名称：</label>
              <span>{{ vehicleData.tradeName || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>挂靠单位：</label>
              <span>{{ vehicleData.attachedName || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>申请人：</label>
              <span>{{ vehicleData.appPerson || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>申请日期：</label>
              <span>{{ formatDate(vehicleData.appDate) }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>备案日期：</label>
              <span>{{ formatDate(vehicleData.recordDate) }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>注册登记日期：</label>
              <span>{{ formatDate(vehicleData.registerDate) }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>海关编码：</label>
              <span>{{ vehicleData.customsCode || '-' }}</span>
            </div>
          </el-col>
        </el-row>
      </el-card>

      <!-- 其他信息 -->
      <el-card class="detail-card">
        <template #header>
          <div class="card-header">
            <span>其他信息</span>
          </div>
        </template>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>使用性质：</label>
              <span>{{ vehicleData.usedNature || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>车辆国别：</label>
              <span>{{ vehicleData.vehicleNative || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>车辆用途：</label>
              <span>{{ vehicleData.vehicleUsed || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>区域代码：</label>
              <span>{{ vehicleData.areaCode || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20" v-if="vehicleData.note">
          <el-col :span="24">
            <div class="detail-item">
              <label>备注：</label>
              <span class="note-content">{{ vehicleData.note }}</span>
            </div>
          </el-col>
        </el-row>
      </el-card>

      <!-- 系统信息 -->
      <el-card class="detail-card">
        <template #header>
          <div class="card-header">
            <span>系统信息</span>
          </div>
        </template>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>自动编号：</label>
              <span>{{ vehicleData.autoId || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>车辆性质：</label>
              <span>{{ vehicleData.vehicleNature || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <div class="detail-item">
              <label>载人范围：</label>
              <span>{{ vehicleData.range || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="12">
            <div class="detail-item">
              <label>预留字段1：</label>
              <span>{{ vehicleData.extendField1 || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="8">
            <div class="detail-item">
              <label>预留字段2：</label>
              <span>{{ vehicleData.extendField2 || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="8">
            <div class="detail-item">
              <label>预留字段3：</label>
              <span>{{ vehicleData.extendField3 || '-' }}</span>
            </div>
          </el-col>
          <el-col :span="8">
            <div class="detail-item">
              <label>预留字段4：</label>
              <span>{{ vehicleData.extendField4 || '-' }}</span>
            </div>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="24">
            <div class="detail-item">
              <label>预留字段5：</label>
              <span>{{ vehicleData.extendField5 || '-' }}</span>
            </div>
          </el-col>
        </el-row>
      </el-card>
    </div>

    <template #footer>
      <span class="dialog-footer">
        <el-button @click="$emit('update:visible', false)">关闭</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
// Props
defineProps({
  visible: {
    type: Boolean,
    default: false
  },
  vehicleData: {
    type: Object,
    default: null
  }
})

// Emits
defineEmits(['update:visible'])

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
  try {
    return new Date(date).toLocaleDateString('zh-CN')
  } catch {
    return '-'
  }
}

// 格式化重量
const formatWeight = (weight) => {
  if (weight === null || weight === undefined) return '-'
  return `${weight} KG`
}
</script>

<style scoped>
.vehicle-detail {
  padding: 0;
}

.detail-card {
  margin-bottom: 20px;
}

.detail-card:last-child {
  margin-bottom: 0;
}

.card-header {
  font-weight: bold;
  color: #303133;
}

.detail-item {
  display: flex;
  align-items: flex-start;
  margin-bottom: 12px;
  line-height: 1.5;
}

.detail-item:last-child {
  margin-bottom: 0;
}

.detail-item label {
  font-weight: bold;
  color: #606266;
  min-width: 100px;
  margin-right: 8px;
  flex-shrink: 0;
}

.detail-item span {
  color: #303133;
  word-break: break-word;
}

.note-content {
  white-space: pre-wrap;
  word-break: break-word;
}

.dialog-footer {
  display: flex;
  justify-content: center;
}

:deep(.el-dialog__body) {
  max-height: 70vh;
  overflow-y: auto;
}

:deep(.el-card__header) {
  background-color: #f5f7fa;
  border-bottom: 1px solid #ebeef5;
  padding: 12px 20px;
}

:deep(.el-card__body) {
  padding: 20px;
}
</style>