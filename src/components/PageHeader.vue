<template>
  <div>
    <!--<header-component></header-component>-->
    <div>
      <nav class="navbar navbar-inverse navbar-fixed-top">
        <!--<nav class="navbar navbar-inverse">-->
        <div class="container">
          <div class="navbar-header">
            <a class="navbar-brand navbar-link" href="index.html"><img src="../assets/img/mycardlogo.png" id="logo">MyCard </a>
            <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
          </div>
          <div class="collapse navbar-collapse" id="navcol-1">
            <ul class="nav navbar-nav navbar-right">
              <li role="presentation"><a href="https://ygobbs.com/" target="_blank">{{lang.forum}} </a></li>
              <li role="presentation"><a href="#/ranking">{{lang.rank}} </a></li>
              <li role="presentation"><a href="#/cards">{{lang.card_rank}} </a></li>
              <li role="presentation"><a href="https://rep.ygobbs.com">{{lang.battlelog}} </a></li>
              <!--<li role="presentation"><a href="https://mycard.moe/ygopro/">{{lang.download}} </a></li>-->
              <li role="presentation"><a href="#/download">{{lang.download}} </a></li>
              <li v-if="user.isLogin" class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" href="#"><img v-bind:src="user.avatar_url" id="head-portrait">{{user.username}} <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li role="presentation"><a href="#/profile">{{lang.profile}} </a></li>
                  <li class="divider" role="presentation"></li>
                  <li role="presentation"><a @click.prevent="logout" href="#">{{lang.signout}} </a></li>
                </ul>
              </li>
              <li v-else role="presentation"><a @click.prevent="login" href="#">{{lang.signin}} </a></li>
              <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" href="#">
                  {{lang.lang}} <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li role="presentation"><a @click.prevent="toCn">{{lang.cn}} </a></li>
                  <li role="presentation"><a @click.prevent="toEn">{{lang.en}} </a></li>
                </ul>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </div>
    <!--<other-component></other-component>-->
  </div>
</template>

<script>
  import querystring from 'querystring';
  import crypto from 'crypto';
  import language from './lang';
  import { mapGetters } from 'vuex'


  export default {
    data() {
      return {
      }
    },
    created: function () {
      this.init()
    },
    computed: {
      ...mapGetters({
        lang: 'getLang',
        user: 'getUser'
      }),
    },
    methods: {
      init: function () {
        var token = querystring.parse(location.search.slice(1)).sso;
        if (token) {
          localStorage.setItem('token', token);
          this.render(token);
        } else {
          token = localStorage.getItem('token');
          if (token) {
            this.render(token);
          }
        }

        var lang = localStorage.getItem('lang');
        if (lang === 'en') {
          this.toEn()
        } else {
          this.toCn()
        }
      },
      render: function (token) {
        var user = querystring.parse(new Buffer(token, 'base64').toString());
        this.$store.dispatch('login', user);
      },
      logout: function () {
        localStorage.removeItem('token');
        this.$store.dispatch('logout',{});
        // var redirectUrl = "http://localhost:8081/index.html";
        var redirectUrl = "https://mycard.moe/ygopro/arena/index.html";

        var request = querystring.stringify({
          'redirect': redirectUrl
        });
        location.href = "https://ygobbs.com/logout?" + request;
      },
      login: function () {
        var payload = new Buffer(querystring.stringify({
          return_sso_url: location.href
        })).toString('base64');

        var request = querystring.stringify({
          'sso': payload,
          'sig': crypto.createHmac('sha256', 'zsZv6LXHDwwtUAGa').update(payload).digest('hex')
        });
        location.href = "https://ygobbs.com/session/sso_provider?" + request;
      },
      toCn: function () {
        localStorage.setItem('lang', 'cn');
        // this.lang = language['cn'];
        // this.$dispatch('lang-change', 'cn')
        this.curLang = 'cn'
        this.$store.dispatch('getLang', this);
      },
      toEn: function () {
        localStorage.setItem('lang', 'en');
        // this.lang = language['en'];
        // this.$dispatch('lang-change', 'en')
        this.curLang = 'en'
        this.$store.dispatch('getLang', this);

        this.$emit('helloworld')
      }
    }
  }

</script>