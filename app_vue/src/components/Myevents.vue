<template>
    <div class="corps">
        <navbar></navbar>
        <h3>Mes événements</h3>
        <table class="table table-striped" id="myEventsTable">
            <thead>
            <tr>
                <th scope="col">Créateur</th>
                <th scope="col">Nom</th>
                <th scope="col">Adresse</th>
                <th scope="col">Code Postal</th>
                <th scope="col">Date</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <tr scope="row" v-for="(item,index) in filterOwner" :key="index">
                <td>{{item.owner}}</td>
                <td>{{item.name}}</td>
                <td>{{item.adress}}</td>
                <td>{{item.postCode}}</td>
                <td>{{item.date}}</td>
                <td><b-icon-trash class="clickable" @click="deleteEvent(item.id)"></b-icon-trash></td>
            </tr>
            </tbody>
        </table>
        <button @click="prevPage" class="btn btn-primary">Previous page</button> 
        <button @click="nextPage" class="btn btn-primary">Next page</button>
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
            sqlToJsDate(sqlDate){
                //sqlDate in SQL DATETIME format ("yyyy-mm-dd hh:mm:ss.ms")
                var sqlDateArr1 = sqlDate.split("-");
                //format of sqlDateArr1[] = ['yyyy','mm','dd hh:mm:ms']
                var sYear = sqlDateArr1[0];
                var sMonth = (Number(sqlDateArr1[1]) - 1).toString();
                var sqlDateArr2 = sqlDateArr1[2].split(" ");
                //format of sqlDateArr2[] = ['dd', 'hh:mm:ss.ms']
                var sDay = sqlDateArr2[0];
                var sqlDateArr3 = sqlDateArr2[1].split(":");
                //format of sqlDateArr3[] = ['hh','mm','ss.ms']
                var sHour = sqlDateArr3[0];
                var sMinute = sqlDateArr3[1];
                var sqlDateArr4 = sqlDateArr3[2].split(".");
                //format of sqlDateArr4[] = ['ss','ms']
                var sSecond = sqlDateArr4[0];
                var sMillisecond = sqlDateArr4[1];
                
                return new Date(sYear,sMonth,sDay,sHour,sMinute,sSecond,sMillisecond);
            },
        },
        computed: {
            filterOwner() {
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
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event/owner/" + this.$session.get("log"),
                success: function (result) {
                    result.forEach(element => {
                        tab.push(element);
                    });
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