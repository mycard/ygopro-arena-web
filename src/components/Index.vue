<template>
  <div class="hello">



    <div id="promo" v-if="!user.isLogin" v-bind:style="{ backgroundImage: 'url(' + image + ')' }">
      <div class="jumbotron">
        <h1>MyCard </h1>
        <p>{{lang.index.p1}}</p>
        <p><a class="text-uppercase btn btn-info btn-lg" href="https://mycard.moe">Start Now!</a></p>
        <!--<p><a class="text-uppercase btn btn-info btn-lg" href="#/download">Start Now!</a></p>-->
      </div>
    </div>

    <div id="promo2" v-if="adObj.id" v-bind:style="{ backgroundImage: 'url(' + adObj.src + ')' }">
      <div class="jumbotron">
        <h3>{{adObj.name}} </h3>
        <p>{{adObj.desctext}}</p>
        <p><a class="text-uppercase btn btn-info btn-lg" @click="adClick">去看看!</a></p>
        <!--<p><a class="text-uppercase btn btn-info btn-lg" href="#/download">Start Now!</a></p>-->
      </div>
      <div style="float:right;position:relative; background-color: #d3dce6; padding: 4px; margin-right: -38px; margin-top: 10px;">广告</div>
    </div>



    <div class="projects-clean" v-bind:class="{ 'fix-top': user.isLogin }">
      <div class="container" id="project">
        <div class="intro">
          <h2 class="text-center">{{lang.index.p2}} </h2>
          <p class="text-center">{{lang.index.p3}} </p>
        </div>
        <div class="row projects">
          <div @click="gogo('#/ranking')" class="col-lg-4 col-sm-6 item" v-bind:class="{ 'fix-width': !isMobile , 'fix-width-m': isMobile }"><img class="img-responsive" src="../assets/img/image6.png">
            <h3 class="name">
              <span style="text-decoration: underline;">{{lang.index.h1}}</span>
            </h3>
            <p class="description">{{lang.index.p4}}</p>
          </div>
          <div @click="gogo('#/cards')" class="col-lg-4 col-sm-6 item" v-bind:class="{ 'fix-width': !isMobile , 'fix-width-m': isMobile}"><img class="img-responsive" src="../assets/img/image4.png">
            <h3 class="name">
              <span style="text-decoration: underline;">{{lang.index.h3}}</span>
            </h3>
            <p class="description">{{lang.index.p6}}</p>
          </div>
          <div @click="gogo('#/userinfo')" class="col-lg-4 col-sm-6 item" v-bind:class="{ 'fix-width': !isMobile , 'fix-width-m': isMobile }"><img class="img-responsive" src="../assets/img/image5.png">
            <h3 class="name">
              <span style="text-decoration: underline;">{{lang.index.h2}}</span>
            </h3>
            <p class="description">{{lang.index.p5}}</p>
          </div>
          <div @click="gogo('https://rep.ygobbs.com')" class="col-lg-4 col-sm-6 item" v-bind:class="{ 'fix-width': !isMobile , 'fix-width-m': isMobile}"><img class="img-responsive" src="../assets/img/image3.png">
            <h3 class="name">
              <span style="text-decoration: underline;">{{lang.index.h4}}</span>
            </h3>
            <p class="description">{{lang.index.p7}}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import querystring from 'querystring';
  import image from '../assets/img/banner.jpg'
  import image3 from '../assets/img/image3.png'
  import { mapGetters } from 'vuex'
  import API from '../api'

  export default {
    data() {
      return {
        isMobile: false,
        image: image,
        image3: image3,
        adObj:{}
      }
    },

    computed: {
      ...mapGetters({
        lang: 'getLang',
        user: 'getUser'
      }),
    },

    mounted: function () {
      var _this = this
      API.getAd({}).then((res) => {
        if (res.data.data && res.data.data !== "null") {
          _this.adObj = res.data.data
          if (_this.isMobile) {
            _this.adObj.src = _this.adObj.imgm_url
          } else {
            _this.adObj.src = _this.adObj.imgp_url
          }

        }
      }, (res) => {
        console.log(res)
      });

    },

    created: function () {
      var clientWidth = document.body.clientWidth;
      if (clientWidth < 753) {
        this.isMobile = true
      }

      var self = this;
      window.onresize = function () {
        var clientWidth = document.body.clientWidth;
        if (clientWidth < 753) {
          self.isMobile = true;
        } else {
          self.isMobile = false;
        }
      }
    },
    methods: {
      gogo: function (url) {
        // window.open(url)
        window.location.href = url
      },
      adClick: function(){
        API.adClick({ id: this.adObj.id }).then((res) => {

        }, (res) => {
          console.log(res)
        });

        window.open(this.adObj.click_ref, "_blank");
      },
      adImpl: function(){
        API.adImpl({ id: this.adObj.id }).then((res) => {

        }, (res) => {
          console.log(res)
        });
      }
    },
  }

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .item {
    cursor: pointer;
    max-height: 160px;
  }
  
  .projects-clean {
    color: #313437;
    background-color: #ffffff;
  }
  
  .fix-width {
    width: 50%;
    min-height: 435px;
  }
  
  .fix-width-m {
    min-height: 385px;
  }
  
  #promo {
    text-align: center;
    padding: 40px;
    background-repeat: no-repeat;
    background-size: cover;
    margin-top: 50px;
  }
  
  #promo2 {
    text-align: center;
    padding: 40px;
    background-repeat: no-repeat;
    background-size: cover;
    margin-top: 50px;
  }
  
  .el-carousel__item h3 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 200px;
    margin: 0;
  }
  
  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }
  
  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
</style>