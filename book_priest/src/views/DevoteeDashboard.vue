<template>
  <div class="dashboard-container">
    <div class="bg-header-premium"></div>
    <main class="main-content">
      <!-- Profile Header -->
      <header class="profile-header animate-fade-up">
        <div class="profile-row">
           <div class="profile-info">
             <div class="avatar-lg premium-shadow" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDXTAMN9Ms8x6ULRgFzsnll-xAbgcELP0S3-1Y6covhb7EX34zX1vw3G38wNbVpBhiBisDtoUE0CHb_XLXvJW_oOKHf9w9PLTThJTAYvheB7HG45u9V-7tpr5iruMtPCiLGAxYhpj0YRD1H3WiXcrvOGixmfseF0NzHB0p4JJ0r_QrhBA6pk-FASeF1lg3aVfzxQMvt3kO9WLME05VWTK4iaH3SGt8Io-NF2bOHqnRQHdA5CJnLJUa2tXJ8HYiBrXVAiWyL0kOAvdfV')"></div>
             <div>
               <h1 class="user-name">Namaste, Rahul!</h1>
               <div class="flex items-center gap-1 opacity-90 text-sm">
                  <span class="material-symbols-outlined text-sm">location_on</span>
                  <span>Bangalore, India</span>
               </div>
             </div>
           </div>
           <button class="icon-btn-glass hover-scale">
             <span class="material-symbols-outlined">notifications</span>
           </button>
        </div>
      </header>

      <!-- Segmented Control -->
      <div class="segment-control animate-fade-up animate-delay-1">
         <button
           class="segment-btn"
           :class="{ active: activeTab === 'upcoming' }"
           @click="setTab('upcoming')"
         >Upcoming</button>
         <button
           class="segment-btn"
           :class="{ active: activeTab === 'history' }"
           @click="setTab('history')"
         >History</button>
         <button
           class="segment-btn"
           :class="{ active: activeTab === 'saved' }"
           @click="setTab('saved')"
         >Saved</button>
      </div>

      <!-- ═══ UPCOMING TAB ═══ -->
      <div v-show="activeTab === 'upcoming'" class="animate-fade-up animate-delay-2">
        <section class="section">
          <h2 class="section-title">Upcoming Puja</h2>
          <AUCARD class="booking-card mb-6 premium-shadow" no-padding>
            <template #default>
              <div class="booking-card-content">
                <div class="booking-header">
                  <div class="flex items-center gap-4">
                    <div class="date-badge-premium">
                       <span class="db-month">OCT</span>
                       <span class="db-day">24</span>
                    </div>
                    <div>
                      <h3 class="booking-title">Satyanarayan Katha</h3>
                      <div class="flex items-center gap-2 text-muted text-xs mt-1">
                        <span class="material-symbols-outlined text-xs">schedule</span>
                        <span>09:00 AM &bull; Home Visit</span>
                      </div>
                    </div>
                  </div>
                  <AUBADGE label="CONFIRMED" variant="success" size="small" pill class="status-pill" />
                </div>
                
                <div class="divider"></div>
                
                <div class="priest-row-premium">
                   <div class="flex items-center gap-3">
                     <div class="priest-avatar-sm-premium" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAU-ACNNVD6_1b6jCPYMO2W4ydeN_dwCJw_hk_BNDDZFFd_vfRavveDz8WMGOvHHmQ6DhUNbQOL7BsMsejAuulNAxtNKoxreEYq6NVfXqjSN3v5JDq5qaAWs_FZNQsDs6snJHBes1meVMFAmzcp9l3AI-npwFOcqI9jWwin00_UyRnIKo_hKFu1-JGWHiT07-JJ_wyiZas__wKxn9oNt1eu251UdmKj1j_7cG7nAHqDwKVWARkUWZirTXZAXk7Ol3mXD9R4BDKdOCWn')"></div>
                     <span class="priest-name-premium">Pt. Rajesh Sharma</span>
                   </div>
                   <button class="txt-btn-premium hover-scale">View Details</button>
                </div>
              </div>
            </template>
          </AUCARD>
        </section>
      </div>

      <!-- ═══ HISTORY TAB ═══ -->
      <div v-show="activeTab === 'history'" class="animate-fade-up animate-delay-2">
        <section class="section">
          <div class="flex items-center justify-between mb-4">
            <h2 class="section-title mb-0">Past Bookings</h2>
            <button class="link-btn-premium">View All</button>
          </div>
          
          <AUCARD class="past-card mb-3 premium-shadow" no-padding>
             <template #default>
               <div class="past-content">
                  <div class="flex items-center gap-4">
                    <div class="past-icon-circle bg-orange-light">
                      <span class="material-symbols-outlined text-orange">event_repeat</span>
                    </div>
                    <div>
                       <h3 class="past-title">Ganesh Havan</h3>
                       <p class="past-date">Sep 12, 2023</p>
                    </div>
                  </div>
                  <div class="flex flex-col items-end">
                     <p class="price-sm-premium">₹2,100</p>
                     <div class="rating-row-premium">
                       <span class="material-symbols-outlined star-fill">star</span>
                       <span>4.5</span>
                     </div>
                  </div>
               </div>
             </template>
          </AUCARD>
          
          <AUCARD class="past-card premium-shadow" no-padding>
             <template #default>
               <div class="past-content">
                  <div class="flex items-center gap-4">
                    <div class="past-icon-circle bg-blue-light">
                      <span class="material-symbols-outlined text-blue">home</span>
                    </div>
                    <div>
                       <h3 class="past-title">Griha Pravesh</h3>
                       <p class="past-date">Aug 05, 2023</p>
                    </div>
                  </div>
                  <div class="flex flex-col items-end">
                     <p class="price-sm-premium">₹5,100</p>
                     <button class="rate-btn-premium hover-scale">Rate Now</button>
                  </div>
               </div>
             </template>
          </AUCARD>
        </section>
      </div>

      <!-- ═══ SAVED TAB ═══ -->
      <div v-show="activeTab === 'saved'" class="animate-fade-up animate-delay-2">
        <section class="section">
          <h2 class="section-title">Saved Pujas</h2>
          <div v-if="savedPujas.length === 0" class="empty-state">
            <div class="empty-icon-container">
              <span class="material-symbols-outlined">favorite</span>
            </div>
            <p class="empty-text">No saved pujas yet</p>
            <AUBUTTON label="Explore Pujas" variant="primary" class="hover-scale" @click="$router.push('/pujas')" />
          </div>
          <AUCARD
            v-for="item in savedPujas"
            :key="item.title"
            class="past-card mb-4 premium-shadow"
            no-padding
            @click="$router.push({ name: 'PujaDetails', params: { id: item.id } })"
          >
            <template #default>
              <div class="past-content">
                <div class="flex items-center gap-4">
                  <div class="saved-thumb-premium"
                    :style="{ backgroundImage: `url(${item.image})` }"
                  ></div>
                  <div>
                    <h3 class="past-title">{{ item.title }}</h3>
                    <p class="past-date text-primary font-bold">{{ item.price }}</p>
                  </div>
                </div>
                <AUBUTTON label="Book" size="small" variant="primary" pill @click.stop="$router.push('/pujas/' + item.id + '/select-priest')" />
              </div>
            </template>
          </AUCARD>
        </section>
      </div>

      <!-- Padding for nav -->
      <div class="h-28"></div>
    </main>

    <!-- Bottom Nav -->
    <nav class="bottom-nav glass-effect">
      <button class="nav-item hover-scale" @click="$router.push('/')">
        <span class="material-symbols-outlined">explore</span>
        <span class="nav-label">Explore</span>
      </button>
      <button class="nav-item active hover-scale" @click="$router.push('/dashboard')">
        <span class="material-symbols-outlined filled">calendar_today</span>
        <span class="nav-label">Bookings</span>
      </button>
      <button class="nav-item hover-scale" @click="setTab('saved')">
        <span class="material-symbols-outlined">favorite</span>
        <span class="nav-label">Saved</span>
      </button>
      <button class="nav-item hover-scale" @click="$router.push('/dashboard')">
        <span class="material-symbols-outlined">person</span>
        <span class="nav-label">Profile</span>
      </button>
    </nav>
  </div>
</template>

<script>
import AUBUTTON from "../../../artiqui/src/components/AUBUTTON.vue";
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";
import AUBADGE from "../../../artiqui/src/components/AUBADGE.vue";

export default {
  name: "DevoteeDashboard",
  components: { AUBUTTON, AUCARD, AUBADGE },
  data() {
    return {
      activeTab: "upcoming", // 'upcoming' | 'history' | 'saved'
      savedPujas: [
        // Pre-populated sample saved items; in a real app this comes from a store/API
        {
          id: 1,
          title: "Ganesh Puja",
          price: "₹1,100 - ₹2,500",
          image: "https://lh3.googleusercontent.com/aida-public/AB6AXuAKFd60kcp4bMlebY4X-OZL4ycI52rCGMCwKc-qOdZm1BAizA5FTMBxIXeOKMDlopoIfSUT3AuytcC4hymH5uVfJY8Som2VUMTRP6MdnVtz8h6c7YiGserqxglB-HluCjInMjfdmagXlEX4NzokyMum5pxjQs-liBzp_cBiyfb7tFtPnwRfi9ngAsAJwIP3kRJTyTPGO8YcHdiQmkTSY6nCjzghcphMCEOHPvYuRifxjnspgXj5UmIgWl-Mx6cWcQf5shtqMWLDv0P-"
        },
        {
          id: 3,
          title: "Maha Lakshmi Havan",
          price: "₹5,000 - ₹12,000",
          image: "https://lh3.googleusercontent.com/aida-public/AB6AXuCg_bZfifsYg9FTPU5lxKO3vCfypWs1g-rliNrx4DpiuBvRhDsGVbFm7U_IgMV6c7jrUP_KALhslHPvQhL2rarbuCuFgkY6qEMdC1vsdPeBBj7-lJbIX0tFAlEXTK4z79us4B-8Rbj1DHQ9XOmU6w4Z2POPo9M2juMBSSu0BdfDET3l3HVGCmZiZMul1ANihWSK8fI75rzYorYK8TJmiPWc0BS5UZ9-3ZLBzJ5k52XHtZnIHEkCWva0RejZK8QyNbUq1O-ASECzSRth"
        }
      ]
    };
  },
  methods: {
    setTab(tab) {
      this.activeTab = tab;
    },
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.dashboard-container {
  font-family: "Work Sans", sans-serif;
  background-color: var(--bg-main);
  min-height: 100vh;
  color: var(--text-main);
  padding-bottom: 24px;
}

.bg-header-premium {
  height: 240px;
  background: linear-gradient(135deg, var(--primary) 0%, #FF4500 100%);
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 0;
  border-radius: 0 0 40px 40px;
  box-shadow: 0 10px 30px rgba(255, 140, 0, 0.2);
}

.main-content {
  position: relative;
  z-index: 10;
  padding: 24px 20px;
}

/* Profile */
.profile-header {
  padding-top: 20px;
  margin-bottom: 32px;
  color: white;
}

.profile-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.profile-info {
  display: flex;
  align-items: center;
  gap: 20px;
}

.avatar-lg {
  width: 72px;
  height: 72px;
  border-radius: 24px;
  border: 3px solid rgba(255, 255, 255, 0.4);
  background-size: cover;
  background-position: center;
  transform: rotate(-3deg);
}

.user-name {
  font-size: 22px;
  font-weight: 800;
  margin: 0;
  text-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.icon-btn-glass {
  width: 44px;
  height: 44px;
  border-radius: 14px;
  background-color: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  cursor: pointer;
}

/* Segment Control */
.segment-control {
  background-color: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  padding: 6px;
  display: flex;
  box-shadow: var(--shadow-md);
  margin-bottom: 32px;
  border: 1px solid rgba(255, 255, 255, 0.5);
}

.segment-btn {
  flex: 1;
  padding: 10px;
  border-radius: 12px;
  border: none;
  background: transparent;
  font-size: 14px;
  font-weight: 700;
  color: var(--text-muted);
  cursor: pointer;
  transition: var(--transition);
}

.segment-btn.active {
  background-color: var(--primary);
  color: white;
  box-shadow: 0 4px 12px rgba(255, 140, 0, 0.3);
}

/* Sections */
.section {
  margin-bottom: 32px;
}

.section-title {
  font-size: 19px;
  font-weight: 800;
  margin: 0 0 16px;
  color: var(--text-main);
}

.mb-0 { margin-bottom: 0; }
.mb-3 { margin-bottom: 12px; }
.mb-4 { margin-bottom: 16px; }
.mb-6 { margin-bottom: 24px; }

/* Booking Card */
.booking-card-content {
  padding: 20px;
}

.booking-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.date-badge-premium {
  background: white;
  border: 1px solid rgba(0,0,0,0.05);
  border-radius: 14px;
  padding: 6px 12px;
  display: flex;
  flex-direction: column;
  align-items: center;
  min-width: 56px;
  box-shadow: var(--shadow-sm);
}

.db-month { font-size: 11px; font-weight: 800; color: var(--primary); text-transform: uppercase; }
.db-day { font-size: 20px; font-weight: 900; color: var(--text-main); line-height: 1; margin-top: 2px; }

.booking-title { font-size: 17px; font-weight: 800; margin: 0; color: var(--text-main); }
.text-muted { color: var(--text-muted); }

.status-pill {
  font-weight: 800 !important;
  letter-spacing: 0.5px;
}

.divider { height: 1px; background-color: rgba(0,0,0,0.04); margin: 16px 0; }

.priest-row-premium { display: flex; justify-content: space-between; align-items: center; }

.priest-avatar-sm-premium { width: 32px; height: 32px; border-radius: 10px; background-size: cover; background-position: center; border: 2px solid white; box-shadow: var(--shadow-sm); }

.priest-name-premium { font-size: 14px; font-weight: 700; color: var(--text-main); }

.txt-btn-premium {
  color: var(--primary);
  font-size: 13px;
  font-weight: 800;
  background: none;
  border: none;
  cursor: pointer;
}

/* Past Bookings */
.link-btn-premium {
  color: var(--primary);
  font-size: 13px;
  font-weight: 800;
  background: none;
  border: none;
  cursor: pointer;
}

.past-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
}

.past-icon-circle {
  width: 44px;
  height: 44px;
  border-radius: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.bg-orange-light { background: #FFF7ED; }
.text-orange { color: #EA580C; }
.bg-blue-light { background: #EFF6FF; }
.text-blue { color: #2563EB; }

.past-title { font-size: 15px; font-weight: 800; margin: 0; color: var(--text-main); }
.past-date { font-size: 12px; color: var(--text-muted); font-weight: 600; margin: 2px 0 0; }

.price-sm-premium { font-size: 15px; font-weight: 800; margin: 0; color: var(--text-main); }

.rating-row-premium { display: flex; align-items: center; gap: 4px; margin-top: 4px; font-size: 12px; font-weight: 800; color: #D97706; }
.star-fill { font-size: 14px; font-variation-settings: 'FILL' 1; }

.rate-btn-premium {
  font-size: 12px;
  color: var(--primary);
  font-weight: 800;
  background: #FFF7ED;
  border: none;
  padding: 4px 12px;
  border-radius: 8px;
  margin-top: 4px;
  cursor: pointer;
}

/* Empty State */
.empty-state {
  text-align: center;
  padding: 48px 20px;
  background: white;
  border-radius: 24px;
  border: 1px dashed rgba(0,0,0,0.1);
}

.empty-icon-container {
  width: 64px;
  height: 64px;
  background: var(--bg-main);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
  color: var(--primary);
}

.empty-text {
  font-size: 15px;
  color: var(--text-muted);
  font-weight: 700;
  margin-bottom: 24px;
}

/* Saved */
.saved-thumb-premium {
  width: 52px;
  height: 52px;
  border-radius: 12px;
  background-size: cover;
  background-position: center;
}

.h-28 { height: 112px; }

/* Bottom Nav */
.bottom-nav {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 16px 24px 36px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 100;
  border-top: 1px solid var(--glass-border);
}

.nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  background: none;
  border: none;
  color: #A1A1AA;
  cursor: pointer;
  transition: var(--transition);
}

.nav-item.active {
  color: var(--primary);
}

.nav-item .filled {
  font-variation-settings: 'FILL' 1;
}

.nav-label {
  font-size: 11px;
  font-weight: 800;
}
</style>
