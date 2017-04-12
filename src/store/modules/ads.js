import * as types from '../mutation-types'

// initial state
// shape: [{ id, quantity }]
const state = {
    items: [],
    count: 0,
    info: {},
    sizeList: [],
    imgList: [],
    stuffReport: []
}

// getters
const getters = {}

// actions
const actions = {}

// mutations
const mutations = {
    [types.GET_ADS] (state, {data}) {
        for (var i in data.items) {
            data.items[i].clickcost_avg = data.items[i].clickcost_avg.toFixed(2);
            data.items[i].clickrate = data.items[i].clickrate.toFixed(2);
            data.items[i].cost = data.items[i].cost.toFixed(2);
            data.items[i].day_budget = data.items[i].day_budget.toFixed(2);
            data.items[i].price = data.items[i].price.toFixed(2);
        }
        state.items = data.items
        state.count = data.count
    },
    [types.GET_AD_INFO] (state, {data}) {
        state.info = data
    },
    [types.GET_STUFF_SIZE] (state, {listData}) {
        state.sizeList = listData
    },
    [types.GET_STUFF_IMG] (state, {imgs}) {
        state.imgList = imgs
    },
    [types.CHANGE_AD_STATUS] (state, {data}) {
        let index = data.index
        let status = data.is_enable
        if (status && status === 1) {
            state.items[index].ad_status = 1
            state.items[index].ad_status_str = '投放中'
        } else {
            state.items[index].ad_status = 2
            state.items[index].ad_status_str = '已暂停'
        }
    },
    [types.GET_ADS_REPORT] (state, {report}) {
        var date = [];
        var impData = [];
        var clickData = [];
        var clickrateData = [];
        var costData = [];
        var costAvgData = [];

        for (var i in report) {
            date.push(report[i].logdate);
            impData.push(report[i].imp);
            clickData.push(report[i].click);
            clickrateData.push(report[i].clickrate.toFixed(2));
            costData.push(report[i].cost);
            costAvgData.push(report[i].clickcost_avg.toFixed(2));
        }
        state.stuffReport = {
            'date': date,
            'impData': impData,
            'clickData': clickData,
            'clickrateData': clickrateData,
            'costData': costData,
            'costAvgData': costAvgData,
        }
    },
}

export default {
    state,
    getters,
    actions,
    mutations
}
