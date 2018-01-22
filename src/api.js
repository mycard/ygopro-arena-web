import Vue from 'vue';
import VueResource from 'vue-resource'
import query from 'querystring';
import config from './config';

Vue.use(VueResource)

const URL = "http://localhost:3000/api"
// const URL = "https://api.mycard.moe/ygopro/arena"

export default class Api {

    static uploadUrl = `${URL}/upload`

    static implUrl = `${URL}/impltrack`

    static clkUrl = `${URL}/clktrack`

    static getDownloadUrl(url) {
        url = url.slice(7)
        var downloadUrl = `${URL}/download/${url}`
        return downloadUrl
    }

    static getCount(opt) {
        var request = query.stringify(opt);
        const url = `${config.COUNTER_URL}?${request}`;
        return Vue.http.get(url);
    }

    static getUserInfo(opt) {
        var request = query.stringify(opt);
        const url = `${URL}/user?${request}`;
        return Vue.http.get(url);
    }

    static getUsers(opt) {
        var request = query.stringify(opt);
        const url = `${URL}/users?${request}`;
        return Vue.http.get(url);
    }

    static getUserDueHistory(opt) {
        return Vue.http.get(`${URL}/history`, { 'params': opt });
    }

    static getDownloadUrls() {
        return Vue.http.get('https://api.github.com/repos/mycard/mycard/releases/latest')
    }

    static getAvatar(opt) {
        return Vue.http.get(`https://api.moecube.com/accounts/users/${opt.username}.avatar`)
    }

    static getCardInfo(opt) {
        var request = query.stringify(opt);
        const url = `${URL}/cardinfo?${request}`;
        return Vue.http.get(url);
    }

    static getDeckInfo(opt) {
        return Vue.http.get(`${URL}/deckinfo`, { 'params': opt });
    }

    static saveDeck(opt) {
        const url = `${URL}/deckinfo`
        return Vue.http.post(url, opt, { 'emulateJSON': true });
    }

    static saveDeckDemo(opt) {
        const url = `${URL}/deckdemo`
        return Vue.http.post(url, opt, { 'emulateJSON': true });
    }

    static getReport(opt) {
        return Vue.http.get(`${URL}/report`, { 'params': opt });
    }

    static getVoteList(opt) {
        return Vue.http.get(`${URL}/votes`, { 'params': opt });
    }

    static saveVote(opt) {
        const url = `${URL}/votes`
        return Vue.http.post(url, opt, { 'emulateJSON': true });
    }

    static voteStatus(opt) {
        const url = `${URL}/voteStatus`
        return Vue.http.post(url, opt, { 'emulateJSON': true });
    }

    static getVote(opt) {
        return Vue.http.get(`${URL}/vote`, { 'params': opt });
    }

    static submitVote(opt) {
        const url = `${URL}/submitVote`
        return Vue.http.post(url, opt, { 'emulateJSON': true });
    }

    static saveAds(opt) {
        const url = `${URL}/ads`
        return Vue.http.post(url, opt, { 'emulateJSON': true });
    }

    static getAdsList(opt) {
        return Vue.http.get(`${URL}/ads`, { 'params': opt });
    }

    static adsStatus(opt) {
        const url = `${URL}/adsStatus`
        return Vue.http.post(url, opt, { 'emulateJSON': true });
    }

    static getAd(opt) {
        return Vue.http.get(`${URL}/getAd`, { 'params': opt });
    }

    static adClick(opt) {
        const url = `${URL}/adClick`
        return Vue.http.post(url, opt, { 'emulateJSON': true });
    }

    static adImpl(opt) {
        const url = `${URL}/adImpl`
        return Vue.http.post(url, opt, { 'emulateJSON': true });
    }

}
