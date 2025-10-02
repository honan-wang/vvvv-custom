import { createRouter, createWebHistory } from 'vue-router'
import { useUserStore } from '@/stores/user'

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login.vue'),
    meta: { title: '登录' }
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import('@/layouts/MainLayout.vue'),
    meta: { requiresAuth: true, title: '海关数据申报系统' },
    children: [
      {
        path: '',
        redirect: '/dashboard/declaration'
      },
      {
        path: 'declaration',
        name: 'Declaration',
        component: () => import('@/views/Declaration/index.vue'),
        meta: { title: '单一申报', requiresAuth: true }
      },
      {
        path: 'user-management',
        name: 'UserManagement',
        component: () => import('@/views/UserManagement/index.vue'),
        meta: { title: '用户管理', requiresAuth: true }
      },
      {
        path: 'vehicle-management',
        name: 'VehicleManagement',
        component: () => import('@/views/VehicleManagement/VehicleList.vue'),
        meta: { title: '车辆管理', requiresAuth: true }
      },
      {
        path: 'profile',
        name: 'Profile',
        component: () => import('@/views/Profile/index.vue'),
        meta: { title: '个人中心', requiresAuth: true }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 路由守卫
router.beforeEach(async (to, from, next) => {
  const userStore = useUserStore()
  
  // 初始化用户状态（从本地存储恢复）
  if (!userStore.userInfo) {
    userStore.initializeFromStorage()
  }
  
  // 设置页面标题
  if (to.meta.title) {
    document.title = to.meta.title
  }
  
  // 检查是否需要登录
  if (to.meta.requiresAuth) {
    if (!userStore.isLoggedIn) {
      // 保存用户想要访问的页面，登录后跳转
      next(`/login?redirect=${encodeURIComponent(to.fullPath)}`)
      return
    }
    
    // 如果有token但没有用户信息，尝试获取用户信息
    if (userStore.token && !userStore.userInfo) {
      try {
        await userStore.refreshUserInfo()
      } catch (error) {
        console.error('获取用户信息失败，重定向到登录页', error)
        next(`/login?redirect=${encodeURIComponent(to.fullPath)}`)
        return
      }
    }
  }
  
  // 如果已登录且访问登录页，重定向到申报页面
  if (to.path === '/login' && userStore.isLoggedIn) {
    const redirect = to.query.redirect || '/dashboard/declaration'
    next(redirect)
    return
  }
  
  next()
})

export default router