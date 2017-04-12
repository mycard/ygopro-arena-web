<template>
	<div id="history">

		<el-form :inline="true" :model="formInline">
			<el-form-item>
				<el-select style="width: 100px;" v-model="type" placeholder="类别" @change="selectChange">
					<el-option label="所有" value="0"></el-option>
					<el-option label="竞技" value="1"></el-option>
					<el-option label="娱乐" value="2"></el-option>
				</el-select>
			</el-form-item>
			<!--<el-date-picker
                v-model="date"
                type="daterange"
                align="right"
                placeholder="选择日期范围"
                :picker-options="pickerOptions2"
                style="width: 220px;">
        </el-date-picker>-->
			<el-form-item>
				<el-input v-model="username" @blur="searchTextChange" icon="search" style="width: 200px;" placeholder="用户名"></el-input>
			</el-form-item>
		</el-form>


		<el-table :data="history.data" stripe style="width: 100%">
			<el-table-column prop="usernamea" label="玩家A" width="180">
				<template scope="scope">
					<el-tag :type="scope.row.userscorea > scope.row.userscoreb ? 'success' : 'gray'" close-transition>{{scope.row.usernamea}}</el-tag>
					<el-icon v-if="scope.row.userscorea < 0" class="el-icon-warning"></el-icon>
				</template>
			</el-table-column>
			<el-table-column prop="usernameb" label="玩家B" width="180">
				<template scope="scope">
					<el-tag :type="scope.row.userscoreb > scope.row.userscorea ? 'success' : 'gray'" close-transition>{{scope.row.usernameb}}</el-tag>
					<el-icon v-if="scope.row.userscoreb < 0" class="el-icon-warning"></el-icon>
				</template>
			</el-table-column>
			<el-table-column label="类型" :formatter="formatter0" width="80"></el-table-column>
			<el-table-column label="开始时间" :formatter="formatter1"></el-table-column>
			<el-table-column label="结束时间" :formatter="formatter2"></el-table-column>
		</el-table>
		<div class="text-center">
			<el-pagination :page-size="pageSize" layout="total, prev, pager, next" :total="history.total" @current-change="clickpage"></el-pagination>
		</div>
	</div>

</template>

<script>
	import querystring from 'querystring';
	import language from './lang';

	import API from '../api'

	import tb_language from './tb_lang.js'
	import { mapGetters } from 'vuex'

	import moment from 'moment'

	export default {
		created: function () {
			var lang = localStorage.getItem('lang') || 'cn';
			this.init(lang)
		},
		watch: {
			date: function (val) {
				console.log(val)
				if (val[0] != null) {
					this.from_date = val[0].toString()
					this.to_date = val[1].toString()
				} else {
					this.from_date = '';
					this.to_date = '';
				}
				this.renderTable()
			},
		},
		data: function () {
			return {
				page: 1,
				from_date: '',
				to_date: '',
				date: '',
				username: '',
				type: '0',
				formInline: {
				},
				pickerOptions2: {
					shortcuts: [
						{
							text: '今天',
							onClick(picker) {
								const end = new Date();
								const start = new Date();
								start.setTime(start.getTime());
								picker.$emit('pick', [start, end]);
							}
						},
						{
							text: '昨天',
							onClick(picker) {
								const end = new Date();
								const start = new Date();
								start.setTime(start.getTime() - 3600 * 1000 * 24 * 1);
								picker.$emit('pick', [start, end]);
							}
						},
						{
							text: '最近一周',
							onClick(picker) {
								const end = new Date();
								const start = new Date();
								start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
								picker.$emit('pick', [start, end]);
							}
						}, {
							text: '最近一个月',
							onClick(picker) {
								const end = new Date();
								const start = new Date();
								start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
								picker.$emit('pick', [start, end]);
							}
						}, {
							text: '最近三个月',
							onClick(picker) {
								const end = new Date();
								const start = new Date();
								start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
								picker.$emit('pick', [start, end]);
							}
						}]
				},
				pageSize: 15,
				history: {
					total: 0,
					data: []
				}
			}
		},

		methods: {
			searchTextChange: function () {
				var username = this.username
				this.renderTable()
			},
			selectChange: function (val) {
				this.type = val
				this.renderTable()
			},
			init: function (lang) {
				this.renderTable()
			},
			clickpage: function (num) {
				console.log('asdasdasd!!!ASDASD!!!!')
				this.page = num
				this.renderTable()
			},
			formatter0(row, column) {
				if ('athletic' === row.type) {
					return '竞技'
				} else {
					return '娱乐'
				}
			},
			formatter1(row, column) {
				return moment(row.start_time).subtract(8, 'h').format('YYYY-MM-DD HH:mm')
			},
			formatter2(row, column) {
				return moment(row.end_time).subtract(8, 'h').format('YYYY-MM-DD HH:mm')
			},
			renderTable: function () {
				var params = {
					page: this.page,
					username: this.username,
					type: this.type,
					from_date: this.from_date,
					to_date: this.to_date
				}
				var _this = this; 
				API.getUserDueHistory(params).then((res) => {
					_this.history = res.data
				}, (res) => {
					//
				})
			}
		}
	}

</script>

<style scoped>
	#history{
		margin-top: 100px;
	}
</style>