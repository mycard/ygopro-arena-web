import Vue from 'vue'
import VueResource from 'vue-resource'
import * as types from './mutation-types'
import Api from '../resource/http/api';

Vue.use(VueResource)

export const createCampaign = ({commit}, context) => {
    let param = {
        'campaign_name': context.ruleForm.campaign_name,
        'os_version_set': context.ruleForm.os_version_set,
        'aosv_set': context.ruleForm.aosv_set,
        'iosv_set': context.ruleForm.iosv_set,
        'device_type_set': context.ruleForm.device_type_set,
        'net_type_set': context.ruleForm.net_type_set,
        'operators_set': context.ruleForm.operators_set,
        'app_type_set': context.ruleForm.app_type_set,
        'area_set': context.ruleForm.area_set,
        'area_ids': context.ruleForm.area_ids,
        'dmp_set': context.ruleForm.dmp_set,
        'day_budget': context.ruleForm.day_budget,
        'start_time': context.ruleForm.start_time,
        'end_time': context.ruleForm.end_time,
        'period_set': context.ruleForm.period_set,
    }
    Api.createCampaign(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            if (context.isDialog == 1) {
                context.$emit('closeDialog')
            } else {
                window.location.href = '/#/home/plans';
            }
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const updateCampaign = ({commit}, context) => {
    let param = {
        'campaign_id': context.ruleForm.campaign_id,
        'campaign_name': context.ruleForm.campaign_name,
        'os_version_set': context.ruleForm.os_version_set,
        'aosv_set': context.ruleForm.aosv_set,
        'iosv_set': context.ruleForm.iosv_set,
        'device_type_set': context.ruleForm.device_type_set,
        'net_type_set': context.ruleForm.net_type_set,
        'operators_set': context.ruleForm.operators_set,
        'app_type_set': context.ruleForm.app_type_set,
        'area_set': context.ruleForm.area_set,
        'area_ids': context.ruleForm.area_ids,
        'dmp_set': context.ruleForm.dmp_set,
        'day_budget': context.ruleForm.day_budget,
        'start_time': context.ruleForm.start_time,
        'end_time': context.ruleForm.end_time,
        'period_set': context.ruleForm.period_set,
    }
    Api.updateCampaign(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            window.location.href = '/#/home/plans';
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getCampaignList = ({commit}, context) => {
    let param = {
        'status': context.status,
        'from_date': context.from_date,
        'to_date': context.to_date,
        'campaign_name': context.campaign_name,
        'campaign_id': context.campaign_id,
        'page': context.page,
        'page_num': context.page_num
    }
    Api.getCampaignList(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            let tableData = {}
            tableData.listData = res.body.data.items
            tableData.pageTotal = res.body.data.count
            commit(types.GET_CAMPAIGN_LIST, {listData: tableData.listData, pageTotal: tableData.pageTotal})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getStuffSize = ({commit}, context) => {
    let param = {
        'ad_form': context.ruleForm.ad_form,

    }
    Api.getStuffSize(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            let tableData = {}
            tableData.listData = res.body.data.items
            commit(types.GET_STUFF_SIZE, {listData: tableData.listData})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getCampaignOption = ({commit}, context) => {
    Api.getCampaignOption().then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_CAMPAIGN_OPTION, {listData: res.body.data})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const createAds = ({commit}, context) => {
    let param = {
        'ad_name': context.ruleForm.ad_name,
        'campaign_id': context.ruleForm.campaign_id,
        'ad_form': context.ruleForm.ad_form,
        'frequency_set': context.ruleForm.frequency_set,
        'show_switch': context.ruleForm.show_switch,
        'frequency_period': context.ruleForm.frequency_period,
        'show_frequency': context.ruleForm.show_frequency,
        'total_frequency': context.ruleForm.total_frequency,
        'click_switch': context.ruleForm.click_switch,
        'click_frequency': context.ruleForm.click_frequency,
        'pattern': context.ruleForm.pattern,
        'start_time': context.ruleForm.start_time,
        'end_time': context.ruleForm.end_time,
        'schedule_type': context.ruleForm.schedule_type,
        'day_budget': context.ruleForm.day_budget,
        'price': context.ruleForm.price,
        'effect_type': context.ruleForm.effect_type,
    }
    Api.createAds(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            context.ruleForm.ad_id = res.data.data.ad_id;
            context.$store.dispatch('createStuff', context);
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const updateAds = ({commit}, context) => {
    let param = {
        'ad_id': context.ruleForm.ad_id,
        'ad_name': context.ruleForm.ad_name,
        'campaign_id': context.ruleForm.campaign_id,
        'ad_form': context.ruleForm.ad_form,
        'frequency_set': context.ruleForm.frequency_set,
        'show_switch': context.ruleForm.show_switch,
        'frequency_period': context.ruleForm.frequency_period,
        'show_frequency': context.ruleForm.show_frequency,
        'total_frequency': context.ruleForm.total_frequency,
        'click_switch': context.ruleForm.click_switch,
        'click_frequency': context.ruleForm.click_frequency,
        'pattern': context.ruleForm.pattern,
        'start_time': context.ruleForm.start_time,
        'end_time': context.ruleForm.end_time,
        'schedule_type': context.ruleForm.schedule_type,
        'day_budget': context.ruleForm.day_budget,
        'price': context.ruleForm.price,
        'effect_type': context.ruleForm.effect_type,
    }
    Api.updateAds(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            context.$store.dispatch('updateStuff', context);
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const changeCampaignStatus = ({commit}, context) => {
    let param = {
        'campaign_id': context.changeCampaignStatusOpt.campaign_id,
        'is_enable': context.changeCampaignStatusOpt.is_enable,
    }
    Api.changeCampaignStatus(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.CHANGE_CAMPAIGN_STATUS, {data: context.changeCampaignStatusOpt})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getCampaignInfoByCampaignId = ({commit}, context) => {
    Api.getCampaignInfoByCampaignId(context.campaign_id).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_CAMPAIGN_INFO, {data: res.data.data})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getMoneyAndAds = ({commit}, context) => {
    Api.getMoneyAndAds().then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_MONEY_AND_ADS, {data: res.data.data})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getTop5 = ({commit}, context) => {
    Api.getTop5().then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_TOP5, {top5data: res.data.data})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getAdsReport = ({commit}, context) => {
    let param = {
        'from_date': context.from_date,
        'to_date': context.to_date,
    };
    Api.getAdsReport(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_ADS_REPORT, {report: res.data.data.report, total: res.data.data.total})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getTrendReport = ({commit}, context) => {
    let param = {
        'from_date': context.from_date,
        'to_date': context.to_date,
    };
    Api.getTrendReport(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_TREND_REPORT, {report: res.data.data.report})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}


export const getAds = ({commit}, context) => {
    let param = {
        'status': context.status,
        'from_date': context.from_date,
        'to_date': context.to_date,
        'ad_name': context.ad_name,
        'ad_id': context.ad_id,
        'campaign_id': context.campaign_id,
        'page': context.page
    }

    Api.getAds(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_ADS, {data: res.body.data})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getAdInfo = ({commit}, context) => {
    Api.getAdInfoByAdId(context.adId).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_AD_INFO, {data: res.body.data})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const changeAdStatus = ({commit}, context) => {
    let param = {
        'ad_id': context.changeAdStatusOpt.ad_id,
        'is_enable': context.changeAdStatusOpt.is_enable,
    }
    Api.changeAdStatus(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.CHANGE_AD_STATUS, {data: context.changeAdStatusOpt})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getStuffImg = ({commit}, context) => {
    Api.getStuffImg(context.adId).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_STUFF_IMG, {imgs: res.body.data.imgs})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const adsBatchDelete = ({commit}, context) => {
    Api.adsBatchDelete(context.adIds.join()).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            context.$store.dispatch('getAds', context);
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const adsBatchUpdateStatus = ({commit}, context) => {
    Api.adsBatchUpdateStatus(context.adIds.join(), context.update_status).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            context.$store.dispatch('getAds', context);
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const adsBatchUpdateDate = ({commit}, context) => {
    Api.adsBatchUpdateDate(context.adIds.join(), context.start_time, context.end_time).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            context.$store.dispatch('getAds', context);
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const adsBatchUpdateTime = ({commit}, context) => {
    Api.adsBatchUpdateTime(context.adIds.join(), context.schedule_type).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            context.$store.dispatch('getAds', context);
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const adsBatchUpdatePrice = ({commit}, context) => {
    Api.adsBatchUpdatePrice(context.adIds.join(), context.update_price).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            context.$store.dispatch('getAds', context);
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const createStuff = ({commit}, context) => {
    let param = {
        'stuff_name': context.ruleForm.ad_name,
        'ad_id': context.ruleForm.ad_id,
        'target': context.ruleForm.target,
        'callback_url': context.ruleForm.callback_url,
        'is_predown': context.ruleForm.is_predown,
        'is_trackidfa': context.ruleForm.is_trackidfa,
        'imgs': JSON.stringify(context.ruleForm.imgs),
    }
    Api.createStuff(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            window.location.href = '/#/home/ads';
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const updateStuff = ({commit}, context) => {
    let param = {
        'stuff_id': context.ruleForm.stuff_id,
        'stuff_name': context.ruleForm.ad_name, //  暂时一对一
        'target': context.ruleForm.target,
        'callback_url': context.ruleForm.callback_url,
        'is_predown': context.ruleForm.is_predown,
        'is_trackidfa': context.ruleForm.is_trackidfa,
        'ad_id': context.ruleForm.ad_id,
        'add_imgs': JSON.stringify(context.ruleForm.imgs),
        'del_img_ids': context.ruleForm.del_img_ids.join(','),
    }
    Api.updateStuff(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            window.location.href = '/#/home/ads';
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getAccountBalance = ({commit}) => {
    Api.getAccountBalance().then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_ACCOUNT_BALANCE, {data: res.body.data.account})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getUserInfo = ({commit}) => {
    Api.getUserInfo().then((res) => {
        if (res.data.status !== 0) {
        Api.errorReturn(res.data, context)
    } else {
        commit(types.GET_USER_INFO, {data: res.body.data.user})
    }
}, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getBillList = ({commit}, context) => {
    let param = {
        'type': context.type,
        'from_date': context.from_date,
        'to_date': context.to_date,
        'page': context.page,
        'page_num': context.page_num
    }
    Api.getBillList(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            let tableData = {}
            tableData.listData = res.body.data.items
            tableData.pageTotal = res.body.data.count
            commit(types.GET_BILL_LIST, {listData: tableData.listData, pageTotal: tableData.pageTotal})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getInvoiceList = ({commit}, context) => {
    let param = {
        'page': context.curpage,
        'page_num': context.page_num
    }
    Api.getInvoiceList(param).then((res) => {
        if (res.body.status !== 0) {
            Api.errorReturn(res.body.data, context)
        } else {
            let tableData = {}
            tableData.listData = res.body.data.items
            tableData.pageTotal = res.body.data.count
            commit(types.GET_INVOICE_LIST, {listData: tableData.listData, pageTotal: tableData.pageTotal})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getTaxInfo = ({commit}, context) => {
    Api.getTaxInfo().then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_INVOICE_TAX, {data: res.body.data})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getAddress = ({commit}, context) => {
    Api.getAddress().then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_INVOICE_ADDRESS, {data: res.body.data})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const createTaxInfo = ({commit}, context) => {
    let param = {
        'certificate': context.image,
        'company': context.tax.company,
        'code': context.tax.code,
        'bank': context.tax.bank,
        'account': context.tax.account,
        'address': context.tax.address,
        'phone': context.tax.phone
    }
    Api.createTaxInfo(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.CREATE_INVOICE, {id: res.data.data.taxinfo_id})
            Api.successReturn(context)
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const createAddress = ({commit}, context) => {
    let param = {
        'contact': context.address.contact,
        'phone': context.address.phone,
        'email': context.address.email,
        'address': context.address.address
    }
    Api.createAddress(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.CREATE_ADDRESS, {data: res.data.data.contact_id})
            Api.successReturn(context)
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const applyInvoice = ({commit}, context) => {
    let param = {
        'type': context.ruleForm.type,
        'detail': context.ruleForm.detail,
        'month': context.ruleForm.month,
        'amount': context.ruleForm.amount,
        'title': context.ruleForm.title,
        'taxinfo_id': context.tax.id,
        'contact_id': context.address.id
    }
    Api.applyInvoice(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            Api.successReturn(context)
            context.ruleForm.type = ''
            context.ruleForm.title = ''
            context.ruleForm.detail = ''
            context.ruleForm.month = ''
            context.ruleForm.amount = ''
            context.date = ''
            context.amount = 0.00
            context.$store.dispatch('getInvoiceList', context);
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const cancelInvoice = ({commit}, context) => {
    let param = {
        'invoice_id': context.changeInvoiceStatusOpt.invoice_id,
    }
    Api.cancelInvoice(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            context.confirmModel = false
            commit(types.CHANGE_INVOICE_STATUS, {data: context.changeInvoiceStatusOpt})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}

export const getInvoiceAmount = ({commit}, context) => {
    let param = {
        'month': context.ruleForm.month
    }
    Api.getInvoiceAmount(param).then((res) => {
        if (res.data.status !== 0) {
            Api.errorReturn(res.data, context)
        } else {
            commit(types.GET_INVOICE_AMOUNT, {data: res.body.data})
        }
    }, (res) => {
        Api.sysErrorReturn(context)
    });
}


export const getLang = ({commit}, context) => {
     commit(types.GET_LANG, {lang: context.curLang})
}

export const login = ({commit}, user) => {
     commit(types.LOGIN, {user: user})
}

export const logout = ({commit}, context) => {
     commit(types.LOGOUT, {})
}
