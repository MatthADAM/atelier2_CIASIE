<template>
    <div>
        <navbar></navbar>
        <p>Bienvenue {{this.$session.get("name")}} !</p>
        <div class="mapbox">
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
            </div>
        </div>
    </div>
</template>

<script>

import { LMap, LTileLayer, LMarker, LIcon, LPopup} from 'vue2-leaflet';
import 'leaflet/dist/leaflet.css';
import spinner from 'vue-spinner/src/SyncLoader';
import Navbar from './Navbar.vue';
import $ from 'jquery'

    export default {
        beforeCreate: function () {
            if (!this.$session.exists()) {
            this.$router.push('/')
            }
        },
        methods: {
        },
        data () {
            return {
                center: [48.688418, 6.1825940],
                zoom: 12,
                osmurl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                markers: [],
                coord:[],
                eventPublic: [],
                loading: true,
            }
        },
        created () {
            var eventPublic;
            var eventPersos;
            var lt;
            var lng;
            var coo = [];

            $.ajax({
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event?public=1",
                success: function (result) {
                    eventPublic = result;
                },
                async: false
            });
            this.markers = eventPublic;
            $.ajax({
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event/owner/" + this.$session.get("log"),
                success: function (result) {
                    eventPersos = result;
                },
                async: false
            });
            eventPersos.forEach(element => {
                this.markers.push(element);
            });
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
        components: {LMap, LTileLayer, LMarker, LIcon, LPopup, spinner, Navbar},   
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
    width: 900px;
    height: 400px;
}
</style>