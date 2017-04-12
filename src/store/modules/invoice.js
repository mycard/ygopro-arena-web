import * as types from '../mutation-types'

import lg  from '../../components/lang'

// initial state
// shape: [{ id, quantity }]
const state = {
    amount: 0.00, // 可发票金额
    address: {},
    tax: {},
    listData: [],
    pageTotal: 1,
    lang: lg['cn']
}

// getters
const getters = {}

// actions
const actions = {}

// mutations
const mutations = {
    [types.GET_LANG] (state, {lang}) {
        state.lang = lg[lang]
    },
    [types.GET_INVOICE_ADDRESS] (state, {data}) {
        state.address = data
    },
    [types.GET_INVOICE_TAX] (state, {data}) {
        state.tax = data
    },
    [types.CREATE_INVOICE] (state, {id}) {
        state.tax.id = id
    },
    [types.CREATE_ADDRESS] (state, {id}) {
        state.address.id = id
    },
    [types.GET_INVOICE_AMOUNT] (state, {data}) {
        state.amount = data.invoice_amount.toFixed(2)
    },
    [types.CHANGE_INVOICE_STATUS] (state, {data}) {
        let index = data.index
        state.listData[index].status = 2
        state.listData[index].status_str = '已撤销'
    },



}

export default {
    state,
    getters,
    actions,
    mutations
}
