<template>
  <div class=content>
    <div class="container">
      <ul class="nav nav-tabs">
        <li class="active"><a href="#tab-1" role="tab" data-toggle="tab">{{lang.userRank.pointRank}} </a></li>
        <li><a href="#tab-2" role="tab" data-toggle="tab">{{lang.userRank.expRank}} </a></li>
      </ul>

      <div class="tab-content">

        <div role="tabpanel" class="tab-pane active" id="tab-1">
          <br>
          <p>{{lang.userRank.tableHead2}}</p>
          <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
            <table class="table table-striped table-bordered table-hover example" id="pt_table" :width="width"></table>
          </div>
        </div>

        <div role="tabpanel" class="tab-pane" id="tab-2">
          <br>
          <p>{{lang.userRank.tableHead1}}</p>
          <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
            <table class="table table-striped table-bordered table-hover example" id="exp_table" :width="width"></table>
          </div>
        </div>

        <div class="form-group" style="display:none">
          <button type="submit" id="search" class="form-control btn btn-primary">{{lang.search}}</button>
        </div>

        <Footads></Footads>
      </div>
    </div>
  </div>
</template>

<script>
  import Footads from './Footads'
  import tb_language from './tb_lang.js'
  import API from '../api';
  import { mapGetters } from 'vuex'
  var expTable, ptTable


  export default {

    components: {
      Footads
    },

    created: function () {

      var regex_match = /(nokia|iphone|android|motorola|^mot-|softbank|foma|docomo|kddi|up.browser|up.link|htc|dopod|blazer|netfront|helio|hosin|huawei|novarra|CoolPad|webos|techfaith|palmsource|blackberry|alcatel|amoi|ktouch|nexian|samsung|^sam-|s[cg]h|^lge|ericsson|philips|sagem|wellcom|bunjalloo|maui|symbian|smartphone|midp|wap|phone|windows ce|iemobile|^spice|^bird|^zte-|longcos|pantech|gionee|^sie-|portalmmm|jigs browser|hiptop|^benq|haier|^lct|operas*mobi|opera*mini|320x320|240x320|176x220)/i;
      var u = navigator.userAgent;
      if (null == u) {
        return true;
      }
      var result = regex_match.exec(u);
      if (null == result) {
      } else {
        this.width = "250%"
      }

      var lang = localStorage.getItem('lang') || 'cn';
      this.init(lang)
    },
    data() {
      return {
        width: "100%",
      }
    },

    watch: {
      lang: function (val) {
        console.log('lang change1', val)
        this.init2()
      },
    },

    mounted: function () {
      this.init2();
    },

    computed: {
      ...mapGetters({
        lang: 'getLang',
      }),
    },

    methods: {
      init: function (lang) {

      },
      init2: function () {

        function renderPage() {

          if (ptTable) {
            ptTable.destroy();
          }

          if (expTable) {
            expTable.destroy();
          }

          expTable = renderExpTable();
          ptTable = renderArenaTable();

          API.getUsers({ o: 'pt' }).then((res) => {
            if (ptTable) {
              ptTable.destroy();
            }
            ptTable = renderArenaTable(res.data)
          }, (res) => {
            console.log(res)
          });

          API.getUsers({ o: 'exp' }).then((res) => {
            if (expTable) {
              expTable.destroy();
            }
            expTable = renderExpTable(res.data)
          }, (res) => {
            console.log(res)
          });
        }

        function renderExpTable(tableData) {
          tableData = tableData || [];
          var lang = localStorage.getItem('lang') || 'cn';

          var rank = 1;
          var processData = tableData.map(function (d) {
            return [rank++, d.username, parseInt(d.exp), d.entertain_win, d.entertain_lose];
          });
          var table = $('#exp_table').DataTable({
            data: processData,
            order: [[0, "asc"]],
            "ordering": true,
            columns: [
              { title: tb_language[lang].rank },
              { title: tb_language[lang].name },
              { title: tb_language[lang].exp },
              { title: tb_language[lang].win },
              { title: tb_language[lang].lose },
            ],
            "columnDefs": [
              {
                "render": function (data, type, row) {
                  return "<a href='#/userinfo?username=" + encodeURIComponent(data) + "'>" + data + "</a>";
                },
                "targets": 1
              },
            ],
            "language": lang === 'en' ? tb_language.en : tb_language.cn
          });

          return table;
        }

        function renderArenaTable(tableData) {
          tableData = tableData || [];

          var lang = localStorage.getItem('lang') || 'cn';

          var rank = 1;
          var processData = tableData.map(function (d) {
            let ratio = 0
            if (d.athletic_all > 0) {
              ratio = (d.athletic_win / d.athletic_all * 100).toFixed(2)
            }
            return [rank++, d.username, parseInt(d.pt), d.athletic_win, d.athletic_lose, ratio + "%"];
          });
          var table = $('#pt_table').DataTable({
            data: processData,
            order: [[0, "asc"]],
            "ordering": true,
            columns: [
              { title: tb_language[lang].rank },
              { title: tb_language[lang].name },
              { title: tb_language[lang].pt },
              { title: tb_language[lang].win },
              { title: tb_language[lang].lose },
              { title: tb_language[lang].wl },
            ],
            "columnDefs": [
              {
                "render": function (data, type, row) {
                  return "<a href='#/userinfo?username=" + encodeURIComponent(data) + "'>" + data + "</a>";
                },
                "targets": 1
              },
            ],
            "language": tb_language[lang]
          });

          return table;
        }

        renderPage();

        $("#search").click(function () {
          renderPage();
          return false;
        })
      }
    },
    events: {
      'lang-change': function (lang) {
        this.init(lang)
        $("#search").trigger('click')
      }
    },

  }

</script>