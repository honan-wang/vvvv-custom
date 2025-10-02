<template>
  <el-dialog
    v-model="dialogVisible"
    :title="isEdit ? '编辑用户' : '新增用户'"
    width="600px"
    :close-on-click-modal="false"
    :close-on-press-escape="false"
    @close="handleClose"
  >
    <el-form
      ref="formRef"
      :model="form"
      :rules="rules"
      label-width="120px"
      class="user-form"
    >
      <el-form-item label="用户名" prop="username">
        <el-input
          v-model="form.username"
          placeholder="请输入用户名"
          :disabled="isEdit"
          clearable
        />
      </el-form-item>

      <el-form-item label="密码" prop="password" v-if="!isEdit">
        <el-input
          v-model="form.password"
          type="password"
          placeholder="请输入密码"
          show-password
          clearable
        />
      </el-form-item>

      <el-form-item label="确认密码" prop="confirmPassword" v-if="!isEdit">
        <el-input
          v-model="form.confirmPassword"
          type="password"
          placeholder="请再次输入密码"
          show-password
          clearable
        />
      </el-form-item>

      <el-form-item label="企业代码" prop="companyCode">
        <el-input
          v-model="form.companyCode"
          placeholder="请输入10位企业海关编码"
          maxlength="10"
          clearable
        />
      </el-form-item>

      <el-form-item label="企业名称" prop="companyName">
        <el-input
          v-model="form.companyName"
          placeholder="请输入企业名称"
          clearable
        />
      </el-form-item>

      <el-form-item label="海关关区代码" prop="customsCode">
        <el-input
          v-model="form.customsCode"
          placeholder="请输入海关关区代码"
          clearable
        />
      </el-form-item>

      <el-form-item label="海关关区名称" prop="customsName">
        <el-input
          v-model="form.customsName"
          placeholder="请输入海关关区名称"
          clearable
        />
      </el-form-item>

      <el-form-item label="是否启用" prop="status">
        <el-switch
          v-model="form.status"
          :active-value="1"
          :inactive-value="0"
          active-text="启用"
          inactive-text="禁用"
        />
      </el-form-item>
    </el-form>

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="handleClose">取消</el-button>
        <el-button type="primary" :loading="loading" @click="handleSubmit">
          {{ isEdit ? '更新' : '创建' }}
        </el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive, computed, watch, nextTick } from 'vue'
import { ElMessage } from 'element-plus'
import { createUser, updateUser } from '@/api/user'

// Props
const props = defineProps({
  visible: {
    type: Boolean,
    default: false
  },
  formData: {
    type: Object,
    default: () => ({})
  },
  isEdit: {
    type: Boolean,
    default: false
  }
})

// Emits
const emit = defineEmits(['update:visible', 'success'])

// 响应式数据
const formRef = ref()
const loading = ref(false)

// 计算属性
const dialogVisible = computed({
  get: () => props.visible,
  set: (value) => emit('update:visible', value)
})

// 表单数据
const form = reactive({
  username: '',
  password: '',
  confirmPassword: '',
  companyCode: '',
  companyName: '',
  customsCode: '',
  customsName: '',
  status: 1
})


// 验证密码是否一致
const validateConfirmPassword = (rule, value, callback) => {
  if (value && value !== form.password) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}

// 验证企业代码格式
const validateCompanyCode = (rule, value, callback) => {
  if (value && !/^\d{10}$/.test(value)) {
    callback(new Error('企业代码必须是10位数字'))
  } else {
    callback()
  }
}

// 表单验证规则
const rules = reactive({
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '用户名长度在3到20个字符', trigger: 'blur' },
    { pattern: /^[a-zA-Z0-9_]+$/, message: '用户名只能包含字母、数字和下划线', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在6到20个字符', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    { validator: validateConfirmPassword, trigger: 'blur' }
  ],
  companyCode: [
    { required: true, message: '请输入企业代码', trigger: 'blur' },
    { validator: validateCompanyCode, trigger: 'blur' }
  ],
  companyName: [
    { required: true, message: '请输入企业名称', trigger: 'blur' },
    { min: 2, max: 100, message: '企业名称长度在2到100个字符', trigger: 'blur' }
  ],
  customsCode: [
    { required: true, message: '请输入海关关区代码', trigger: 'blur' }
  ],
  customsName: [
    { required: true, message: '请输入海关关区名称', trigger: 'blur' }
  ],
  status: [
    { required: true, message: '请选择启用状态', trigger: 'change' }
  ]
})

// 监听表单数据变化
watch(
  () => props.formData,
  (newData) => {
    if (newData && Object.keys(newData).length > 0) {
      Object.assign(form, {
        username: newData.username || '',
        password: '',
        confirmPassword: '',
        companyCode: newData.companyCode || '',
        companyName: newData.companyName || '',
        customsCode: newData.customsCode || '',
        customsName: newData.customsName || '',
        status: newData.status !== undefined ? newData.status : 1
      })
    }
  },
  { immediate: true, deep: true }
)

// 监听对话框显示状态
watch(dialogVisible, (visible) => {
  if (visible) {
    // 延迟清除验证状态，确保表单已渲染
    nextTick(() => {
      formRef.value?.clearValidate()
    })
  }
})

// 方法

const handleSubmit = async () => {
  try {
    // 表单验证
    await formRef.value.validate()
    
    loading.value = true
    
    // 构建提交数据
    const submitData = {
      username: form.username,
      companyCode: form.companyCode,
      companyName: form.companyName,
      customsCode: form.customsCode,
      customsName: form.customsName,
      status: form.status,
      role: 'user' // 默认角色
    }
    
    // 如果是新增用户，包含密码
    if (!props.isEdit) {
      submitData.password = form.password
    }
    
    let response
    if (props.isEdit) {
      response = await updateUser(props.formData.id, submitData)
    } else {
      response = await createUser(submitData)
    }
    
    if (response && response.success) {
      ElMessage.success(props.isEdit ? '更新用户成功' : '创建用户成功')
      emit('success')
    } else {
      throw new Error(response?.message || (props.isEdit ? '更新用户失败' : '创建用户失败'))
    }
    
  } catch (error) {
    if (error !== false) { // 表单验证失败时不显示错误消息
      console.error('提交用户信息失败:', error)
      ElMessage.error(error.message || (props.isEdit ? '更新用户失败' : '创建用户失败'))
    }
  } finally {
    loading.value = false
  }
}

const handleClose = () => {
  // 重置表单
  Object.assign(form, {
    username: '',
    password: '',
    confirmPassword: '',
    companyCode: '',
    companyName: '',
    customsCode: '',
    customsName: '',
    status: 1
  })
  
  // 清除验证状态
  nextTick(() => {
    formRef.value?.clearValidate()
  })
  
  emit('update:visible', false)
}
</script>

<style scoped>
.user-form {
  padding: 0 20px;
}

.dialog-footer {
  text-align: right;
  padding: 0 20px;
}

/* 表单项样式优化 */
:deep(.el-form-item__label) {
  font-weight: 600;
}

:deep(.el-input__wrapper) {
  box-shadow: 0 0 0 1px #dcdfe6 inset;
}

:deep(.el-input__wrapper:hover) {
  box-shadow: 0 0 0 1px #c0c4cc inset;
}

:deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 1px #409eff inset;
}

/* 开关样式 */
:deep(.el-switch) {
  display: flex;
  align-items: center;
}

:deep(.el-switch__label) {
  margin: 0 8px;
  font-weight: normal;
}

/* 选择器样式 */
:deep(.el-select) {
  width: 100%;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .user-form {
    padding: 0 10px;
  }
  
  :deep(.el-form-item__label) {
    line-height: 1.4;
  }
}
</style>