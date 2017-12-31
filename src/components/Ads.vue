<template>
	<div class="container">
		<div id="history">



			<el-button type="text" @click="newVote">新增广告素材</el-button>

			<el-dialog title="广告素材" :visible.sync="dialogFormVisible">
				<el-form :model="dynamicValidateForm" :rules="rules2" ref="dynamicValidateForm" label-width="80px" class="demo-dynamic">

					<el-form-item prop="name" label="广告标题" :rules="{required: true, message: '广告标题不能为空', trigger: 'blur'}">
						<el-input v-model="dynamicValidateForm.name"></el-input>
					</el-form-item>

					<el-form-item prop="desc" label="广告描述" :rules="{required: true, message: '广告描述不能为空', trigger: 'blur'}">
						<el-input v-model="dynamicValidateForm.desc"></el-input>
					</el-form-item>

					<el-form-item prop="imgp" label="PC图片" :rules="{required: true, message: 'PC图片不能为空', trigger: 'blur'}">
						<el-input v-model="dynamicValidateForm.imgp" placeholder="请输入用于PC端展示的图片url,建议图片尺寸800x480"></el-input>
					</el-form-item>

					<el-form-item prop="imgm" label="手机图片" :rules="{required: true, message: '手机图片不能为空', trigger: 'blur'}">
						<el-input v-model="dynamicValidateForm.imgm" placeholder="请输入用于手机端展示的图片url,建议图片尺寸300x400"></el-input>
					</el-form-item>

					<el-form-item prop="clkref" label="点击链接" :rules="{required: true, message: '点击链接不能为空', trigger: 'blur'}">
						<el-input v-model="dynamicValidateForm.clkref" placeholder="请填入广告点击后的跳转地址"></el-input>
					</el-form-item>

					<el-form-item prop="implurl" label="曝光追踪地址" :rules="{required: true, message: '曝光追踪地址不能为空', trigger: 'blur'}">
						<el-input v-model="dynamicValidateForm.implurl" :disabled="true"></el-input>
					</el-form-item>

					<el-form-item prop="clkurl" label="点击追踪地址" :rules="{required: true, message: '点击追踪地址不能为空', trigger: 'blur'}">
						<el-input v-model="dynamicValidateForm.clkurl" :disabled="true"></el-input>
					</el-form-item>

					<el-form-item label="是否立即启用">
						<el-checkbox v-model="dynamicValidateForm.status"></el-checkbox>
					</el-form-item>


					<!--<el-form-item>-->
					<!--<el-button type="primary" @click="submitForm('dynamicValidateForm')">提交</el-button>-->

					<!--<el-button @click="resetForm('dynamicValidateForm')">重置</el-button>-->
					<!--</el-form-item>-->
				</el-form>
				<div slot="footer" class="dialog-footer">
					<el-button @click="dialogFormVisible = false">取 消</el-button>
					<!--<el-button @click="resetForm('dynamicValidateForm')">重置</el-button>-->
					<el-button type="primary" @click="submitForm('dynamicValidateForm')">提 交</el-button>
				</div>
			</el-dialog>


			<hr>

			<!--<el-form :inline="true" :model="formInline">
				<el-form-item>
					<el-select style="width: 100px;" v-model="type" placeholder="状态" @change="selectChange">
						<el-option label="全部" value="0"></el-option>
						<el-option label="启用中" value="1"></el-option>
						<el-option label="已禁用" value="2"></el-option>
					</el-select>
				</el-form-item>
			</el-form>-->


			<el-table :data="history.data" v-loading.fullscreen.lock="loading" element-loading-text="拼命加载中" style="width: 100%" :default-expand-all="expand">
				<el-table-column type="expand">
					<template scope="props">
						<p>描述: {{ props.row.desctext }}</p>
						<p>PC图片: {{ props.row.imgp_url }}</p>
						<p>手机图片: {{ props.row.imgm_url }}</p>
						<p>点击链接: {{ props.row.click_ref }}</p>
						<p>曝光追踪: {{ props.row.impl_url }}</p>
						<p>点击追踪: {{ props.row.click_url }}</p>
					</template>

				</el-table-column>
				<!--<el-table-column label="id" prop="id"></el-table-column>-->
				<el-table-column label="广告标题" prop="name"></el-table-column>

				<el-table-column label="状态" :formatter="formatter3"></el-table-column>

				<el-table-column label="曝光次数" prop="impl"></el-table-column>
				<el-table-column label="点击次数" prop="clk"></el-table-column>


				<el-table-column label="状态编辑">
					<template scope="props">
						<!--<el-tooltip :content="'Switch value: ' + props.row.status" placement="top">-->
						<el-switch v-model="props.row.status" @change="switchChange(props.row.id,props.row.status)" on-color="#13ce66" off-color="#ff4949"
							on-text="启用" off-text="禁用" :on-value="onValue" :off-value="offValue">
							</el-switch>
							<!--</el-tooltip>-->
					</template>
				</el-table-column>

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

		mounted: function () {

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
			var checkMax = (rule, value, callback) => {
				if (!value) {
					return callback(new Error('个数不能为空'));
				}
				setTimeout(() => {
					value = value - 0
					if (!Number.isInteger(value)) {
						callback(new Error('请输入数字值'));
					} else {
						if (value > 6) {
							callback(new Error('个数不能超过6个'));
						} else {
							callback();
						}
					}
				}, 500);
			};
			return {
				rules2: {
					max: [
						{ validator: checkMax, trigger: 'blur' }
					]
				},
				radio: "x",
				loading: true,
				onValue: true,
				offValue: false,
				value2: true,
				expand: true,
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
					id: '',
					name: '',
					desc: '',
					imgp: '',
					imgm: '',
					clkref: '',
					status: true,
					implurl: API.implUrl,
					clkurl: API.clkUrl
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

		computed: {
      		...mapGetters({
				lang: 'getLang',
				user: 'getUser'
			})
		},

		methods: {
			switchChange: function (id, status) {
				// this.loading = true
				var param = {
					id: id,
					status: status
				}
				API.adsStatus(param).then((res) => {
					// this.loading = false

					// this.$notify({
					// 	title: '操作成功',
					// 	message: '状态已修改!',
					// 	type: 'success'
					// })

				}, (res) => {
					// this.loading = false
				});
			},
			newVote() {
				this.dialogFormVisible = true
				this.dynamicValidateForm.id = ""
				this.dynamicValidateForm.name = ""
				this.dynamicValidateForm.status = true

				this.dynamicValidateForm.desc = ""
				this.dynamicValidateForm.imgp = ""
				this.dynamicValidateForm.imgm = ""
				this.dynamicValidateForm.clkref = ""
				this.dynamicValidateForm.implurl = API.implUrl
				this.dynamicValidateForm.clkurl = API.clkUrl

			},
			handleClick(row) {
				this.dynamicValidateForm.id = row.id
				this.dynamicValidateForm.status = row.status

				this.dynamicValidateForm.name = row.name
				this.dynamicValidateForm.desc = row.desctext

				this.dynamicValidateForm.imgp = row.imgp_url
				this.dynamicValidateForm.imgm = row.imgm_url
				this.dynamicValidateForm.clkref = row.click_ref
				this.dynamicValidateForm.implurl = row.impl_url
				this.dynamicValidateForm.clkurl = row.click_url

				this.needRender = false
				this.dialogFormVisible = true;
			},
			selectChange: function (val) {
				this.type = val
				this.renderTable()
			},
			init: function (lang) {

				//权限设置
				if (!this.user.isLogin || !this.user.admin) {
					this.$notify({
						// title: '警告',
						message: '需要管理员权限才能查看该页面，已为您自动跳转到首页 ！',
						type: 'warning'
					})
					this.loading = false
					return this.$router.replace('/')
				}

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
			formatter4(row, column) {
				return row.count
			},
			renderTable: function () {
				var params = {
					type: this.type,
					page: this.page,
					username: this.username,
					type: this.type,
					from_date: this.from_date,
					to_date: this.to_date
				}
				var _this = this;
				_this.loading = true
				API.getAdsList(params).then((res) => {
					_this.loading = false
					var history = {}
					history.total = res.data.total
					var optionCountMap = res.data.optionCountMap
					var voteCountMap = res.data.voteCountMap
					history.data = res.data.data;
					// console.log(history.data)
					_this.history = history



				}, (res) => {
					//
					_this.loading = false
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
								name: this.dynamicValidateForm.name,
								desc: this.dynamicValidateForm.desc,
								imgp: this.dynamicValidateForm.imgp,
								imgm: this.dynamicValidateForm.imgm,
								clkref: this.dynamicValidateForm.clkref,
								implurl: this.dynamicValidateForm.implurl,
								clkurl: this.dynamicValidateForm.clkurl,
								status: this.dynamicValidateForm.status
							}

							var _this = this;

							API.saveAds(param).then((res) => {
								this.dialogFormVisible2 = false

								// this.$notify({
								// 	title: '操作成功',
								// 	message: '感谢您的提交!',
								// 	type: 'success'
								// })
								_this.renderTable()
								setTimeout(function () {
									_this.isClick = false;
								}, 1500)
							}, (res) => {
								setTimeout(function () {
									_this.isClick = false;
								}, 1500)
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