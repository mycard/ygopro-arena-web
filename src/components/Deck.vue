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


      <div class="row">
        <div class="col-md-4" id="profile">
          <div class="thumbnail">
            <img v-bind:src="avatar_url" style="height:300px;margin-top:2px;margin-top:3px">
            <div class="caption">
              <h3>
                <!--<i class="glyphicon glyphicon-user"></i> -->
                <strong>{{username}}</strong></h3>
              <!--<p class="text-muted" style="font-size:20px;">{{form.desc}}</p>-->
            </div>
          </div>
        </div>

        <div class="col-md-8">

          <div class="caption">
            <!--<h3>-->
            <!--<i class="glyphicon glyphicon-user"></i> -->
            <!--<strong>{{username}}</strong></h3>-->
            <p style="font-size:20px;">
              <!--<pre>{{form.desc}}</pre>-->
              <pre><p v-html="form.desc"></p></pre>
            </p>
            <!--作者：{{author}}-->
          </div>


          <el-dialog :title="username" size="large" v-model="dialogFormVisible">
            <el-form :model="form">
              <el-form-item label="标题" :label-width="formLabelWidth">
                <el-input v-model="title_new" placeholder="请输入标题" auto-complete="off"></el-input>
              </el-form-item>
              <el-form-item label="图片URL" :label-width="formLabelWidth">
                <el-input v-model="avatar_url_new" placeholder="请输入您希望展示的图片的地址" auto-complete="off"></el-input>
                <a href="https://ygobbs.com/" target="_blank" class="el-icon-upload2"> 图片上传地址</a>
              </el-form-item>
              <!--<el-form-item label="类型" :label-width="formLabelWidth">
                <el-select v-model="form.region" placeholder="请选择类型">
                  <el-option label="一" value="shanghai"></el-option>
                  <el-option label="二" value="beijing"></el-option>
                </el-select>
              </el-form-item>-->

              <el-form-item label="描述" :label-width="formLabelWidth">
                <!--<el-input type="textarea" :autosize="{ minRows: 2, maxRows: 6}" placeholder="请输入您对此卡组的描述" v-model="form.desc_new">
                </el-input>-->
                <vue-html5-editor :content="form.desc_new" :height="200" :z-index="1000" @change="updateData1" ></vue-html5-editor>

              </el-form-item>

          

              <el-form-item label="卡组攻略" :label-width="formLabelWidth">
                <!--<el-input type="textarea" :autosize="{ minRows: 2, maxRows: 6}" placeholder="请输入卡组攻略" v-model="form.strategy_new">
                </el-input>-->
                <vue-html5-editor :content="form.strategy_new" :height="200" :z-index="1000" @change="updateData2" ></vue-html5-editor>

              </el-form-item>

              <el-form-item label="参考资料" :label-width="formLabelWidth">
                <!--<el-input type="textarea" :autosize="{ minRows: 2, maxRows: 6}" placeholder="请输入参考资料" v-model="form.reference_new">
                </el-input>-->
                <vue-html5-editor :content="form.reference_new" :height="200" :z-index="1000" @change="updateData3" ></vue-html5-editor>

              </el-form-item>


            </el-form>
            <div slot="footer" class="dialog-footer">
              <el-button @click="cancelModify">取 消</el-button>
              <el-button type="primary" @click="submitModify">确 定</el-button>
            </div>
          </el-dialog>

          <!--上传卡组范例-->
          <el-dialog title="上传卡组范例" size="large" v-model="dialogFormVisible2">
            <el-form :model="form">
              <el-form-item label="标题" :label-width="formLabelWidth">
                <el-input v-model="demo_title" placeholder="请输入标题" auto-complete="off"></el-input>
              </el-form-item>
              <el-form-item label="图片URL" :label-width="formLabelWidth">
                <el-input v-model="demo_url" placeholder="请输入您希望展示的图片的地址" auto-complete="off"></el-input>
                <a href="https://ygobbs.com/t/86271" target="_blank" class="el-icon-upload2"> 图片上传地址</a>
              </el-form-item>

              <!--<el-popover
                ref="popover1"
                placement="top-start"
                title="标题"
                width="200"
                trigger="hover"
                content="这是一段内容,这是一段内容,这是一段内容,这是一段内容。">
              </el-popover>

              <el-button v-popover:popover1>hover 激活</el-button>-->

              <!--<el-form-item label="类型" :label-width="formLabelWidth">
                <el-select v-model="form.region" placeholder="请选择类型">
                  <el-option label="一" value="shanghai"></el-option>
                  <el-option label="二" value="beijing"></el-option>
                </el-select>
              </el-form-item>-->

              <!--<el-form-item label="描述" :label-width="formLabelWidth">
                <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 6}" placeholder="请输入您对此卡组的描述" v-model="form.desc_new">
                </el-input>
              </el-form-item>-->


              <el-form-item label="文件" :label-width="formLabelWidth">
                <!--<el-upload
                    class="avatar-uploader"
                    :action="uploadUrl"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                    :before-upload="beforeAvatarUpload">
                    <img v-if="imageUrl" :src="imageUrl" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    <div class="el-upload__tip" slot="tip">上传卡组文件，大小不能超过500kb</div>
                  </el-upload>-->

                <el-upload class="upload-demo" :action="uploadUrl" :on-change="handleChange" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload"
                  :file-list="fileList3">
                  <el-button size="small" type="primary">点击上传</el-button>
                  <div slot="tip" class="el-upload__tip">上传卡组文件，大小不能超过3KB</div>
                  </el-upload>

              </el-form-item>



              <!--<button v-if="downloadPath" @click.prevent="download" >下载</button>-->


            </el-form>
            <div slot="footer" class="dialog-footer">
              <el-button @click="cancelModify2">取 消</el-button>
              <el-button type="primary" @click="submitModify2">确 定</el-button>
            </div>
          </el-dialog>

        </div>
      </div>

      <div class="container">
        <div class="row">


          <h4 class="color-blue"> <i class="glyphicon glyphicon-list-alt"></i> 卡组攻略 </h4>
          <!--<pre>{{form.strategy}}</pre>-->
          <pre><p v-html="form.strategy"></p></pre>
          <br>


          <h4 class="color-blue"> <i class="glyphicon glyphicon-list-alt"></i> 卡组范例&下载 </h4>

          <div v-if="user.isLogin">
            <div class="alert alert-success alert-dismissible" role="alert">
              <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <span v-if="!isNew">您可以上传卡组范例。</span>
              <span v-if="isNew">还没有卡组范例。</span>
              <i class="el-icon-edit hand" @click.prevent="showDialog2">我要上传</i>
            </div>
          </div>
          <div v-else>
            <div class="alert alert-success alert-dismissible" role="alert">
              <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <span>登录后才可上传卡组范例。</span>
              <a class="hand" @click.prevent="login" href="#">登录</a>
            </div>
          </div>

          <el-row>
            <el-col :span="7" v-for="(o, index) in demo1" :key="0" :offset="index > 0 ? 1 : 0">
              <el-card :body-style="{ padding: '0px' }">
                <img :src="o.url" class="image">
                <div style="padding: 6px;">
                  <span style="font-size: 14px">标题: {{o.title}}</span>
                  <br>
                  <span style="font-size: 14px">上传者: {{o.author}}</span>
                  <div class="bottom clearfix">
                    <time class="time">{{o.create_time}}</time>
                    <el-button v-if="o.file" type="text" class="button" @click="downloadFile(o.file)">下载此范例卡组</el-button>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>
          <br>
          <el-row>
            <el-col :span="7" v-for="(o, index) in demo2" :key="1" :offset="index > 0 ? 1 : 0">
              <el-card :body-style="{ padding: '0px' }">
                <img :src="o.url" class="image">
                <div style="padding: 6px;">
                  <span style="font-size: 14px">标题: {{o.title}}</span>
                  <br>
                  <span style="font-size: 14px">上传者: {{o.author}}</span>
                  <div class="bottom clearfix">
                    <time class="time">{{o.create_time}}</time>
                    <el-button v-if="o.file" type="text" class="button" @click="downloadFile(o.file)">下载</el-button>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>
          <br>

          <h4 class="color-blue"> <i class="glyphicon glyphicon-list-alt"></i> 参考资料 </h4>
          <!--<pre v-html="form.reference">{{form.reference}}</pre>-->
          <pre><p v-html="form.reference"></p></pre>
          <br>

          <h4 class="color-blue"> <i class="glyphicon glyphicon-list-alt"></i> 编辑历史 </h4>

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
          <br>



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
        contentHtml:"xx",
        unknow:"assets/img/unknow.jpeg",
        currentDate: new Date(),
        author: "",
        fileList3: [],
        isMobile: false,
        searchText: "",
        hasError: false,
        username: "",
        title: '',
        title_new: '',
        avatar_url: "assets/img/unknow.jpeg",
        avatar_url_new: "",
        input3: 'asdasd',
        dialogFormVisible2: false,
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
          strategy: '-',
          strategy_new: '',
          reference: '-',
          reference_new: ''
        },
        formLabelWidth: '40px',
        isNew: true,
        isClick: false,
        todayCount: 0,
        uploadUrl: API.uploadUrl,
        imageUrl: "",
        downloadPath: "",
        demo_title: "",
        demo_url: "",
        demo1: [],
        demo2: []
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

          this.form.reference = dataPbj.reference || '-'
          this.form.reference_new = dataPbj.reference
          this.form.strategy = dataPbj.strategy || '-'
          this.form.strategy_new = dataPbj.strategy

          this.demo1 = res.data.demo.slice(0, 3)
          this.demo2 = res.data.demo.slice(3, 6)

          this.author = dataPbj.author

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
      updateData1: function(html){
        this.form.desc_new = html
      },
      updateData2: function(html){
        this.form.strategy_new = html
      },
      updateData3: function(html){
       this.form.reference_new = html
      },
      init: function () {
        // var username = querystring.parse(location.hash.slice(11)).username
        // this.searchText = username;
        // this.searchByUsername(username)

      },

      handleChange(file, fileList) {
        this.fileList3 = fileList.slice(-1);
      },

      handleAvatarSuccess(res, file) {
        this.downloadPath = file.response.path
        this.imageUrl = URL.createObjectURL(file.raw);
      },
      beforeAvatarUpload(file) {
        var type = /\.[^\.]+/.exec(file.name);
        const isJPG = type[0] === '.ydk';
        const isLt2M = file.size / 1024 < 3;

        if (!isJPG) {
          this.$message.error('上传文件只能是 ydk 格式!');
          return false
        }
        if (!isLt2M) {
          this.$message.error('上传文件大小不能超过 3KB!');
          return false
        }
        return true;
      },

      download: function () {
        window.location.href = API.getDownloadUrl(this.downloadPath)
      },

      downloadFile: function (path) {
        window.location.href = API.getDownloadUrl(path)
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

            this.form.reference = dataPbj.reference || '-'
            this.form.reference_new = dataPbj.reference
            this.form.strategy = dataPbj.strategy || '-'
            this.form.strategy_new = dataPbj.strategy

            this.author = dataPbj.author

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

      showDialog2: function () {
        this.dialogFormVisible2 = true
        setTimeout(function () {
          console.log($(".el-upload__input"))
          $(".el-upload__input").hide()
        }, 100)

      },
      cancelModify: function () {
        this.dialogFormVisible = false
      },
      cancelModify2: function () {
        this.dialogFormVisible2 = false
      },
      submitModify2: function () {
        

        if (this.isClick) {
          this.$notify({
            title: '警告',
            message: '您操作得太快了!',
            type: 'error'
          })
        } else {
          
          if (!this.demo_title || !this.demo_url) {
            this.$notify({
              title: '警告',
              message: '标题和截图不能为空!',
              type: 'error'
            })
            return
          }


          this.isClick = true;
          var param = {
            user: this.user.username,
            name: this.username,
            title: this.demo_title,
            url: this.demo_url,
            file: this.downloadPath
          }
          var _this = this;
          API.saveDeckDemo(param).then((res) => {
            this.dialogFormVisible2 = false

            this.$notify({
              title: '操作成功',
              message: '感谢您的提交!',
              type: 'success'
            })
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
              strategy: this.form.strategy_new,
              reference: this.form.reference_new,
              url: this.avatar_url_new,
              isNew: this.isNew
            }
            var _this = this;
            API.saveDeck(param).then((res) => {
              this.dialogFormVisible = false
              this.isNew = false
              this.form.desc = this.form.desc_new
              this.form.strategy = this.form.strategy_new
              this.form.reference = this.form.reference_new

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
  
  .el-upload__input {}
  
  .el-upload__tip {}
  
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  
  .avatar-uploader .el-upload:hover {
    border-color: #20a0ff;
  }
  
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
  
  .time {
    font-size: 13px;
    color: #999;
  }
  
  .bottom {
    margin-top: 13px;
    line-height: 12px;
  }
  
  .button {
    padding: 0;
    float: right;
  }
  
  .image {
    width: 100%;
    display: block;
  }
  
  .clearfix:before,
  .clearfix:after {
    display: table;
    content: "";
  }
  
  .clearfix:after {
    clear: both
  }
  
  pre {
    white-space: pre-wrap;
    white-space: -moz-pre-wrap;
    white-space: -pre-wrap;
    white-space: -o-pre-wrap;
    word-wrap: break-word;
  }
</style>