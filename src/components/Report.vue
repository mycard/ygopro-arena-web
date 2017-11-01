<template>
	<div class="container">
		<div id="history">

			<el-form :inline="true" :model="formInline">
				<!--<el-form-item>
					<el-select style="width: 100px;" v-model="type" placeholder="类别" @change="selectChange">
						<el-option label="所有" value="0"></el-option>
						<el-option label="竞技" value="1"></el-option>
						<el-option label="娱乐" value="2"></el-option>
					</el-select>
				</el-form-item>-->
				<el-date-picker v-model="date" type="daterange" align="right" placeholder="选择日期范围" :picker-options="pickerOptions2" style="width: 220px;">
				</el-date-picker>
				<!--<el-form-item>
					<el-input v-model="username" @blur="searchTextChange" icon="search" style="width: 200px;" placeholder="用户名"></el-input>
				</el-form-item>-->
			</el-form>

			<!--<hr>-->
			<br>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">数据统计 </h3>
				</div>
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover">
						<tbody>
							<tr>
								<td>竞技场总场数 </td>
								<td>{{report.athletic.total}} </td>
							</tr>
							<tr>
								<td>竞技场断线数 </td>
								<td>{{report.athletic.disconnect}} </td>
							</tr>
							<tr>
								<td>竞技场参与玩家总数 </td>
								<td>{{report.athletic.users}} </td>
							</tr>
							<tr>
								<td>娱乐场总场数 </td>
								<td>{{report.entertain.total}} </td>
							</tr>
							<tr>
								<td>娱乐场断线数 </td>
								<td>{{report.entertain.disconnect}} </td>
							</tr>
							<tr>
								<td>娱乐场参与玩家总数 </td>
								<td>{{report.entertain.users}} </td>
							</tr>
							<tr>
								<td>所有场次参与玩家总数 </td>
								<td>{{report.totalActive}} </td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<hr>

			<div id="myChart" :style="{width: '100%', height: '400px'}"></div>

			<hr>

			<div id="myChart2" :style="{width: '100%', height: '600px'}"></div>

			<hr>

			<div id="myChart3" :style="{width: '100%', height: '600px'}"></div>
			<br>
			<br>
			<br>

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
			<!--<div class="text-center">
				<el-pagination :page-size="pageSize" layout="total, prev, pager, next" :total="history.total" @current-change="clickpage"></el-pagination>
			</div>-->
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
				report: {
					entertain: {
						total: 0,
						disconnect: 0,
						users: 0
					},
					athletic: {
						total: 0,
						disconnect: 0,
						users: 0
					},
					totalActive: 0
				},
				page: 1,
				from_date: '',
				to_date: '',
				date: [new Date(), new Date()],
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

		mounted() {
			this.drawLine();
		},

		methods: {
			drawLine() {
				// 基于准备好的dom，初始化echarts实例
				this.myChart = this.$echarts.init(document.getElementById('myChart'))
				this.myChart2 = this.$echarts.init(document.getElementById('myChart2'))
				this.myChart3 = this.$echarts.init(document.getElementById('myChart3'))
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
			renderTable: function () {
				var params = {
					from_date: this.from_date ? moment(this.from_date).format("YYYY-MM-DD") : moment().format("YYYY-MM-DD"),
					to_date: this.to_date ? moment(this.to_date).add(1, 'day').format("YYYY-MM-DD") : moment().add(1, 'day').format("YYYY-MM-DD"),
				}
				var _this = this;
				API.getReport(params).then((res) => {
					_this.report = res.data

					var colors = ['#5793f3', '#d14a61', '#675bba'];

					var option = {
						title: { text: '战斗场次走势图' },
						color: colors,

						tooltip: {
							trigger: 'none',
							axisPointer: {
								type: 'cross'
							}
						},
						legend: {
							data: ['竞技场', '娱乐场']
						},
						grid: {
							top: 70,
							bottom: 50
						},
						xAxis: [
							{
								type: 'category',
								axisTick: {
									alignWithLabel: true
								},
								axisLine: {
									onZero: false,
									lineStyle: {
										color: colors[1]
									}
								},
								axisPointer: {
									label: {
										formatter: function (params) {
											return '娱乐场数  ' + params.value
												+ (params.seriesData.length ? '：' + params.seriesData[0].data : '');
										}
									}
								},
								data: Object.keys(_this.report.hourlyDataMap.entertain)
							},
							{
								type: 'category',
								axisTick: {
									alignWithLabel: true
								},
								axisLine: {
									onZero: false,
									lineStyle: {
										color: colors[0]
									}
								},
								axisPointer: {
									label: {
										formatter: function (params) {
											return '竞技场数  ' + params.value
												+ (params.seriesData.length ? '：' + params.seriesData[0].data : '');
										}
									}
								},
								data: Object.keys(_this.report.hourlyDataMap.athletic)
							}
						],
						yAxis: [
							{
								type: 'value'
							}
						],
						series: [
							{
								name: '竞技场',
								type: 'line',
								xAxisIndex: 1,
								smooth: true,
								data: Object.values(_this.report.hourlyDataMap.athletic)
							},
							{
								name: '娱乐场',
								type: 'line',
								smooth: true,
								data: Object.values(_this.report.hourlyDataMap.entertain)
							}
						]
					};

					_this.myChart.setOption(option);




					option = {
						title: {
							text: '时段场数比例图',
							subtext: '竞技场, 统计天数:' + _this.report.totalDays + "天, 总场数:" + _this.report.totalAthletic,
							x: 'left'
						},
						tooltip: {
							trigger: 'item',
							formatter: function (p) {
								return p.data.name + " : 总" + p.data.value + "场, 均" + p.data.avg + "场 (" + p.percent + "%)"
							}
						},
						legend: {
							orient: 'vertical',
							right: 10,
							top: 20,
							bottom: 20,
							data: _this.report.legendDataAthletic
						},
						series: [
							{
								name: '时段',
								type: 'pie',
								radius: '80%',
								center: ['50%', '50%'],
								data: _this.report.seriesDataAthletic,
								itemStyle: {
									emphasis: {
										shadowBlur: 10,
										shadowOffsetX: 0,
										shadowColor: 'rgba(0, 0, 0, 0.5)'
									}
								}
							}
						]
					};

					_this.myChart2.setOption(option);



						option = {
						title: {
							text: '时段场数比例图',
							subtext: '娱乐场, 统计天数:' + _this.report.totalDays + "天, 总场数:" + _this.report.totalEntertain,
							x: 'left'
						},
						tooltip: {
							trigger: 'item',
							formatter: function (p) {
								return p.data.name + " : 总" + p.data.value + "场, 均" + p.data.avg + "场 (" + p.percent + "%)"
							}
						},
						legend: {
							orient: 'vertical',
							right: 10,
							top: 20,
							bottom: 20,
							data: _this.report.legendDataEntertain
						},
						series: [
							{
								name: '时段',
								type: 'pie',
								radius: '80%',
								center: ['50%', '50%'],
								data: _this.report.seriesDataEntertain,
								itemStyle: {
									emphasis: {
										shadowBlur: 10,
										shadowOffsetX: 0,
										shadowColor: 'rgba(0, 0, 0, 0.5)'
									}
								}
							}
						]
					};

					_this.myChart3.setOption(option);


				}, (res) => {
					//
				})
			}
		}
	}

</script>

<style scoped>
	#history {
		margin-top: 100px;
	}
</style>