<template>

  <div id="app">
    <page-header></page-header>
    <router-view></router-view>
    <page-footer></page-footer>
  </div>

</template>

<script>
  import PageHeader from './components/PageHeader'
  import PageFooter from './components/PageFooter'

  //css
  // import "./assets/bootstrap/css/bootstrap.min.css"

  import "./assets/css/Projects-Clean.css"
  import "./assets/css/Pretty-Search-Form.css"
  // import "./assets/css/styles.css"
  import "./assets/css/font-awesome.min.css"
  import "./assets/fonts/material-icons.css"

  //js
  window.jQuery = window.$ = require('jquery');
  require('./assets/bootstrap/js/bootstrap.min.js')

  export default {
    name: 'app',
    components: {
      PageHeader,
      PageFooter
    }
  }

</script>

<style scoped>
  #app {
    /*font-family: 'Avenir', Helvetica, Arial, sans-serif;*/
    /*-webkit-font-smoothing: antialiased;*/
    /*-moz-osx-font-smoothing: grayscale;*/
    /*color: #2c3e50;*/
    /*margin-top: 60px;*/
  }
</style>