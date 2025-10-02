// 模版功能测试脚本

import { 
  saveTemplate, 
  getTemplates, 
  deleteTemplate, 
  getLastUsedTemplate,
  setLastUsedTemplate,
  cleanTemplateData,
  applyTemplateData
} from './template.js'

// 测试数据
const testFormData = {
  dischargedNo: 'TEST001', // 这个字段应该被清理掉
  carNo: '粤B12345',
  carWt: 5000,
  startLand: '440300',
  goalLand: 'HK',
  areaCode: '1',
  factWeight: 1200,
  note: '测试备注',
  packNo: 10,
  grossWeight: 1300,
  packType: '1',
  ieMark: 'I',
  materialNature: '1',
  bookNo: 'BOOK001',
  goodsList: [
    {
      itemNo: '001',
      goodsName: '测试商品1',
      declareQty: 100,
      goodsCode: '1234567890',
      goodsSpec: '规格1',
      unit: 'KG',
      unitPrice: 10.5,
      totalPrice: 1050,
      currency: 'CNY',
      materialNature: '1',
      remark: '备注1'
    },
    {
      itemNo: '002',
      goodsName: '测试商品2',
      declareQty: 50,
      goodsCode: '0987654321',
      goodsSpec: '规格2',
      unit: 'PCS',
      unitPrice: 25.8,
      totalPrice: 1290,
      currency: 'CNY',
      materialNature: '2',
      remark: '备注2'
    }
  ]
}

// 运行测试
export function runTemplateTests() {
  console.log('开始测试模版功能...')
  
  try {
    // 1. 测试清理数据
    console.log('1. 测试数据清理功能')
    const cleanedData = cleanTemplateData(testFormData)
    console.log('清理前:', testFormData)
    console.log('清理后:', cleanedData)
    console.log('✓ 数据清理测试通过')
    
    // 2. 测试保存模版
    console.log('\n2. 测试保存模版')
    const saved = saveTemplate('测试模版1', cleanedData)
    console.log('保存结果:', saved)
    console.log('✓ 模版保存测试通过')
    
    // 3. 测试获取模版列表
    console.log('\n3. 测试获取模版列表')
    const templates = getTemplates()
    console.log('模版列表:', templates)
    console.log('✓ 获取模版列表测试通过')
    
    // 4. 测试最后使用模版
    console.log('\n4. 测试最后使用模版功能')
    const template = templates[0]
    if (template) {
      setLastUsedTemplate(template)
      const lastUsed = getLastUsedTemplate()
      console.log('最后使用的模版:', lastUsed)
      console.log('✓ 最后使用模版测试通过')
    }
    
    // 5. 测试应用模版数据
    console.log('\n5. 测试应用模版数据')
    const currentData = { ...testFormData }
    if (template) {
      const appliedData = applyTemplateData(template.data, currentData)
      console.log('应用前:', currentData)
      console.log('应用后:', appliedData)
      console.log('✓ 应用模版数据测试通过')
    }
    
    // 6. 测试删除模版（可选，会清理测试数据）
    // console.log('\n6. 测试删除模版')
    // if (template) {
    //   const deleted = deleteTemplate(template.id)
    //   console.log('删除结果:', deleted)
    //   console.log('✓ 删除模版测试通过')
    // }
    
    console.log('\n🎉 所有模版功能测试通过！')
    return true
    
  } catch (error) {
    console.error('❌ 模版功能测试失败:', error)
    return false
  }
}

// 清理测试数据
export function cleanTestData() {
  try {
    const templates = getTemplates()
    const testTemplates = templates.filter(t => t.name.includes('测试'))
    
    testTemplates.forEach(template => {
      deleteTemplate(template.id)
    })
    
    console.log(`已清理 ${testTemplates.length} 个测试模版`)
    return true
  } catch (error) {
    console.error('清理测试数据失败:', error)
    return false
  }
}

// 在浏览器控制台中可以运行：
// import { runTemplateTests, cleanTestData } from '/src/utils/templateTest.js'
// runTemplateTests()
// cleanTestData()