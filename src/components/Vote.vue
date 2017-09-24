<template>
	<div class="container">
		<div id="history">

			<!--<el-form :inline="true" :model="formInline">
				<el-form-item>
					<el-select style="width: 100px;" v-model="type" placeholder="类别" @change="selectChange">
						<el-option label="所有" value="0"></el-option>
						<el-option label="竞技" value="1"></el-option>
						<el-option label="娱乐" value="2"></el-option>
					</el-select>
				</el-form-item>
				<el-date-picker v-model="date" type="daterange" align="right" placeholder="选择日期范围" :picker-options="pickerOptions2" style="width: 220px;">
				</el-date-picker>
				<el-form-item>
					<el-input v-model="username" @blur="searchTextChange" icon="search" style="width: 200px;" placeholder="用户名"></el-input>
				</el-form-item>
			</el-form>-->


			<!--<el-table :data="history.data" stripe style="width: 100%">
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
			</el-table>-->


			<el-button type="text" @click="newVote">新建投票</el-button>

			<el-dialog title="投票详情" :visible.sync="dialogFormVisible">
				<el-form :model="dynamicValidateForm" ref="dynamicValidateForm" label-width="80px" class="demo-dynamic">
					<el-form-item prop="title" label="投票标题" :rules="{required: true, message: '投票标题不能为空', trigger: 'blur'}">
						<el-input v-model="dynamicValidateForm.title"></el-input>
					</el-form-item>
					<el-form-item v-for="(domain, index) in dynamicValidateForm.domains" :label="'投票项' + index" :key="domain.key" :prop="'domains.' + index + '.name'"
						:rules="{required: true, message: '投票项内容不能为空', trigger: 'blur'}">
						<el-input v-model="domain.name"></el-input>
						<el-button @click.prevent="removeDomain(domain)">删除</el-button>
						</el-form-item>

						<el-form-item prop="email" label="投票日期">
							<el-date-picker v-model="date" type="daterange" placeholder="选择日期范围" :picker-options="pickerOptions2" style="width: 220px;">
							</el-date-picker>
						</el-form-item>

						<el-form-item label="是否启用">
							<!--<el-tooltip :content="xxx " placement="top">-->
							<!--<el-switch v-model="dynamicValidateForm.status" on-color="#13ce66" off-color="#ff4949" on-value="true" off-value="false">
								</el-switch>-->
							<!--</el-tooltip>-->
							<el-checkbox v-model="dynamicValidateForm.status"></el-checkbox>
						</el-form-item>


						<!--<el-form-item>-->
						<!--<el-button type="primary" @click="submitForm('dynamicValidateForm')">提交</el-button>-->

						<!--<el-button @click="resetForm('dynamicValidateForm')">重置</el-button>-->
						<!--</el-form-item>-->
				</el-form>
				<div slot="footer" class="dialog-footer">
					<el-button @click="dialogFormVisible = false">取 消</el-button>
					<el-button @click="addDomain">新增投票项</el-button>
					<!--<el-button @click="resetForm('dynamicValidateForm')">重置</el-button>-->
					<el-button type="primary" @click="submitForm('dynamicValidateForm')">提 交</el-button>
				</div>
			</el-dialog>


			<hr>
			<el-table :data="history.data" style="width: 100%">
				<el-table-column type="expand">
					<template scope="props">

						<div v-for=" item in props.row.options">
							{{ item.name }} -- {{ item.count || 0 }} 票
							<el-progress :percentage="item.percentage"></el-progress>
						</div>


					</template>

				</el-table-column>
				<!--<el-table-column label="ID" prop="id"></el-table-column>-->
				<el-table-column label="标题" prop="title"></el-table-column>

				<el-table-column label="开始时间" :formatter="formatter1"></el-table-column>
				<el-table-column label="结束时间" :formatter="formatter2"></el-table-column>

				<el-table-column label="状态" :formatter="formatter3"></el-table-column>

				<!--<el-table-column label="状态">
					<template scope="props">
						<el-tooltip :content="'Switch value: ' + props.row.status" placement="top">
							<el-switch v-model="props.row.status" on-color="#13ce66" off-color="#ff4949" on-value="true" off-value="false">
							</el-switch>
						</el-tooltip>
					</template>
				</el-table-column>-->


				<el-table-column label="操作" width="100">
					<template scope="props">
						<el-button @click="handleClick(props.row)" type="text" size="small">编辑</el-button>
					</template>
				</el-table-column>

			</el-table>


			<div class="text-center">
				<el-pagination :page-size="pageSize" layout="total, prev, pager, next" :total="history.total" @current-change="clickpage"></el-pagination>
			</div>

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
				if (val[0] != null) {
					this.from_date = moment(val[0]).format('YYYY-MM-DD HH:mm')
					this.to_date = moment(val[1]).format('YYYY-MM-DD HH:mm')
				} else {
					this.from_date = '';
					this.to_date = '';
				}
				if (this.needRender) {
					this.renderTable()
				}

			},
		},
		data: function () {
			return {
				radio: "x",
				ddd: [1, 2, 31, 231, 23],
				needRender: true,
				page: 1,
				from_date: moment().format('YYYY-MM-DD HH:mm'),
				to_date: moment().add(7, 'd').format('YYYY-MM-DD HH:mm'),
				date: [moment().format('YYYY-MM-DD HH:mm'), moment().add(7, 'd').format('YYYY-MM-DD')],
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
				},
				dynamicValidateForm: {
					domains: [{
						key: Date.now()
					}],
					id: '',
					status: false,
					title: ''
				},
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
				isClick: false,
			}
		},

		methods: {
			newVote() {
				this.dialogFormVisible = true
				this.dynamicValidateForm.id = ""
				title: ''
				this.dynamicValidateForm.title = ""
				this.dynamicValidateForm.status = false
				this.dynamicValidateForm.domains = [{
					key: Date.now()
				}]

			},
			handleClick(row) {

				this.dynamicValidateForm.id = row.id
				this.dynamicValidateForm.status = row.status
				this.dynamicValidateForm.title = row.title
				this.dynamicValidateForm.domains = row.options
				this.date = [row.start_time, row.end_time]
				this.dialogFormVisible = true;

			},
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
				return moment(row.start_time).format('YYYY-MM-DD HH:mm')
			},
			formatter2(row, column) {
				return moment(row.end_time).format('YYYY-MM-DD HH:mm')
			},
			formatter3(row, column) {
				return row.status ? '启用' : '禁用'
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
				API.getVoteList(params).then((res) => {
					var history = {}
					history.total = res.data.total
					var optionCountMap = res.data.optionCountMap
					history.data = res.data.data.map(function (row) {
						row.options = JSON.parse(row.options)
						var voteVount = 0 
						row.options.map(function(option){
							option.count = parseInt(optionCountMap[option.key])
							voteVount += option.count
							return option
						})

						row.options.map(function(option){
							var percentage = 100
							if(voteVount === 0 || option.count === 0){
								percentage = 0
							}else{
								percentage = option.count / voteVount * 100
							}
							
							option.percentage = percentage
							return option
						})
						return row
					})
					console.log(history.data)
					_this.history = history
				}, (res) => {
					//
				})
			},
			submitForm(formName) {
				this.$refs[formName].validate((valid) => {
					if (valid) {

						if (this.isClick) {
							this.$notify({
								title: '警告',
								message: '您操作得太快了!',
								type: 'error'
							})
						} else {
							this.dialogFormVisible = false

							this.isClick = true;
							var param = {
								id: this.dynamicValidateForm.id,
								title: this.dynamicValidateForm.title,
								options: JSON.stringify(this.dynamicValidateForm.domains),
								start_time: this.from_date,
								end_time: this.to_date,
								status: this.dynamicValidateForm.status
							}
							var _this = this;

							API.saveVote(param).then((res) => {
								this.dialogFormVisible2 = false

								this.$notify({
									title: '操作成功',
									message: '感谢您的提交!',
									type: 'success'
								})
								_this.renderTable()
								setTimeout(function () {
									_this.isClick = false;
								}, 3000)
							}, (res) => {
								setTimeout(function () {
									_this.isClick = false;
								}, 3000)
								this.hasError = true
							});

						}




					} else {
						console.log('error submit!!');
						return false;
					}
				});
			},
			resetForm(formName) {
				this.$refs[formName].resetFields();
			},
			removeDomain(item) {
				var index = this.dynamicValidateForm.domains.indexOf(item)
				if (index !== -1) {
					this.dynamicValidateForm.domains.splice(index, 1)
				}
			},
			addDomain() {
				this.dynamicValidateForm.domains.push({
					key: Date.now()
				});
			}
		}
	}

</script>

<style scoped>
	#history {
		margin-top: 100px;
	}
	
	.demo-table-expand {
		font-size: 0;
	}
	
	.demo-table-expand label {
		width: 90px;
		color: #99a9bf;
	}
	
	.demo-table-expand .el-form-item {
		margin-right: 0;
		margin-bottom: 0;
		width: 100%;
	}
</style>