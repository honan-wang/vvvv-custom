import axios from 'axios'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/stores/user'
import router from '@/router'

// 创建axios实例
const request = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:5002/api',
  timeout: 30000, // 增加到30秒，因为后端API需要3-4秒响应时间
  headers: {
    'Content-Type': 'application/json'
  }
})

// 请求拦截器
request.interceptors.request.use(
  (config) => {
    // 从store获取token
    const userStore = useUserStore()
    const token = userStore.token

    console.log('🔐 请求拦截器 - Token:', token ? `${token.substring(0, 20)}...` : 'null')

    // 检查token是否有效
    if (token) {
      try {
        // 分割Token为三部分
        const parts = token.split('.')
        if (parts.length !== 3) {
          throw new Error('Token格式不正确，应该有三个部分')
        }

        // 解析JWT payload（不验证签名，只检查过期时间）
        // 处理base64url编码（替换字符并添加padding）
        let base64 = parts[1].replace(/-/g, '+').replace(/_/g, '/')
        // 添加padding
        while (base64.length % 4) {
          base64 += '='
        }

        const payload = JSON.parse(atob(base64))
        const now = Math.floor(Date.now() / 1000)

        console.log('🕐 Token过期时间:', new Date(payload.exp * 1000).toLocaleString())
        console.log('🕐 当前时间:', new Date(now * 1000).toLocaleString())

        // 如果token未过期，则添加到请求头
        if (payload.exp && payload.exp > now) {
          config.headers.Authorization = `Bearer ${token}`
          console.log('✅ Token有效，已添加到请求头')
        } else {
          // Token已过期，清除本地存储的token
          console.log('❌ Token已过期')
          userStore.logout()
        }
      } catch (error) {
        // Token格式错误，但仍然尝试使用它（让后端验证）
        console.log('⚠️ Token解析失败，直接使用:', error.message)
        config.headers.Authorization = `Bearer ${token}`
      }
    } else {
      console.log('⚠️ 没有Token')
    }

    return config
  },
  (error) => {
    console.error('请求错误:', error)
    return Promise.reject(error)
  }
)

// 响应拦截器
request.interceptors.response.use(
  (response) => {
    const res = response.data

    // 如果是文件下载类型，直接返回
    if (response.config.responseType === 'blob') {
      return response
    }

    // 检查响应状态码是否为成功状态
    if (response.status >= 200 && response.status < 300) {
      // 如果后端返回的数据有success字段，检查该字段
      if (res.hasOwnProperty('success')) {
        if (res.success === true) {
          return res
        } else {
          // 业务错误
          const message = res.message || '请求失败'
          ElMessage.error(message)
          return Promise.reject(new Error(message))
        }
      }
      // 如果没有success字段，认为是成功的
      return res
    }

    // HTTP状态码不是成功状态
    const message = res.message || '请求失败'
    ElMessage.error(message)
    return Promise.reject(new Error(message))
  },
  (error) => {
    console.error('响应错误详情:', {
      message: error.message,
      code: error.code,
      config: {
        url: error.config?.url,
        method: error.config?.method,
        timeout: error.config?.timeout,
        skipErrorMessage: error.config?.skipErrorMessage
      },
      response: error.response ? {
        status: error.response.status,
        statusText: error.response.statusText,
        data: error.response.data
      } : null
    })

    // 检查是否配置了跳过错误提示（通过config.skipErrorMessage配置）
    const skipErrorMessage = error.config?.skipErrorMessage
    console.log('🔕 skipErrorMessage配置:', skipErrorMessage)

    let message = '网络请求失败'

    if (error.response) {
      const { status, data } = error.response

      switch (status) {
        case 401:
          message = '登录已过期，请重新登录'
          // 清除token并跳转到登录页
          const userStore = useUserStore()
          userStore.logout()
          router.push('/login')
          break
        case 403:
          message = '没有权限访问'
          break
        case 404:
          message = '请求的资源不存在'
          break
        case 500:
          message = '服务器内部错误'
          break
        default:
          message = data?.message || `请求失败 (${status})`
      }
    } else if (error.code === 'ECONNABORTED') {
      message = '请求超时'
    } else if (error.message === 'Network Error') {
      message = '网络连接失败'
    }

    // 如果配置了跳过错误提示，则不显示ElMessage
    if (!skipErrorMessage) {
      ElMessage.error(message)
    }

    return Promise.reject(error)
  }
)

export default request