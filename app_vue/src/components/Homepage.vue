<template>
    <div class="mapHome">
        <img class="icon" src="../assets/meeting.png">
        <p>Bienvenue !</p>
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
                    <l-icon icon-url="https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Google_Maps_icon_%282020%29.svg/714px-Google_Maps_icon_%282020%29.svg.png"/>
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
            <br/>
            <router-link to="/connexion">
                <button class="btn btn-outline-primary" role="button">Connexion</button>
            </router-link>
            <router-link to="/inscription">
                <button class="btn btn-outline-info" role="button">Inscription</button>
            </router-link>
        </div>
    </div>
</template>

<script>

import { LMap, LTileLayer, LMarker, LIcon, LPopup} from 'vue2-leaflet';
import 'leaflet/dist/leaflet.css';
import spinner from 'vue-spinner/src/SyncLoader';
import $ from 'jquery'

    export default {
        methods: {
        },
        created () {
            var eventPublic;
            var lt;
            var lng;
            var coo = [];

            $.ajax({
                url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/event?public=1",
                success: function (result) {
                    eventPublic = result;
                },
                async: false
            });
            this.markers = eventPublic;

            this.markers.forEach(element => {
                    $.ajax({
                        url: "https://api-adresse.data.gouv.fr/search/?q=" + element.adress.replace(/ /g, "+") + "&postcode=" + element.postCode,
                        success: function (result) {
                            lt = result.features[0].geometry.coordinates[1];
                            lng = result.features[0].geometry.coordinates[0];
                            coo.push([lt,lng]);
                        },
                        async: false
                    });
            });
            this.coord = coo;
            this.loading = false;
        },
        data () {
            return {
                center: [48.688418, 6.1825940],
                zoom: 12,
                osmurl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                markers: [],
                coord:[],
                loading: true,
            }
        },
        components: {LMap, LTileLayer, LMarker, LIcon, LPopup, spinner},   
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
.mapHome {
    margin: auto;
    margin-bottom: 10px;
    width: fit-content;
    height: fit-content;
}
</style>