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

    <el-dialog title="MCPRO服务改进调查" v-if="!(voteObj.multiple)" :visible.sync="dialogFormVisible" :size='size'>

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

      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitVote">提 交</el-button>
      </div>
    </el-dialog>

    <el-dialog title="MCPRO服务改进调查" v-if="voteObj.multiple" :visible.sync="dialogFormVisible" :size='size'>

      <div class="voteTitle">{{ voteObj.title }} （最多选{{voteObj.max}}项）</div><br>

      <el-form :model="form">

        <el-checkbox-group v-model="opids" :min="0" :max="voteObj.max">
          <el-form-item :label-width="formLabelWidth" v-for="item in voteObj.options" :key="item.key">
            <el-checkbox :label="item.key" :key="item.key">{{item.name}}</el-checkbox>
          </el-form-item>
        </el-checkbox-group>

      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitVote">提 交</el-button>
      </div>
    </el-dialog>

    <div id="ads" style="display: none">
      <div @click="adClick">
        <img v-bind:style="{ height: 'auto',  width: width  }" v-bind:src="adObj.src">
      </div>
    </div>



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
      const cityOptions = ['上海', '北京', '广州', '深圳'];
      return {
        opids: [],
        height: "300",
        width: "400",
        isMobile: false,
        cities: cityOptions,
        voteObj: {
          multiple: false,
          options: []
        },
        adObj: {

        },
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
        this.isMobile = true
        this.size = 'large';
      }

    },

    mounted: function () {

      var _this = this

      if (location.hash === "#/vote" || location.hash === "#/report" || location.hash === "#/ads") {
        return;
      }



      // var voteTime = localStorage.getItem('voteTime');
      // if (voteTime) {
      //   var today = moment().format('YYYY-MM-DD')
      //   if (voteTime === today) {
      //     return
      //   }
      // }

      var _this = this
      API.getAd({}).then((res) => {
        if (res.data.data && res.data.data !== "null") {
          _this.adObj = res.data.data
          if (_this.isMobile) {
            _this.adObj.src = _this.adObj.imgm_url
          } else {
            _this.adObj.src = _this.adObj.imgp_url
          }

          setTimeout(function () {

            var area = ["800px", "480px"]
            if (_this.isMobile) {
              area = ["300px", "400px"]
            }

            layer.open({
              type: 1
              , title: false //不显示标题栏
              // ,closeBtn: false
              , area: area
              , shade: 0.8
              , offset: _this.isMobile ? '100px' : "auto"
              , id: 'LAY_layuipro' //设定一个id，防止重复弹出
              // ,btn: ['火速围观', '残忍拒绝']
              , btnAlign: 'c'
              , moveType: 1 //拖拽模式，0或者1
              , content: $('#ads')
              , success: function (layero) {
                var btn = layero.find('.layui-layer-btn');
                btn.find('.layui-layer-btn0').attr({
                  href: 'http://www.layui.com/'
                  , target: '_blank'
                });
              }
              , success: function () {
                _this.adImpl()
                setTimeout(function () {
                  layer.close(layer.index);
                }, 5000)
              }
              , end: function () {
                $("#ads").hide()
              }
            });

          }, 3000)


        }
      }, (res) => {
        console.log(res)
      });



      if (!this.user.isLogin) {
        return;
      }


      API.getVote({ user: this.user.id, username: this.user.username }).then((res) => {
        if (res.data.data && res.data.data !== "null") {
          this.voteObj = res.data.data
          this.voteObj.options = JSON.parse(this.voteObj.options)


          if (this.isMobile) {
            setTimeout(function () {

              //单个使用

              //全局使用。即所有弹出层都默认采用，但是单个配置skin的优先级更高
              // layer.config({
              //   skin: 'demo-class'
              // })


              layer.open({
                type: 1
                , title: ''
                , offset: 'b' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                , area: ['100%', 'auto']
                , closeBtn: 0
                , id: 'layerDemo'
                // ,skin: 'demo-class'
                , content: '<div style="padding: 20px;margin-bottom: -20px; text-align: center">' + '是否参与问卷调查? <br><p class="voteFoot">参与调查可以改善您游戏体验与获得EXP！</p> ' + '</div>'
                , btn: ['投票Start!', '但是我拒绝!']
                , btnAlign: 'c' //按钮居中
                , shade: 0 //不显示遮罩
                , yes: function () {
                  layer.closeAll();
                  _this.dialogFormVisible = true;
                }
                , btn2: function () {
                  console.log('拒绝！')
                }
              });
            }, 1000)
          } else {


            setTimeout(function () {

              //单个使用

              //全局使用。即所有弹出层都默认采用，但是单个配置skin的优先级更高
              // layer.config({
              //   skin: 'demo-class'
              // })


              layer.open({
                type: 1
                , title: 'Hi, ' + _this.user.username
                , offset: 'rb' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                // , area: ['100%', 'auto']
                , id: 'layerDemo'
                // ,skin: 'demo-class'
                , content: '<div style="padding: 20px;margin-bottom: -20px; text-align: center">' + '是否参与问卷调查? <br><p class="voteFoot">参与调查可以改善您游戏体验与获得EXP！</p> ' + '</div>'
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

      adClick: function () {

        API.adClick({ id: this.adObj.id }).then((res) => {

        }, (res) => {
          console.log(res)
        });

        window.open(this.adObj.click_ref, "_blank");
      },

      adImpl: function () {

        API.adImpl({ id: this.adObj.id }).then((res) => {

        }, (res) => {
          console.log(res)
        });
      },

      submitVote: function () {


        var param = {
          user: this.user.id,
          username: this.user.username,
          opid: this.radio,
          multiple: this.voteObj.multiple,
          opids: this.opids,
          voteid: this.voteObj.id
        }

        if (this.voteObj.multiple) {
          if (this.opids.length == 0) {
            this.$notify({
              // title: '操作成功',
              message: '请选择后在提交 ！',
              type: 'warning'
            })
            return;
          }
        } else {
          if (!this.radio) {
            this.$notify({
              // title: '操作成功',
              message: '请选择后在提交 ！',
              type: 'warning'
            })
            return;
          }
        }

        this.dialogFormVisible = false

        var _this = this

        API.submitVote(param).then((res) => {

          // this.$notify({
          //   title: '操作成功',
          //   message: '感谢您的参与, 环境会因为您而变得更好。此问卷为您奖励 EXP + 1 ！',
          //   type: 'success'
          // })

          if (this.isMobile) {
            layer.open({
              type: 1
              , title: ''
              , offset: 'b' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
              , area: ['100%', 'auto']
              , closeBtn: 0
              , id: 'layerDemo'
              , time: 10000
              , content: '<div style="padding: 20px ;">' + '感谢您的参与,环境会因为您而变得更好。此问卷为您奖励EXP+1!' + '</div>'
              , btn: ['知道了', '参与下一个投票']

              , btnAlign: 'c' //按钮居中
              , shade: 0 //不显示遮罩
              , yes: function () {
                layer.closeAll();
                // _this.dialogFormVisible = true;
              },
              btn2: function (index, layero) {
                //按钮【按钮二】的回调
                layer.closeAll();
                //return false 开启该代码可禁止点击该按钮关闭

                API.getVote({ user: _this.user.id, username: _this.user.username }).then((res) => {
                  if (res.data.data && res.data.data !== "null") {
                    _this.voteObj = res.data.data
                    _this.voteObj.options = JSON.parse(_this.voteObj.options)
                    _this.dialogFormVisible = true;
                  } else {
                    API.getVote({ user: _this.user.id, username: _this.user.username }).then((res) => {
                      if (res.data.data && res.data.data !== "null") {
                        _this.voteObj = res.data.data
                        _this.voteObj.options = JSON.parse(_this.voteObj.options)
                        _this.dialogFormVisible = true;
                      } else {
                        API.getVote({ user: _this.user.id, username: _this.user.username }).then((res) => {
                          if (res.data.data && res.data.data !== "null") {
                            _this.voteObj = res.data.data
                            _this.voteObj.options = JSON.parse(_this.voteObj.options)
                            _this.dialogFormVisible = true;
                          } else {

                          }

                        }, (res) => {
                          console.log(res)
                        });
                      }

                    }, (res) => {
                      console.log(res)
                    });
                  }

                }, (res) => {
                  console.log(res)
                });

              }
            });
          } else {
            layer.open({
              type: 1
              , title: 'Hi, ' + _this.user.username
              , offset: 'rb' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
              , id: 'layerDemo'
              , time: 10000
              , content: '<div style="padding: 20px ;">' + '感谢您的参与,环境会因为您而变得更好。此问卷为您奖励EXP+1!' + '</div>'
              , btn: ['知道了', '参与下一个投票']

              , btnAlign: 'c' //按钮居中
              , shade: 0 //不显示遮罩
              , yes: function () {
                layer.closeAll();
                // _this.dialogFormVisible = true;
              },
              btn2: function (index, layero) {
                //按钮【按钮二】的回调
                layer.closeAll();
                //return false 开启该代码可禁止点击该按钮关闭

                API.getVote({ user: _this.user.id, username: _this.user.username }).then((res) => {
                  if (res.data.data && res.data.data !== "null") {
                    _this.voteObj = res.data.data
                    _this.voteObj.options = JSON.parse(_this.voteObj.options)
                    _this.dialogFormVisible = true;
                  } else {
                    API.getVote({ user: _this.user.id, username: _this.user.username }).then((res) => {
                      if (res.data.data && res.data.data !== "null") {
                        _this.voteObj = res.data.data
                        _this.voteObj.options = JSON.parse(_this.voteObj.options)
                        _this.dialogFormVisible = true;
                      } else {
                        API.getVote({ user: _this.user.id, username: _this.user.username }).then((res) => {
                          if (res.data.data && res.data.data !== "null") {
                            _this.voteObj = res.data.data
                            _this.voteObj.options = JSON.parse(_this.voteObj.options)
                            _this.dialogFormVisible = true;
                          } else {

                          }

                        }, (res) => {
                          console.log(res)
                        });
                      }

                    }, (res) => {
                      console.log(res)
                    });
                  }

                }, (res) => {
                  console.log(res)
                });

              }
            });
          }




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
    /*margin-left: 20px;*/
  }
  
  .wrap {
    white-space: normal;
    width: 260px;
    /*word-break:break-all; width:100px; overflow:auto;*/
  }
  /*body .demo-class .layui-layer-title{background:#c00; color:#fff; border: none;}
body .demo-class .layui-layer-btn{border-top:1px solid #E9E7E7}
body .demo-class .layui-layer-btn a{background:#333;}
body .demo-class .layui-layer-btn .layui-layer-btn1{background:#999;}*/
</style>