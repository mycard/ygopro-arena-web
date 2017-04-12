<template>
  <div class="hello">
    <div id="promo" v-if="!isLogin">
      <div class="jumbotron">
        <h1>MyCard </h1>
        <p>{{lang.index.p1}}</p>
        <p><a class="text-uppercase btn btn-info btn-lg" href="#/download">Start Now!</a></p>
      </div>
    </div>

    <div class="projects-clean" v-bind:class="{ 'fix-top': isLogin }">
      <div class="container" id="project">
        <div class="intro">
          <h2 class="text-center">{{lang.index.p2}} </h2>
          <p class="text-center">{{lang.index.p3}} </p>
        </div>
        <div class="row projects">
          <div @click="gogo('#/ranking')" class="col-lg-4 col-sm-6 item" v-bind:class="{ 'fix-width': !isMobile , 'fix-width-m': isMobile }"><img class="img-responsive" src="../../static/assets/img/image6.png">
            <h3 class="name">
              <span style="text-decoration: underline;">{{lang.index.h1}}</span>
            </h3>
            <p class="description">{{lang.index.p4}}</p>
          </div>
          <div @click="gogo('#/cards')" class="col-lg-4 col-sm-6 item" v-bind:class="{ 'fix-width': !isMobile , 'fix-width-m': isMobile}"><img class="img-responsive" src="../../static/assets/img/image4.png">
            <h3 class="name">
              <span style="text-decoration: underline;">{{lang.index.h3}}</span>
            </h3>
            <p class="description">{{lang.index.p6}}</p>
          </div>
          <div @click="gogo('#/userinfo')" class="col-lg-4 col-sm-6 item" v-bind:class="{ 'fix-width': !isMobile , 'fix-width-m': isMobile }"><img class="img-responsive" src="../../static/assets/img/image5.png">
            <h3 class="name">
              <span style="text-decoration: underline;">{{lang.index.h2}}</span>
            </h3>
            <p class="description">{{lang.index.p5}}</p>
          </div>
          <div @click="gogo('https://rep.ygobbs.com')" class="col-lg-4 col-sm-6 item" v-bind:class="{ 'fix-width': !isMobile , 'fix-width-m': isMobile}"><img class="img-responsive" src="../../static/assets/img/image3.png">
            <h3 class="name">
              <span style="text-decoration: underline;">{{lang.index.h4}}</span>
            </h3>
            <p class="description">{{lang.index.p7}}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import language from './lang';
  import querystring from 'querystring';

  export default {
    data() {
      return {
        isLogin: false,
        isMobile: false,
        lang: {},
      }
    },
    created: function () {
      var lang = localStorage.getItem('lang') || 'cn';
      this.init(lang)

      var token = querystring.parse(location.search.slice(1)).sso;
      if (token) {
        localStorage.setItem('token', token);
        this.isLogin = true;
      } else {
        token = localStorage.getItem('token');
        if (token) {
          this.isLogin = true;
        } else {
          this.isLogin = false;
        }
      }

      var clientWidth = document.body.clientWidth;
      if (clientWidth < 753) {
        this.isMobile = true
      }

      var self = this;
      window.onresize = function () {
        var clientWidth = document.body.clientWidth;
        if (clientWidth < 753) {
          self.isMobile = true;
        } else {
          self.isMobile = false;
        }
      }

    },
    methods: {
      init: function (lang) {
        this.lang = language[lang]
      },
      gogo: function (url) {
        // window.open(url)
        window.location.href = url
      }
    },
    events: {
      'lang-change': function (lang) {
        this.init(lang)
      }
    },
  }

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .item {
    cursor: pointer;
    max-height: 160px;
  }
  
  .projects-clean {
    color: #313437;
    background-color: #ffffff;
  }
  
  .fix-width {
    width: 50%;
    min-height: 435px;
  }
  
  .fix-width-m {
    min-height: 385px;
  }
</style>