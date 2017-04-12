
/* eslint-disable */
export default {
  install(Vue) {
    Vue.locationHref = (url) => {
      window.location.href = url;
    };
  },
};
/* eslint-enable */
