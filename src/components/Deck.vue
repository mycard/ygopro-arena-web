<template>
  <div class="content">
    <div class="container">

      <div class="fck">
        <form id="search-form" class="search-form" @submit.prevent="onSubmit">
          <div class="form-group" v-bind:class="{ 'has-error': hasError}">
            <label class="control-label" for="searchText" v-if="hasError">搜索不到该卡组</label>
            <div class="input-group">
              <div class="input-group-addon"><span><i class="glyphicon glyphicon-search"></i></span></div>
              <input class="form-control" type="text" id="searchText" v-model="searchText" placeholder="搜索其他卡组">
              <div class="input-group-btn">
                <button class="btn btn-default" type="submit">{{lang.battle.search}}</button>
                <button class="btn btn-default" style="display:none" type="submit" id="search">{{lang.battle.search}}</button>
              </div>
            </div>
          </div>
        </form>
      </div>

      <h4 style="text-align: center">{{title}}</h4>
      <hr>
      <div class="row">
        <div class="col-md-4" id="profile">
          <div class="thumbnail">
            <img v-bind:src="avatar_url" style="height:300px;margin-top:13px;">
            <div class="caption">
              <h3>
                <!--<i class="glyphicon glyphicon-user"></i> -->
                <strong>{{username}}</strong></h3>
              <p class="text-muted" style="font-size:20px;">{{form.desc}}</p>
            </div>
          </div>
        </div>

        <div class="col-md-8">

          <div v-if="user.isLogin">
            <div class="alert alert-success alert-dismissible" role="alert">
              <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <span v-if="!isNew">您可以参与编辑此页面。</span>
              <span v-if="isNew">还没有人为这个卡组添上攻略哦! 点我编辑页面。</span>
              <i class="el-icon-edit hand" @click.prevent="dialogFormVisible = true">编辑</i>
            </div>
          </div>
          <div v-else>
            <div class="alert alert-success alert-dismissible" role="alert">
              <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <span>登录后才可编辑此页面。</span>
              <a class="hand" @click.prevent="login" href="#">登录</a>
            </div>
          </div>



          <h4 class="color-blue"><i class="glyphicon glyphicon-list-alt"></i> 编辑历史 </h4>
          <!--<div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">编辑历史 </h3>
            </div>-->
          <!--<div class="panel-body">-->
          <!--<div style="width:100%;overflow-x:auto;overflow-y:hidden;">
								<table id="rank" class="table table-striped table-bordered table-hover example" ></table>
							</div>-->
          <!--<div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
              <table id="athletic_rank" class="table table-striped table-bordered table-hover example" :class="{ scroll: isMobile }"></table>
            </div>-->
          <!--</div>-->
          <!--<div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
							<table id="rank" class="table table-striped table-bordered table-hover example" :class="{ scroll: isMobile }" ></table>
					</div>-->

          <!--</div>-->

          <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
            <table id="athletic_rank" class="table table-striped table-bordered table-hover example" :class="{ scroll: isMobile }"></table>
          </div>

          <el-dialog :title="username" size="large" v-model="dialogFormVisible">
            <el-form :model="form">
              <el-form-item label="标题" :label-width="formLabelWidth">
                <el-input v-model="title_new" placeholder="请输入标题" auto-complete="off"></el-input>
              </el-form-item>
              <el-form-item label="图片URL" :label-width="formLabelWidth">
                <el-input v-model="avatar_url_new" placeholder="请输入您希望展示的图片的地址" auto-complete="off"></el-input>
              </el-form-item>
              <!--<el-form-item label="类型" :label-width="formLabelWidth">
                <el-select v-model="form.region" placeholder="请选择类型">
                  <el-option label="一" value="shanghai"></el-option>
                  <el-option label="二" value="beijing"></el-option>
                </el-select>
              </el-form-item>-->

              <el-form-item label="描述" :label-width="formLabelWidth">
                <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 6}" placeholder="请输入您对此卡组的描述" v-model="form.desc_new">
                </el-input>
              </el-form-item>


            </el-form>
            <div slot="footer" class="dialog-footer">
              <el-button @click="cancelModify">取 消</el-button>
              <el-button type="primary" @click="submitModify">确 定</el-button>
            </div>
          </el-dialog>

        </div>
      </div>
    </div>
  </div>

</template>

<script>
  import querystring from 'querystring';
  import crypto from 'crypto';
  import API from '../api'
  import { mapGetters } from 'vuex'
  import moment from 'moment'
  import tb_language from './tb_lang.js'

  var rankTable;
  var rankTable2;

  export default {
    data() {
      return {
        isMobile: false,
        searchText: "",
        hasError: false,
        username: "",
        title: '',
        title_new: '',
        avatar_url: "assets/img/unknow.jpeg",
        avatar_url_new: "",
        input3: 'asdasd',
        dialogTableVisible: false,
        dialogFormVisible: false,
        form: {
          name: '',
          region: '',
          date1: '',
          date2: '',
          delivery: false,
          type: [],
          resource: '',
          desc: '',
          desc_new: '',

        },
        formLabelWidth: '40px',
        isNew: true,
        isClick: false,
        todayCount: 0
      }
    },
    created: function () {
      var regex_match = /(nokia|iphone|android|motorola|^mot-|softbank|foma|docomo|kddi|up.browser|up.link|htc|dopod|blazer|netfront|helio|hosin|huawei|novarra|CoolPad|webos|techfaith|palmsource|blackberry|alcatel|amoi|ktouch|nexian|samsung|^sam-|s[cg]h|^lge|ericsson|philips|sagem|wellcom|bunjalloo|maui|symbian|smartphone|midp|wap|phone|windows ce|iemobile|^spice|^bird|^zte-|longcos|pantech|gionee|^sie-|portalmmm|jigs browser|hiptop|^benq|haier|^lct|operas*mobi|opera*mini|320x320|240x320|176x220)/i;
      var u = navigator.userAgent;
      if (null == u) {
        return true;
      }
      var result = regex_match.exec(u);
      if (null == result) {
        this.isMobile = false;
      } else {
        this.isMobile = true;
      }
    },
    mounted: function () {
      var queryObj = querystring.parse(location.search.slice(1))
      var name = queryObj.name
      var version = queryObj.version

      if (!name) return


      rankTable = this.renderRankTable("#athletic_rank");

      API.getDeckInfo({ name: name, version: version }).then((res) => {

        if (res.data.code === 404) {
          // this.hasError = true
          this.isNew = true;
          this.username = name
        } else {
          this.isNew = false;
          this.hasError = false
          this.user_info = res.data
          this.username = res.data.data.name
          var dataPbj = JSON.parse(res.data.data.content)

          this.title = dataPbj.title
          this.title_new = dataPbj.title
          this.avatar_url = dataPbj.url
          this.avatar_url_new = dataPbj.url
          this.form.desc = dataPbj.desc
          this.form.desc_new = dataPbj.desc

          if (rankTable) {
            rankTable.destroy();
          }
          rankTable = this.renderRankTable("#athletic_rank", res.data.history)
        }
      }, (res) => {
        this.hasError = true
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
      init: function () {
        // var username = querystring.parse(location.hash.slice(11)).username
        // this.searchText = username;
        // this.searchByUsername(username)

      },

      onSubmit: function () {
        var name = this.searchText

        if (!name) return


        API.getDeckInfo({ name: name }).then((res) => {

          if (res.data.code === 404) {
            this.hasError = true
            this.isNew = true;
          } else {
            this.hasError = false
            this.user_info = res.data
            this.username = res.data.data.name
            this.isNew = false;

            var dataPbj = JSON.parse(res.data.data.content)

            this.title = dataPbj.title
            this.title_new = dataPbj.title
            this.avatar_url = dataPbj.url
            this.avatar_url_new = dataPbj.url
            this.form.desc = dataPbj.desc
            this.form.desc_new = dataPbj.desc

            if (rankTable) {
              rankTable.destroy();
            }
            rankTable = this.renderRankTable("#athletic_rank", res.data.history)
          }
        }, (res) => {
          this.hasError = true
          console.log(res)
        });
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

      cancelModify: function () {
        this.dialogFormVisible = false
      },
      submitModify: function () {

        if (!this.title_new || !this.title_new.trim()) {
          this.$notify({
            title: '警告',
            message: '请输入标题!',
            type: 'error'
          })
          return;
        }

        if (!this.avatar_url_new || !this.avatar_url_new.trim()) {
          this.$notify({
            title: '警告',
            message: '请输入图片URL!',
            type: 'error'
          })
          return;
        }

        if (!this.form.desc_new || !this.form.desc_new.trim()) {
          this.$notify({
            title: '警告',
            message: '请输入描述!',
            type: 'error'
          })
          return;
        }

        if (this.todayCount >= 3) {
          this.$notify({
            title: '警告',
            message: '您今天已经提交过3次,请明天再提交!',
            type: 'error'
          })
          this.dialogFormVisible = false
        } else {
          if (this.isClick) {
            this.$notify({
              title: '警告',
              message: '您操作得太快了!',
              type: 'error'
            })
          } else {
            this.isClick = true;
            var param = {
              user: this.user.username,
              name: this.username,
              title: this.title_new,
              desc: this.form.desc_new,
              url: this.avatar_url_new,
              isNew: this.isNew
            }
            var _this = this;
            API.saveDeck(param).then((res) => {
              this.dialogFormVisible = false
              this.isNew = false
              this.form.desc = this.form.desc_new
              this.avatar_url = this.avatar_url_new
              this.title = this.title_new
              this.$notify({
                title: '操作成功',
                message: '感谢您的提交!',
                type: 'success'
              })
              _this.todayCount++;
              setTimeout(function () {
                _this.isClick = false;
              }, 3000)
            }, (res) => {
              setTimeout(function () {
                _this.isClick = false;
              }, 3000)
              this.hasError = true
              console.log(res)
            });
          }

        }



      },

      renderRankTable: function (id, tableData) {

        tableData = tableData || [];
        var lang = localStorage.getItem('lang') || 'cn';

        var today = moment().format('YYYY-MM-DD');
        var curUser = this.user.username;

        var _this = this;
        var processData = tableData.map(function (d) {
          var contentObj = JSON.parse(d.content);
          var dayStr = moment(d.start_time).format('YYYY-MM-DD');
          if (curUser === contentObj.author && dayStr === today) {
            _this.todayCount++;
          }
          return [contentObj.author, contentObj.title || "", moment(d.start_time).format('YYYY-MM-DD HH:mm'), d];
        });
        var table = $(id).DataTable({
          paging: true,
          searching: false,
          ordering: false,
          pageLength: 10,
          lengthChange: false,
          info: false,
          data: processData,

          columns: [
            { title: '作者' },
            { title: '标题' },
            { title: '创建时间' },
            { title: '操作' },
          ],

          "columnDefs": [
            {
              "render": function (data, type, row) {
                return "<a  href='?name=" + data.name + "&version=" + data.id + "#/deck'><span class='label label-info'>查看此版本</span></a>";
              },
              "targets": 3
            },
          ],
          "language": lang === 'en' ? tb_language.en : tb_language.cn
        });

        return table;
      },

    },
  }

</script>

<style scoped>
  .hand {
    cursor: pointer
  }
  
  .fck {
    margin-bottom: 20px;
    margin-top: -30px;
  }
</style>