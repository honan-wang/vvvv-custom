<template>
  <div class="profile-container">
    <el-card class="profile-card">
      <template #header>
        <div class="card-header">
          <el-icon><User /></el-icon>
          <span>个人中心</span>
        </div>
      </template>
      
      <div class="profile-content">
        <!-- 用户基本信息 -->
        <div class="user-info-section">
          <div class="avatar-section">
            <el-avatar :size="80" class="user-avatar">
              <el-icon><User /></el-icon>
            </el-avatar>
            <h3 class="username">{{ userInfo?.username }}</h3>
            <el-tag :type="getRoleTagType(userInfo?.role)" class="role-tag">
              {{ getRoleText(userInfo?.role) }}
            </el-tag>
          </div>
          
          <div class="info-details">
            <el-descriptions :column="2" border>
              <el-descriptions-item label="用户名">
                {{ userInfo?.username || '-' }}
              </el-descriptions-item>
              <el-descriptions-item label="角色">
                {{ getRoleText(userInfo?.role) || '-' }}
              </el-descriptions-item>
              <el-descriptions-item label="企业海关编码">
                {{ userInfo?.customsCode || '-' }}
              </el-descriptions-item>
              <el-descriptions-item label="企业名称">
                {{ userInfo?.customsName || '-' }}
              </el-descriptions-item>
              <el-descriptions-item label="公司编码">
                {{ userInfo?.companyCode || '-' }}
              </el-descriptions-item>
              <el-descriptions-item label="公司名称">
                {{ userInfo?.companyName || '-' }}
              </el-descriptions-item>
            </el-descriptions>
          </div>
        </div>
        
        <!-- 修改密码 -->
        <div class="password-section">
          <h4>修改密码</h4>
          <el-form 
            ref="passwordFormRef" 
            :model="passwordForm" 
            :rules="passwordRules" 
            label-width="120px"
            class="password-form"
          >
            <el-form-item label="当前密码" prop="currentPassword">
              <el-input
                v-model="passwordForm.currentPassword"
                type="password"
                placeholder="请输入当前密码"
                show-password
                clearable
              />
            </el-form-item>
            <el-form-item label="新密码" prop="newPassword">
              <el-input
                v-model="passwordForm.newPassword"
                type="password"
                placeholder="请输入新密码"
                show-password
                clearable
              />
            </el-form-item>
            <el-form-item label="确认新密码" prop="confirmPassword">
              <el-input
                v-model="passwordForm.confirmPassword"
                type="password"
                placeholder="请确认新密码"
                show-password
                clearable
              />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="handleChangePassword" :loading="loading">
                修改密码
              </el-button>
              <el-button @click="resetPasswordForm">重置</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { User } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import axios from '@/utils/request'

const userStore = useUserStore()

// 响应式数据
const loading = ref(false)
const userInfo = ref(null)
const passwordFormRef = ref(null)

// 密码表单
const passwordForm = reactive({
  currentPassword: '',
  newPassword: '',
  confirmPassword: ''
})

// 表单验证规则
const passwordRules = {
  currentPassword: [
    { required: true, message: '请输入当前密码', trigger: 'blur' }
  ],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, message: '新密码长度不能少于6位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认新密码', trigger: 'blur' },
    {
      validator: (rule, value, callback) => {
        if (value !== passwordForm.newPassword) {
          callback(new Error('两次输入的密码不一致'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ]
}

// 方法
const getRoleText = (role) => {
  const roleMap = {
    'admin': '管理员',
    'declarant': '申报员',
    'auditor': '审核员'
  }
  return roleMap[role] || role
}

const getRoleTagType = (role) => {
  const typeMap = {
    'admin': 'danger',
    'declarant': 'primary',
    'auditor': 'success'
  }
  return typeMap[role] || 'info'
}

const loadUserInfo = async () => {
  try {
    // 获取当前用户信息
    userInfo.value = userStore.userInfo
    
    // 如果没有用户信息，尝试从API获取
    if (!userInfo.value) {
      const response = await axios.get('/api/auth/profile')
      if (response.data.success) {
        userInfo.value = response.data.data
      }
    }
  } catch (error) {
    console.error('获取用户信息失败:', error)
    ElMessage.error('获取用户信息失败')
  }
}

const handleChangePassword = async () => {
  if (!passwordFormRef.value) return
  
  try {
    // 表单验证
    const valid = await passwordFormRef.value.validate()
    if (!valid) return
    
    // 确认修改
    await ElMessageBox.confirm('确定要修改密码吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    loading.value = true
    
    // 调用修改密码API
    const response = await axios.post('/api/auth/change-password', {
      userId: userInfo.value?.id,
      currentPassword: passwordForm.currentPassword,
      newPassword: passwordForm.newPassword
    })
    
    if (response.data.success) {
      ElMessage.success('密码修改成功，请重新登录')
      resetPasswordForm()
      
      // 延迟后退出登录
      setTimeout(async () => {
        await userStore.logout()
        window.location.href = '/login'
      }, 2000)
    } else {
      ElMessage.error(response.data.message || '密码修改失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('修改密码失败:', error)
      ElMessage.error(error.response?.data?.message || '修改密码失败')
    }
  } finally {
    loading.value = false
  }
}

const resetPasswordForm = () => {
  passwordForm.currentPassword = ''
  passwordForm.newPassword = ''
  passwordForm.confirmPassword = ''
  passwordFormRef.value?.clearValidate()
}

// 生命周期
onMounted(() => {
  loadUserInfo()
})
</script>

<style scoped>
.profile-container {
  padding: 20px;
  max-width: 1000px;
  margin: 0 auto;
}

.profile-card {
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.card-header {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 18px;
  font-weight: 600;
  color: #303133;
}

.profile-content {
  padding: 20px 0;
}

.user-info-section {
  margin-bottom: 40px;
}

.avatar-section {
  text-align: center;
  margin-bottom: 30px;
  padding: 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 8px;
  color: white;
}

.user-avatar {
  background-color: rgba(255, 255, 255, 0.2);
  color: white;
  margin-bottom: 15px;
}

.username {
  margin: 0 0 10px 0;
  font-size: 24px;
  font-weight: 500;
}

.role-tag {
  font-size: 14px;
}

.info-details {
  background-color: #fafafa;
  padding: 20px;
  border-radius: 8px;
}

.password-section {
  border-top: 1px solid #e4e7ed;
  padding-top: 30px;
}

.password-section h4 {
  margin: 0 0 20px 0;
  color: #303133;
  font-size: 16px;
  font-weight: 600;
}

.password-form {
  max-width: 500px;
}

.password-form .el-form-item {
  margin-bottom: 20px;
}

.password-form .el-button {
  margin-right: 10px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .profile-container {
    padding: 10px;
  }
  
  .avatar-section {
    padding: 15px;
  }
  
  .username {
    font-size: 20px;
  }
  
  .info-details {
    padding: 15px;
  }
  
  .password-form {
    max-width: 100%;
  }
}

/* Element Plus 样式覆盖 */
:deep(.el-descriptions__label) {
  font-weight: 600;
  color: #606266;
}

:deep(.el-descriptions__content) {
  color: #303133;
}

:deep(.el-form-item__label) {
  font-weight: 500;
  color: #606266;
}
</style>