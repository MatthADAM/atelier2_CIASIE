<template>
    <div class="mapbox">
        <img class="icon" src="../assets/meeting.png">
        <p>Bienvenue !</p>
        <l-map
            :center="center"
            :zoom="zoom"
            class="map"
            ref="map"
            style="width:900px;height:400px;"
            v-if="coord.length == markers.length">
            <l-tile-layer :url="osmurl"></l-tile-layer>
            <l-marker v-for="(item,index) in markers" :key="item.name" :lat-lng="coord[index]">
            </l-marker>
        </l-map>
        <br/>
        <p>{{coord}}</p>
        <router-link to="/connexion" tag="button" class="btn btn-outline-primary"> Se connecter </router-link>
        <router-link to="/inscription" tag="button" class="btn btn-outline-info"> S'inscrire </router-link>
    </div>
</template>

<script>

import { LMap, LTileLayer, LMarker, LIcon} from 'vue2-leaflet';
import 'leaflet/dist/leaflet.css';
import axios from 'axios';

    export default {
        methods: {
        },
        created () {
            this.markers.forEach(element => {
                axios
                .get("https://api-adresse.data.gouv.fr/search/?q=" + element.adress.replace(/ /g, "+") + "&postcode=" + element.postalCode)
                .then(response => {
                    this.lat = response.data.features[0].geometry.coordinates[1];
                    this.lon = response.data.features[0].geometry.coordinates[0];
                    this.coord.push([this.lat,this.lon]);
                    console.log(this.coord);
                });    
            });
            
        },
        data () {
            return {
                center: [48.688418, 6.1825940],
                zoom: 12,
                osmurl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                markers: [
                    {id:1,name:"Test1", adress: "37 Rue du général frère", postalCode:"54500"},
                    {id:2,name:"Test2", adress: "2Ter Boulevard Charlemagne", postalCode:"54000"},
                ],
                lat:0,
                lon:0,
                coord:[],
            }
        },
        components: {LMap, LTileLayer, LMarker, LIcon},   
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