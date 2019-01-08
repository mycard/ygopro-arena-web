<template>
    <div>
        <div class="content">
            <div class="container">
                <div>
                    <h4 class="color-blue"><i class="glyphicon glyphicon-filter"></i> {{lang.qc}}</h4>
                    <div class="well">
                        <form action="" method="get" role="form" class="form-inline form-filter">

                            <div class="form-group" style="margin-right: 10px;">
                                <div class="input-group">
                                    <div class="input-group-addon">{{lang.time}}</div>
                                    <select name="type" class="form-control" id="type" v-on:change="onChange">
                      <option value="day">{{lang.today}}</option>
                      <option value="week">{{lang.week}}</option>
                      <option value="halfmonth">{{lang.half_month}}</option>
                      <option value="month">{{lang.month}}</option>
                      <option value="season">{{lang.season}}</option>
                    </select>
                                </div>
                            </div>

                            <div class="form-group" style="margin-right: 10px;">
                                <div class="input-group">
                                    <div class="input-group-addon">{{lang.source}}</div>
                                    <select name="server" class="form-control" id="server" v-on:change="onChange">
                                        <option value="mycard">MCPro</option>
                                        <option value="233">233</option>
                                        <option value="koishi">Koishi</option>
                                        <option value="koishi_tcg">Koishi_tcg</option>
                                    </select>
                                </div>
                            </div>


                            <div class="form-group" style="margin-right: 10px;">
                                <div class="input-group">
                                    <div class="input-group-addon">{{lang.type}}</div>
                                    <select name="source" class="form-control" id="source" v-on:change="onChange">
                                        <option value="athletic">{{lang.athletic}}</option>
                                        <option value="entertain">{{lang.entertain}}</option>
                                        <option value="custom">{{lang.custom}}</option>
                                        <option value="tag">{{lang.tag}}</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group" style="margin-right: 10px;">
                                <div class="input-group">
                                    <div class="input-group-addon">{{lang.totalDeck}}</div>
                                    <span class="form-control">{{totalDeck}}</span>
                                </div>
                            </div>

                            <div class="form-group" style="display:none">
                                <button type="submit" id="search" class="form-control btn btn-primary">{{lang.search}}</button>
                            </div>

                        </form>
                    </div>

                    <h4 class="color-blue"><i class="glyphicon glyphicon-list-alt"></i> {{lang.table_data}} </h4>



                    <div>
                        <ul class="nav nav-tabs">

                            <li :class="{ active: isActive }" v-if="isActive">
                                <a href="#tab-0" role="tab" data-toggle="tab"><img class="tab-img" :src="img0"></a>
                            </li>
                            <li :class="{ active: !isActive }">
                                <a href="#tab-1" role="tab" data-toggle="tab"><img class="tab-img" :src="img1"></a>
                            </li>
                            <li>
                                <a href="#tab-2" role="tab" data-toggle="tab"><img class="tab-img" :src="img2"></a>
                            </li>
                            <li>
                                <a href="#tab-3" role="tab" data-toggle="tab"><img class="tab-img" :src="img3"></a>
                            </li>
                            <li>
                                <a href="#tab-4" role="tab" data-toggle="tab"><img class="tab-img" :src="img4"></a>
                            </li>
                            <li>
                                <a href="#tab-5" role="tab" data-toggle="tab"><img class="tab-img" :src="img5"></a>
                            </li>
                        </ul>

                        <div class="tab-content">

                            <div role="tabpanel" class="tab-pane" :class="{ active: isActive }" v-if="isActive" id="tab-0">
                                <br>
                                <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
                                    <table id="deck" class="table table-striped table-bordered table-hover example" :width="width"></table>
                                </div>
                            </div>

                            <div role="tabpanel" class="tab-pane" :class="{ active: !isActive }" id="tab-1">
                                <br>
                                <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
                                    <table id="monster" class="table table-striped table-bordered table-hover example" :width="width"></table>
                                </div>
                            </div>

                            <div role="tabpanel" class="tab-pane" id="tab-2">
                                <br>
                                <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
                                    <table id="spell" class="table table-striped table-bordered table-hover example" :width="width"></table>
                                </div>
                            </div>

                            <div role="tabpanel" class="tab-pane" id="tab-3">
                                <br>
                                <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
                                    <table id="trap" class="table table-striped table-bordered table-hover example" :width="width"></table>
                                </div>
                            </div>

                            <div role="tabpanel" class="tab-pane" id="tab-4">
                                <br>
                                <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
                                    <table id="side" class="table table-striped table-bordered table-hover example" :width="width"></table>
                                </div>
                            </div>

                            <div role="tabpanel" class="tab-pane" id="tab-5">
                                <br>
                                <div class="table-responsive" style="width:100%;overflow-x:auto;overflow-y:hidden;">
                                    <table id="ex" class="table table-striped table-bordered table-hover example" :width="width"></table>
                                </div>
                            </div>

                            <div class="form-group" style="display:none">
                                <button type="submit" id="search" class="form-control btn btn-primary">{{lang.search}}</button>
                            </div>

                        </div>
                    </div>

                </div>
               <Footads></Footads>
            </div>
        </div>

  
    </div>
</template>

<script>
  import Footads from './Footads'
    import tb_language from './tb_lang.js'
    import { mapGetters } from 'vuex'

    import API from '../api';

    import img0 from '../assets/img/500x300_deck.jpg'
    // import img1 from '../assets/MonsterWithBorder.jpg'
    import img1 from '../assets/img/500x300_monster.jpg'
    // import img2 from '../assets/SpellWithBorder.jpg'
    import img2 from '../assets/img/500x300_Spell.jpg'
    // import img3 from '../assets/TrapWithBorder.jpg'
    import img3 from '../assets/img/500x300_Trap.jpg'
    // import img4 from '../assets/SideWithBorder.jpg'
    import img4 from '../assets/img/500x300_side.jpg'
    import img5 from '../assets/img/ExtraWithBorder.jpg'


    var dt = require('datatables.net')
    var dt2 = require('datatables.net-bs')
    import "../assets/css/dataTables.bootstrap.min.css"

    var monsterTable;
    var spellTable;
    var trapTable;
    var exTable;
    var sideTable;

    var deckTable;

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
        mounted: function () {
            this.init2();
        },


        data() {
            return {
                isActive: true,
                totalDeck: 0,
                width: "100%",
                img0: img0,
                img1: img1,
                img2: img2,
                img3: img3,
                img4: img4,
                img5: img5,
            }
        },
        computed: {
            ...mapGetters({
                lang: 'getLang',
            }),
        },
        watch: {
            lang: function (val) {
                console.log('lang change1', val)
                this.init2()
            },
        },
        methods: {
            init: function (lang) {
                if (lang === "cn") {
                    this.isActive = true;
                } else {
                    this.isActive = false;
                }
                // this.lang = language[lang]
                this.getCount()
            },
            init2: function () {
                var lang = localStorage.getItem('lang') || 'cn';
                if (lang === "cn") {
                    this.isActive = true;
                } else {
                    this.isActive = false;
                }
                function renderPage() {
                    if (monsterTable) {
                        monsterTable.destroy();
                    }
                    if (spellTable) {
                        spellTable.destroy();
                    }
                    if (trapTable) {
                        trapTable.destroy();
                    }
                    if (exTable) {
                        exTable.destroy();
                    }
                    if (sideTable) {
                        sideTable.destroy();
                    }

                    var server = $("#server").val() || "mycard"
                    var source = $("#source").val() || "athletic"
                    var final_source = server + "-" + source

                    $.get('https://api.mycard.moe/ygopro/analytics/single/type', {
                        type: $("#type").val(),
                        lang: localStorage.getItem('lang') || 'cn',
                        extra: 'name',
                        source: final_source
                    }, function (data) {
                        var monster = data.monster;
                        var spell = data.spell;
                        var trap = data.trap;
                        var side = data.side;
                        var ex = data.ex;

                        monsterTable = renderTable("#monster", monster)
                        spellTable = renderTable("#spell", spell)
                        trapTable = renderTable("#trap", trap)
                        exTable = renderTable("#ex", ex)
                        sideTable = renderTable("#side", side)
                    });

                    //卡组api https://api.mycard.moe/ygopro/analytics/deck/type?type=day&source=mycard-entertain
                    //只显示中文
                    var lang = localStorage.getItem('lang') || 'cn';
                    if (lang === "cn") {

                        if (deckTable) {
                            deckTable.destroy();
                        }

                        $.get('https://api.mycard.moe/ygopro/analytics/deck/type', {
                            type: $("#type").val(),
                            source: final_source
                        }, function (data) {
                            var obj = JSON.parse(data);
                            var rank = 1;
                            var processData = obj.map(function (x) {
                                var tagStr = [];
                                var deckName = x.name;
                                for (var i = 0; i < x.tags.length; i++) {
                                    var tagName = x.tags[i].name;
                                    var short_tagName = tagName.replace(deckName + "-", "");
                                    tagStr.push(short_tagName)
                                }
                                return [rank++, x.name, x.count, tagStr.join(" , ")];
                            });

                            deckTable = $("#deck").DataTable({
                                data: processData,
                                order: [[2, "desc"]],
                                "ordering": true,
                                columns: [
                                    { title: "Rank" },
                                    { title: "Deck" },
                                    { title: "Count" },
                                    { title: "Top Tags" },
                                ],
                                "columnDefs": [
                                    {
                                        "render": function (data, type, row) {
                                            // return "<span title='" + data + "'>" + data + "</span>";
                                            // return "<img src='imag.png' />";
                                            return "<a href='?name=" + data + "#/deck'>" + data + "</a>";
                                        },
                                        "targets": 1
                                    },
                                ],
                                "language": tb_language[lang]
                            });
                        });
                    }

                }

                function renderTable(tableID, tableData) {
                    tableData = tableData || [];

                    var lang = localStorage.getItem('lang') || 'cn';
                    var langIndex = (lang === 'en' ? 'en-US' : 'zh-CN');

                    var rank = 1;
                    var processData = tableData.map(function (d) {
                        return [rank++, d.name[langIndex], d.frequency, d.putone, d.puttwo, d.putthree, d.id];
                    });

                    var table = $(tableID).DataTable({
                        data: processData,
                        order: [[2, "desc"]],
                        "ordering": true,
                        columns: [
                            { title: tb_language[lang].rank },
                            { title: tb_language[lang].cardName },
                            { title: tb_language[lang].used },
                            { title: tb_language[lang].put1 },
                            { title: tb_language[lang].put2 },
                            { title: tb_language[lang].put3 },
                        ],
                        "columnDefs": [
                            {
                                "render": function (data, type, row) {
                                    // return "<span title='" + data + "'>" + data + "</span>";
                                    // return "<a href='?id=" + row[6] + "#/cardinfo'>" + data + "</a>";
                                    return "<a href='https://www.ourocg.cn/search/" + row[6] + "'>" + data + "</a>";
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
            },
            onChange: function () {
                $("#search").trigger('click')
                this.getCount()
            },
            getCount: function () {

                var server = $("#server").val() || "mycard"
                var source = $("#source").val() || "athletic"

                var opt = {
                    type: $("#type").val() || "day",
                    source: server + "-" + source
                }
                var self = this
                API.getCount(opt).then((res) => {
                    if (isNaN(res.data)) {
                        self.totalDeck = 0
                    } else {
                        self.totalDeck = res.data
                    }
                });
            }
        },
        events: {
            'lang-change': function (lang) {
                this.init(lang)
                this.onChange()
            }
        },
    }

</script>


<style scoped>
    .tab-img {
        height: 72px;
        width: 120px;
    }
</style>