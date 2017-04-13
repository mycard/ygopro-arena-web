<template>
  <div class="content">
    <div class="container">

      <!--<div class="fck">
        <form id="search-form" class="search-form" @submit.prevent="onSubmit">
          <div class="form-group" v-bind:class="{ 'has-error': hasError}">
            <label class="control-label" for="searchText" v-if="hasError">{{lang.battle.notfound}}</label>
            <div class="input-group">
              <div class="input-group-addon"><span><i class="glyphicon glyphicon-search"></i></span></div>
              <input class="form-control" type="text" id="searchText" v-model="searchText" :placeholder="lang.battle.ph2">
              <div class="input-group-btn">
                <button class="btn btn-default" type="submit">{{lang.battle.search}}</button>
                <button class="btn btn-default" style="display:none" type="submit" id="search">{{lang.battle.search}}</button>
              </div>
            </div>
          </div>
        </form>
      </div>-->

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

          <div class="alert alert-success alert-dismissible" role="alert" v-if="!isNew">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>            您可以参与编辑此页面。
            <i class="el-icon-edit" @click.prevent="dialogFormVisible = true">编辑</i>
          </div>
          <div class="alert alert-success alert-dismissible" role="alert" v-if="isNew">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>            此卡组还未有任何信息。您可以参与编辑此页面。
            <i class="el-icon-edit" @click.prevent="dialogFormVisible = true">编辑</i>
          </div>

          <el-dialog :title="username" v-model="dialogFormVisible">
            <el-form :model="form">
              <el-form-item label="图片URL" :label-width="formLabelWidth">
                <el-input v-model="avatar_url" auto-complete="off"></el-input>
              </el-form-item>
              <el-form-item label="下拉类型" :label-width="formLabelWidth">
                <el-select v-model="form.region" placeholder="请选择类型">
                  <el-option label="一" value="shanghai"></el-option>
                  <el-option label="二" value="beijing"></el-option>
                </el-select>
              </el-form-item>

              <el-form-item label="卡组描述" :label-width="formLabelWidth">
                <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 6}" placeholder="请输入内容" v-model="form.desc">
                </el-input>
              </el-form-item>


            </el-form>
            <div slot="footer" class="dialog-footer">
              <el-button @click="dialogFormVisible = false">取 消</el-button>
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
  import language from './lang';

  import unknow from '../assets/img/unknow.jpeg'

  import API from '../api'

  import tb_language from './tb_lang.js'
  import { mapGetters } from 'vuex'

  import moment from 'moment'

  var rankTable;
  var rankTable2;

  export default {
    data() {
      return {
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
          desc: ''
        },
        formLabelWidth: '120px',

        isNew: true,
        searchText: "",
        hasError: false,
        username: "",
        avatar_url: unknow,
        isMobile: false,
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
    created: function () {
      this.init()
      var lang = localStorage.getItem('lang');
      this.initLang(lang);

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
    events: {
      'lang-change': function (lang) {
        this.initLang(lang)
      }
    },

    watch: {
      lang: function (val) {
        console.log('lang change1', val)
        this.init2()
      },
    },

    mounted: function () {
      this.init2();
    },

    computed: {
      		...mapGetters({
        lang: 'getLang',
      }),
    },

    methods: {

      submitModify: function () {

        var param = {
          name: this.username,
          desc: this.form.desc,
          url:this.avatar_url,
          isNew: this.isNew
        }
        API.saveDeck(param).then((res) => {
          console.log(res.data)
          this.dialogFormVisible = false
          this.$notify({
            title: '操作成功',
            message: '感谢您的提交!',
            type: 'success'
          })
        }, (res) => {
          this.hasError = true
          console.log(res)
        });
      },

      onSubmit: function () {
        this.searchByUsername(this.searchText)
      },
      init: function () {
        var name = querystring.parse(location.search.slice(1)).name
        this.searchText = name;
        this.username = name
        this.searchByUsername(name)
      },
      init2: function () {


      },

      initLang: function (lang) {
        this.lang = language[lang]
        $("#search").trigger('click');
      },
      searchByUsername: function (name) {
        if (!name) return
        API.getDeckInfo({ name: name }).then((res) => {
          this.hasError = false
          this.user_info = res.data
          this.username = name

          if (res.data.code === 404) {
            this.isNew = true;
          } else {
            this.isNew = false;
            this.avatar_url = res.data.data.url 
            this.form.desc = res.data.data.content 
          }

        }, (res) => {
          this.hasError = true
          console.log(res)
        });
        $("#search").trigger('click');
      }
    },
  }

</script>

<style scoped>
  .fck {
    margin-bottom: 20px;
    margin-top: -30px;
  }
  
  .scroll {
    width: 250%;
  }
</style>