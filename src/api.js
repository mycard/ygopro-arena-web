import Vue from 'vue';
import VueResource from 'vue-resource'
import query from 'querystring';
import config from './config';

Vue.use(VueResource)

// const URL = "http://localhost:3000/api"
const URL = "https://api.mycard.moe/ygopro/arena"

export default class Api {

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
        return `https://ygobbs.com/user_avatar/ygobbs.com/${opt.username}/400/1.png`
    }

    static getCardInfo(opt) {
        var request = query.stringify(opt);
        const url = `${URL}/cardinfo?${request}`;
        return Vue.http.get(url);
    }

    static getDeckInfo(opt) {
        var tmp = "http://localhost:3000/api"
        return Vue.http.get(`${tmp}/deckinfo`, { 'params': opt });
    }

    static saveDeck(opt) {
        var tmp = "http://localhost:3000/api"
        const url = `${tmp}/deckinfo`
        return Vue.http.post(url, opt, { 'emulateJSON': true });
    }

}
