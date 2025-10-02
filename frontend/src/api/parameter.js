import request from './index'

/**
 * 系统参数相关API
 */
export const parameterApi = {
  /**
   * 根据参数类型获取参数选项列表（用于下拉框）
   * @param {string} paraType 参数类型，如：PORT_KA（港口代码）
   * @returns {Promise} 参数选项列表
   */
  getParameterOptions(paraType) {
    return request.get(`/SystemParameter/options/${paraType}`)
  },

  /**
   * 获取港口代码选项（起始地、目的地专用）
   * @returns {Promise} 港口代码选项列表
   */
  getPortOptions() {
    return request.get('/SystemParameter/ports')
  },

  /**
   * 获取区域标志选项
   * @returns {Promise} 区域标志选项列表
   */
  getRegionOptions() {
    return request.get('/SystemParameter/regions')
  },

  /**
   * 获取包装种类选项
   * @returns {Promise} 包装种类选项列表
   */
  getWrapTypeOptions() {
    return request.get('/SystemParameter/wrap-types')
  },

  /**
   * 获取账册号选项
   * @returns {Promise} 账册号选项列表
   */
  getBookOptions() {
    return request.get('/SystemParameter/books')
  },

  /**
   * 获取计量单位选项
   * @returns {Promise} 计量单位选项列表
   */
  getUnitOptions() {
    return request.get('/SystemParameter/units')
  },

  /**
   * 获取币制选项
   * @returns {Promise} 币制选项列表
   */
  getCurrencyOptions() {
    return request.get('/SystemParameter/currencies')
  },

  /**
   * 获取所有系统参数
   * @returns {Promise} 系统参数列表
   */
  getAllParameters() {
    return request.get('/SystemParameter')
  },

  /**
   * 根据参数类型获取系统参数
   * @param {string} paraType 参数类型
   * @returns {Promise} 系统参数列表
   */
  getParametersByType(paraType) {
    return request.get(`/SystemParameter/type/${paraType}`)
  },

  /**
   * 获取账册表体信息
   * @param {string} bookNo 账册号
   * @param {string} itemNo 项号
   * @returns {Promise} 账册表体信息
   */
  getBookItemInfo(bookNo, itemNo) {
    return request.get(`/SystemParameter/book-item/${bookNo}/${itemNo}`)
  }
}