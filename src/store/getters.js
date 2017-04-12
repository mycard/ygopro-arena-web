export const getCampaignList = state => state.campaign
export const getCampaignInfo = state => state.campaign.info
export const getTop5 = state => state.campaign
export const getMoneyAndAds = state => state.campaign
export const getAds = state => state.ads
export const getAdInfo = state => state.ads.info
export const getStuffSize = state => state.ads.sizeList
export const getStuffImg = state => state.ads.imgList
export const getCampaignOption = state => state.campaign.optionList
export const getStuffReport = state => state.ads.stuffReport
export const getAdsReport = state => state.campaign.report
export const getTrendReport = state => state.campaign.trendReport
export const getAccountBalance = state => state.account.account
export const getBillList = state => state.account
export const getInvoiceList = state => state.invoice
export const getAddress = state => state.invoice.address
export const getTax = state => state.invoice.tax
export const getInvoiceAmount = state => state.invoice.amount
export const getUserInfo = state => state.account.userInfo


export const getLang = state => state.invoice.lang