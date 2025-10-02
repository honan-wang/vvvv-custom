<template>
  <el-dialog
    v-model="dialogVisible"
    title="选择模板"
    width="800px"
    :before-close="handleClose"
  >
    <div class="template-dialog">
      <!-- 搜索和筛选 -->
      <div class="search-bar">
        <el-input
          v-model="searchText"
          placeholder="搜索模板名称"
          prefix-icon="Search"
          clearable
          style="width: 300px;"
        />
        <el-select
          v-model="filterType"
          placeholder="模板类型"
          clearable
          style="width: 150px; margin-left: 12px;"
        >
          <el-option label="进口" value="I" />
          <el-option label="出口" value="E" />
        </el-select>
      </div>
      
      <!-- 模板列表 -->
      <div class="template-list" v-loading="loading">
        <el-empty v-if="!filteredTemplates.length" description="暂无模板数据" />
        
        <div class="template-grid" v-else>
          <div
            v-for="template in filteredTemplates"
            :key="template.id"
            class="template-item"
            :class="{ 'selected': selectedTemplate?.id === template.id }"
            @click="selectTemplate(template)"
          >
            <div class="template-header">
              <div class="template-title">{{ template.name }}</div>
              <div class="template-actions">
                <el-tag
                  v-if="template.data && template.data.ieMark"
                  :type="template.data.ieMark === 'I' ? 'success' : 'warning'"
                  size="small"
                >
                  {{ template.data.ieMark === 'I' ? '进口' : '出口' }}
                </el-tag>
                <el-button 
                  size="small" 
                  type="danger" 
                  link 
                  @click="handleDeleteTemplate(template, $event)"
                  style="margin-left: 8px;"
                >
                  删除
                </el-button>
              </div>
            </div>
            
            <div class="template-info">
              <div v-if="template.data && template.data.description" class="info-item description">
                <span class="label">描述：</span>
                <span class="value">{{ template.data.description }}</span>
              </div>
              <div v-if="template.data && template.data.startLand" class="info-item">
                <span class="label">起始地：</span>
                <span class="value">{{ getLocationName(template.data.startLand) }}</span>
              </div>
              <div v-if="template.data && template.data.goalLand" class="info-item">
                <span class="label">目的地：</span>
                <span class="value">{{ getLocationName(template.data.goalLand) }}</span>
              </div>
              <div v-if="template.data && template.data.goodsList" class="info-item">
                <span class="label">商品数：</span>
                <span class="value">{{ template.data.goodsList.length || 0 }}</span>
              </div>
            </div>
            
            <div class="template-footer">
              <div class="create-info">
                <el-icon><Clock /></el-icon>
                创建于 {{ formatDate(template.createTime) }}
              </div>
              <div class="update-date">
                更新于 {{ formatDate(template.updateTime) }}
              </div>
            </div>
            
            <!-- 选中标识 -->
            <div v-if="selectedTemplate?.id === template.id" class="selected-icon">
              <el-icon><Check /></el-icon>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="handleClose">取消</el-button>
        <el-button 
          type="primary" 
          @click="handleConfirm"
          :disabled="!selectedTemplate"
        >
          确定使用
        </el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getTemplates, deleteTemplate, setLastUsedTemplate } from '@/utils/template'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['update:modelValue', 'confirm'])

// 响应式数据
const loading = ref(false)
const searchText = ref('')
const filterType = ref('')
const selectedTemplate = ref(null)
const templates = ref([])

// 计算属性
const dialogVisible = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value)
})

const filteredTemplates = computed(() => {
  let filteredList = templates.value || []
  
  // 按名称搜索
  if (searchText.value) {
    filteredList = filteredList.filter(item => 
      item.name.toLowerCase().includes(searchText.value.toLowerCase())
    )
  }
  
  // 按类型筛选
  if (filterType.value) {
    filteredList = filteredList.filter(item => 
      item.data && item.data.ieMark === filterType.value
    )
  }
  
  return filteredList
})

// 监听对话框显示状态
watch(dialogVisible, (visible) => {
  if (visible) {
    fetchTemplates()
    resetSelection()
  }
})

// 获取模板列表
const fetchTemplates = () => {
  loading.value = true
  try {
    templates.value = getTemplates()
  } catch (error) {
    console.error('获取模板列表失败:', error)
    ElMessage.error('获取模板列表失败')
  } finally {
    loading.value = false
  }
}

// 选择模板
const selectTemplate = (template) => {
  selectedTemplate.value = template
}

// 重置选择
const resetSelection = () => {
  selectedTemplate.value = null
  searchText.value = ''
  filterType.value = ''
}

// 获取地点名称
const getLocationName = (code) => {
  const locationMap = {
    'SZ': '深圳',
    'GZ': '广州',
    'ZH': '珠海',
    'DG': '东莞',
    'HK': '香港',
    'MO': '澳门'
  }
  return locationMap[code] || code
}

// 处理关闭
const handleClose = () => {
  dialogVisible.value = false
  resetSelection()
}

// 处理确认
const handleConfirm = () => {
  if (selectedTemplate.value) {
    // 记录最后使用的模版
    setLastUsedTemplate(selectedTemplate.value)
    
    emit('confirm', selectedTemplate.value)
    handleClose()
  }
}

// 删除模版
const handleDeleteTemplate = async (template, event) => {
  event.stopPropagation() // 阻止事件冒泡
  
  try {
    await ElMessageBox.confirm(
      `确定要删除模版"${template.name}"吗？此操作不可恢复。`,
      '删除确认',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )
    
    const success = deleteTemplate(template.id)
    if (success) {
      ElMessage.success('模版删除成功')
      // 重新获取模版列表
      fetchTemplates()
      // 如果删除的是当前选中的模版，清空选择
      if (selectedTemplate.value?.id === template.id) {
        selectedTemplate.value = null
      }
    } else {
      ElMessage.error('模版删除失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('删除模版失败:', error)
      ElMessage.error('删除模版失败')
    }
  }
}

// 格式化日期
const formatDate = (dateString) => {
  if (!dateString) return '--'
  const date = new Date(dateString)
  return date.toLocaleDateString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit'
  })
}

// 组件挂载时获取数据
onMounted(() => {
  if (dialogVisible.value) {
    fetchTemplates()
  }
})
</script>

<style scoped>
.template-dialog {
  min-height: 400px;
}

.search-bar {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid #e4e7ed;
}

.template-list {
  min-height: 300px;
}

.template-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
  gap: 16px;
}

.template-item {
  border: 1px solid #e4e7ed;
  border-radius: 8px;
  padding: 16px;
  background-color: #fff;
  cursor: pointer;
  transition: all 0.3s;
  position: relative;
}

.template-item:hover {
  border-color: #409eff;
  box-shadow: 0 2px 12px rgba(64, 158, 255, 0.1);
}

.template-item.selected {
  border-color: #409eff;
  background-color: #f0f9ff;
}

.template-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 12px;
}

.template-actions {
  display: flex;
  align-items: center;
  flex-shrink: 0;
}

.template-title {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  flex: 1;
  margin-right: 12px;
}

.template-info {
  margin-bottom: 16px;
}

.info-item {
  display: flex;
  align-items: center;
  margin-bottom: 8px;
  font-size: 14px;
}

.info-item:last-child {
  margin-bottom: 0;
}

.label {
  color: #909399;
  width: 60px;
  flex-shrink: 0;
}

.value {
  color: #606266;
  flex: 1;
}

.template-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 12px;
  border-top: 1px solid #f0f2f5;
  font-size: 12px;
  color: #909399;
}

.create-info {
  display: flex;
  align-items: center;
  gap: 4px;
}

.selected-icon {
  position: absolute;
  top: 12px;
  right: 12px;
  width: 20px;
  height: 20px;
  background-color: #409eff;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 12px;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .template-grid {
    grid-template-columns: 1fr;
  }
  
  .search-bar {
    flex-direction: column;
    gap: 12px;
    align-items: stretch;
  }
  
  .search-bar .el-input,
  .search-bar .el-select {
    width: 100% !important;
    margin-left: 0 !important;
  }
}
</style>