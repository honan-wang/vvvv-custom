<template>
  <el-dialog
    v-model="dialogVisible"
    title="保存为模板"
    width="500px"
    :before-close="handleClose"
  >
    <el-form
      ref="formRef"
      :model="form"
      :rules="rules"
      label-width="100px"
      class="template-form"
    >
      <el-form-item label="模板名称" prop="templateName">
        <el-input
          v-model="form.templateName"
          placeholder="请输入模板名称"
          maxlength="50"
          show-word-limit
        />
      </el-form-item>
      
      <el-form-item label="模板描述" prop="description">
        <el-input
          v-model="form.description"
          type="textarea"
          :rows="3"
          placeholder="请输入模板描述（可选）"
          maxlength="200"
          show-word-limit
        />
      </el-form-item>
      
      <el-form-item label="模板类型">
        <el-tag :type="form.ieMark === 'I' ? 'success' : 'warning'">
          {{ form.ieMark === 'I' ? '进口模板' : '出口模板' }}
        </el-tag>
      </el-form-item>
      
      <el-form-item label="包含内容">
        <el-checkbox-group v-model="form.includeFields">
          <div class="checkbox-list">
            <el-checkbox label="headerInfo">表头信息</el-checkbox>
            <el-checkbox label="goodsInfo">商品信息</el-checkbox>
            <el-checkbox label="vehicleInfo">车辆信息</el-checkbox>
          </div>
        </el-checkbox-group>
      </el-form-item>
      
      <el-form-item label="共享设置">
        <el-radio-group v-model="form.shareType">
          <div class="radio-list">
            <el-radio label="private">
              <div class="radio-content">
                <div class="radio-title">私有模板</div>
                <div class="radio-desc">仅自己可以使用</div>
              </div>
            </el-radio>
            <el-radio label="public">
              <div class="radio-content">
                <div class="radio-title">公共模板</div>
                <div class="radio-desc">所有用户都可以使用</div>
              </div>
            </el-radio>
          </div>
        </el-radio-group>
      </el-form-item>
    </el-form>
    
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="handleClose">取消</el-button>
        <el-button type="primary" @click="handleConfirm" :loading="saving">
          保存模板
        </el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive, computed, watch } from 'vue'
import { ElMessage } from 'element-plus'
import { saveTemplate, cleanTemplateData } from '@/utils/template'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  formData: {
    type: Object,
    default: () => ({})
  }
})

const emit = defineEmits(['update:modelValue', 'confirm'])

// 响应式数据
const formRef = ref(null)
const saving = ref(false)

// 表单数据
const form = reactive({
  templateName: '',
  description: '',
  ieMark: '',
  includeFields: ['headerInfo', 'goodsInfo'],
  shareType: 'private'
})

// 验证规则
const rules = {
  templateName: [
    { required: true, message: '请输入模板名称', trigger: 'blur' },
    { min: 2, max: 50, message: '模板名称长度在 2 到 50 个字符', trigger: 'blur' }
  ]
}

// 计算属性
const dialogVisible = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value)
})

// 监听对话框显示状态
watch(dialogVisible, (visible) => {
  if (visible) {
    initForm()
  } else {
    resetForm()
  }
})

// 监听表单数据变化
watch(() => props.formData, (newData) => {
  if (newData && dialogVisible.value) {
    initForm()
  }
}, { deep: true })

// 初始化表单
const initForm = () => {
  if (props.formData) {
    // 根据申报单数据生成默认模板名称
    const timestamp = new Date().toLocaleDateString().replace(/\//g, '-')
    const ieText = props.formData.ieMark === 'I' ? '进口' : '出口'
    const startLand = getLocationName(props.formData.startLand)
    const goalLand = getLocationName(props.formData.goalLand)
    
    form.templateName = `${ieText}模板-${startLand}到${goalLand}-${timestamp}`
    form.ieMark = props.formData.ieMark || ''
    form.description = `自动生成的${ieText}申报模板`
  }
}

// 重置表单
const resetForm = () => {
  form.templateName = ''
  form.description = ''
  form.ieMark = ''
  form.includeFields = ['headerInfo', 'goodsInfo']
  form.shareType = 'private'
  formRef.value?.resetFields()
}

// 获取地点名称
const getLocationName = (code) => {
  const locationMap = {
    'SZ': '深圳',
    'GZ': '广州',
    'ZH': '珠海',
    'DG': '东莞',
    'HK': '香港',
    'MO': '澳门'
  }
  return locationMap[code] || code || '未知'
}

// 处理关闭
const handleClose = () => {
  dialogVisible.value = false
}

// 处理确认
const handleConfirm = async () => {
  try {
    const valid = await formRef.value?.validate()
    if (!valid) return
    
    saving.value = true
    
    // 清理模版数据
    const cleanedData = cleanTemplateData(props.formData)
    
    // 根据选择的字段过滤数据
    const templateData = {}
    
    if (form.includeFields.includes('headerInfo')) {
      Object.assign(templateData, {
        startLand: cleanedData.startLand,
        goalLand: cleanedData.goalLand,
        areaCode: cleanedData.areaCode,
        ieMark: cleanedData.ieMark,
        materialNature: cleanedData.materialNature,
        packType: cleanedData.packType,
        bookNo: cleanedData.bookNo,
        note: cleanedData.note
      })
    }
    
    if (form.includeFields.includes('goodsInfo')) {
      templateData.goodsList = cleanedData.goodsList || []
    }
    
    if (form.includeFields.includes('vehicleInfo')) {
      Object.assign(templateData, {
        carNo: cleanedData.carNo,
        carWt: cleanedData.carWt
      })
    }
    
    // 添加模版元数据
    templateData.description = form.description
    templateData.shareType = form.shareType
    
    // 保存模版
    const success = saveTemplate(form.templateName, templateData)
    
    if (success) {
      ElMessage.success('模板保存成功')
      emit('confirm', { templateName: form.templateName, templateData })
      handleClose()
    } else {
      ElMessage.error('模板保存失败')
    }
  } catch (error) {
    console.error('保存模板失败:', error)
    ElMessage.error(error.message || '保存模板失败')
  } finally {
    saving.value = false
  }
}
</script>

<style scoped>
.template-form {
  padding: 20px 0;
}

.checkbox-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.radio-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.radio-content {
  margin-left: 8px;
}

.radio-title {
  font-weight: 500;
  color: #303133;
  margin-bottom: 4px;
}

.radio-desc {
  font-size: 12px;
  color: #909399;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}

:deep(.el-checkbox) {
  margin-bottom: 8px;
}

:deep(.el-radio) {
  margin-bottom: 12px;
  align-items: flex-start;
}

:deep(.el-radio__input) {
  margin-top: 2px;
}

:deep(.el-form-item__content) {
  flex-wrap: wrap;
}
</style>