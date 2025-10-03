<template>
  <el-dialog
    v-model="dialogVisible"
    :title="dialogTitle"
    width="90%"
    :before-close="handleClose"
    destroy-on-close
    center
    class="create-dialog"
  >
    <div class="dialog-content">
      <!-- 核放单表头 -->
      <el-card class="section-card" shadow="never">
        <template #header>
          <span class="section-title">核放单表头信息</span>
        </template>
        
        <el-form
          ref="headerFormRef"
          :model="formData"
          :rules="headerRules"
          label-width="120px"
          class="header-form"
        >
          <el-row :gutter="24">
            <el-col :span="8">
              <el-form-item label="核放单编号" prop="dischargedNo">
                <el-input 
                  v-model="formData.dischargedNo" 
                  placeholder="系统自动生成"
                  readonly
                  class="readonly-input"
                />
              </el-form-item>
            </el-col>
            
            <el-col :span="8">
              <el-form-item label="车牌号码" prop="carNo" class="required-field">
                <el-autocomplete
                  v-model="formData.carNo"
                  :fetch-suggestions="fetchVehicleSuggestions"
                  placeholder="请输入车牌号码"
                  clearable
                  :trigger-on-focus="false"
                  @select="handleVehicleSelect"
                  @blur="handleCarNoChange"
                  class="full-width"
                  value-key="plateNumber"
                >
                  <template #default="{ item }">
                    <div class="suggestion-item">
                      <div class="plate-number">{{ item.plateNumber }}</div>
                      <div class="vehicle-info">
                        {{ item.vehicleType }} | 车重:{{ item.vehicleWeight }}kg | {{ item.operatingCompany }}
                      </div>
                    </div>
                  </template>
                </el-autocomplete>
              </el-form-item>
            </el-col>
            
            <el-col :span="8">
              <el-form-item label="车重(kg)" prop="carWt" class="required-field">
                <el-input-number
                  v-model="formData.carWt"
                  :min="0"
                  :precision="2"
                  placeholder="请输入车重"
                  class="full-width"
                  controls-position="right"
                  @change="calculateTotalWeight"
                />
              </el-form-item>
            </el-col>
          </el-row>
          
          <el-row :gutter="24">
            <el-col :span="8">
              <el-form-item label="起始地" prop="startLand" class="required-field">
                <el-select v-model="formData.startLand" placeholder="请选择起始地" class="full-width">
                  <el-option 
                    v-for="option in startPortOptions" 
                    :key="option.value" 
                    :label="option.label" 
                    :value="option.value" 
                  />
                </el-select>
              </el-form-item>
            </el-col>
            
            <el-col :span="8">
              <el-form-item label="目的地" prop="goalLand" class="required-field">
                <el-select v-model="formData.goalLand" placeholder="请选择目的地" class="full-width">
                  <el-option 
                    v-for="option in goalPortOptions" 
                    :key="option.value" 
                    :label="option.label" 
                    :value="option.value" 
                  />
                </el-select>
              </el-form-item>
            </el-col>
            
            <el-col :span="8">
              <el-form-item label="区域标志" prop="areaCode" class="required-field">
                <el-select v-model="formData.areaCode" placeholder="请选择区域标志" class="full-width">
                  <el-option 
                    v-for="option in regionOptions" 
                    :key="option.value" 
                    :label="option.label" 
                    :value="option.value" 
                  />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          
          <el-row :gutter="24">
            <el-col :span="8">
              <el-form-item label="空车核放单" prop="emptyCarDischarge">
                <el-switch
                  v-model="formData.emptyCarDischarge"
                  active-text="是"
                  inactive-text="否"
                  :active-value="true"
                  :inactive-value="false"
                />
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </el-card>
      
      <!-- 申请单信息 -->
      <el-card class="section-card" shadow="never">
        <template #header>
          <span class="section-title">申请单表头信息</span>
        </template>
        
        <el-form
          ref="applicationFormRef"
          :model="formData"
          :rules="applicationRules"
          label-width="120px"
          class="header-form"
        >
          <el-row :gutter="24">
            <el-col :span="8">
              <el-form-item label="毛重(kg)" prop="grossWeight" class="required-field">
                <el-input-number
                  v-model="formData.grossWeight"
                  :min="0"
                  :precision="2"
                  placeholder="请输入毛重"
                  class="full-width"
                  controls-position="right"
                  @change="calculateTotalWeight"
                />
              </el-form-item>
            </el-col>

            <el-col :span="8">
              <el-form-item label="包装件数" prop="packNo" class="required-field">
                <el-input-number
                  v-model="formData.packNo"
                  :min="0"
                  :precision="0"
                  placeholder="请输入包装件数"
                  class="full-width"
                  controls-position="right"
                />
              </el-form-item>
            </el-col>
             <el-col :span="8">
              <el-form-item label="总重量(kg)" prop="factWeight">
                <el-input-number
                  v-model="formData.factWeight"
                  :min="0"
                  :precision="2"
                  placeholder="自动计算：毛重+车重"
                  class="full-width readonly-input"
                  controls-position="right"
                  readonly
                />
              </el-form-item>
            </el-col>
            
          </el-row>
          
          <el-row :gutter="24">
            <el-col :span="8">
              <el-form-item label="包装种类" prop="packType" class="required-field">
                <el-select v-model="formData.packType" placeholder="请选择包装种类" class="full-width">
                  <el-option 
                    v-for="option in wrapTypeOptions" 
                    :key="option.value" 
                    :label="option.label" 
                    :value="option.value" 
                  />
                </el-select>
              </el-form-item>
            </el-col>
            
            <el-col :span="8">
              <el-form-item label="进出标志" prop="ieMark" class="required-field">
                <el-select v-model="formData.ieMark" placeholder="请选择进出标志" class="full-width" :disabled="true">
                  <el-option label="进口" value="1" />
                  <el-option label="出口" value="2" />
                </el-select>
              </el-form-item>
            </el-col>
            
            <el-col :span="8">
              <el-form-item label="料件性质" prop="materialNature" class="required-field">
                <el-select v-model="formData.materialNature" placeholder="请选择料件性质" class="full-width">
                  <el-option label="成品" value="1" />
                  <el-option label="料件" value="3" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item label="账册号" prop="bookNo" class="required-field">
                <el-select 
                  v-model="formData.bookNo" 
                  placeholder="请选择账册号"
                  class="full-width"
                  filterable
                  clearable
                  @change="handleBookNoChange"
                >
                  <el-option 
                    v-for="option in bookOptions" 
                    :key="option.value" 
                    :label="option.label" 
                    :value="option.value" 
                  />
                </el-select>
              </el-form-item>
            </el-col>
            
            <el-col :span="12">
              <el-form-item label="备注" prop="note">
                <el-input 
                  v-model="formData.note" 
                  placeholder="请输入备注信息"
                  maxlength="200"
                  show-word-limit
                  type="textarea"
                  :rows="1"
                />
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </el-card>
      
      <!-- 商品表体 -->
      <el-card class="section-card" shadow="never">
        <template #header>
          <div class="section-header">
            <span class="section-title">商品表体信息</span>
            <el-button type="primary" size="small" icon="Plus" @click="addGoodsRow">
              添加商品
            </el-button>
          </div>
        </template>
        
        <el-table
          :data="formData.goodsList"
          border
          stripe
          max-height="300"
          class="goods-table full-width-table"
        >
          <el-table-column type="index" label="序号" width="60" align="center" fixed />

          <el-table-column label="项号" width="100" fixed>
            <template #default="{ row, $index }">
              <el-input
                v-model="row.itemNo"
                placeholder="项号"
                size="small"
                class="required-goods-field"
                @blur="handleItemNoChange(row, $index)"
              />
            </template>
          </el-table-column>

          <el-table-column label="申报数量" min-width="150">
            <template #default="{ row, $index }">
              <el-input-number
                v-model="row.declareQty"
                :min="0"
                :precision="2"
                size="small"
                class="full-width required-goods-field"
                controls-position="right"
                @change="calculateTotal($index)"
              />
            </template>
          </el-table-column>

          <el-table-column label="商品总价" min-width="120">
            <template #default="{ row, $index }">
              <el-input-number
                v-model="row.totalPrice"
                :min="0"
                :precision="2"
                size="small"
                class="full-width required-goods-field"
                controls-position="right"
                @change="calculateUnitPrice($index)"
              />
            </template>
          </el-table-column>

          <el-table-column label="商品单价" min-width="120">
            <template #default="{ row, $index }">
              <el-input-number
                v-model="row.unitPrice"
                :min="0"
                :precision="4"
                size="small"
                class="full-width"
                controls-position="right"
                @change="calculateTotal($index)"
              />
            </template>
          </el-table-column>

          <el-table-column label="商品名称" min-width="150">
            <template #default="{ row, $index }">
              <el-input
                v-model="row.goodsName"
                placeholder="商品名称"
                size="small"
                class="required-goods-field"
              />
            </template>
          </el-table-column>

          <el-table-column label="商品规格" min-width="150">
            <template #default="{ row, $index }">
              <el-input
                v-model="row.goodsSpec"
                placeholder="商品规格"
                size="small"
                class="required-goods-field"
              />
            </template>
          </el-table-column>

          <el-table-column label="商品编码" min-width="120">
            <template #default="{ row, $index }">
              <el-input
                v-model="row.goodsCode"
                placeholder="编码"
                size="small"
                class="required-goods-field"
              />
            </template>
          </el-table-column>

          <el-table-column label="计量单位" min-width="100">
            <template #default="{ row, $index }">
              <el-select
                v-model="row.unit"
                placeholder="单位"
                size="small"
                class="full-width required-goods-field"
              >
                <el-option
                  v-for="option in unitOptions"
                  :key="option.value"
                  :label="option.label"
                  :value="option.value"
                />
              </el-select>
            </template>
          </el-table-column>

          <el-table-column label="币制" min-width="100">
            <template #default="{ row, $index }">
              <el-select
                v-model="row.currency"
                placeholder="币制"
                size="small"
                class="full-width required-goods-field"
              >
                <el-option
                  v-for="option in currencyOptions"
                  :key="option.value"
                  :label="option.label"
                  :value="option.value"
                />
              </el-select>
            </template>
          </el-table-column>
          
          <el-table-column label="操作" width="80" align="center" fixed="right">
            <template #default="{ row, $index }">
              <el-button 
                type="danger" 
                size="small"
                icon="Delete"
                link
                @click="removeGoodsRow($index)"
                :disabled="formData.goodsList.length <= 1"
              />
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </div>
    
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="handleClose">取消</el-button>
        <el-button @click="handleLoadTemplate">加载模版</el-button>
        <el-button @click="handleSaveAsTemplate">保存为模版</el-button>
        <el-button type="primary" @click="handleSave" :loading="saving">
          保存
        </el-button>
        <el-button type="success" @click="handleSubmit" :loading="submitting">
          申报
        </el-button>
      </div>
    </template>
    
    <!-- 保存模版对话框 -->
    <SaveTemplateDialog
      v-model="showSaveTemplateDialog"
      :form-data="formData"
      @confirm="handleSaveTemplateConfirm"
    />
    
    <!-- 加载模版对话框 -->
    <TemplateDialog
      v-model="showTemplateDialog"
      @confirm="handleTemplateConfirm"
    />
  </el-dialog>
</template>

<script setup>
import { ref, reactive, computed, watch, nextTick } from 'vue'
import { ElMessage } from 'element-plus'
import { useDeclarationStore } from '@/stores/declaration'
import { vehicleAPI } from '@/api/vehicle'
import { parameterApi } from '@/api/parameter'
import { getLastUsedTemplate, applyTemplateData } from '@/utils/template'
import SaveTemplateDialog from './SaveTemplateDialog.vue'
import TemplateDialog from './TemplateDialog.vue'

// 定义组件props和emits
const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  type: {
    type: String,
    default: 'import',
    validator: (value) => ['import', 'export'].includes(value)
  }
})

const emit = defineEmits(['update:modelValue', 'success', 'close'])

// 状态管理
const declarationStore = useDeclarationStore()

// 响应式数据
const headerFormRef = ref(null)
const applicationFormRef = ref(null)
const saving = ref(false)
const submitting = ref(false)
const showSaveTemplateDialog = ref(false)
const showTemplateDialog = ref(false)

// 下拉框选项数据
const allPortOptions = ref([])  // 港口代码选项
const filterPortOptions = (remarkFlag) => {
  const options = allPortOptions.value || []
  const hasRemark = options.some((option) => {
    if (!option) {
      return false
    }
    const remarkValue = option.remark === undefined || option.remark === null ? '' : String(option.remark).trim()
    return remarkValue !== ''
  })

  if (!hasRemark) {
    return options
  }

  return options.filter((option) => {
    if (!option) {
      return false
    }
    const optionRemark = option.remark === undefined || option.remark === null ? '' : String(option.remark)
    return optionRemark === String(remarkFlag)
  })
}

const startPortOptions = computed(() => {
  return props.type === 'import' ? filterPortOptions('1') : filterPortOptions('2')
})

const goalPortOptions = computed(() => {
  return props.type === 'import' ? filterPortOptions('2') : filterPortOptions('1')
})
const regionOptions = ref([])  // 区域标志选项
const wrapTypeOptions = ref([])  // 包装种类选项
const bookOptions = ref([])  // 账册号选项
const unitOptions = ref([])  // 计量单位选项
const currencyOptions = ref([])  // 币制选项

// 对话框显示状态
const dialogVisible = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value)
})

// 对话框标题
const dialogTitle = computed(() => {
  return props.type === 'import' ? '新建进口申报单' : '新建出口申报单'
})

// 表单数据
const formData = reactive({
  dischargedNo: '',
  carNo: '',
  carWt: null,
  startLand: '',
  goalLand: '',
  areaCode: '',
  emptyCarDischarge: false,
  factWeight: null,
  note: '',
  packNo: null,
  grossWeight: null,
  packType: '',
  ieMark: props.type === 'import' ? 'I' : 'E',
  materialNature: '',
  bookNo: '',
  goodsList: [
    {
      itemNo: '',
      goodsName: '',
      declareQty: null,
      goodsCode: '',
      goodsSpec: '',
      unit: '',
      unitPrice: null,
      totalPrice: null,
      currency: 'CNY',
      materialNature: '',
      remark: ''
    }
  ]
})

// 核放单表头验证规则（空车核放单时只验证这些）
const headerRules = {
  carNo: [
    { required: true, message: '请输入车牌号码', trigger: 'blur' }
  ],
  carWt: [
    { required: true, message: '请输入车重', trigger: 'blur' }
  ],
  startLand: [
    { required: true, message: '请选择起始地', trigger: 'change' }
  ],
  goalLand: [
    { required: true, message: '请选择目的地', trigger: 'change' }
  ],
  areaCode: [
    { required: true, message: '请选择区域标志', trigger: 'change' }
  ]
}

// 申请单验证规则（非空车核放单时需要验证）
const applicationRules = {
  grossWeight: [
    { required: true, message: '请输入毛重', trigger: 'blur' }
  ],
  packNo: [
    { required: true, message: '请输入包装件数', trigger: 'blur' }
  ],
  ieMark: [
    { required: true, message: '请选择进出标志', trigger: 'change' }
  ],
  packType: [
    { required: true, message: '请选择包装种类', trigger: 'change' }
  ],
  materialNature: [
    { required: true, message: '请选择料件性质', trigger: 'change' }
  ],
  bookNo: [
    { required: true, message: '请选择账册号', trigger: 'change' }
  ]
}

// 监听type变化，更新进出标志
watch(() => props.type, (newType) => {
  formData.ieMark = newType === 'import' ? 'I' : 'E'
}, { immediate: true })

// 监听对话框打开，初始化数据
watch(() => props.modelValue, (newValue) => {
  if (newValue) {
    initFormData()
    loadPortOptions()
    loadRegionOptions()
    loadWrapTypeOptions()
    loadBookOptions()
    loadUnitOptions()
    loadCurrencyOptions()
    loadLastUsedTemplate()
  }
})

watch(startPortOptions, (options) => {
  if (!options.some((option) => option.value === formData.startLand)) {
    formData.startLand = ''
  }
  if (options.length === 1) {
    const [onlyOption] = options
    if (onlyOption && onlyOption.value !== undefined && onlyOption.value !== null) {
      formData.startLand = onlyOption.value
    }
  }
}, { immediate: true })

watch(goalPortOptions, (options) => {
  if (!options.some((option) => option.value === formData.goalLand)) {
    formData.goalLand = ''
  }
  if (options.length === 1) {
    const [onlyOption] = options
    if (onlyOption && onlyOption.value !== undefined && onlyOption.value !== null) {
      formData.goalLand = onlyOption.value
    }
  }
}, { immediate: true })

watch(regionOptions, (options) => {
  if (!options.some((option) => option.value === formData.areaCode)) {
    formData.areaCode = ''
  }
  if (options.length === 1) {
    const [onlyOption] = options
    if (onlyOption && onlyOption.value !== undefined && onlyOption.value !== null) {
      formData.areaCode = onlyOption.value
    }
  }
}, { immediate: true })

// 初始化表单数据
const initFormData = () => {
  // 重置表单数据
  Object.keys(formData).forEach(key => {
    if (key === 'goodsList') {
      formData[key] = [
        {
          itemNo: '',
          goodsName: '',
          declareQty: null,
          goodsCode: '',
          goodsSpec: '',
          unit: '',
          unitPrice: null,
          totalPrice: null,
          currency: 'CNY',
          materialNature: '',
          remark: ''
        }
      ]
    } else if (key === 'ieMark') {
      formData[key] = props.type === 'import' ? 'I' : 'E'
    } else if (key === 'emptyCarDischarge') {
      formData[key] = false
    } else {
      formData[key] = ['carWt', 'factWeight', 'packNo', 'grossWeight'].includes(key) ? null : ''
    }
  })
}

// 添加商品行
const addGoodsRow = () => {
  formData.goodsList.push({
    itemNo: '',
    goodsName: '',
    declareQty: null,
    goodsCode: '',
    goodsSpec: '',
    unit: '',
    unitPrice: null,
    totalPrice: null,
    currency: 'CNY',
    materialNature: '',
    remark: ''
  })
}

// 删除商品行
const removeGoodsRow = (index) => {
  if (formData.goodsList.length > 1) {
    formData.goodsList.splice(index, 1)
  }
}

// 计算总价（从数量和单价计算）
const calculateTotal = (index) => {
  const item = formData.goodsList[index]
  if (item.declareQty && item.unitPrice) {
    item.totalPrice = (item.declareQty * item.unitPrice).toFixed(2)
  }
}

// 计算单价（从总价和数量计算）
const calculateUnitPrice = (index) => {
  const item = formData.goodsList[index]
  if (item.totalPrice && item.declareQty && item.declareQty > 0) {
    item.unitPrice = (item.totalPrice / item.declareQty).toFixed(4)
  }
}

// 计算总重量：毛重 + 车重
const calculateTotalWeight = () => {
  const grossWeight = formData.grossWeight || 0
  const carWeight = formData.carWt || 0
  formData.factWeight = grossWeight + carWeight
}

// 车辆自动完成功能
const fetchVehicleSuggestions = async (queryString, callback) => {
  if (!queryString) {
    callback([])
    return
  }
  
  try {
    const response = await vehicleAPI.searchVehicles(queryString, 10)
    const suggestions = response.data || []
    
    // 转换数据格式以匹配Element Plus Autocomplete组件
    const formattedSuggestions = suggestions.map(vehicle => ({
      id: vehicle.autoId,
      plateNumber: vehicle.vehicleNo,
      vehicleType: vehicle.vehicleType,
      vehicleWeight: vehicle.vehicleWt,
      loadWeight: vehicle.loadWt,
      operatingCompany: vehicle.tradeName,
      value: vehicle.vehicleNo // Autocomplete组件需要的value字段
    }))
    
    callback(formattedSuggestions)
  } catch (error) {
    console.error('获取车辆建议失败:', error)
    callback([])
  }
}

// 选择车辆时的处理
const handleVehicleSelect = (selectedVehicle) => {
  if (selectedVehicle) {
    // 自动填充车牌号和车重
    formData.carNo = selectedVehicle.plateNumber
    formData.carWt = selectedVehicle.vehicleWeight
    
    // 计算总重量
    calculateTotalWeight()
    
    ElMessage.success(`已选择车辆：${selectedVehicle.plateNumber}`)
  }
}

// 车牌号失去焦点时的处理
const handleCarNoChange = async () => {
  if (!formData.carNo) {
    // 只有在车牌号为空且车重也为空时才清空车重，避免意外清空已填充的车重
    if (!formData.carWt) {
      formData.carWt = null
      calculateTotalWeight()
    }
    return
  }

  try {
    // 根据车牌号获取车辆详细信息
    const response = await vehicleAPI.getVehicleByVehicleNo(formData.carNo)

    if (response.data) {
      const vehicle = response.data
      // 只有在车重为空或与当前车重不同时才自动填充，避免覆盖用户已修改的车重
      if (!formData.carWt || formData.carWt !== vehicle.vehicleWt) {
        formData.carWt = vehicle.vehicleWt
        // 计算总重量
        calculateTotalWeight()
        ElMessage.success(`已自动填充车重：${vehicle.vehicleWt}kg`)
      }
    }
  } catch (error) {
    // 如果是404错误（车辆不存在），提示用户手动输入，不显示错误弹框
    if (error.response && error.response.status === 404) {
      ElMessage.info('未找到该车辆信息，请手动输入车重')
    }
    // 其他错误静默处理，让用户手动输入
    console.log('车辆信息查询失败，需要手动输入车重:', error.message)
  }
}

// 加载港口选项数据
const loadPortOptions = async () => {
  try {
    const response = await parameterApi.getPortOptions()
    if (response.success && response.data) {
      allPortOptions.value = (response.data || [])
    }
  } catch (error) {
    console.error('加载港口选项失败:', error)
    ElMessage.error('加载港口选项失败')
  }
}

// 加载区域标志选项数据
const loadRegionOptions = async () => {
  try {
    const response = await parameterApi.getRegionOptions()
    if (response.success && response.data) {
      regionOptions.value = response.data
    }
  } catch (error) {
    console.error('加载区域标志选项失败:', error)
    ElMessage.error('加载区域标志选项失败')
  }
}

// 加载包装种类选项数据
const loadWrapTypeOptions = async () => {
  try {
    const response = await parameterApi.getWrapTypeOptions()
    if (response.success && response.data) {
      wrapTypeOptions.value = response.data
    }
  } catch (error) {
    console.error('加载包装种类选项失败:', error)
    ElMessage.error('加载包装种类选项失败')
  }
}

// 加载账册号选项数据
const loadBookOptions = async () => {
  try {
    const response = await parameterApi.getBookOptions()
    if (response.success && response.data) {
      bookOptions.value = response.data
      
      // 如果只有1条数据，自动选择
      if (response.data.length === 1) {
        formData.bookNo = response.data[0].value
        ElMessage.success(`已自动选择账册：${response.data[0].label}`)
      }
    }
  } catch (error) {
    console.error('加载账册号选项失败:', error)
    ElMessage.error('加载账册号选项失败')
  }
}

// 加载计量单位选项数据
const loadUnitOptions = async () => {
  try {
    const response = await parameterApi.getUnitOptions()
    if (response.success && response.data) {
      unitOptions.value = response.data
    }
  } catch (error) {
    console.error('加载计量单位选项失败:', error)
    ElMessage.error('加载计量单位选项失败')
  }
}

// 加载币制选项数据
const loadCurrencyOptions = async () => {
  try {
    const response = await parameterApi.getCurrencyOptions()
    if (response.success && response.data) {
      currencyOptions.value = response.data
    }
  } catch (error) {
    console.error('加载币制选项失败:', error)
    ElMessage.error('加载币制选项失败')
  }
}

// 处理账册号变化
const handleBookNoChange = (value) => {
  // 当账册号变化时，清空所有商品项号
  if (formData.goodsList) {
    formData.goodsList.forEach(item => {
      item.itemNo = ''
      item.goodsName = ''
      item.goodsCode = ''
      item.goodsSpec = ''
      item.unit = ''
      item.currency = ''
    })
  }
}

// 验证商品表体必填字段
const validateGoodsList = () => {
  if (!formData.goodsList || formData.goodsList.length === 0) {
    return { isValid: false, message: '商品表体信息不能为空' }
  }

  // 检查是否有至少一行有效数据
  const hasValidGoods = formData.goodsList.some(item =>
    item.itemNo || item.goodsName || item.declareQty > 0 || item.totalPrice > 0 ||
    item.goodsSpec || item.goodsCode || item.unit || item.currency
  )

  if (!hasValidGoods) {
    return { isValid: false, message: '商品表体至少要有一条有效数据' }
  }

  // 验证每一行的必填字段
  for (let i = 0; i < formData.goodsList.length; i++) {
    const item = formData.goodsList[i]
    const rowNum = i + 1

    // 如果这一行有任何数据，那么必填字段都需要填写
    const hasAnyData = item.itemNo || item.goodsName || item.declareQty > 0 || item.totalPrice > 0 ||
                      item.goodsSpec || item.goodsCode || item.unit || item.currency || item.unitPrice > 0

    if (hasAnyData) {
      // 检查必填字段
      if (!item.itemNo) {
        return { isValid: false, message: `第${rowNum}行：项号为必填项` }
      }
      if (!item.declareQty || item.declareQty <= 0) {
        return { isValid: false, message: `第${rowNum}行：申报数量为必填项且必须大于0` }
      }
      if (!item.totalPrice || item.totalPrice <= 0) {
        return { isValid: false, message: `第${rowNum}行：商品总价为必填项且必须大于0` }
      }
      if (!item.goodsName) {
        return { isValid: false, message: `第${rowNum}行：商品名称为必填项` }
      }
      if (!item.goodsSpec) {
        return { isValid: false, message: `第${rowNum}行：商品规格为必填项` }
      }
      if (!item.goodsCode) {
        return { isValid: false, message: `第${rowNum}行：商品编码为必填项` }
      }
      if (!item.unit) {
        return { isValid: false, message: `第${rowNum}行：计量单位为必填项` }
      }
      if (!item.currency) {
        return { isValid: false, message: `第${rowNum}行：币制为必填项` }
      }
    }
  }

  return { isValid: true, message: '' }
}

// 处理项号变化
const handleItemNoChange = async (row, index) => {
  if (!row.itemNo || !formData.bookNo) {
    return
  }
  
  try {
    // 确保单位选项已经加载
    if (unitOptions.value.length === 0) {
      await loadUnitOptions()
    }
    
    // 调用API查询账册表体信息
    const response = await parameterApi.getBookItemInfo(formData.bookNo, row.itemNo)
    
    if (response.success && response.data) {
      const itemInfo = response.data

      // 自动填充商品信息
      row.goodsName = itemInfo.goodsName || itemInfo.G_NAME || ''
      row.goodsCode = itemInfo.goodsCode || itemInfo.CODE_TS || ''
      row.goodsSpec = itemInfo.goodsSpec || itemInfo.G_MODEL || ''
      
      // 根据单位代码匹配下拉框选项
      const unitCode = (itemInfo.UNIT || itemInfo.unit || '').trim()
      
      if (unitCode) {
        // 在unitOptions中查找匹配的选项
        const matchedUnit = unitOptions.value.find(option => option.value === unitCode)
        
        if (matchedUnit) {
          // 先清空再设置，确保触发变化
          row.unit = ''
          await nextTick()
          row.unit = matchedUnit.value
        } else {
          // 如果没有匹配到，直接使用代码
          row.unit = unitCode
        }
      } else {
        row.unit = ''
      }

      // 根据币制代码匹配下拉框选项
      const currencyCode = (itemInfo.CURR || itemInfo.currency || '').trim()

      if (currencyCode) {
        // 确保币制选项已经加载
        if (currencyOptions.value.length === 0) {
          await loadCurrencyOptions()
        }

        // 在currencyOptions中查找匹配的选项
        const matchedCurrency = currencyOptions.value.find(option => option.value === currencyCode)

        if (matchedCurrency) {
          // 先清空再设置，确保触发变化
          row.currency = ''
          await nextTick()
          row.currency = matchedCurrency.value
        } else {
          // 如果没有匹配到，直接使用代码
          row.currency = currencyCode
        }
      }
      
      ElMessage.success('已自动填充商品信息')
    } else {
      ElMessage.warning('未找到对应的项号信息，请检查项号是否正确')
      // 清空自动填充的字段
      row.goodsName = ''
      row.goodsCode = ''
      row.goodsSpec = ''
      row.unit = ''
      row.currency = ''
    }
  } catch (error) {
    console.error('查询项号信息失败:', error)
    ElMessage.error('查询项号信息失败')
    // 清空自动填充的字段
    row.goodsName = ''
    row.goodsCode = ''
    row.goodsSpec = ''
    row.unit = ''
    row.currency = ''
  }
}

// 处理保存
const handleSave = async () => {
  try {
    // 根据空车核放单状态进行条件验证
    await headerFormRef.value?.validate()
    
    // 如果不是空车核放单，需要验证申请单表单
    if (!formData.emptyCarDischarge) {
      await applicationFormRef.value?.validate()
      
      // 验证商品表体不能为空
      if (!formData.goodsList || formData.goodsList.length === 0) {
        ElMessage.error('空车核放单为否时，商品表体信息不允许为空，至少要有一条数据')
        return
      }
      
      // 验证商品表体必填字段
      const goodsValidationResult = validateGoodsList()
      if (!goodsValidationResult.isValid) {
        ElMessage.error(goodsValidationResult.message)
        return
      }
    }
    
    saving.value = true
    
    let dischargedNo = null
    
    // 调用保存API - 根据是否空车核放单选择不同的API
    if (formData.emptyCarDischarge) {
      // 空车核放单使用专门的API
      dischargedNo = await declarationStore.saveEmptyVehicleDeclarationData(formData)
    } else {
      // 非空车核放单使用新的API
      dischargedNo = await declarationStore.saveDeclarationData(formData)
    }
    
    // 更新表单中的核放单编号
    if (dischargedNo) {
      formData.dischargedNo = dischargedNo
    }
    
    ElMessage.success('保存成功')
    emit('success')
  } catch (error) {
    console.error('保存失败:', error)
    if (error.message) {
      ElMessage.error(error.message)
    } else {
      ElMessage.error('保存失败')
    }
  } finally {
    saving.value = false
  }
}

// 处理提交
const handleSubmit = async () => {
  try {
    // 先保存（保存时已包含所有验证逻辑）
    await handleSave()
    
    submitting.value = true
    
    // 然后提交
    await declarationStore.submitDeclarationData(formData.dischargedNo)
    
    ElMessage.success('提交成功')
    emit('success')
  } catch (error) {
    console.error('提交失败:', error)
    ElMessage.error('提交失败')
  } finally {
    submitting.value = false
  }
}

// 加载最近使用的模版
const loadLastUsedTemplate = async () => {
  try {
    const lastTemplate = getLastUsedTemplate()
    if (lastTemplate && lastTemplate.data) {
      // 检查模版类型是否匹配当前申报类型
      if (lastTemplate.data.ieMark === formData.ieMark) {
        const appliedData = applyTemplateData(lastTemplate.data, formData)
        Object.assign(formData, appliedData)
        
        // 重新计算商品总价
        if (formData.goodsList) {
          formData.goodsList.forEach((item, index) => {
            calculateTotal(index)
          })
        }
        
        ElMessage.success(`已自动加载模版：${lastTemplate.name}`)
      }
    }
  } catch (error) {
    console.error('加载最近使用模版失败:', error)
  }
}

// 加载模版
const handleLoadTemplate = () => {
  showTemplateDialog.value = true
}

// 保存为模版
const handleSaveAsTemplate = () => {
  showSaveTemplateDialog.value = true
}

// 处理模版选择确认
const handleTemplateConfirm = (template) => {
  try {
    if (template && template.data) {
      const appliedData = applyTemplateData(template.data, formData)
      Object.assign(formData, appliedData)
      
      // 重新计算商品总价
      if (formData.goodsList) {
        formData.goodsList.forEach((item, index) => {
          calculateTotal(index)
        })
      }
      
      ElMessage.success(`已加载模版：${template.name}`)
    }
  } catch (error) {
    console.error('应用模版失败:', error)
    ElMessage.error('应用模版失败')
  }
}

// 处理保存模版确认
const handleSaveTemplateConfirm = (templateInfo) => {
  ElMessage.success(`模版"${templateInfo.templateName}"保存成功`)
}

// 关闭对话框
const handleClose = () => {
  emit('close')
}
</script>

<style scoped>
.create-dialog :deep(.el-dialog) {
  margin: 3vh auto !important;
}

.create-dialog :deep(.el-dialog__body) {
  padding: 8px 16px;
  max-height: 80vh;
  overflow-y: auto;
}

.dialog-content {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.section-card {
  margin-bottom: 12px;
}

.section-card:last-child {
  margin-bottom: 0;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
}

.header-form :deep(.el-form-item) {
  margin-bottom: 12px;
}

/* 必填项黄色底色样式 */
.required-field :deep(.el-input__inner),
.required-field :deep(.el-select .el-input__inner),
.required-field :deep(.el-textarea__inner) {
  background-color: #fffbe6 !important;
}

.required-field :deep(.el-input-number .el-input__inner) {
  background-color: #fffbe6 !important;
}

/* 商品表体必填项样式 */
.required-goods-field :deep(.el-input__inner),
.required-goods-field :deep(.el-select .el-input__inner),
.required-goods-field :deep(.el-input-number .el-input__inner) {
  background-color: #fffbe6 !important;
}

.full-width {
  width: 100%;
}

.readonly-input :deep(.el-input__inner) {
  background-color: #f5f7fa;
  cursor: not-allowed;
}

.goods-table :deep(.el-input-number) {
  width: 100%;
}

.goods-table :deep(.el-input-number .el-input__inner) {
  text-align: left;
}

/* 表格布局优化 - 充分利用空间 */
.full-width-table {
  width: 100%;
}

.full-width-table :deep(.el-table__body-wrapper) {
  overflow-x: auto;
}

.full-width-table :deep(.el-table__header-wrapper) {
  overflow-x: auto;
}

/* 表格内控件充满单元格 */
.goods-table :deep(.el-table__cell) {
  padding: 6px 8px;
}

.goods-table :deep(.el-input),
.goods-table :deep(.el-select),
.goods-table :deep(.el-input-number) {
  width: 100%;
}

.dialog-footer {
  display: flex;
  justify-content: center;
  gap: 12px;
}

:deep(.el-card__header) {
  padding: 10px 16px;
  background-color: #fafafa;
  border-bottom: 1px solid #ebeef5;
}

:deep(.el-card__body) {
  padding: 16px;
}

/* 车辆建议列表样式 */
.suggestion-item {
  padding: 8px 0;
}

.plate-number {
  font-weight: 600;
  color: #303133;
  font-size: 14px;
}

.vehicle-info {
  font-size: 12px;
  color: #909399;
  margin-top: 2px;
}

/* Autocomplete下拉框样式优化 */
:deep(.el-autocomplete-suggestion) {
  max-height: 200px;
}

:deep(.el-autocomplete-suggestion__wrap) {
  max-height: 200px;
}

:deep(.el-autocomplete-suggestion .el-popper) {
  max-width: 400px;
}
</style>

