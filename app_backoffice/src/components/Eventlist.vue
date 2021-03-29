<template>
    <div class="corps">
        <navbar></navbar>
        <h3>Liste d'événements</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th v-bind:class="order === 1 ? 'descending' : 'ascending'" class="clickable" v-on:click="order = order * - 1" scope="col">Créateur</th>
                <th scope="col">Nom</th>
                <th scope="col">Adresse</th>
                <th scope="col">Code Postal</th>
                <th scope="col">Date</th>
            </tr>
            </thead>
            <tbody>
            <tr scope="row" v-for="item in filterPage" :key="item.name">
                <td>{{item.owner}}</td>
                <td>{{item.name}}</td>
                <td>{{item.adress}}</td>
                <td>{{item.postCode}}</td>
                <td>{{item.date}}</td>
                <td><b-icon-trash class="clickable" @click="deleteEvent(item.id)"></b-icon-trash></td>
            </tr>
            </tbody>
        </table>
        <button @click="prevPage" class="btn btn-primary">Page précédente</button> 
        <button @click="nextPage" class="btn btn-primary">Page suivante</button>
    </div>
</template>

<script>
import Navbar from './Navbar.vue'
import $ from 'jquery'
    export default {
        methods: {
            nextPage() {
                if((this.currentPage*this.pageSize) < this.res.length) this.currentPage++;
            },
            prevPage() {
                if(this.currentPage > 1) this.currentPage--;
            },
            deleteEvent(id) {
                axios.post('http://docketu.iutnc.univ-lorraine.fr:11501/api/delete/event/' + id)
                .then(function (response) {
                    console.log(response);
                });
                this.res.forEach(element => {
                    if (element.id == id) {
                        let i = this.res.indexOf(element);
                        this.res.splice(i,1);
                    }
                });
            },
        },
        computed: {
            filterPage() {
                return this.res.filter((row, index) => {
		            let start = (this.currentPage-1)*this.pageSize;
		            let end = this.currentPage*this.pageSize;
		            if(index >= start && index < end) return true;
	            });
            }
        },
        data () {
            return {
                res: [],
                order: -1,
                pageSize:10,
                currentPage:1,
            }
        },
        beforeCreate: function () {
            if (!this.$session.exists()) {
            this.$router.push('/')
            }
        },
        created () {
            var tab = [];
            $.ajax({
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event",
                success: function (result) {
                    tab = result;
                },
                async: false
            });
            this.res = tab;
        },
        components: { Navbar,},
    }
</script>

<style >
.clickable:hover {
    cursor:pointer;
}
.ascending:after {
    content: "\25B2";
    padding-left: 15px;
}
.descending:after {
    content: "\25BC";
    padding-left: 15px;
}
</style>