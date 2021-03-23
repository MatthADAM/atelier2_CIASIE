<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark rounded">
        <a class="navbar-brand" href="#">Menu</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <router-link to="/events">
                    <a class="nav-item nav-link" role="a">Map</a>
                </router-link>
                <router-link to="/list">
                    <a class="nav-item nav-link" role="a">Event list</a>
                </router-link>
                <router-link to="/myevents">
                    <a class="nav-item nav-link" role="a">My Events</a>
                </router-link>
            </div>
        </div>
    </nav>
</template>

<script>
export default {

}
</script>

<style>

</style>