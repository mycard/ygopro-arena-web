import Vue from 'vue';
import query from 'querystring' ;
import config from '../../config/config';

export default class Api {

    /** --- campaign --- */

    static getCampaignList(opt) {
        var request = query.stringify(opt);
        const url = `${config.URL_PREFIX}/campaign/get_list?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getCampaignInfoByCampaignId(campaignId) {
        var request = query.stringify({
            campaign_id: campaignId
        });
        const url = `${config.URL_PREFIX}/campaign/get_info?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getCampaignOption() {
        const url = `${config.URL_PREFIX}/campaign/get_option`;
        return Vue.http.get(url, {'credentials': true});
    }

    static changeCampaignStatus(opt) {
        const url = `${config.URL_PREFIX}/campaign/update_status`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }

    static createCampaign(opt) {
        const url = `${config.URL_PREFIX}/campaign/create`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }

    static updateCampaign(opt) {
        const url = `${config.URL_PREFIX}/campaign/update`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }

    /* --- ad --- */
    static createAds(opt) {
        const url = `${config.URL_PREFIX}/ad/create`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }

    static updateAds(opt) {
        const url = `${config.URL_PREFIX}/ad/update`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }

    static changeAdStatus(opt) {
        const url = `${config.URL_PREFIX}/ad/update_status`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }

    static adsBatchDelete(adIds) {
        const url = `${config.URL_PREFIX}/ad/batch_update`;
        return Vue.http.post(url, {'ad_ids': adIds, 'status': 3}, {'emulateJSON': true, 'credentials': true});
    }

    static adsBatchUpdateStatus(adIds, status) {
        const url = `${config.URL_PREFIX}/ad/batch_update`;
        return Vue.http.post(url, {'ad_ids': adIds, 'status': status}, {'emulateJSON': true, 'credentials': true});
    }

    static adsBatchUpdateDate(adIds, starTime, endTime) {
        const url = `${config.URL_PREFIX}/ad/batch_update`;
        return Vue.http.post(url, {'ad_ids': adIds, 'start_time': starTime, 'end_time': endTime}, {'emulateJSON': true, 'credentials': true});
    }

    static adsBatchUpdateTime(adIds, scheduleType) {
        const url = `${config.URL_PREFIX}/ad/batch_update`;
        return Vue.http.post(url, {'ad_ids': adIds, 'schedule_type': scheduleType}, {'emulateJSON': true, 'credentials': true});
    }

    static adsBatchUpdatePrice(adIds, price) {
        const url = `${config.URL_PREFIX}/ad/batch_update`;
        return Vue.http.post(url, {'ad_ids': adIds, 'price': price}, {'emulateJSON': true, 'credentials': true});
    }

    static getAds(opt) {
        var request = query.stringify(opt);
        const url = `${config.URL_PREFIX}/ad/get_list?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getStuffImg(adId) {
        var request = query.stringify({
            ad_id: adId
        });
        const url = `${config.URL_PREFIX}/ad/get_img_list?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getAdInfoByAdId(adId) {
        var request = query.stringify({
            ad_id: adId
        });
        
        const url = `${config.URL_PREFIX}/ad/get_info?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    /* --- dashboard --- */

    static getMoneyAndAds() {
        const url = `${config.URL_PREFIX}/stats/get_money_and_ads`;
        return Vue.http.get(url, {'credentials': true});
    }

    /* --- report --- */

    static getTop5() {
        const url = `${config.URL_PREFIX}/report/get_top5`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getAdsReport(opt) {
        var request = query.stringify(opt);
        const url = `${config.URL_PREFIX}/report/ads?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getTrendReport(opt) {
        var request = query.stringify(opt);
        const url = `${config.URL_PREFIX}/report/trend?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    /* --- stuff --- */

    static getStuffSize(opt) {
        var request = query.stringify(opt);
        const url = `${config.URL_PREFIX}/stuff/get_all_size?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    static createStuff(opt) {
        const url = `${config.URL_PREFIX}/stuff/create`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }

    static updateStuff(opt) {
        const url = `${config.URL_PREFIX}/stuff/update`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }


    /* --- account --- */

    static getAccountBalance() {
        const url = `${config.URL_PREFIX}/account/get_balance`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getUserInfo() {
        const url = `${config.URL_PREFIX}/account/get_user_info`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getBillList(opt) {
        var request = query.stringify(opt);
        const url = `${config.URL_PREFIX}/account/get_bill_list?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getInvoiceList(opt) {
        var request = query.stringify(opt);
        const url = `${config.URL_PREFIX}/account/get_invoice_list?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getTaxInfo() {
        const url = `${config.URL_PREFIX}/account/get_tax_info`;
        return Vue.http.get(url, {'credentials': true});
    }

    static getAddress() {
        const url = `${config.URL_PREFIX}/account/get_address`;
        return Vue.http.get(url, {'credentials': true});
    }

    static applyInvoice(opt) {
        const url = `${config.URL_PREFIX}/account/apply_invoice`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }

    static cancelInvoice(opt) {
        var request = query.stringify(opt);
        const url = `${config.URL_PREFIX}/account/cancel_invoice?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    static createTaxInfo(opt) {
        const url = `${config.URL_PREFIX}/account/create_tax_info`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }

    static createAddress(opt) {
        const url = `${config.URL_PREFIX}/account/create_address`;
        return Vue.http.post(url, opt, {'emulateJSON': true, 'credentials': true});
    }

    static getInvoiceAmount(opt) {
        var request = query.stringify(opt);
        const url = `${config.URL_PREFIX}/account/get_invoice_amount?${request}`;
        return Vue.http.get(url, {'credentials': true});
    }

    /* --- 成功处理 --- */
    static successReturn(context) {
        context.$notify({
            title: '操作成功',
            message: '操作成功',
            type: 'success'
        })
    }

    /* --- 错误处理 --- */
    static errorReturn(opt, context) {
        context.$notify({
            title: '错误',
            message: opt.msg,
            type: 'error'
        })
        if (opt.status === 20001) { //    木有登录
            window.location.href = `${config.LOGIN_URL}`;
        }
    }

    static sysErrorReturn(context) {
        context.$notify({
            title: '服务器开小差～',
            message: '服务器开小差，请联系管理员～',
            type: 'error'
        })
    }
}
