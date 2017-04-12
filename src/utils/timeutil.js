import moment from 'moment'
import { leftPadding } from './stringutil';
import {DEFAULT_TIME_FORMAT} from '../constants/constants'

export function parseTime(timeStr, format) {
    if (format == null) {
        return moment(timeStr, DEFAULT_TIME_FORMAT).toDate()
    }
    return moment(timeStr, format).toDate()
}

export function timeDifference(from, to) {
    return from.getTime() - to.getTime()
}

export function convertToChineseDay(day) {
    switch (day) {
        case 0:
            return '一'
        case 1:
            return '二'
        case 2:
            return '三'
        case 3:
            return '四'
        case 4:
            return '五'
        case 5:
            return '六'
        case 6:
            return '日'
        default:
            return '未知'
    }
}

export function stringToDate(timeStr) {
    var time = new Date((timeStr - 0) * 1000)
    return time
}

export function getTomorrowTime() {
    var time = new Date()
    const year = time.getFullYear()
    const month = time.getMonth()+1
    const date = time.getDate()+1
    return new Date(year+","+month+","+date).getTime()/1000;
}

export function getNowTime() {
    var time = new Date()
    const year = time.getFullYear()
    const month = time.getMonth()+1
    const date = time.getDate()
    return new Date(year+","+month+","+date).getTime()/1000;
}

export function stringToCanonicalDate(timeStr) {
    var time = new Date((timeStr - 0) * 1000)
    const year = time.getFullYear()
    const month = time.getMonth() + 1
    const date = time.getDate()
    return `${year}年${month}月${date}日`
}

export function simpleFormat(date) {
    const year = date.getFullYear()
    const month = leftPadding(String(date.getMonth() + 1), 2, '0');
    const day = leftPadding(String(date.getDate()), 2, '0');
    return `${year}${month}${day}`
}
