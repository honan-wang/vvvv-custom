import request from './index'

const baseURL = '/vehicle'

export const vehicleAPI = {
  // 获取车辆列表（管理员查看所有）
  getVehicles(params) {
    return request.get(baseURL, { params })
  },

  // 获取用户可管理的车辆列表（只显示自己企业的车辆）
  getManageableVehicles(params) {
    return request.get(`${baseURL}/manageable`, { params })
  },

  // 根据AutoId获取车辆详情
  getVehicleById(autoId) {
    return request.get(`${baseURL}/${autoId}`)
  },

  // 根据车牌号获取车辆信息
  getVehicleByVehicleNo(vehicleNo) {
    return request.get(`${baseURL}/by-vehicle-no/${vehicleNo}`, {
      skipErrorMessage: true // 跳过自动错误提示，由调用方自行处理
    })
  },

  // 创建车辆
  createVehicle(data) {
    return request.post(baseURL, data)
  },

  // 更新车辆
  updateVehicle(autoId, data) {
    return request.put(`${baseURL}/${autoId}`, data)
  },

  // 删除车辆
  deleteVehicle(autoId) {
    return request.delete(`${baseURL}/${autoId}`)
  },

  // 检查车牌号是否存在
  checkVehicleNo(vehicleNo, excludeAutoId = null) {
    const params = excludeAutoId ? { excludeAutoId } : {}
    return request.get(`${baseURL}/check-vehicle-no/${vehicleNo}`, { params })
  },

  // 根据车牌号搜索车辆（用于自动完成）
  searchVehicles(keyword, limit = 10) {
    const params = { keyword, limit }
    return request.get(`${baseURL}/search`, { params })
  }
}

// 保持向后兼容，同时提供新的命名导出
export const vehicleApi = vehicleAPI
export default vehicleAPI