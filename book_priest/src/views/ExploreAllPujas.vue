<template>
  <div class="explore-container">
    <!-- Header -->
    <header class="header glass-effect">
      <div class="header-top">
        <div class="flex items-center gap-2">
          <button class="icon-btn hover-scale" @click="$router.back()">
            <span class="material-symbols-outlined text-xl">arrow_back_ios</span>
          </button>
          <h1 class="text-xl font-bold gradient-text">Explore All Pujas</h1>
        </div>
        <div class="flex gap-4">
          <button class="icon-btn hover-scale" @click="showSearch = !showSearch">
            <span class="material-symbols-outlined text-2xl">search</span>
          </button>
        </div>
      </div>

      <!-- Inline Search Bar -->
      <div v-if="showSearch" class="search-bar-inline animate-fade-up">
        <span class="material-symbols-outlined search-icon">search</span>
        <input
          v-model="searchQuery"
          type="text"
          placeholder="Search pujas..."
          class="search-field"
          ref="searchInput"
          autofocus
        />
        <button v-if="searchQuery" class="icon-btn" @click="searchQuery = ''">
          <span class="material-symbols-outlined" style="font-size:18px">close</span>
        </button>
      </div>

      <!-- Filter Chips -->
      <div class="filters-scroll no-scrollbar">
        <button
          v-for="chip in filterChips"
          :key="chip.key"
          class="filter-chip hover-scale"
          :class="{ 'chip-active': activeFilter === chip.key }"
          @click="activeFilter = chip.key"
        >
          {{ chip.label }}
          <span class="material-symbols-outlined chip-arrow">keyboard_arrow_down</span>
        </button>
      </div>
    </header>

    <main class="main-content animate-fade-up animate-delay-1">
      <p v-if="filteredPujas.length === 0" class="no-results">No pujas found.</p>
      <AUCARD v-for="(puja, index) in filteredPujas" 
             :key="puja.id" 
             class="mb-6 premium-shadow" 
             :class="'animate-delay-' + (index + 1)"
             no-padding>
        <template #default>
          <div class="puja-card-inner">
            <div class="puja-info">
              <div>
                <div class="flex items-center gap-2 mb-2">
                  <span class="material-symbols-outlined text-primary text-xl">{{ puja.icon }}</span>
                  <h3 class="text-lg font-bold leading-tight">{{ puja.title }}</h3>
                </div>
                <p class="text-gray-500 text-sm font-medium mb-1">{{ puja.meta }}</p>
                <p class="price-text">{{ puja.price }}</p>
              </div>
              <AUBUTTON
                label="Book Now"
                size="small"
                variant="primary"
                class="mt-4 hover-scale"
                @click="openPuja(puja)"
              />
            </div>
            <div class="puja-image-container">
              <div class="puja-image" :style="{ backgroundImage: `url(${puja.image})` }"></div>
              <div class="image-overlay"></div>
            </div>
          </div>
        </template>
      </AUCARD>
      
      <div class="h-24"></div>
    </main>

    <!-- Bottom Nav -->
    <nav class="bottom-nav glass-effect">
      <button class="nav-item active" @click="$router.push('/pujas')">
        <span class="material-symbols-outlined icon-fill">explore</span>
        <span class="text-xs font-bold">Explore</span>
      </button>
      <button class="nav-item" @click="$router.push('/dashboard')">
        <span class="material-symbols-outlined">calendar_today</span>
        <span class="text-xs font-medium">Bookings</span>
      </button>
      <button class="nav-item" @click="$router.push('/dashboard')">
        <span class="material-symbols-outlined">favorite</span>
        <span class="text-xs font-medium">Saved</span>
      </button>
      <button class="nav-item" @click="$router.push('/dashboard')">
        <span class="material-symbols-outlined">person</span>
        <span class="text-xs font-medium">Profile</span>
      </button>
    </nav>
  </div>
</template>

<script>
import AUBUTTON from "../../../artiqui/src/components/AUBUTTON.vue";
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";
import AUBADGE from "../../../artiqui/src/components/AUBADGE.vue";

export default {
  name: "ExploreAllPujas",
  components: { AUBUTTON, AUCARD, AUBADGE },
  data() {
    return {
      showSearch: false,
      searchQuery: "",
      activeFilter: "all",
      filterChips: [
        { key: "all", label: "All" },
        { key: "occasion", label: "Occasion" },
        { key: "language", label: "Language" },
        { key: "price", label: "Price" },
        { key: "duration", label: "Duration" },
      ],
      pujas: [
        { id: 1, title: "Ganesh Puja", icon: "psychiatry", category: "occasion", meta: "60 mins • Vedic Rituals", price: "₹1,100 - ₹2,500", image: "https://lh3.googleusercontent.com/aida-public/AB6AXuAKFd60kcp4bMlebY4X-OZL4ycI52rCGMCwKc-qOdZm1BAizA5FTMBxIXeOKMDlopoIfSUT3AuytcC4hymH5uVfJY8Som2VUMTRP6MdnVtz8h6c7YiGserqxglB-HluCjInMjfdmagXlEX4NzokyMum5pxjQs-liBzp_cBiyfb7tFtPnwRfi9ngAsAJwIP3kRJTyTPGO8YcHdiQmkTSY6nCjzghcphMCEOHPvYuRifxjnspgXj5UmIgWl-Mx6cWcQf5shtqMWLDv0P-" },
        { id: 2, title: "Satyanarayan Katha", icon: "menu_book", category: "language", meta: "120 mins • Sanskrit", price: "₹3,500 - ₹5,000", image: "https://lh3.googleusercontent.com/aida-public/AB6AXuDNN78n48aGhFSyq8xjyB9CSGjOss8wfcOW_O_op0V8sj63UpVkRLcbVod6ZmaU6G6W78VFsXO4jFqfmZ2kcxTqaeysuz0C94Uh7zGPBjFgkgGI-WGbAy78J0zHbA1CxqoKR8dn6lQfLKxic-M8R5-JfthXHlzMJvcADjUCQ8oJHorMrgJPtPWb5VPSHxXl0Dw0mQqS0l0A8fnr3c3sAuVlsah-S8HTIVr3eIV17Jn64rYtrqi_p5-3XkUsxhzgscejQNpa_VRtADO5" },
        { id: 3, title: "Maha Lakshmi Havan", icon: "local_fire_department", category: "occasion", meta: "150 mins • Hindi/Sanskrit", price: "₹5,000 - ₹12,000", image: "https://lh3.googleusercontent.com/aida-public/AB6AXuCg_bZfifsYg9FTPU5lxKO3vCfypWs1g-rliNrx4DpiuBvRhDsGVbFm7U_IgMV6c7jrUP_KALhslHPvQhL2rarbuCuFgkY6qEMdC1vsdPeBBj7-lJbIX0tFAlEXTK4z79us4B-8Rbj1DHQ9XOmU6w4Z2POPo9M2juMBSSu0BdfDET3l3HVGCmZiZMul1ANihWSK8fI75rzYorYK8TJmiPWc0BS5UZ9-3ZLBzJ5k52XHtZnIHEkCWva0RejZK8QyNbUq1O-ASECzSRth" },
        { id: 4, title: "Griha Pravesh", icon: "house", category: "duration", meta: "180 mins • Full Rituals", price: "₹7,500 - ₹15,000", image: "https://lh3.googleusercontent.com/aida-public/AB6AXuANvZVHFh8PM5ihuAH5nS6oPDQvQNlV8mLMm1hxjHLy71-1V68tmolMQ6sMGAsQGqy8uNVheYOYmaFrBNH6sFTiBOmG2WXgnwMd_-MeBpvvci0au5xiG3fYry95__H01lgIkMMYcyY79wKu8zkuq4p6azrgO8OVt6thY0pH4bu944ov1S739NCeh1b-JtlrtG4am1HNVwiSlMKTUucKxNzKXgATlUqRRjPpfCB3wOVy2a4ylm1lkT2nY_V0wH-yHsYfOyQCfWabajZ5" },
        { id: 5, title: "Navagraha Homa", icon: "auto_awesome", category: "occasion", meta: "90 mins • Vedic", price: "₹4,000 - ₹8,000", image: "" },
        { id: 6, title: "Vastu Shanti", icon: "home", category: "language", meta: "120 mins • Sanskrit/Hindi", price: "₹3,000 - ₹6,000", image: "" },
      ],
    };
  },
  computed: {
    filteredPujas() {
      let list = this.pujas;
      if (this.activeFilter !== "all") {
        list = list.filter(p => p.category === this.activeFilter);
      }
      if (this.searchQuery.trim()) {
        const q = this.searchQuery.toLowerCase();
        list = list.filter(p => p.title.toLowerCase().includes(q) || p.meta.toLowerCase().includes(q));
      }
      return list;
    },
  },
  methods: {
    openPuja(puja) {
      this.$router.push({
        name: "PujaDetails",
        params: { id: puja.id },
        query: { title: puja.title, image: puja.image, price: puja.price, meta: puja.meta }
      });
    },
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.explore-container {
  font-family: "Work Sans", sans-serif;
  background-color: var(--bg-main);
  min-height: 100vh;
  color: var(--text-main);
  padding-bottom: 24px;
}

/* Header */
.header {
  position: sticky;
  top: 0;
  z-index: 50;
  padding: 8px 16px 12px;
  box-shadow: var(--shadow-sm);
}

.gradient-text {
  background: linear-gradient(135deg, var(--primary), #FF4500);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.header-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 56px;
}

.icon-btn {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: none;
  cursor: pointer;
  transition: var(--transition);
}

.hover-scale:active {
  transform: scale(0.95);
}

.filters-scroll {
  display: flex;
  gap: 10px;
  overflow-x: auto;
  padding: 8px 0;
}

.filter-chip {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 8px 16px;
  border-radius: 12px;
  border: 1px solid rgba(0,0,0,0.05);
  background: white;
  font-size: 13px;
  font-weight: 600;
  color: var(--text-main);
  cursor: pointer;
  white-space: nowrap;
  font-family: "Work Sans", sans-serif;
  box-shadow: var(--shadow-sm);
  transition: var(--transition);
}

.filter-chip.chip-active {
  background: var(--primary);
  color: white;
  border-color: var(--primary);
  box-shadow: 0 4px 10px rgba(255, 140, 0, 0.3);
}

/* Inline Search Bar */
.search-bar-inline {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  background: white;
  border-radius: 14px;
  margin-bottom: 12px;
  border: 1px solid rgba(0,0,0,0.05);
  box-shadow: var(--shadow-sm);
}

.search-field {
  flex: 1;
  border: none;
  background: transparent;
  font-family: "Work Sans", sans-serif;
  font-size: 15px;
  outline: none;
  color: var(--text-main);
}

/* Content */
.main-content {
  padding: 20px 16px;
}

.puja-card-inner {
  display: flex;
  align-items: stretch;
  overflow: hidden;
  border-radius: 16px;
}

.puja-info {
  flex: 1;
  padding: 20px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.price-text {
  color: var(--primary);
  font-weight: 800;
  font-size: 16px;
  margin-top: 8px;
}

.puja-image-container {
  width: 140px;
  position: relative;
}

.puja-image {
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center;
}

.image-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to right, white, transparent 30%);
}

/* Bottom Nav */
.bottom-nav {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 12px 24px 32px;
  border-top: 1px solid var(--glass-border);
  display: flex;
  justify-content: space-between;
  z-index: 50;
}

.nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  background: none;
  border: none;
  color: #9CA3AF;
  cursor: pointer;
  transition: var(--transition);
}

.nav-item.active {
  color: var(--primary);
}
</style>
