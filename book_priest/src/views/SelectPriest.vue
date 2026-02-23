<template>
  <div class="page-container">
    <!-- Header -->
    <header class="header glass-effect">
      <div class="header-top">
        <button class="icon-btn hover-scale" @click="$router.back()">
          <span class="material-symbols-outlined">arrow_back_ios_new</span>
        </button>
        <h1 class="header-title gradient-text">Select Priest</h1>
        <button class="icon-btn hover-scale">
          <span class="material-symbols-outlined">filter_list</span>
        </button>
      </div>
      
      <!-- Search -->
      <div class="search-bar animate-fade-up">
        <AUINPUT 
          placeholder="Search for priests..." 
          icon="search"
          v-model="searchQuery"
          class="premium-input-shadow"
        />
      </div>

      <!-- Filters -->
      <div class="filters-scroll no-scrollbar animate-fade-up animate-delay-1">
        <button
          v-for="chip in filterChips"
          :key="chip.key"
          class="filter-chip-btn hover-scale"
          :class="{ 'chip-active': activeFilter === chip.key }"
          @click="activeFilter = chip.key"
        >{{ chip.label }}</button>
      </div>
    </header>

    <main class="main-content">
      <p v-if="filteredPriests.length === 0" class="no-results animate-fade-up">No priests found.</p>
      <AUCARD v-for="(priest, index) in filteredPriests" 
             :key="priest.name" 
             class="priest-card mb-6 premium-shadow" 
             :class="'animate-delay-' + (index % 5 + 1)"
             no-padding>
        <template #default>
          <div class="priest-card-inner">
            <div class="priest-header">
              <div class="flex gap-4">
                <div class="avatar-container">
                  <div class="priest-avatar" :style="{ backgroundImage: `url(${priest.image})` }"></div>
                  <div class="online-indicator"></div>
                </div>
                <div class="flex-1">
                  <div class="flex justify-between items-start">
                    <h3 class="priest-name">{{ priest.name }}</h3>
                    <div class="rating-badge">
                      <span class="material-symbols-outlined icon-star">star</span>
                      <span>{{ priest.rating }}</span>
                    </div>
                  </div>
                  <p class="priest-loc">{{ priest.location }} • {{ priest.experience }} exp</p>
                  <div class="flex flex-wrap gap-2 mt-2">
                    <AUBADGE size="small" variant="flat" v-for="lang in priest.languages" :key="lang" class="lang-badge">{{ lang }}</AUBADGE>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="priest-footer">
              <div class="price-block">
                <p class="price-label">Pujan starting from</p>
                <p class="price-val">₹{{ priest.price }}</p>
              </div>
              <AUBUTTON label="Select Priest" variant="primary" size="small" class="select-btn hover-scale" @click="selectPriest(priest)" />
            </div>
          </div>
        </template>
      </AUCARD>
      
      <div class="h-8"></div>
    </main>
  </div>
</template>

<script>
import AUBUTTON from "../../../artiqui/src/components/AUBUTTON.vue";
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";
import AUBADGE from "../../../artiqui/src/components/AUBADGE.vue";
import AUINPUT from "../../../artiqui/src/components/AUINPUT.vue";

export default {
  name: "SelectPriest",
  components: { AUBUTTON, AUCARD, AUBADGE, AUINPUT },
  data() {
    return {
      searchQuery: "",
      activeFilter: "all",
      filterChips: [
        { key: "all", label: "All" },
        { key: "vedic", label: "Vedic" },
        { key: "experienced", label: "20+ Yrs" },
        { key: "nearby", label: "Nearby" },
      ],
      priests: [
        {
          name: "Pandit Rajesh Sharma",
          location: "Varanasi",
          experience: "15 Years",
          rating: 4.9,
          price: "2,100",
          languages: ["Hindi", "Sanskrit"],
          image: "https://lh3.googleusercontent.com/aida-public/AB6AXuAU-ACNNVD6_1b6jCPYMO2W4ydeN_dwCJw_hk_BNDDZFFd_vfRavveDz8WMGOvHHmQ6DhUNbQOL7BsMsejAuulNAxtNKoxreEYq6NVfXqjSN3v5JDq5qaAWs_FZNQsDs6snJHBes1meVMFAmzcp9l3AI-npwFOcqI9jWwin00_UyRnIKo_hKFu1-JGWHiT07-JJ_wyiZas__wKxn9oNt1eu251UdmKj1j_7cG7nAHqDwKVWARkUWZirTXZAXk7Ol3mXD9R4BDKdOCWn"
        },
        {
          name: "Acharya Anil Kumar",
          location: "Haridwar",
          experience: "12 Years",
          rating: 4.8,
          price: "1,800",
          languages: ["Hindi", "English"],
          image: "https://lh3.googleusercontent.com/aida-public/AB6AXuCtRH3SP0IgggNlSheWKMLy0ZgpTU90fhX_RLX2TKHsw3vQJXEl7rRq-hPPtmIjtAz-3lRRk9ytiVmf_T-dIwKRw_DfP55jdLIMvDxtH7MH0qRgS-MaVgSRwnB9dhxVAb4ui9pglOXEFIj0_CBgsiL5-kyYAbNY-wyV79cgFUnJSfQfilw2JHPKo1H_gyj-18X2HSEX8HdIQjDBJ0G14y4CsN3G5V5dQKZLN-X6VrDT3awSfcVLMmCqnYBgfZmF9FFAf9x-yQdHbJ3n"
        },
        {
          name: "Shastri Vikram Singh",
          location: "Rishikesh",
          experience: "8 Years",
          rating: 4.7,
          price: "1,500",
          languages: ["Sanskrit", "Hindi"],
          image: ""
        },
        {
          name: "Pandit Suresh Joshi",
          location: "Nashik",
          experience: "20 Years",
          rating: 4.6,
          price: "3,100",
          languages: ["Marathi", "Hindi"],
          image: ""
        }
      ]
    };
  },
  computed: {
    filteredPriests() {
      let list = this.priests;
      if (this.activeFilter === "vedic") {
        list = list.filter(p => p.languages.includes("Sanskrit"));
      } else if (this.activeFilter === "experienced") {
        list = list.filter(p => parseInt(p.experience) >= 15);
      } else if (this.activeFilter === "nearby") {
        list = list.filter(p => ["Varanasi", "Haridwar"].includes(p.location));
      }
      if (this.searchQuery.trim()) {
        const q = this.searchQuery.toLowerCase();
        list = list.filter(p =>
          p.name.toLowerCase().includes(q) ||
          p.location.toLowerCase().includes(q)
        );
      }
      return list;
    },
  },
  methods: {
    selectPriest(priest) {
      this.$router.push({
        name: "CheckoutPayment",
        query: {
          priestName: priest.name,
          priestImage: priest.image,
          priestPrice: priest.price,
          pujaTitle: this.$route.query.title || "Puja & Havan",
          pujaImage: this.$route.query.image || ""
        }
      });
    },
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.page-container {
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
  padding: 12px 16px;
  box-shadow: var(--shadow-sm);
}

.header-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.header-title {
  font-size: 19px;
  font-weight: 800;
  margin: 0;
}

.gradient-text {
  background: linear-gradient(135deg, var(--primary), #FF4500);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.icon-btn {
  width: 44px;
  height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: none;
  cursor: pointer;
  border-radius: 12px;
}

.hover-scale:active {
  transform: scale(0.95);
}

.search-bar {
  margin-bottom: 20px;
}

.premium-input-shadow {
  box-shadow: var(--shadow-sm);
  border: 1px solid rgba(0,0,0,0.03);
}

.filters-scroll {
  display: flex;
  gap: 10px;
  overflow-x: auto;
  padding: 4px 0;
}

.filter-chip-btn {
  display: inline-flex;
  align-items: center;
  padding: 8px 18px;
  border-radius: 14px;
  border: 1px solid rgba(0,0,0,0.05);
  background: white;
  font-size: 13px;
  font-weight: 700;
  color: var(--text-muted);
  cursor: pointer;
  white-space: nowrap;
  font-family: "Work Sans", sans-serif;
  transition: var(--transition);
}

.filter-chip-btn.chip-active {
  background: var(--primary);
  color: white;
  border-color: var(--primary);
  box-shadow: 0 4px 10px rgba(255, 140, 0, 0.25);
}

.no-results {
  text-align: center;
  color: var(--text-muted);
  padding: 48px 16px;
  font-size: 15px;
  font-weight: 600;
}

/* Content */
.main-content {
  padding: 24px 16px;
}

.priest-card {
  border-radius: 20px;
  border: 1px solid rgba(0,0,0,0.03);
  overflow: hidden;
  background: white;
}

.priest-card-inner {
  display: flex;
  flex-direction: column;
}

.priest-header {
  padding: 20px;
}

.avatar-container {
  position: relative;
}

.priest-avatar {
  width: 72px;
  height: 72px;
  border-radius: 20px;
  background-size: cover;
  background-position: center;
  background-color: #F3F4F6;
  border: 4px solid var(--bg-main);
  box-shadow: var(--shadow-sm);
}

.online-indicator {
  position: absolute;
  bottom: 4px;
  right: 4px;
  width: 14px;
  height: 14px;
  background-color: #10B981;
  border: 2px solid white;
  border-radius: 50%;
}

.priest-name {
  font-size: 17px;
  font-weight: 800;
  margin: 0;
  color: var(--text-main);
}

.priest-loc {
  font-size: 13px;
  color: var(--text-muted);
  font-weight: 600;
  margin: 4px 0 0;
}

.rating-badge {
  display: flex;
  align-items: center;
  gap: 4px;
  background-color: #FFFBEB;
  color: #D97706;
  padding: 4px 8px;
  border-radius: 8px;
  font-size: 13px;
  font-weight: 800;
}

.icon-star {
  font-size: 16px;
  font-variation-settings: 'FILL' 1;
}

.lang-badge {
  background: #F3F4F6;
  color: #4B5563;
  font-weight: 700;
  letter-spacing: 0.3px;
}

.priest-footer {
  background-color: #FCFDFE;
  padding: 16px 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-top: 1px solid rgba(0,0,0,0.03);
}

.price-label {
  font-size: 11px;
  color: var(--text-muted);
  font-weight: 600;
  margin: 0 0 2px;
}

.price-val {
  font-size: 18px;
  font-weight: 800;
  color: var(--text-main);
  margin: 0;
}

.select-btn {
  height: 40px;
  padding: 0 20px;
  border-radius: 12px;
  font-weight: 700;
}

.mb-6 { margin-bottom: 24px; }
.h-8 { height: 32px; }

.no-scrollbar::-webkit-scrollbar { display: none; }
.no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
</style>
