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



    <!-- Form -->
    <el-button type="text" @click="dialogFormVisible = true">打开嵌套表单的 Dialog</el-button>

    <el-dialog title="MCPRO服务改进调查" :visible.sync="dialogFormVisible" :size='size'>

      <!--<img src="../assets/img/mycardlogo.png" id="logo">-->
      <div class="voteTitle">{{ voteObj.title }} </div><br>

      <el-form :model="form">

        <el-form-item :label-width="formLabelWidth">
          <div v-for=" item in voteObj.options">
            <el-radio v-model="radio" :label="item.key">
              <span class='wrap'>
               {{item.name}}
               </span>
            </el-radio>
          </div>
        </el-form-item>

        <p class="voteFoot">投票可以改善您的游戏体验。还可以获得EXP哦 ^_^</p>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <!--<el-button @click="dialogFormVisible = false">取 消</el-button>-->
        <el-button type="primary" @click="submitVote">提 交</el-button>
      </div>
    </el-dialog>




  </div>
</template>

<script>
  import querystring from 'querystring';
  import crypto from 'crypto';

  import language from './lang';
  import { mapGetters } from 'vuex'
  import API from '../api'
  import moment from 'moment'

  export default {
    data() {
      return {
        voteObj: {},
        size: 'small',
        dialogFormVisible: false,
        form: {
          name: '',
          region: '',
          date1: '',
          date2: '',
          delivery: false,
          type: [],
          resource: '',
          desc: ''
        },
        formLabelWidth: '20px',
        radio: ""
      }
    },
    created: function () {
      this.init()



      var regex_match = /(nokia|iphone|android|motorola|^mot-|softbank|foma|docomo|kddi|up.browser|up.link|htc|dopod|blazer|netfront|helio|hosin|huawei|novarra|CoolPad|webos|techfaith|palmsource|blackberry|alcatel|amoi|ktouch|nexian|samsung|^sam-|s[cg]h|^lge|ericsson|philips|sagem|wellcom|bunjalloo|maui|symbian|smartphone|midp|wap|phone|windows ce|iemobile|^spice|^bird|^zte-|longcos|pantech|gionee|^sie-|portalmmm|jigs browser|hiptop|^benq|haier|^lct|operas*mobi|opera*mini|320x320|240x320|176x220)/i;
      if (regex_match.exec(navigator.userAgent)) {
        this.size = 'large';
      }

    },

    mounted: function () {

      var _this = this

      if (location.hash === "#/vote") {
        return;
      }

      if (!this.user.isLogin) {
        return;
      }



      // var voteTime = localStorage.getItem('voteTime');
      // if (voteTime) {
      //   var today = moment().format('YYYY-MM-DD')
      //   if (voteTime === today) {
      //     return
      //   }
      // }


      API.getVote({ user: this.user.id, username: this.user.username }).then((res) => {

        this.voteObj = res.data.data
        if (this.voteObj !== "null") {
          this.voteObj.options = JSON.parse(this.voteObj.options)

          setTimeout(function () {
            layer.open({
              type: 1
              , title: 'Hi, ' + _this.user.username
              , offset: 'rb' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
              , id: 'layerDemo'
              , content: '<div style="padding: 20px 100px;">' + '是否参与问卷调查?' + '</div>'
              , btn: '好的'
              , btnAlign: 'c' //按钮居中
              , shade: 0 //不显示遮罩
              , yes: function () {
                layer.closeAll();
                _this.dialogFormVisible = true;
              }
            });
          }, 1000)
        }


      }, (res) => {
        console.log(res)
      });



    },

    computed: {
      ...mapGetters({
        lang: 'getLang',
        user: 'getUser'
      }),
    },
    methods: {

      submitVote: function () {

        var param = {
          user: this.user.id,
          username: this.user.username,
          opid: this.radio,
          voteid: this.voteObj.id
        }
        console.log(param)

        if (!this.radio) {
          this.$notify({
            // title: '操作成功',
            message: '请选择后在提交 ！',
            type: 'warning'
          })
          return;
        }

        this.dialogFormVisible = false

        var _this = this

        API.submitVote(param).then((res) => {

          // this.$notify({
          //   title: '操作成功',
          //   message: '感谢您的参与, 环境会因为您而变得更好。此问卷为您奖励 EXP + 1 ！',
          //   type: 'success'
          // })

          layer.open({
              type: 1
              , title: 'Hi, ' + _this.user.username
              , offset: 'rb' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
              , id: 'layerDemo'
              , time: 3000
              , content: '<div style="padding: 10px 80px;">' + '感谢您的参与,环境会因为您而变得更好。此问卷为您奖励EXP+1!' + '</div>'
              , btn: '知道了'
              , btnAlign: 'c' //按钮居中
              , shade: 0 //不显示遮罩
              , yes: function () {
                layer.closeAll();
                // _this.dialogFormVisible = true;
              }
          });



          // localStorage.setItem('voteTime', moment().format('YYYY-MM-DD'));
        }, (res) => {
          console.log(res)
        });
      },
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
        console.log(user)
        this.$store.dispatch('login', user);
      },
      logout: function () {
        localStorage.removeItem('token');
        this.$store.dispatch('logout', {});
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

<style>
  .voteTitle {
    font-size: 22px;
    margin-left: 20px;
    font-family: "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "微软雅黑", Arial, sans-serif;
  }
  
  .voteFoot {
    margin-left: 20px;
  }
  
  .wrap {
    white-space: normal;
    width: 260px;
    /*word-break:break-all; width:100px; overflow:auto;*/
  }
</style>