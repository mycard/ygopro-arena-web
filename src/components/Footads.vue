<template>
  <div class="other">
    <footer  @click="adClick">
      <div class="row" v-bind:style="{ backgroundImage: 'url(' + adObj.src + ')' }">
        <div class="col-md-4 col-sm-6 footer-navigation">
          <h3><a href="#">{{ adObj.name }} </a></h3>
          <p class="links"><a href="#"> {{ adObj.desctext }} </a></p>
          <!--<p class="company-name">mycard © 2016 </p>-->
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
  import img from "../assets/img/image3.png"
  import API from '../api'

  export default {
    data() {
      return {
        isMobile: false,
        msg: 'other!',
        img: img,
        adObj: {},
      }
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
    mounted: function () {
      var _this = this

      if (this.isMobile) {
        this.width = "100%"
      }

      API.getAd({ type: 2 }).then((res) => {
        if (res.data.data && res.data.data !== "null") {
          _this.adObj = res.data.data
          if (_this.isMobile) {
            _this.adObj.src = _this.adObj.imgm_url
          } else {
            _this.adObj.src = _this.adObj.imgp_url
          }
          _this.adImpl()
        }
      }, (res) => {
        console.log(res)
      });

    },
    methods: {
      gogo: function (url) {
        // window.open(url)
        window.location.href = url
      },
      adClick: function () {
        API.adClick({ id: this.adObj.id }).then((res) => {

        }, (res) => {
          console.log(res)
        });

        window.open(this.adObj.click_ref, "_blank");
      },
      adImpl: function () {
        API.adImpl({ id: this.adObj.id }).then((res) => {

        }, (res) => {
          console.log(res)
        });
      }
    },

  }

</script>