<template>
    <div class="content">
        <div class="container">
            <template>
                <el-alert title="上传ydk文件和填写必要的信息之后,卡组表格即可自动生成" type="success">
                </el-alert>
                <hr>
                <el-alert v-if="isIE" title="您的浏览器不支持卡表打印功能。
卡表打印功能支持谷歌、Safari、火狐以及手机默认浏览器。" type="error">
                    </el-alert>
            </template>
            <hr>
            <el-form ref="form" :model="form" label-width="80px">

                <el-form-item label="姓名" :label-width="formLabelWidth">
                    <el-input v-model="form.name" placeholder="请输入标题姓名" auto-complete="off" width="10px"></el-input>
                </el-form-item>

                <el-form-item label="Event" :label-width="formLabelWidth">
                    <el-input v-model="form.event" placeholder="请输入Event" auto-complete="off" width="10px"></el-input>
                </el-form-item>

                <el-form-item label="参赛ID" :label-width="formLabelWidth">
                    <el-input v-model="form.gameid" placeholder="请输入gameid" auto-complete="off" width="10px"></el-input>
                </el-form-item>

                <el-form-item label="日期" :label-width="formLabelWidth">
                    <el-date-picker v-model="form.date" type="date" placeholder="选择日期" format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd">
                    </el-date-picker>
                    <!--<el-input v-model="form.date" placeholder="请输入" auto-complete="off" width="10px"></el-input>-->
                </el-form-item>

                <el-form-item label="ydk文件" :label-width="formLabelWidth">
                    <el-upload class="upload-demo" :action="uploadUrl" :on-change="handleChange" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload"
                        :file-list="fileList3">
                        <el-button size="small" type="primary">点击上传</el-button>
                        <div slot="tip" class="el-upload__tip">上传卡组文件，大小不能超过3KB</div>
                        </el-upload>
                </el-form-item>

                 <el-form-item label="备选项" :label-width="formLabelWidth">
                    <el-checkbox v-model="checked">是否生成图片</el-checkbox>
                </el-form-item>
               
                <el-form-item>
                    <el-button type="primary" @click="onSubmit">确认</el-button>
                </el-form-item>
            </el-form>
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

    export default {
        data() {
            return {
                fileList3: [],

                isIE: false,

                form: {
                    name: '',
                    event: '',
                    date: '',
                    gameid: '',

                },
                formLabelWidth: '80px',
                isNew: true,
                isClick: false,
                todayCount: 0,
                uploadUrl: API.uploadUrl,
                imageUrl: "",
                downloadPath: "",
                demo_title: "",
                demo_url: "",
                demo1: [],
                checked: false,
                demo2: []
            }
        },

        created: function () {
            setTimeout(function () {
                $(".el-upload__input").hide()
            }, 100)

            this.isIE = this.isIEMethod();
        },

        computed: {
      		...mapGetters({
                lang: 'getLang',
                user: 'getUser'
            }),
        },

        methods: {
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

            isIEMethod: function (ver) {
                var b = document.createElement('b')
                b.innerHTML = '<!--[if IE ' + ver + ']><i></i><![endif]-->'
                return b.getElementsByTagName('i').length === 1
            },

            onSubmit: function () {
                // if (!this.form.name || !this.form.name.trim()) {
                //     this.$notify({
                //         title: '警告',
                //         message: '请输入姓名!',
                //         type: 'error'
                //     })
                //     return;
                // }

                // if (!this.form.event || !this.form.event.trim()) {
                //     this.$notify({
                //         title: '警告',
                //         message: '请输入event!',
                //         type: 'error'
                //     })
                //     return;
                // }

                var date;

                if (this.form.date) {
                    date = moment(this.form.date).format('YYMMDD')
                }

                if (!this.downloadPath || !this.downloadPath.trim()) {
                    this.$notify({
                        title: '警告',
                        message: '请上传ydk文件!',
                        type: 'error'
                    })
                    return;
                }

                var opt = {
                    name: this.form.name,
                    event: this.form.event,
                    gameid: this.form.gameid,
                    date: date,
                    id: this.downloadPath.slice(7),
                    img: this.checked
                }

                var request = querystring.stringify(opt);
                // var baseUrl = "http://localhost:8081"
                var baseUrl = "https://mycard.moe/ygopro/arena"
                var url = `${baseUrl}/konami.html?${request}`;

                window.open(url, "_blank");
            },

        },
    }

</script>

<style scoped>

</style>