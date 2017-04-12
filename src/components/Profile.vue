<template>
  <div class="content">
    <div class="container">
      <div class="row">
        <div class="col-md-3" id="profile">
          <div class="thumbnail">
            <img v-bind:src="avatar_url" style="height:200px;margin-top:13px;">
            <div class="caption">
              <h3> <i class="glyphicon glyphicon-user"></i> <strong>{{username}}</strong></h3>
              <!--<p class="text-nowrap text-muted" style="font-size:20px;">有妞不泡，大逆不道;遇妞则泡，替天行道。 </p>-->
            </div>
          </div>
        </div>
        <div class="col-md-9">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">{{lang.athletic}} </h3>
            </div>
            <div class="table-responsive">
              <table class="table table-striped table-bordered table-hover">
                <tbody>
                  <tr>
                    <td>D.P </td>
                    <td>{{user_info.pt}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.athletic_rank}} </td>
                    <td>{{user_info.arena_rank}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.win}} </td>
                    <td>{{user_info.athletic_win}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.lose}} </td>
                    <td>{{user_info.athletic_lose}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.draw}} </td>
                    <td>{{user_info.athletic_draw}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.all}} </td>
                    <td>{{user_info.athletic_all}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.ratio}} </td>
                    <td>{{user_info.athletic_wl_ratio}}% </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">{{lang.entertain}} </h3>
            </div>
            <div class="table-responsive">
              <table class="table table-striped table-bordered table-hover">
                <tbody>
                  <tr>
                    <td>EXP </td>
                    <td>{{user_info.exp}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.exp_rank}} </td>
                    <td>{{user_info.exp_rank}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.win}} </td>
                    <td>{{user_info.entertain_win}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.lose}} </td>
                    <td>{{user_info.entertain_lose}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.draw}} </td>
                    <td>{{user_info.entertain_draw}} </td>
                  </tr>
                  <tr>
                    <td>{{lang.all}} </td>
                    <td>{{user_info.entertain_all}} </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import querystring from 'querystring';
  import language from './lang';
  import API from '../api'
  import { mapGetters } from 'vuex'

  export default {
    data() {
      return {
        username: "",
        avatar_url: "",
        user_info: {
          exp: 0,
          pt: 500,
          entertain_win: 0,
          entertain_lose: 0,
          entertain_draw: 0,
          entertain_all: 0,
          entertain_wl_ratio: 0,
          exp_rank: 0,
          athletic_win: 0,
          athletic_lose: 0,
          athletic_draw: 0,
          athletic_all: 0,
          athletic_wl_ratio: 0,
          arena_rank: 0
        }
      }
    },
    computed: {
      ...mapGetters({
        lang: 'getLang',
      }),
    },

    watch: {
      lang: function (val) {
        
      },
    },

    created: function () {
      this.init()
      var lang = localStorage.getItem('lang');
      this.initLang(lang)
    },
    events: {
      'lang-change': function (lang) {
        this.initLang(lang)
      }
    },
    methods: {
      init: function () {
        var token = querystring.parse(location.search.slice(1)).sso;
        if (token) {
          this.render(token);
          this.isLogin = true;
        } else {
          token = localStorage.getItem('token');
          if (token) {
            this.render(token);
            this.isLogin = true;
          } else {
            this.isLogin = false;
          }
        }
      },
      initLang: function (lang) {
      },
      render: function (token) {
        var user = querystring.parse(new Buffer(token, 'base64').toString());
        this.username = user.username;
        this.avatar_url = user.avatar_url;

        let opt = {
          'username': user.username
        }

        API.getUserInfo(opt).then((res) => {
          this.user_info = res.data
        });

      }
    },
  }

</script>