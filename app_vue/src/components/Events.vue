<template>
    <div class="mapbox">
        <navigationBar></navigationBar>
        <p>Bienvenue {{this.name}} !</p>
        <div v-if="loading">
            <spinner></spinner>
        </div>
        <div v-else>
            <l-map
                :center="center"
                :zoom="zoom"
                class="map"
                ref="map"
                style="width:900px;height:400px;"
                v-if="coord.length == markers.length">
                <l-tile-layer :url="osmurl"></l-tile-layer>
                <l-marker v-for="(item,index) in markers" :key="item.name" :lat-lng="coord[index]">
                    <l-popup :content="item.name + ' - ' + item.adress"></l-popup>
                </l-marker>
            </l-map>
            <l-map :center="center"
                :zoom="zoom"
                class="map"
                ref="map"
                style="width:900px;height:400px;"
                v-else>
                <l-tile-layer :url="osmurl"></l-tile-layer>
            </l-map>
        </div>
    </div>
</template>

<script>

import { LMap, LTileLayer, LMarker, LIcon, LPopup} from 'vue2-leaflet';
import 'leaflet/dist/leaflet.css';
import axios from 'axios';
import spinner from 'vue-spinner/src/SyncLoader';
import navigationBar from './Navbar.vue';
import {urlApi} from '../variables/variables.js';

    export default {
        methods: {
        },
        created () {
            this.markers.forEach(element => {
                if (element.public == true) {
                    axios
                    .get("https://api-adresse.data.gouv.fr/search/?q=" + element.adress.replace(/ /g, "+") + "&postcode=" + element.postCode)
                    .then(response => {
                        this.lat = response.data.features[0].geometry.coordinates[1];
                        this.lon = response.data.features[0].geometry.coordinates[0];
                        this.coord.push([this.lat,this.lon]);
                        this.eventPublic.push(element);
                        console.log(this.coord);
                    });    
                } else {
                    console.log("non");
                }
            });
            this.loading = false;
        },
        data () {
            return {
                center: [48.688418, 6.1825940],
                zoom: 12,
                osmurl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                markers: [
                    {id:1,name:"Test1", adress: "37 Rue du général frère", postCode:"54500",public:true,date:Date.now(),owner:{nom:"ADAM"}},
                    {id:2,name:"Test2", adress: "2Ter Boulevard Charlemagne", postCode:"54000",public:true,date:Date.now(),owner:{nom:"ADAM"}},
                ],
                lat:0,
                lon:0,
                coord:[],
                eventPublic: [],
                loading: true,
                name: localStorage.getItem('name'),
            }
        },
        components: {LMap, LTileLayer, LMarker, LIcon, LPopup, spinner, navigationBar},   
    }
</script>

<style>
*{
    background-color: inherit;
}

.icon {
    height:10rem;
    width:auto;
}
.mapbox {
    margin: auto;
    width: fit-content;
    height: fit-content;
}
</style>