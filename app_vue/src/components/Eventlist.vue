<template>
    <div>
        <navbar></navbar>
        <h3>Liste d'événements</h3>
    </div>
</template>

<script>
import Navbar from './Navbar.vue'
import $ from 'jquery'
    export default {
        data () {
            return {
            }
        },
        created () {
            /* console.log(this.items);
            var date = [];
            $.ajax({
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event?public=1",
                success: function (result) {
                    this.res = result;
                    console.log(this.res);
                    this.res.forEach(element => {
                        date.push({name:element.name});
                    });
                    this.data = date;
                    console.log(this.data);
                },
                async: false
            }); */
        },
        components: { Navbar,},
    }
</script>

<style >

</style>