import dayjs from 'dayjs'
import 'dayjs/locale/zh-cn'
import relativeTime from 'dayjs/plugin/relativeTime'
import duration from 'dayjs/plugin/duration'
import isToday from 'dayjs/plugin/isToday'
import isYesterday from 'dayjs/plugin/isYesterday'

// 配置中文
dayjs.locale('zh-cn')

// 扩展插件
dayjs.extend(relativeTime)
dayjs.extend(duration)
dayjs.extend(isToday)
dayjs.extend(isYesterday)

/**
 * 格式化日期
 * @param {string|Date|dayjs.Dayjs} date - 日期
 * @param {string} format - 格式化字符串，默认 'YYYY-MM-DD HH:mm:ss'
 * @returns {string} 格式化后的日期字符串
 */
export function formatDate(date, format = 'YYYY-MM-DD HH:mm:ss') {
  if (!date) return ''
  return dayjs(date).format(format)
}

/**
 * 格式化日期（仅日期）
 * @param {string|Date|dayjs.Dayjs} date - 日期
 * @returns {string} 格式化后的日期字符串
 */
export function formatDateOnly(date) {
  return formatDate(date, 'YYYY-MM-DD')
}

/**
 * 格式化时间（仅时间）
 * @param {string|Date|dayjs.Dayjs} date - 日期
 * @returns {string} 格式化后的时间字符串
 */
export function formatTimeOnly(date) {
  return formatDate(date, 'HH:mm:ss')
}

/**
 * 格式化相对时间
 * @param {string|Date|dayjs.Dayjs} date - 日期
 * @returns {string} 相对时间字符串
 */
export function formatRelativeTime(date) {
  if (!date) return ''
  const target = dayjs(date)
  
  if (target.isToday()) {
    return `今天 ${target.format('HH:mm')}`
  }
  
  if (target.isYesterday()) {
    return `昨天 ${target.format('HH:mm')}`
  }
  
  const now = dayjs()
  const diff = now.diff(target, 'day')
  
  if (diff <= 7) {
    return target.fromNow()
  }
  
  if (target.year() === now.year()) {
    return target.format('MM-DD HH:mm')
  }
  
  return target.format('YYYY-MM-DD HH:mm')
}

/**
 * 获取日期范围
 * @param {string} type - 范围类型：'today', 'yesterday', 'thisWeek', 'thisMonth', 'thisYear'
 * @returns {Array} [开始日期, 结束日期]
 */
export function getDateRange(type) {
  const now = dayjs()
  
  switch (type) {
    case 'today':
      return [
        now.startOf('day').format('YYYY-MM-DD HH:mm:ss'),
        now.endOf('day').format('YYYY-MM-DD HH:mm:ss')
      ]
    
    case 'yesterday':
      const yesterday = now.subtract(1, 'day')
      return [
        yesterday.startOf('day').format('YYYY-MM-DD HH:mm:ss'),
        yesterday.endOf('day').format('YYYY-MM-DD HH:mm:ss')
      ]
    
    case 'thisWeek':
      return [
        now.startOf('week').format('YYYY-MM-DD HH:mm:ss'),
        now.endOf('week').format('YYYY-MM-DD HH:mm:ss')
      ]
    
    case 'lastWeek':
      const lastWeekStart = now.subtract(1, 'week').startOf('week')
      const lastWeekEnd = now.subtract(1, 'week').endOf('week')
      return [
        lastWeekStart.format('YYYY-MM-DD HH:mm:ss'),
        lastWeekEnd.format('YYYY-MM-DD HH:mm:ss')
      ]
    
    case 'thisMonth':
      return [
        now.startOf('month').format('YYYY-MM-DD HH:mm:ss'),
        now.endOf('month').format('YYYY-MM-DD HH:mm:ss')
      ]
    
    case 'lastMonth':
      const lastMonthStart = now.subtract(1, 'month').startOf('month')
      const lastMonthEnd = now.subtract(1, 'month').endOf('month')
      return [
        lastMonthStart.format('YYYY-MM-DD HH:mm:ss'),
        lastMonthEnd.format('YYYY-MM-DD HH:mm:ss')
      ]
    
    case 'thisYear':
      return [
        now.startOf('year').format('YYYY-MM-DD HH:mm:ss'),
        now.endOf('year').format('YYYY-MM-DD HH:mm:ss')
      ]
    
    case 'last7Days':
      return [
        now.subtract(7, 'day').startOf('day').format('YYYY-MM-DD HH:mm:ss'),
        now.endOf('day').format('YYYY-MM-DD HH:mm:ss')
      ]
    
    case 'last30Days':
      return [
        now.subtract(30, 'day').startOf('day').format('YYYY-MM-DD HH:mm:ss'),
        now.endOf('day').format('YYYY-MM-DD HH:mm:ss')
      ]
    
    default:
      return ['', '']
  }
}

/**
 * 计算两个日期之间的差值
 * @param {string|Date|dayjs.Dayjs} startDate - 开始日期
 * @param {string|Date|dayjs.Dayjs} endDate - 结束日期
 * @param {string} unit - 单位：'day', 'hour', 'minute', 'second'
 * @returns {number} 差值
 */
export function getDateDiff(startDate, endDate, unit = 'day') {
  if (!startDate || !endDate) return 0
  return dayjs(endDate).diff(dayjs(startDate), unit)
}

/**
 * 判断日期是否有效
 * @param {string|Date|dayjs.Dayjs} date - 日期
 * @returns {boolean} 是否有效
 */
export function isValidDate(date) {
  if (!date) return false
  return dayjs(date).isValid()
}

/**
 * 获取当前时间戳
 * @returns {number} 时间戳
 */
export function getCurrentTimestamp() {
  return dayjs().valueOf()
}

/**
 * 时间戳转日期
 * @param {number} timestamp - 时间戳
 * @param {string} format - 格式化字符串
 * @returns {string} 格式化后的日期字符串
 */
export function timestampToDate(timestamp, format = 'YYYY-MM-DD HH:mm:ss') {
  if (!timestamp) return ''
  return dayjs(timestamp).format(format)
}

/**
 * 日期转时间戳
 * @param {string|Date|dayjs.Dayjs} date - 日期
 * @returns {number} 时间戳
 */
export function dateToTimestamp(date) {
  if (!date) return 0
  return dayjs(date).valueOf()
}

/**
 * 格式化持续时间
 * @param {number} seconds - 秒数
 * @returns {string} 格式化后的持续时间
 */
export function formatDuration(seconds) {
  if (!seconds || seconds < 0) return '0秒'
  
  const duration = dayjs.duration(seconds * 1000)
  const days = Math.floor(duration.asDays())
  const hours = duration.hours()
  const minutes = duration.minutes()
  const secs = duration.seconds()
  
  let result = ''
  
  if (days > 0) result += `${days}天`
  if (hours > 0) result += `${hours}小时`
  if (minutes > 0) result += `${minutes}分钟`
  if (secs > 0 || result === '') result += `${secs}秒`
  
  return result
}

// 导出dayjs实例，以便在其他地方使用
export { dayjs }
export default dayjs