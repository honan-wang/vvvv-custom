<template>
  <el-dialog
    :model-value="visible"
    @update:model-value="$emit('update:visible', $event)"
    :title="isEdit ? '编辑车辆' : '新增车辆'"
    width="900px"
    :close-on-click-modal="false"
    :close-on-press-escape="false"
  >
    <el-form
      ref="formRef"
      :model="formData"
      :rules="formRules"
      label-width="120px"
      label-position="right"
    >
      <!-- 基本信息 -->
      <el-card class="form-card">
        <template #header>
          <div class="card-header">
            <span>基本信息</span>
          </div>
        </template>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="车牌号" prop="vehicleNo">
              <el-input v-model="formData.vehicleNo" placeholder="请输入车牌号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="车辆类型" prop="vehicleType">
              <el-select v-model="formData.vehicleType" placeholder="请选择车辆类型" style="width: 100%">
                <el-option label="货车" value="货车" />
                <el-option label="客车" value="客车" />
                <el-option label="专用车" value="专用车" />
                <el-option label="拖拉机" value="拖拉机" />
                <el-option label="其他" value="其他" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="品牌型号" prop="brandType">
              <el-input v-model="formData.brandType" placeholder="请输入品牌型号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="车辆颜色" prop="colour">
              <el-input v-model="formData.colour" placeholder="请输入车辆颜色" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="车辆重量(KG)" prop="vehicleWt">
              <el-input-number 
                v-model="formData.vehicleWt" 
                :min="0" 
                :precision="2"
                placeholder="请输入车辆重量"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="载重量(KG)" prop="loadWt">
              <el-input-number 
                v-model="formData.loadWt" 
                :min="0" 
                :precision="2"
                placeholder="请输入载重量"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="载客量" prop="loadPack">
              <el-input-number 
                v-model="formData.loadPack" 
                :min="0" 
                :precision="0"
                placeholder="请输入载客量"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="formData.status" placeholder="请选择状态" style="width: 100%">
                <el-option label="正常" value="正常" />
                <el-option label="维修" value="维修" />
                <el-option label="停用" value="停用" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>

      <!-- 证件信息 -->
      <el-card class="form-card">
        <template #header>
          <div class="card-header">
            <span>证件信息</span>
          </div>
        </template>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="IC卡号" prop="icCode">
              <el-input v-model="formData.icCode" placeholder="请输入IC卡号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="许可证号" prop="licenseNo">
              <el-input v-model="formData.licenseNo" placeholder="请输入许可证号" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="电子车牌1" prop="eleNo1">
              <el-input v-model="formData.eleNo1" placeholder="请输入电子车牌1" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="电子车牌2" prop="eleNo2">
              <el-input v-model="formData.eleNo2" placeholder="请输入电子车牌2" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="电子车牌3" prop="eleNo3">
              <el-input v-model="formData.eleNo3" placeholder="请输入电子车牌3" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="发动机号码" prop="amotorNo">
              <el-input v-model="formData.amotorNo" placeholder="请输入发动机号码" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="车辆识别代号" prop="differenceNo">
              <el-input v-model="formData.differenceNo" placeholder="请输入车辆识别代号" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="境外车牌号" prop="foreignNo">
              <el-input v-model="formData.foreignNo" placeholder="请输入境外车牌号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="证件有效期" prop="validityDate">
              <el-date-picker
                v-model="formData.validityDate"
                type="date"
                placeholder="请选择证件有效期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>

      <!-- 企业信息 -->
      <el-card class="form-card">
        <template #header>
          <div class="card-header">
            <span>企业信息</span>
          </div>
        </template>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="经营企业名称" prop="tradeName">
              <el-input v-model="formData.tradeName" placeholder="请输入经营企业名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="挂靠单位" prop="attachedName">
              <el-input v-model="formData.attachedName" placeholder="请输入挂靠单位" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="申请人" prop="appPerson">
              <el-input v-model="formData.appPerson" placeholder="请输入申请人" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="申请日期" prop="appDate">
              <el-date-picker
                v-model="formData.appDate"
                type="date"
                placeholder="请选择申请日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="备案日期" prop="recordDate">
              <el-date-picker
                v-model="formData.recordDate"
                type="date"
                placeholder="请选择备案日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="注册登记日期" prop="registerDate">
              <el-date-picker
                v-model="formData.registerDate"
                type="date"
                placeholder="请选择注册登记日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>

      <!-- 其他信息 -->
      <el-card class="form-card">
        <template #header>
          <div class="card-header">
            <span>其他信息</span>
          </div>
        </template>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="使用性质" prop="usedNature">
              <el-input v-model="formData.usedNature" placeholder="请输入使用性质" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="车辆国别" prop="vehicleNative">
              <el-input v-model="formData.vehicleNative" placeholder="请输入车辆国别" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="车辆用途" prop="vehicleUsed">
              <el-input v-model="formData.vehicleUsed" placeholder="请输入车辆用途" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="海关编码" prop="customsCode">
              <el-input v-model="formData.customsCode" placeholder="请输入海关编码" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="备注" prop="note">
              <el-input 
                v-model="formData.note" 
                type="textarea" 
                :rows="3"
                placeholder="请输入备注信息"
              />
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>
    </el-form>

    <template #footer>
      <span class="dialog-footer">
        <el-button @click="$emit('update:visible', false)">取消</el-button>
        <el-button type="primary" @click="handleSave" :loading="saving">保存</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive, watch, nextTick } from 'vue'
import { ElMessage } from 'element-plus'
import { vehicleAPI } from '@/api/vehicle'

// Props
const props = defineProps({
  visible: {
    type: Boolean,
    default: false
  },
  vehicleData: {
    type: Object,
    default: null
  },
  isEdit: {
    type: Boolean,
    default: false
  }
})

// Emits
const emit = defineEmits(['update:visible', 'save-success'])

// 响应式数据
const formRef = ref()
const saving = ref(false)

// 表单数据
const formData = reactive({
  vehicleNo: '',
  vehicleType: '',
  icCode: '',
  eleNo1: '',
  eleNo2: '',
  eleNo3: '',
  vehicleWt: null,
  foreignNo: '',
  vehicleNature: '',
  usedNature: '',
  brandType: '',
  amotorNo: '',
  differenceNo: '',
  vehicleNative: '',
  range: '',
  vehicleUsed: '',
  licenseNo: '',
  loadWt: null,
  loadPack: null,
  colour: '',
  validityDate: '',
  recordDate: '',
  registerDate: '',
  attachedName: '',
  tradeName: '',
  appPerson: '',
  appDate: '',
  status: '正常',
  customsCode: '',
  note: '',
  areaCode: '',
  extendField1: null,
  extendField2: null,
  extendField3: '',
  extendField4: '',
  extendField5: ''
})

// 表单验证规则
const formRules = {
  vehicleNo: [
    { required: true, message: '请输入车牌号', trigger: 'blur' },
    { min: 2, max: 20, message: '车牌号长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  vehicleType: [
    { required: true, message: '请选择车辆类型', trigger: 'change' }
  ],
  brandType: [
    { max: 30, message: '品牌型号不能超过30个字符', trigger: 'blur' }
  ],
  tradeName: [
    { max: 200, message: '经营企业名称不能超过200个字符', trigger: 'blur' }
  ]
}

// 重置表单
const resetForm = () => {
  Object.keys(formData).forEach(key => {
    if (typeof formData[key] === 'string') {
      formData[key] = ''
    } else if (typeof formData[key] === 'number') {
      formData[key] = null
    }
  })
  formData.status = '正常'
  
  nextTick(() => {
    formRef.value?.clearValidate()
  })
}

// 填充表单数据
const fillFormData = (data) => {
  if (data) {
    Object.keys(formData).forEach(key => {
      if (data[key] !== undefined) {
        formData[key] = data[key]
      }
    })
  }
}

// 保存车辆
const handleSave = async () => {
  try {
    const valid = await formRef.value.validate()
    if (!valid) return

    saving.value = true

    const response = props.isEdit 
      ? await vehicleAPI.updateVehicle(props.vehicleData.autoId, formData)
      : await vehicleAPI.createVehicle(formData)

    if (response.success) {
      ElMessage.success(props.isEdit ? '更新成功' : '创建成功')
      emit('save-success')
    } else {
      ElMessage.error(response.message || (props.isEdit ? '更新失败' : '创建失败'))
    }
  } catch (error) {
    console.error('保存车辆失败:', error)
    ElMessage.error(props.isEdit ? '更新失败' : '创建失败')
  } finally {
    saving.value = false
  }
}

// 监听对话框显示状态
watch(() => props.visible, (visible) => {
  if (visible) {
    if (props.isEdit && props.vehicleData) {
      fillFormData(props.vehicleData)
    } else {
      resetForm()
    }
  }
})
</script>

<style scoped>
.form-card {
  margin-bottom: 20px;
}

.form-card:last-child {
  margin-bottom: 0;
}

.card-header {
  font-weight: bold;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

:deep(.el-dialog__body) {
  max-height: 70vh;
  overflow-y: auto;
}

:deep(.el-card__header) {
  background-color: #f5f7fa;
  border-bottom: 1px solid #ebeef5;
}
</style>