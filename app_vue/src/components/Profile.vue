<template>
    <div>

    </div>
</template>

<script>
    export default {
        beforeCreate: function () {
            if (!this.$session.exists()) {
            this.$router.push('/')
            }
        },
    }
</script>

<style >

</style>