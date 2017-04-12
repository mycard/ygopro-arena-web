import * as types from '../mutation-types'

// initial state
// shape: [{ id, quantity }]
const state = {
    account: [],
    ads: [],
    imp: [],
    click: [],
    clickrate: [],
    listData: [],
    optionList: {
        os_type: [],
        os_version: {1: [], 2: []},
        device_type: {1: [], 2: []},
        net_type: [],
        operators: [],
        app_type: [],
        area: {"CN": [], "OVERSEA": []},
        dmp: []
    },
    info: {},
    pageTotal: 1,
    report: {
      total: {
        imp: 0 ,
        click: 0
      }
    },
    trendReport: []
}

// getters
const getters = {}

// actions
const actions = {}

// mutations
const mutations = {
    [types.GET_MONEY_AND_ADS] (state, {data}) {
        data.account.balance = data.account.balance.toFixed(2);
        state.account = data.account
        state.ads = data.ads
    },
    [types.GET_TOP5] (state, {top5data}) {
        state.imp = top5data.imp
        state.click = top5data.click
        state.clickrate = top5data.clickrate
    },
    [types.GET_CAMPAIGN_LIST] (state, {listData, pageTotal}) {
        for (var i in listData) {
            listData[i].clickcost_avg = listData[i].clickcost_avg.toFixed(2);
            listData[i].clickrate = listData[i].clickrate.toFixed(2);
            listData[i].cost = listData[i].cost.toFixed(2);
            listData[i].campaign_daybudget = listData[i].campaign_daybudget.toFixed(2);
        }
        state.listData = listData
        state.pageTotal = pageTotal
    },
    [types.GET_CAMPAIGN_INFO] (state, {data}) {
        state.info = data
    },
    [types.CHANGE_CAMPAIGN_STATUS] (state, {data}) {
        let index = data.index
        let status = data.is_enable
        if (status && status === 1) {
            state.listData[index].campaign_status = 2
            state.listData[index].campaign_status_str = '投放中'
        } else {
            state.listData[index].campaign_status = 3
            state.listData[index].campaign_status_str = '已暂停'
        }
    },
    [types.GET_CAMPAIGN_OPTION] (state, {listData}) {
        state.optionList = listData
    },
    [types.GET_TREND_REPORT] (state, {report}) {
        var date = [];
        var impData = [];
        var clickData = [];
        var clickrateData = [];
        var costData = [];
        var costAvgData = [];

        for (var i in report) {
            impData.push(report[i].imp);
            clickData.push(report[i].click);
            clickrateData.push(report[i].clickrate.toFixed(2));
            costData.push(report[i].cost.toFixed(2));
            costAvgData.push(report[i].clickcost_avg.toFixed(2));
            date.push(report[i].logdate);
            report[i].date_str = report[i].logdate;
            report[i].clickrate = report[i].clickrate.toFixed(2);
            report[i].clickcost_avg = report[i].clickcost_avg.toFixed(2);
            report[i].cost = report[i].cost.toFixed(2);
        }
        state.trendReport = {
            'list': report,
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
