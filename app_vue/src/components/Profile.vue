<template>
    <div>
        <navbar></navbar>
    </div>
</template>

<script>
import Navbar from './Navbar.vue'
    export default {
        components: { Navbar },
        beforeCreate: function () {
            if (!this.$session.exists()) {
            this.$router.push('/')
            }
        },
    }
</script>

<style >

</style>