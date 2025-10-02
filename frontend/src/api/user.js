import request from './index'

// 获取用户列表（分页）
export function getUserList(data) {
  return request.post('/user/list', data)
}

// 根据ID获取用户详情
export function getUserById(id) {
  return request.get(`/user/${id}`)
}

// 创建用户
export function createUser(data) {
  return request.post('/user', data)
}

// 更新用户信息
export function updateUser(id, data) {
  return request.put(`/user/${id}`, data)
}

// 删除用户
export function deleteUser(id) {
  return request.delete(`/user/${id}`)
}

// 批量删除用户
export function batchDeleteUsers(ids) {
  return request.delete('/user/batch', ids)
}

// 重置用户密码
export function resetUserPassword(id, newPassword) {
  return request.post(`/user/${id}/reset-password`, { newPassword })
}

// 检查用户名是否存在（如果后端有这个接口）
export function checkUsername(username) {
  return request.get(`/user/check-username`, { params: { username } })
}

// 获取海关关区列表（现在前端不需要了，因为改为了文本框）
export function getCustomsList() {
  return request.get('/customs')
}