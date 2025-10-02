// 申请单状态工具类
export const ApplicationStatusHelper = {
  // 状态选项
  statusOptions: [
    { value: 'FBG100100', label: '预录入', type: 'info' },
    { value: 'FBG100200', label: '待审核', type: 'warning' },
    { value: 'FBG100300,FBG100500', label: '审核通过', type: 'success' },
    { value: 'FBG100400', label: '退回', type: 'danger' },
    { value: 'FBG100600', label: '查验通过', type: 'success' },
    { value: 'FBG100900', label: '作废', type: 'info' }
  ],

  /**
   * 获取状态描述
   * @param {string} statusCode 状态代码
   * @returns {string} 状态描述
   */
  getStatusDescription(statusCode) {
    const statusMap = {
      'FBG100100': '预录入',
      'FBG100200': '待审核',
      'FBG100300': '审核通过',
      'FBG100400': '退回',
      'FBG100500': '审核通过',
      'FBG100600': '查验通过',
      'FBG100900': '作废'
    }
    return statusMap[statusCode] || '未知状态'
  },

  /**
   * 获取状态标签类型
   * @param {string} statusCode 状态代码
   * @returns {string} Element UI标签类型
   */
  getStatusTagType(statusCode) {
    const typeMap = {
      'FBG100100': 'info',
      'FBG100200': 'warning',
      'FBG100300': 'success',
      'FBG100400': 'danger',
      'FBG100500': 'success',
      'FBG100600': 'success',
      'FBG100900': 'info'
    }
    return typeMap[statusCode] || 'info'
  },

  /**
   * 判断是否为审核通过状态
   * @param {string} statusCode 状态代码
   * @returns {boolean} 是否审核通过
   */
  isApproved(statusCode) {
    return ['FBG100300', 'FBG100500', 'FBG100600'].includes(statusCode)
  },

  /**
   * 判断是否为等待状态
   * @param {string} statusCode 状态代码
   * @returns {boolean} 是否等待状态
   */
  isPending(statusCode) {
    return statusCode === 'FBG100200'
  },

  /**
   * 判断是否为被退回状态
   * @param {string} statusCode 状态代码
   * @returns {boolean} 是否被退回
   */
  isRejected(statusCode) {
    return statusCode === 'FBG100400'
  },

  /**
   * 判断是否为最终状态
   * @param {string} statusCode 状态代码
   * @returns {boolean} 是否最终状态
   */
  isFinalStatus(statusCode) {
    return ['FBG100600', 'FBG100900'].includes(statusCode)
  },

  /**
   * 将申请单状态转换为申报状态
   * @param {string} statusCode 申请单状态代码
   * @param {boolean} isDischargeStep 是否为核放单阶段
   * @returns {string} 申报状态
   */
  convertToDeclarationStatus(statusCode, isDischargeStep = false) {
    if (!isDischargeStep) {
      // 申请单阶段
      const statusMap = {
        'FBG100100': 'Draft',
        'FBG100200': 'ApplicationSubmitted',
        'FBG100300': 'ApplicationApproved',
        'FBG100400': 'ApplicationRejected',
        'FBG100500': 'ApplicationApproved',
        'FBG100600': 'ApplicationApproved',
        'FBG100900': 'ApplicationRejected'
      }
      return statusMap[statusCode] || 'Draft'
    } else {
      // 核放单阶段
      const statusMap = {
        'FBG100100': 'DischargeSubmitted',
        'FBG100200': 'DischargeSubmitted',
        'FBG100300': 'DischargeApproved',
        'FBG100400': 'DischargeRejected',
        'FBG100500': 'DischargeApproved',
        'FBG100600': 'DischargeApproved',
        'FBG100900': 'DischargeRejected'
      }
      return statusMap[statusCode] || 'DischargeSubmitted'
    }
  },

  /**
   * 获取申报进度步骤
   * @param {string} declarationStatus 申报状态
   * @returns {number} 步骤索引
   */
  getProgressStep(declarationStatus) {
    const stepMap = {
      'Draft': 0,
      'ApplicationSubmitted': 1,
      'ApplicationApproved': 2,
      'DischargeSubmitted': 2,
      'DischargeApproved': 3,
      'ApplicationRejected': 1,
      'DischargeRejected': 2
    }
    return stepMap[declarationStatus] || 0
  },

  /**
   * 获取状态描述（用于申报流程显示）
   * @param {string} declarationStatus 申报状态
   * @returns {object} 状态信息
   */
  getDeclarationStatusInfo(declarationStatus) {
    const statusInfo = {
      'Draft': {
        description: '草稿',
        canStart: true,
        canResubmit: false,
        isPending: false,
        isCompleted: false,
        isRejected: false
      },
      'ApplicationSubmitted': {
        description: '申请单已提交',
        canStart: false,
        canResubmit: false,
        isPending: true,
        isCompleted: false,
        isRejected: false
      },
      'ApplicationApproved': {
        description: '申请单审批通过',
        canStart: false,
        canResubmit: false,
        isPending: false,
        isCompleted: false,
        isRejected: false
      },
      'ApplicationRejected': {
        description: '申请单被退回',
        canStart: false,
        canResubmit: true,
        isPending: false,
        isCompleted: false,
        isRejected: true
      },
      'DischargeSubmitted': {
        description: '核放单已提交',
        canStart: false,
        canResubmit: false,
        isPending: true,
        isCompleted: false,
        isRejected: false
      },
      'DischargeApproved': {
        description: '申报完成',
        canStart: false,
        canResubmit: false,
        isPending: false,
        isCompleted: true,
        isRejected: false
      },
      'DischargeRejected': {
        description: '核放单被退回',
        canStart: false,
        canResubmit: true,
        isPending: false,
        isCompleted: false,
        isRejected: true
      }
    }

    return statusInfo[declarationStatus] || statusInfo['Draft']
  }
}

// 核放单状态工具类
export const DischargeStatusHelper = {
  // 状态选项
  statusOptions: [
    { value: 'HFD100100', label: '预录入', type: 'info' },
    { value: 'HFD100200', label: '待审核', type: 'warning' },
    { value: 'HFD100300,HFD100500', label: '审核通过', type: 'success' },
    { value: 'HFD100400', label: '退回', type: 'danger' },
    { value: 'HFD100600', label: '查验通过', type: 'success' }
  ],

  /**
   * 获取状态描述
   * @param {string} statusCode 状态代码
   * @returns {string} 状态描述
   */
  getStatusDescription(statusCode) {
    const statusMap = {
      'HFD100100': '预录入',
      'HFD100200': '待审核',
      'HFD100300': '审核通过',
      'HFD100400': '退回',
      'HFD100500': '审核通过',
      'HFD100600': '查验通过'
    }
    return statusMap[statusCode] || '未知状态'
  },

  /**
   * 获取状态标签类型
   * @param {string} statusCode 状态代码
   * @returns {string} Element UI标签类型
   */
  getStatusTagType(statusCode) {
    const typeMap = {
      'HFD100100': 'info',
      'HFD100200': 'warning',
      'HFD100300': 'success',
      'HFD100400': 'danger',
      'HFD100500': 'success',
      'HFD100600': 'success'
    }
    return typeMap[statusCode] || 'info'
  },

  /**
   * 判断是否为审核通过状态
   * @param {string} statusCode 状态代码
   * @returns {boolean} 是否审核通过
   */
  isApproved(statusCode) {
    return ['HFD100300', 'HFD100500', 'HFD100600'].includes(statusCode)
  },

  /**
   * 判断是否为等待状态
   * @param {string} statusCode 状态代码
   * @returns {boolean} 是否等待状态
   */
  isPending(statusCode) {
    return statusCode === 'HFD100200'
  },

  /**
   * 判断是否为被退回状态
   * @param {string} statusCode 状态代码
   * @returns {boolean} 是否被退回
   */
  isRejected(statusCode) {
    return statusCode === 'HFD100400'
  },

  /**
   * 判断是否为最终状态
   * @param {string} statusCode 状态代码
   * @returns {boolean} 是否最终状态
   */
  isFinalStatus(statusCode) {
    return statusCode === 'HFD100600'
  }
}