<template>
    <div class="mapbox">
        <img class="icon" src="../assets/meeting.png">
        <p>Bienvenue !</p>
        <l-map
            :center="center"
            :zoom="zoom"
            class="map"
            ref="map"
            style="width:900px;height:400px;">
            <l-tile-layer :url="osmurl"></l-tile-layer>
            <l-marker :lat-lng="coord" v-if="coord.length > 0"></l-marker>
        </l-map>
        <br/>
        <p>{{coord}}</p>
        <router-link to="/connexion" tag="button" class="btn btn-outline-primary"> Se connecter </router-link>
        <router-link to="/inscription" tag="button" class="btn btn-outline-info"> S'inscrire </router-link>
    </div>
</template>

<script>

import { LMap, LTileLayer, LMarker } from 'vue2-leaflet';
import 'leaflet/dist/leaflet.css';
import axios from 'axios';

    export default {
        methods: {
        },
        created () {
            axios
                .get("https://api-adresse.data.gouv.fr/search/?q=" + this.test.adress.replace(/ /g, "+") + "&postcode=" + this.test.postalCode)
                .then(response => {
                    this.lat = response.data.features[0].geometry.coordinates[1];
                    this.lon = response.data.features[0].geometry.coordinates[0];
                    this.coord = [this.lat,this.lon];
                    console.log(this.coord);
                    console.log(this.gne);
                });
        },
        data () {
            return {
                center: [48.688418, 6.1825940],
                zoom: 12,
                osmurl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                markers: [
                    {id:1,name:"Test1", adress: "37 Rue du général frère", postalCode:"54500"},
                ],
                lat:0,
                lon:0,
                coord:[],
                test : {id:1,name:"Test1", adress: "37 Rue du général frère", postalCode:"54500"},
                gne: [48.660233, 6.170445],
            }
        },
        components: {LMap, LTileLayer, LMarker},   
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