import request from '@/utils/request'

// 获取单一申报列表
export function getUnifiedDeclarationList(data) {
  return request({
    url: '/UnifiedDeclaration/list',
    method: 'post',
    data
  })
}

// 获取单一申报详情
export function getUnifiedDeclarationDetail(dischargedNo) {
  return request({
    url: `/UnifiedDeclaration/detail/${dischargedNo}`,
    method: 'get'
  })
}

// 编辑单一申报
export function editUnifiedDeclaration(dischargedNo, data) {
  return request({
    url: `/UnifiedDeclaration/edit/${dischargedNo}`,
    method: 'put',
    data
  })
}

// 删除单一申报
export function deleteUnifiedDeclaration(dischargedNo) {
  return request({
    url: `/UnifiedDeclaration/delete/${dischargedNo}`,
    method: 'delete'
  })
}