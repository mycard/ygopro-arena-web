import Vue from 'vue'
import Vuex from 'vuex'
import * as actions from './actions'
import * as getters from './getters'
import campaign from './modules/campaign'
import ads from './modules/ads'
import account from './modules/account'
import invoice from './modules/invoice'

Vue.use(Vuex)

export default new Vuex.Store({
    actions,
    getters,
    modules: {
        campaign,
        ads,
        account,
        invoice,
    }
})
