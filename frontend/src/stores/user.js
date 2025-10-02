import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { login as apiLogin, logout as apiLogout, getUserInfo } from '@/api/auth'

export const useUserStore = defineStore('user', () => {
  // 状态
  const token = ref(localStorage.getItem('token') || '')
  const userInfo = ref(JSON.parse(localStorage.getItem('userInfo') || 'null'))
  const permissions = ref(JSON.parse(localStorage.getItem('permissions') || '[]'))
  
  // 计算属性
  const isLoggedIn = computed(() => !!token.value && !!userInfo.value)
  
  // 保存用户信息到本地存储
  const saveToLocalStorage = (tokenValue, userInfoValue, permissionsValue = []) => {
    localStorage.setItem('token', tokenValue)
    localStorage.setItem('userInfo', JSON.stringify(userInfoValue))
    localStorage.setItem('permissions', JSON.stringify(permissionsValue))
    
    // 保存用户关键信息到单独的键，方便申报时使用
    const userStorage = {
      username: userInfoValue.username,
      customsCode: userInfoValue.customsCode,
      customsName: userInfoValue.customsName,
      companyCode: userInfoValue.companyCode,
      companyName: userInfoValue.companyName,
      role: userInfoValue.role
    }
    localStorage.setItem('currentUser', JSON.stringify(userStorage))
  }
  
  // 清除本地存储
  const clearLocalStorage = () => {
    localStorage.removeItem('token')
    localStorage.removeItem('userInfo')
    localStorage.removeItem('permissions')
    localStorage.removeItem('currentUser')
  }
  
  // 方法
  const login = async (loginForm) => {
    try {
      const response = await apiLogin(loginForm)
      
      if (response.success) {
        const { accessToken, userInfo: userData } = response.data
        
        // 设置默认权限
        const defaultPermissions = ['declaration:view', 'declaration:create', 'declaration:edit']
        if (userData.role === 'Admin') {
          defaultPermissions.push('user:manage', 'system:manage')
        }
        
        // 更新状态
        token.value = accessToken
        userInfo.value = userData
        permissions.value = defaultPermissions
        
        // 保存到本地存储
        saveToLocalStorage(accessToken, userData, defaultPermissions)
        
        return { success: true, data: response.data }
      } else {
        return { success: false, message: response.message || '登录失败' }
      }
    } catch (error) {
      console.error('登录失败:', error)
      return { success: false, message: error.message || '登录失败，请稍后重试' }
    }
  }
  
  const logout = async () => {
    try {
      await apiLogout()
    } catch (error) {
      console.error('登出接口调用失败:', error)
    } finally {
      // 清除状态
      token.value = ''
      userInfo.value = null
      permissions.value = []
      
      // 清除本地存储
      clearLocalStorage()
    }
  }
  
  const refreshUserInfo = async () => {
    try {
      const response = await getUserInfo()
      if (response.success) {
        userInfo.value = response.data
        
        // 重新保存到本地存储
        const currentToken = token.value
        const currentPermissions = permissions.value
        saveToLocalStorage(currentToken, response.data, currentPermissions)
      }
    } catch (error) {
      console.error('获取用户信息失败:', error)
      // 如果获取失败，可能token已过期，执行登出
      if (error.status === 401) {
        await logout()
      }
    }
  }
  
  const hasPermission = (permission) => {
    return permissions.value.includes(permission) || userInfo.value?.role === 'Admin'
  }
  
  // 获取当前用户信息（供申报时使用）
  const getCurrentUser = () => {
    const stored = localStorage.getItem('currentUser')
    return stored ? JSON.parse(stored) : null
  }
  
  // 初始化时检查本地存储
  const initializeFromStorage = () => {
    const storedToken = localStorage.getItem('token')
    const storedUserInfo = localStorage.getItem('userInfo')
    const storedPermissions = localStorage.getItem('permissions')
    
    if (storedToken && storedUserInfo) {
      token.value = storedToken
      userInfo.value = JSON.parse(storedUserInfo)
      permissions.value = storedPermissions ? JSON.parse(storedPermissions) : []
    }
  }
  
  return {
    token,
    userInfo,
    permissions,
    isLoggedIn,
    login,
    logout,
    refreshUserInfo,
    hasPermission,
    getCurrentUser,
    initializeFromStorage,
    saveToLocalStorage,
    clearLocalStorage
  }
})