import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Index from '@/components/Index'
import Cards from '@/components/Cards'
import Ranking from '@/components/Ranking'
import Download from '@/components/Download'
import Profile from '@/components/Profile'
import Userinfo from '@/components/Userinfo'
import Cardinfo from '@/components/Cardinfo'
import History from '@/components/History'
import Deck from '@/components/Deck'
import Report from '@/components/Report'
import Vote from '@/components/Vote'
import Ads from '@/components/Ads'
import Deckprint from '@/components/Deckprint'
// import konami from '@/components/konami'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home,
      children: [
        {
          path: '/',
          component: Index
        }
      ]
    },

    {
      path: '/home',
      name: 'home',
      component: Home,
      children: [
        {
          path: '/cards',
          name: 'Cards',
          component: Cards
        },
        {
          path: '/ranking',
          name: 'Ranking',
          component: Ranking
        },
        {
          path: '/download',
          name: 'Download',
          component: Download
        },
        {
          path: '/profile',
          name: 'Profile',
          component: Profile
        },
        {
          path: '/userinfo',
          name: 'Userinfo',
          component: Userinfo
        },
        {
          path: '/cardinfo',
          name: 'Cardinfo',
          component: Cardinfo
        },
        {
          path: '/deckprint',
          name: 'Deckprint',
          component: Deckprint
        },
        {
          path: '/history',
          name: 'History',
          component: History
        },
        {
          path: '/deck',
          name: 'Deck',
          component: Deck
        },
        {
          path: '/report',
          name: 'Report',
          component: Report
        },
        {
          path: '/vote',
          name: 'Vote',
          component: Vote
        },
        {
          path: '/ads',
          name: 'Ads',
          component: Ads
        },
      ]
    },

    // {
    //   path: '/konami',
    //   name: 'konami',
    //   component: konami
    // },

  ]
})
