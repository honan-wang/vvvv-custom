import request from './index'

// 鑾峰彇鐢虫姤鍗曞垪琛?
export function getDeclarationList(params) {
  return request.get('/declaration/list', params)
}

// 鑾峰彇鐢虫姤鍗曡鎯?
export function getDeclarationDetail(id) {
  return request.get(`/declaration/detail/${id}`)
}

// 淇濆瓨鐢虫姤鍗?
export function saveDeclaration(data) {
  return request.post('/Declaration/complete', data)
}

// 淇濆瓨绌鸿溅鏍告斁鍗?
export function saveEmptyVehicleDeclaration(data) {
  return request.post('/Declaration/save-empty-vehicle', data)
}

// 鎻愪氦鐢虫姤鍗?
export function submitDeclaration(id) {
  return request.post(`/declaration/submit/${id}`)
}

// 鍒犻櫎鐢虫姤鍗?
export function deleteDeclaration(id) {
  return request.delete(`/declaration/delete/${id}`)
}

// 鎵归噺鍒犻櫎鐢虫姤鍗?
export function batchDeleteDeclaration(ids) {
  return request.post('/declaration/batch-delete', { ids })
}

// 澶嶅埗鐢虫姤鍗?
export function copyDeclaration(id) {
  return request.post(`/declaration/copy/${id}`)
}

// 鑾峰彇鏍告斁鍗曞彿锛堣皟鐢ㄥ瓨鍌ㄨ繃绋嬶級
export function generateDischargedNo() {
  return request.post('/declaration/generate-no')
}

// 鏍规嵁杞︾墝鍙疯幏鍙栬溅杈嗕俊鎭?
export function getVehicleInfo(carNo) {
  return request.get('/vehicle/info', { carNo })
}

// 鏍规嵁鍟嗗搧缂栫爜鑾峰彇鍟嗗搧淇℃伅
export function getGoodsInfo(goodsCode) {
  return request.get('/goods/info', { goodsCode })
}

// 鏍规嵁璐﹀唽鍙疯幏鍙栬处鍐屼俊鎭?
export function getBookInfo(bookNo) {
  return request.get('/book/info', { bookNo })
}

// 鑾峰彇鏈€鍚庝竴绁ㄧ敵鎶ユ暟鎹?
export function getLastDeclaration() {
  return request.get('/declaration/last')
}

// 瀵煎嚭鐢虫姤鍗曟暟鎹?
export function exportDeclaration(params) {
  return request.download('/declaration/export', params)
}

// 瀵煎叆鐢虫姤鍗曟暟鎹?
export function importDeclaration(file) {
  const formData = new FormData()
  formData.append('file', file)
  return request.upload('/declaration/import', formData)
}

// 鑾峰彇鐢虫姤鍗曠粺璁′俊鎭?
export function getDeclarationStats(params) {
  return request.get('/declaration/stats', params)
}

// 妯℃澘鐩稿叧API

// 鑾峰彇妯℃澘鍒楄〃
export function getTemplateList(params) {
  return request.get('/template/list', params)
}

// 鑾峰彇妯℃澘璇︽儏
export function getTemplateDetail(id) {
  return request.get(`/template/detail/${id}`)
}

// 淇濆瓨妯℃澘
export function saveTemplate(data) {
  return request.post('/template/save', data)
}

// 鍒犻櫎妯℃澘
export function deleteTemplate(id) {
  return request.delete(`/template/delete/${id}`)
}

// 搴旂敤妯℃澘
export function applyTemplate(id) {
  return request.post(`/template/apply/${id}`)
}
