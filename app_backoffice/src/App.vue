<template>
  <div id="app">
    <router-view></router-view>

    <div class="foot">&copy; {{date}} - Matthieu ADAM, Romain BERNARD, Hervé GROSJEAN, Valentin GARDEL</div>
  </div>
</template>

<script>
export default {
  name: 'app',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App',
      date : new Date().getFullYear(),
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  background-color: gold;
}

.form {
  margin-top: 60px;
}

.corps {
  margin-bottom: 10px;
}

h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}

.form-connect {
  width: 50%;
  height: auto;
  margin: 0 auto;
}

html {
  background-color: gold
}
</style>
