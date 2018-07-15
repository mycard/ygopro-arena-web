<template>
	<div class="content">
		<div class="container">

			<div class="fck">
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
			</div>

			<div class="row">
				<div class="col-md-3" id="profile">
					<div class="thumbnail">
						<img v-bind:src="avatar_url" style="height:200px;margin-top:13px;">
						<div class="caption">
							<h3> <i class="glyphicon glyphicon-user"></i> <strong>{{username}}</strong></h3>
							<!--<p class="text-nowrap text-muted" style="font-size:20px;">有妞不泡，大逆不道;遇妞则泡，替天行道。 </p>-->
							<p class="text-muted" style="font-size:20px;">今日首胜: {{activity.today}}/1 </p>
							<p class="text-muted" v-if="showActivity" style="font-size:20px;">{{activity.name}}首胜: {{activity.total}}/{{activity.max}} </p>
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
						<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>						{{lang.tagInfo}}
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

	import img1 from '../assets/img/images1.jpeg'
	import img2 from '../assets/img/images2.jpeg'
	import img3 from '../assets/img/images3.jpeg'
	import API from '../api'

	import tb_language from './tb_lang.js'
	import { mapGetters } from 'vuex'

	import moment from 'moment'

	var rankTable;
	var rankTable2;

	export default {
		data() {
			return {
				activity: {
					today: 0,
					name: '新年充电活动',
					max: '15'
				},
				showActivity: false,
				searchText: "",
				hasError: false,
				username: "",
				avatar_url: "",
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

		watch: {
			lang: function (val) {
				this.init()
			},
		},

		mounted: function () {
			var _this = this
			$("#search").click(function () {
				_this.renderPage();
			})
			this.init()
			window.onhashchange = this.init;
		},

		computed: {
      		...mapGetters({
				lang: 'getLang',
			}),
		},

		methods: {

			onSubmit: function () {
				this.searchByUsername(this.searchText)
			},

			init: function () {
				var username = querystring.parse(location.hash.slice(11)).username
				this.searchText = username;
				this.searchByUsername(username)
			},

			renderPage: function () {
				if (rankTable) {
					rankTable.destroy();
				}

				if (rankTable2) {
					rankTable2.destroy();
				}

				var username = this.searchText
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
					if (_this.activity.name && _this.activity.name.trim().length > 0) {
						_this.showActivity = true;
					}
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
									return "<a href='#/userinfo?username=" + encodeURIComponent(data) + "'><span class='label label-danger'>" + data + "</span></a>  " + append;
								}

								if (userscorea > userscoreb) {
									return "<a href='#/userinfo?username=" + encodeURIComponent(data) + "'><span class='label label-success'>" + data + "</span></a> " + append;
								}

								return "<a href='#/userinfo?username=" + encodeURIComponent(data) + "'><span class='label label-info'>" + data + "</span></a> " + append;
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
									return "<a href='#/userinfo?username=" + encodeURIComponent(data) + "'><span class='label label-danger'>" + data + "</span></a> " + append;
								}

								if (userscorea < userscoreb) {
									return "<a href='#/userinfo?username=" + encodeURIComponent(data) + "'><span class='label label-success'>" + data + "</span></a> " + append;
								}

								return "<a href='#/userinfo?username=" + encodeURIComponent(data) + "'><span class='label label-info'>" + data + "</span></a> " + append;
							},
							"targets": 1
						},
					],
					"language": lang === 'en' ? tb_language.en : tb_language.cn
				});

				return table;
			},

			searchByUsername: function (username) {
				// 0 1 2
				var rand = Math.floor(Math.random() * 3);
				if (rand === 0) {
					this.avatar_url = img1;
				}
				if (rand === 1) {
					this.avatar_url = img2;
				}
				if (rand === 2) {
					this.avatar_url = img3;
				}
				if (!username) return

				var _this = this;
				API.getAvatar({ username: username }).then((res) => {
					_this.avatar_url = res.data
				}, (res) => {
					_this.avatar_url = "https://cdn01.moecube.com/accounts/default_avatar.jpg"
				});

				API.getUserInfo({ username: username }).then((res) => {
					this.hasError = false
					this.user_info = res.data
					this.username = username
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