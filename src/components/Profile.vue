<template>
  <div class="content">
    <div class="container">
      <div class="row">
        <div class="col-md-3" id="profile">
          <div class="thumbnail">
            <img v-bind:src="user.avatar_url" style="height:200px;margin-top:13px;">
            <div class="caption">
              <h3> <i class="glyphicon glyphicon-user"></i> <strong>{{user.username}}</strong></h3>
              <p class="text-muted" style="font-size:20px;">今日首胜: {{activity.today}}/1 </p>
              <p class="text-muted" style="font-size:20px;">{{activity.name}}首胜: {{activity.total}}/{{activity.max}} </p>
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


          <div class="alert alert-info alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>            {{lang.tagInfo}}
          </div>

          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">{{lang.athleticDueHistory}} </h3>
            </div>
            <!--<div class="panel-body">-->
            <!--<div style="width:100%;overflow-x:auto;overflow-y:hidden;">
								<table id="rank" class="table table-striped table-bordered table-hover example" ></table>
							</div>-->
            <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
              <table id="athletic_rank" class="table table-striped table-bordered table-hover example" :class="{ scroll: isMobile }"></table>
            </div>
            <!--</div>-->
            <!--<div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
							<table id="rank" class="table table-striped table-bordered table-hover example" :class="{ scroll: isMobile }" ></table>
					</div>-->

          </div>

          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">{{lang.entertainDueHistory}} </h3>
            </div>
            <!--<div class="panel-body">-->
            <!--<div style="width:100%;overflow-x:auto;overflow-y:hidden;">
								<table id="rank" class="table table-striped table-bordered table-hover example" ></table>
							</div>-->
            <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
              <table id="entertain_rank" class="table table-striped table-bordered table-hover example" :class="{ scroll: isMobile }"></table>
            </div>
            <!--</div>-->
            <!--<div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
							<table id="rank" class="table table-striped table-bordered table-hover example" :class="{ scroll: isMobile }" ></table>
					</div>-->

          </div>



        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import querystring from 'querystring';
  import API from '../api'
  import { mapGetters } from 'vuex'

  var rankTable;
  var rankTable2;
  import moment from 'moment'
  import tb_language from './tb_lang.js'

  export default {
    data() {
      return {
        isMobile: false,
        activity:{
          name:'新年充电活动',
          max:'15'
        },
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
        user: 'getUser'
      }),
    },



    mounted: function () {
      var _this = this
      $("#search").click(function () {
        _this.renderPage();
      })
      // this.init()
      // window.onhashchange = this.init;
      this.renderPage();
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

      let opt = {
        'username': this.user.username
      }

      API.getUserInfo(opt).then((res) => {
        this.user_info = res.data
      });
    },

    methods: {
      init: function () {
      },

      renderPage: function () {
        if (rankTable) {
          rankTable.destroy();
        }

        if (rankTable2) {
          rankTable2.destroy();
        }

        var username = this.user.username
        var type = 1;

        rankTable = this.renderRankTable("#athletic_rank", [], "DP");
        rankTable2 = this.renderRankTable("#entertain_rank", [], "");

        if (!username) return;

        API.getUserDueHistory({ username: username, type: "1", page_num: 100 }).then((res) => {
          if (rankTable) {
            rankTable.destroy();
          }
          rankTable = this.renderRankTable("#athletic_rank", res.data.data, "DP")
        }, (res) => {
          console.log(res)
        });

        API.getUserDueHistory({ username: username, type: "2", page_num: 100 }).then((res) => {
          if (rankTable2) {
            rankTable2.destroy();
          }
          rankTable2 = this.renderRankTable("#entertain_rank", res.data.data, "")
        }, (res) => {
          console.log(res)
        });

        var _this = this;

        API.getFirstWin({ username: username }).then((res) => {
            _this.activity = res.data
        }, (res) => {
          console.log(res)
        });
      },

      renderRankTable: function (id, tableData, ttype) {
        tableData = tableData || [];
        var lang = localStorage.getItem('lang') || 'cn';

        var rank = 1;
        var processData = tableData.map(function (d) {
          return [d.usernamea, d.usernameb, moment(d.start_time).format('YYYY-MM-DD HH:mm'),
          moment(d.end_time).format('YYYY-MM-DD HH:mm'), d.userscorea, d.userscoreb,
          d.pta, d.pta_ex, d.ptb, d.ptb_ex];
        });
        var table = $(id).DataTable({
          paging: true,
          searching: false,
          ordering: false,
          lengthChange: false,
          info: false,
          data: processData,

          columns: [
            { title: tb_language[lang].playerA },
            { title: tb_language[lang].playerB },
            { title: tb_language[lang].startTime },
            { title: tb_language[lang].endTime },

          ],
          "columnDefs": [
            {
              "render": function (data, type, row) {
                var userscorea = row[4];
                var userscoreb = row[5];
                var diff = (parseFloat(row[6]) - parseFloat(row[7])).toFixed(2)
                if (diff > 0) {
                  diff = "+" + diff
                }
                var append = diff + ttype
                if (ttype === "") {
                  append = ""
                }
                if (userscorea < 0) {
                  return "<a href='#/userinfo?username=" + data + "'><span class='label label-danger'>" + data + "</span></a>  " + append;
                }

                if (userscorea > userscoreb) {
                  return "<a href='#/userinfo?username=" + data + "'><span class='label label-success'>" + data + "</span></a> " + append;
                }

                return "<a href='#/userinfo?username=" + data + "'><span class='label label-info'>" + data + "</span></a> " + append;
              },
              "targets": 0
            },
            {
              "render": function (data, type, row) {
                var userscorea = row[4];
                var userscoreb = row[5];
                var diff = (parseFloat(row[8]) - parseFloat(row[9])).toFixed(2)
                if (diff > 0) {
                  diff = "+" + diff
                }
                var append = diff + ttype
                if (ttype === "") {
                  append = ""
                }
                if (userscoreb < 0) {
                  return "<a href='#/userinfo?username=" + data + "'><span class='label label-danger'>" + data + "</span></a> " + append;
                }

                if (userscorea < userscoreb) {
                  return "<a href='#/userinfo?username=" + data + "'><span class='label label-success'>" + data + "</span></a> " + append;
                }

                return "<a href='#/userinfo?username=" + data + "'><span class='label label-info'>" + data + "</span></a> " + append;
              },
              "targets": 1
            },
          ],
          "language": lang === 'en' ? tb_language.en : tb_language.cn
        });

        return table;
      },

    },
  }

</script>