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
  import "./assets/bootstrap/css/bootstrap.min.css"
  
  import "./assets/Projects-Clean.css"
  import "./assets/Pretty-Search-Form.css"
  import "./assets/styles.css"
  

  //js
  window.jQuery = window.$ = require('jquery');
  require('bootstrap/dist/js/bootstrap.min.js')

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
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
    /*margin-top: 60px;*/
  }
</style>