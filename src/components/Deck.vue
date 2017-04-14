<template>
  <div class="content">
    <div class="container">
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

          <el-dialog :title="username" size="large" v-model="dialogFormVisible">
            <el-form :model="form">
              <el-form-item label="URL" :label-width="formLabelWidth">
                <el-input v-model="avatar_url" auto-complete="off"></el-input>
              </el-form-item>
              <el-form-item label="类型" :label-width="formLabelWidth">
                <el-select v-model="form.region" placeholder="请选择类型">
                  <el-option label="一" value="shanghai"></el-option>
                  <el-option label="二" value="beijing"></el-option>
                </el-select>
              </el-form-item>

              <el-form-item label="描述" :label-width="formLabelWidth">
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
  import unknow from '../assets/img/unknow.jpeg'
  import API from '../api'
  import { mapGetters } from 'vuex'
  import moment from 'moment'

  var rankTable;
  var rankTable2;

  export default {
    data() {
      return {
        username: "",
        avatar_url: unknow,
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
        formLabelWidth: '40px',
        isNew: true,
      }
    },
    created: function () {
    },
    mounted: function () {
      var name = querystring.parse(location.search.slice(1)).name
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
    },
    computed: {
      		...mapGetters({
        lang: 'getLang',
        user: 'getUser'
      }),
    },

    methods: {

      submitModify: function () {
        var param = {
          user: this.user.username,
          name: this.username,
          desc: this.form.desc,
          url: this.avatar_url,
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

    },
  }

</script>

<style scoped>

</style>