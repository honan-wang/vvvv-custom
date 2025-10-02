import request from '@/utils/request'

/**
 * 两步申报流程API
 */

/**
 * 开始申报流程（第一步：提交申请单）
 * @param {string} applicationNo 申请单号
 * @returns {Promise} 申报结果
 */
export function startDeclaration(applicationNo) {
  return request.post(`/TwoStepDeclaration/start/${applicationNo}`)
}

/**
 * 重新申报（被退回后）
 * @param {string} businessNo 业务单号（申请单号或核放单号）
 * @returns {Promise} 申报结果
 */
export function resubmitDeclaration(businessNo) {
  return request.post(`/TwoStepDeclaration/resubmit/${businessNo}`)
}

/**
 * 获取申报状态
 * @param {string} dischargedNo 核放单号
 * @returns {Promise} 申报状态信息
 */
export function getDeclarationStatus(dischargedNo) {
  return request.get(`/TwoStepDeclaration/status/${dischargedNo}`)
}

/**
 * 手动触发第二步（仅用于测试）
 * @param {string} dischargedNo 核放单号
 * @returns {Promise} 申报结果
 */
export function manualSubmitDischarge(dischargedNo) {
  return request.post(`/TwoStepDeclaration/submit-discharge/${dischargedNo}`)
}