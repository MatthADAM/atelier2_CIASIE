<template>
    <div class="corps">
        <navbar></navbar>
        <h3>Liste des utilisateurs</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">Adresse mail</th>
                <th scope="col">Nom</th>
            </tr>
            </thead>
            <tbody>
            <tr scope="row" v-for="item in filterPage" :key="item.login">
                <td>{{item.login}}</td>
                <td>{{item.Name}}</td>
                <td><b-icon-trash class="clickable" @click="deleteUser(item.login)"></b-icon-trash></td>
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
import axios from 'axios'
    export default {
        methods: {
            nextPage() {
                if((this.currentPage*this.pageSize) < this.res.length) this.currentPage++;
            },
            prevPage() {
                if(this.currentPage > 1) this.currentPage--;
            },
            deleteUser(log) {
                axios.post('http://docketu.iutnc.univ-lorraine.fr:11501/api/delete/user/' + log)
                .then(function (response) {
                    console.log(response);
                });
                this.res.forEach(element => {
                    if (element.login == log) {
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
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/user",
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