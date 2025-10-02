// 模版存储工具函数

const TEMPLATE_KEY = 'declaration_templates'
const LAST_USED_TEMPLATE_KEY = 'last_used_template'

/**
 * 获取所有模版
 * @returns {Array} 模版列表
 */
export function getTemplates() {
  try {
    const templates = localStorage.getItem(TEMPLATE_KEY)
    return templates ? JSON.parse(templates) : []
  } catch (error) {
    console.error('获取模版失败:', error)
    return []
  }
}

/**
 * 保存模版
 * @param {string} name 模版名称
 * @param {Object} data 模版数据
 * @returns {boolean} 保存是否成功
 */
export function saveTemplate(name, data) {
  try {
    const templates = getTemplates()
    
    // 检查模版名称是否已存在
    const existingIndex = templates.findIndex(template => template.name === name)
    
    const templateData = {
      id: existingIndex >= 0 ? templates[existingIndex].id : generateId(),
      name: name,
      data: data,
      createTime: existingIndex >= 0 ? templates[existingIndex].createTime : new Date().toISOString(),
      updateTime: new Date().toISOString()
    }
    
    if (existingIndex >= 0) {
      // 更新现有模版
      templates[existingIndex] = templateData
    } else {
      // 添加新模版
      templates.push(templateData)
    }
    
    localStorage.setItem(TEMPLATE_KEY, JSON.stringify(templates))
    
    // 记录最后使用的模版
    setLastUsedTemplate(templateData)
    
    return true
  } catch (error) {
    console.error('保存模版失败:', error)
    return false
  }
}

/**
 * 删除模版
 * @param {string} id 模版ID
 * @returns {boolean} 删除是否成功
 */
export function deleteTemplate(id) {
  try {
    const templates = getTemplates()
    const filteredTemplates = templates.filter(template => template.id !== id)
    localStorage.setItem(TEMPLATE_KEY, JSON.stringify(filteredTemplates))
    return true
  } catch (error) {
    console.error('删除模版失败:', error)
    return false
  }
}

/**
 * 根据ID获取模版
 * @param {string} id 模版ID
 * @returns {Object|null} 模版数据
 */
export function getTemplateById(id) {
  try {
    const templates = getTemplates()
    return templates.find(template => template.id === id) || null
  } catch (error) {
    console.error('获取模版失败:', error)
    return null
  }
}

/**
 * 设置最后使用的模版
 * @param {Object} template 模版数据
 */
export function setLastUsedTemplate(template) {
  try {
    localStorage.setItem(LAST_USED_TEMPLATE_KEY, JSON.stringify(template))
  } catch (error) {
    console.error('设置最后使用模版失败:', error)
  }
}

/**
 * 获取最后使用的模版
 * @returns {Object|null} 模版数据
 */
export function getLastUsedTemplate() {
  try {
    const template = localStorage.getItem(LAST_USED_TEMPLATE_KEY)
    return template ? JSON.parse(template) : null
  } catch (error) {
    console.error('获取最后使用模版失败:', error)
    return null
  }
}

/**
 * 生成唯一ID
 * @returns {string} 唯一ID
 */
function generateId() {
  return Date.now().toString(36) + Math.random().toString(36).substr(2)
}

/**
 * 清理模版数据 - 移除不需要保存的字段
 * @param {Object} formData 原始表单数据
 * @returns {Object} 清理后的数据
 */
export function cleanTemplateData(formData) {
  const cleanData = JSON.parse(JSON.stringify(formData))
  
  // 不保存系统自动生成的字段
  delete cleanData.dischargedNo
  
  // 清理商品列表中的空数据
  if (cleanData.goodsList) {
    cleanData.goodsList = cleanData.goodsList.map(item => {
      const cleanItem = { ...item }
      // 清理自动计算的总价
      if (!cleanItem.declareQty || !cleanItem.unitPrice) {
        cleanItem.totalPrice = null
      }
      return cleanItem
    })
  }
  
  return cleanData
}

/**
 * 应用模版数据到表单
 * @param {Object} templateData 模版数据
 * @param {Object} currentFormData 当前表单数据
 * @returns {Object} 合并后的表单数据
 */
export function applyTemplateData(templateData, currentFormData) {
  const appliedData = { ...currentFormData }
  
  // 应用模版数据，但保留某些当前值
  Object.keys(templateData).forEach(key => {
    if (key === 'dischargedNo') {
      // 保持当前的核放单编号
      return
    }
    
    if (key === 'goodsList' && Array.isArray(templateData[key])) {
      // 深拷贝商品列表
      appliedData[key] = JSON.parse(JSON.stringify(templateData[key]))
      // 重新计算总价
      appliedData[key].forEach(item => {
        if (item.declareQty && item.unitPrice) {
          item.totalPrice = (item.declareQty * item.unitPrice).toFixed(2)
        }
      })
    } else {
      appliedData[key] = templateData[key]
    }
  })
  
  return appliedData
}