<template>
  <div id="app">
    <!-- Dev Navigation Overlay (only visible in development) -->
    <!-- <div class="dev-nav" v-if="isDev">
      <router-link
        v-for="route in devRoutes"
        :key="route.name"
        :to="route.path"
        class="dev-nav-link"
        active-class="active"
        exact-active-class="active"
      >
        {{ formatRouteName(route.name) }}
      </router-link>
    </div> -->

    <!-- Main Router View -->
    <router-view />
  </div>
</template>

<script>
export default {
  name: "App",
  data() {
    return {
      isDev: import.meta.env.DEV,
      devRoutes: [
        { name: "Login", path: "/login" },
        { name: "Signup", path: "/signup" },
        { name: "Home", path: "/" },
        { name: "ExploreAllPujas", path: "/pujas" },
        { name: "PujaDetails", path: "/pujas/1" },
        { name: "SelectPriest", path: "/pujas/1/select-priest" },
        { name: "CheckoutPayment", path: "/checkout" },
        { name: "BookingConfirmed", path: "/booking-confirmed" },
        { name: "DevoteeDashboard", path: "/dashboard" },
        { name: "FestivalSpecial", path: "/festival-special" },
        { name: "PriestPartnerDashboard", path: "/priest/dashboard" },
        { name: "PriestEarnings", path: "/priest/earnings" },
        { name: "PlatformAdmin", path: "/admin" },
        { name: "ComponentsTest", path: "/components-test" },
      ],
    };
  },
  methods: {
    formatRouteName(name) {
      return name.replace(/([A-Z])/g, " $1").trim();
    },
  },
};
</script>

<style>
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  padding: 0;
  font-family: "Work Sans", sans-serif;
  background-color: #f8f7f5;
}

/* Dev Navigation Overlay */
.dev-nav {

  position: fixed;
  bottom: 10px;
  right: 10px;
  background: rgba(0, 0, 0, 0.85);
  padding: 8px;
  border-radius: 8px;
  z-index: 9999;
  display: flex;
  flex-direction: column;
  gap: 4px;
  max-height: 80vh;
  overflow-y: auto;
}

.dev-nav-link {
  display: block;
  background: transparent;
  color: #a1a1aa;
  border: 1px solid transparent;
  padding: 4px 8px;
  font-size: 11px;
  text-align: right;
  cursor: pointer;
  border-radius: 4px;
  text-decoration: none;
  transition: color 0.15s;
}

.dev-nav-link:hover {
  color: white;
}

.dev-nav-link.active {
  background: #f5993d;
  color: white !important;
  font-weight: bold;
}
</style>
