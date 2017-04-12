<template>
  <div class="team-boxed">
    <div class="container">
      <div class="intro">
        <h2 class="text-center">{{lang.downloadPage.welcome}} </h2>
        <p class="text-center"><strong>{{lang.downloadPage.desc}}</strong> </p>
      </div>
      <div class="row people">
        <div @click="gogo('windows')" class="col-md-6 col-sm-6 item1">
          <div class="box"><i class="fa fa-windows"></i>
            <h3 class="name">Windows </h3>
            <!--<p class="title">asd</p>-->
          </div>
        </div>
        <div @click="gogo('mac')" class="col-md-6 col-sm-6 item1">
          <div class="box"><i class="fa fa-apple"></i>
            <h3 class="name">Mac </h3>
            <!--<p class="title">asd</p>-->
          </div>
        </div>
        <!--<div @click="gogo('linux')" class="col-md-4 col-sm-6 item1">
					<div class="box"><i class="fa fa-linux"></i>
						<h3 class="name">Linux </h3>
						<p class="title">asd</p>
					</div>
				</div>-->
      </div>
      <div class="intro">
        <p class="text-center"><a :href="lang.downloadPage.user_guide_url">{{lang.downloadPage.user_guide}}</a> </p>
      </div>
    </div>
  </div>
</template>

<script>
  import querystring from 'querystring';
  import API from '../api'

  import { mapGetters } from 'vuex'

  import "../assets/css/Team-Boxed.css"
  import "../assets/css/Team-Clean.css"

  export default {
    data() {
      return {
        downloadUrls: {},
      }
    },
    created: function () {
      // https://wudizhanche.mycard.moe/download?platform=win32
      // https://wudizhanche.mycard.moe/download?platform=darwin

      var self = this
      API.getDownloadUrls().then((res) => {
        let assets = res.data.assets
        for (let i of assets) {
          if (i.browser_download_url.indexOf('.exe') > -1) {
            self.downloadUrls['windows'] = i.browser_download_url
          }
          if (i.browser_download_url.indexOf('.dmg') > -1) {
            self.downloadUrls['mac'] = i.browser_download_url
          }
          if (i.browser_download_url.indexOf('.AppImage') > -1) {
            self.downloadUrls['linux'] = i.browser_download_url
          }
        }
      });
    },
    computed: {
            ...mapGetters({
        lang: 'getLang',
      }),
    },
    watch: {
      lang: function (val) {
        this.initLang()
      },
    },
    events: {
      'lang-change': function (lang) {
        this.initLang(lang)
      }
    },
    methods: {
      initLang: function (lang) {
        
      },
      gogo: function (url) {
        // window.open(url)
        window.location.href = this.downloadUrls[url]
      }
    },
  }

</script>

<style scoped>
  .team-boxed {
    color: #313437;
    background-color: #ffffff;
  }
  
  .item1 {
    cursor: pointer;
  }
  
  .box {
    background-color: red;
  }
</style>