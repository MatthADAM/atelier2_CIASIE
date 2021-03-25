<template>
    <div class="corps">
        <navbar></navbar>
        <h3>Profile</h3>
        
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