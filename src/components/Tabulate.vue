<template>
    <div class="content">
        <div class="container">


            <div style="margin-left: 10%;margin-right: 10%; margin-top: 20px;">
                <el-form ref="form" :model="form" label-width="80px">

                    <el-form-item label="一队队名" :label-width="formLabelWidth">
                        <el-input v-model="form.name1" placeholder="请输入一队队名" auto-complete="off" width="10px"></el-input>
                    </el-form-item>

                    <el-form-item label="二队队名" :label-width="formLabelWidth">
                        <el-input v-model="form.name2" placeholder="请输入二队队名" auto-complete="off" width="10px"></el-input>
                    </el-form-item>

                    <el-form-item label="比赛规则" :label-width="formLabelWidth">
                        <el-input v-model="form.rule" placeholder="请输入比赛规则" auto-complete="off" width="10px"></el-input>
                    </el-form-item>

                    <el-form-item label="比赛地点" :label-width="formLabelWidth">
                        <el-input v-model="form.location" placeholder="请输入比赛地点" auto-complete="off" width="10px"></el-input>
                    </el-form-item>

                    <el-form-item label="一队队员" :label-width="formLabelWidth">
                        <el-input v-model="form.member1" placeholder="请输入一队队员, 成员请用空格分开" auto-complete="off" width="10px"></el-input>
                    </el-form-item>

                    <el-form-item label="二队队员" :label-width="formLabelWidth">
                        <el-input v-model="form.member2" placeholder="请输入二队队员, 成员请用空格分开" auto-complete="off" width="10px"></el-input>
                    </el-form-item>

                    <el-form-item label="比赛日期" :label-width="formLabelWidth">
                        <el-date-picker v-model="form.date" type="date" placeholder="选择日期" format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd">
                        </el-date-picker>
                    </el-form-item>

                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">排表</el-button>
                    </el-form-item>
                </el-form>

            </div>

            <hr>

            <div style="margin-left: 20%;margin-right: 20%; ">
                <!--<p>【胜】VS【负】 </p>-->
                <span class="xx"> 比赛： {{form.name1}} VS {{form.name2}}</span>
                <span class="xx"> 时间： {{getDate()}}</span>
                <span class="xx"> 规则： {{form.rule}}</span>
                <span class="xx"> 地点： {{form.location}}</span>
                <span class="xx"> ------------第一轮------------</span>
                <span class="xx" v-for="x in list">
                    {{x.a}} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0:0 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {{x.b}}
                </span>
                <span class="xx"> ------------第二轮------------</span>
            </div>

            <br>
            <br>
            <br>
            <br>
            <br>

        </div>
    </div>

</template>

<script>
    import querystring from 'querystring';
    import _ from 'lodash';
    import crypto from 'crypto';
    import API from '../api'
    import { mapGetters } from 'vuex'
    import moment from 'moment'
    import tb_language from './tb_lang.js'

    export default {
        data() {
            return {
                fileList3: [],
                list: [],
                options: [{
                    value: '1',
                    label: '默认'
                }, {
                    value: '2',
                    label: 'KONAMI'
                }],
                value: '1',

                isIE: false,

                form: {
                    name1: '',
                    name2: '',
                    rule: '2/3【KOF】',
                    location: '',
                    member1: '',
                    member2: '',
                    date: '',
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
                // checked: false,
                checked2: false,
                demo2: []
            }
        },

        created: function () {

            this.isIE = this.isIEMethod();
        },

        computed: {
      		...mapGetters({
                lang: 'getLang',
                user: 'getUser'
            }),
           
        },

        methods: {
            getDate() {
                if (!this.form.date) {
                    return "";
                }
                return moment(this.form.date).format('YYYY-MM-DD')
            },
            handleChange(file, fileList) {
                this.fileList3 = fileList.slice(-1);
            },

            handleAvatarSuccess(res, file) {
                this.downloadPath = file.response.path
                this.imageUrl = URL.createObjectURL(file.raw);
            },


            isIEMethod: function (ver) {
                var b = document.createElement('b')
                b.innerHTML = '<!--[if IE ' + ver + ']><i></i><![endif]-->'
                return b.getElementsByTagName('i').length === 1
            },

            onSubmit: function () {

                var date;

                if (this.form.date) {
                    date = moment(this.form.date).format('YYMMDD')
                }

                var opt = {
                    name: this.form.name,
                    event: this.form.event,
                    gameid: this.form.gameid,
                    date: date,
                    id: this.downloadPath.slice(7),
                    print: this.checked2,
                }

                var member1 = this.form.member1.split(" ").filter(x => {
                    return x.trim()
                });
                var member2 = this.form.member2.split(" ").filter(x => {
                    return x.trim()
                });

                if (member1.length !== member2.length) {
                    this.$notify({
                        // title: '警告',
                        message: '两队人数不一致!',
                        type: 'error'
                    })
                    return;
                }

                var list = []

                member1 = _.shuffle(member1)
                member2 = _.shuffle(member2)

                for (var i = 0; i < member1.length; i++) {
                    list.push({
                        a: member1[i],
                        b: member2[i]
                    })
                }

                this.list = list;
            }

        },
    }

</script>

<style scoped>

.xx {
    margin-top: 0px;
    margin-bottom: 0px;
    display: block;
}

</style>