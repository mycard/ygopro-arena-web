import * as types from '../mutation-types'

// initial state
// shape: [{ id, quantity }]
const state = {
    userInfo: {
        'id': 0,
        'name': '',
    },
    account: {
        'balance': 0.00,
        'today_cost': 0.00,
    },
    listData: [],
    pageTotal: 1,
}

// getters
const getters = {}

// actions
const actions = {}

// mutations
const mutations = {
    [types.GET_ACCOUNT_BALANCE] (state, {data}) {
        data.balance =  data.balance.toFixed(2)
        data.today_cost =  data.today_cost.toFixed(2)
        state.account = data
    },
    [types.GET_BILL_LIST] (state, {listData, pageTotal}) {
        for (var i in listData) {
            listData[i].amount = listData[i].amount.toFixed(2)
        }
        state.listData = listData
        state.pageTotal = pageTotal
    },
    [types.GET_USER_INFO] (state, {data}) {
        state.userInfo = data
    },
}

export default {
    state,
    getters,
    actions,
    mutations
}
