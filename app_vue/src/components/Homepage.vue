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
            <!-- <l-marker v-for="mark in markers" :key="mark.id" :lat-lng="mark.coordinates"></l-marker> -->
        </l-map>
        <br/>
        <router-link to="/connexion" tag="button" class="btn btn-outline-primary"> Se connecter </router-link>
        <router-link to="/inscription" tag="button" class="btn btn-outline-info"> S'inscrire </router-link>
    </div>
</template>

<script>

import { LMap, LTileLayer, LMarker } from 'vue2-leaflet';
import 'leaflet/dist/leaflet.css';

    export default {
        data () {
            return {
                center: [48.688418, 6.1825940],
                zoom: 12,
                osmurl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                markers: [
                    {id:1,coordinates: [48.693552, 6.183264]},
                    {id:2,coordinates: [48.688080, 6.180562]},
                ],
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