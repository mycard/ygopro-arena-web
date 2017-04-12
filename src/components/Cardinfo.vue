<template>
	<div class="content">
		<div class="container">

			<!--<div class="fck">
				<form id="search-form" class="search-form" @submit.prevent="onSubmit">
					<div class="form-group" v-bind:class="{ 'has-error': hasError}">
						<label class="control-label" for="input1" v-if="hasError">{{lang.battle.notfound}}</label>
						<div class="input-group">
							<div class="input-group-addon"><span><i class="glyphicon glyphicon-search"></i></span></div>
							<input class="form-control" type="text" id="input1" v-model="searchText" placeholder="{{lang.battle.ph2}}">
							<div class="input-group-btn">
								<button class="btn btn-default" type="submit">{{lang.battle.search}}</button>
							</div>
						</div>
					</div>
				</form>
			</div>-->

			<div class="row">
				<div class="col-md-5" id="profile">
					<div class="thumbnail">
						<img v-bind:src="imgSrc" class="avatar">
						<div class="caption">
							<h3> <strong>{{username}}</strong></h3>
							<p class="text-nowrap text-muted c-desc">
								<pre>{{card_info.desc}} </pre>
							</p>
							<!--<p class="text-nowrap text-muted c-desc">{{card_info.desc}}</p>-->
						</div>
					</div>
				</div>

				<div class="col-md-7">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">{{lang.cardinfo.cardinfo}} </h3>
						</div>
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover">
								<tbody>
									<tr>
										<td>{{lang.cardinfo.name}} </td>
										<td>{{card_info.name}} </td>
									</tr>
									<tr>
										<td>{{lang.cardinfo.type}} </td>
										<td>{{card_info.type}} </td>
									</tr>
									<tr>
										<td>{{lang.cardinfo.race}} </td>
										<td>{{card_info.race}} </td>
									</tr>
									<tr>
										<td>{{lang.cardinfo.attribute}} </td>
										<td>{{card_info.attribute}} </td>
									</tr>
									<tr>
										<td>{{lang.cardinfo.level}} </td>
										<td>{{card_info.level}} </td>
									</tr>
									<tr>
										<td>{{lang.cardinfo.attack}} </td>
										<td>{{card_info.atk}} </td>
									</tr>
									<tr>
										<td>{{lang.cardinfo.defend}} </td>
										<td>{{card_info.def}} </td>
									</tr>
								</tbody>

							</table>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>

</template>

<script>
	import querystring from 'querystring';
	import language from './lang';

	import img1 from '../assets/images1.jpeg'
	import img2 from '../assets/images2.jpeg'
	import img3 from '../assets/images3.jpeg'
	import API from '../api'
	import { mapGetters } from 'vuex'

	export default {
		data() {
			return {
				searchText: "",
				hasError: false,
				username: "",
				avatar_url: "",
				imgSrc: "",
				card_info: {
					name: "",
					level: 0,
					desc: "",
					atk: 0,
					def: 0,
					type: "",
					attribute: "",
					race: ""
				},
			}
		},
		created: function () {
			var lang = localStorage.getItem('lang')
			this.initLang(lang)
		},
		events: {
			'lang-change': function (lang) {
				this.initLang(lang)
			}
		},

		watch: {
			lang: function (val) {
				this.initLang()
			},
		},

		mounted: function () {
			this.initLang();
		},

		computed: {
      		...mapGetters({
				lang: 'getLang',
			}),
		},

		methods: {
			onSubmit: function () {
				this.searchById(this.searchText)
			},

			initLang: function () {
				var lang = localStorage.getItem('lang') || 'cn';
				this.local = lang
				var id = querystring.parse(location.search.slice(1)).id
				this.searchById(id)
			},
			searchById: function (id) {
				this.imgSrc = `https://github.com/mycard/ygopro-images/blob/master/pics/${id}.jpg?raw=true`

				API.getCardInfo({ id: id, lang: this.local }).then((res) => {
					this.hasError = false
					this.card_info = res.data
				}, (res) => {
					this.hasError = true
				});
			}
		},
	}

</script>

<style scoped>
	.fck {
		margin-bottom: 20px;
		margin-top: -30px;
	}
	
	.avatar {
		height: 380px;
		margin-top: 13px;
	}
	
	.c-desc {
		font-size: 20px;
	}
	
	pre {
		white-space: pre-wrap;
		word-wrap: break-word;
	}
</style>