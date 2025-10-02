import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'
import { useUserStore } from '@/stores/user'
import router from '@/router'

// 创建axios实例
const service = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:5002/api',
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json'
  }
})

// 请求拦截器
service.interceptors.request.use(
  config => {
    // 添加认证token
    const userStore = useUserStore()
    if (userStore.token) {
      config.headers['Authorization'] = `Bearer ${userStore.token}`
    }
    
    // 添加请求时间戳防止缓存
    if (config.method === 'get') {
      config.params = {
        ...config.params,
        _t: Date.now()
      }
    }
    
    return config
  },
  error => {
    console.error('请求错误:', error)
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    const res = response.data
    
    // 适配后端的ApiResponse格式：{success: bool, message: string, data: T}
    if (res.success !== undefined) {
      // 如果success为false，则认为是错误
      if (!res.success) {
        ElMessage({
          message: res.message || '请求失败',
          type: 'error',
          duration: 3000
        })
        
        return Promise.reject(new Error(res.message || '请求失败'))
      } else {
        return res
      }
    }
    
    // 兼容原有格式：{code: number}
    if (res.code !== undefined && res.code !== 200) {
      ElMessage({
        message: res.message || '请求失败',
        type: 'error',
        duration: 3000
      })
      
      // 如果是401，说明token过期，需要重新登录
      if (res.code === 401) {
        ElMessageBox.confirm(
          '登录状态已过期，您可以继续留在该页面，或者重新登录',
          '系统提示',
          {
            confirmButtonText: '重新登录',
            cancelButtonText: '取消',
            type: 'warning'
          }
        ).then(() => {
          const userStore = useUserStore()
          userStore.logout().then(() => {
            router.push('/login')
          })
        })
      }
      
      return Promise.reject(new Error(res.message || '请求失败'))
    } else {
      return res
    }
  },
  error => {
    console.error('响应错误:', error)

    // 检查是否配置了跳过错误提示
    const skipErrorMessage = error.config?.skipErrorMessage
    console.log('🔕 skipErrorMessage配置:', skipErrorMessage)

    let message = '网络错误'

    if (error.response) {
      const { status, data } = error.response

      switch (status) {
        case 400:
          message = data.message || '请求参数错误'
          break
        case 401:
          message = '认证失败，请重新登录'
          // 清除本地token并跳转到登录页
          const userStore = useUserStore()
          userStore.logout().then(() => {
            router.push('/login')
          })
          break
        case 403:
          message = '权限不足'
          break
        case 404:
          message = '请求的资源不存在'
          break
        case 500:
          message = '服务器内部错误'
          break
        case 502:
          message = '网关错误'
          break
        case 503:
          message = '服务不可用'
          break
        case 504:
          message = '网关超时'
          break
        default:
          message = data.message || `连接错误${status}`
      }
    } else if (error.code === 'ECONNABORTED') {
      message = '请求超时'
    } else if (error.message.includes('Network Error')) {
      message = '网络连接异常'
    }

    // 如果配置了跳过错误提示，则不显示ElMessage
    if (!skipErrorMessage) {
      ElMessage({
        message,
        type: 'error',
        duration: 3000
      })
    }

    return Promise.reject(error)
  }
)

// 封装请求方法
const request = {
  get(url, config) {
    return service({
      method: 'get',
      url,
      params: config?.params,
      ...config
    })
  },
  
  post(url, data, config) {
    return service({
      method: 'post',
      url,
      data,
      ...config
    })
  },
  
  put(url, data, config) {
    return service({
      method: 'put',
      url,
      data,
      ...config
    })
  },
  
  delete(url, config) {
    return service({
      method: 'delete',
      url,
      ...config
    })
  },
  
  // 文件上传
  upload(url, formData, config) {
    return service({
      method: 'post',
      url,
      data: formData,
      headers: {
        'Content-Type': 'multipart/form-data'
      },
      ...config
    })
  },
  
  // 文件下载
  download(url, params, config) {
    return service({
      method: 'get',
      url,
      params,
      responseType: 'blob',
      ...config
    })
  }
}

export default request