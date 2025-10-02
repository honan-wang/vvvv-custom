import request from './index'

// 用户登录
export function login(data) {
  return request.post('/auth/login', data)
}

// 用户退出登录
export function logout() {
  return request.post('/auth/logout')
}

// 获取用户信息
export function getUserInfo() {
  return request.get('/auth/profile')
}

// 获取验证码
export function getCaptcha() {
  return request.get('/auth/captcha')
}

// 刷新token
export function refreshToken() {
  return request.post('/auth/refresh')
}

// 修改密码
export function changePassword(data) {
  return request.post('/auth/change-password', data)
}

// 重置密码
export function resetPassword(data) {
  return request.post('/auth/reset-password', data)
}