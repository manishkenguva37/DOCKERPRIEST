<template>
  <div class="admin-container">
    <!-- Top App Bar -->
    <header class="header">
      <div class="header-left">
        <span class="material-symbols-outlined text-primary icon-lg">dashboard</span>
        <h1 class="header-title">Platform Admin</h1>
      </div>
      <div class="header-right">
        <button class="icon-btn">
          <span class="material-symbols-outlined">notifications</span>
        </button>
        <div class="admin-avatar" :style="{ backgroundImage: `url(${admin.image})` }"></div>
      </div>
    </header>

    <main class="main-content">
      <!-- Quick Stats -->
      <section class="stats-grid">
        <div v-for="stat in stats" :key="stat.label" class="stat-card">
          <p class="stat-label">{{ stat.label }}</p>
          <div class="stat-row">
            <p class="stat-val">{{ stat.value }}</p>
            <span class="stat-trend" :class="stat.trendColor">{{ stat.trend }}</span>
          </div>
        </div>
      </section>

      <!-- Booking Trends -->
      <section class="section">
        <AUCARD class="chart-card">
           <template #default>
             <div class="chart-header">
               <h2 class="card-title">Booking Trends</h2>
               <span class="badge-soft">LAST 30 DAYS</span>
             </div>
             <div class="total-bookings">
               <p class="big-num">450</p>
               <div class="trend-block">
                 <p class="trend-up">↑ 8.2%</p>
                 <p class="sub-text">vs prev month</p>
               </div>
             </div>
             <!-- Mock Chart -->
             <div class="mock-chart">
               <svg viewBox="0 0 400 100" class="chart-svg">
                 <path d="M0 80 Q 50 20 100 60 T 200 40 T 300 70 T 400 30" fill="none" stroke="#f5993d" stroke-width="3" />
                 <path d="M0 80 Q 50 20 100 60 T 200 40 T 300 70 T 400 30 V 100 H 0 Z" fill="url(#gradient)" opacity="0.2" />
                 <defs>
                   <linearGradient id="gradient" x1="0" x2="0" y1="0" y2="1">
                     <stop offset="0%" stop-color="#f5993d" />
                     <stop offset="100%" stop-color="white" stop-opacity="0" />
                   </linearGradient>
                 </defs>
               </svg>
             </div>
             <div class="chart-axis">
               <span>WEEK 1</span><span>WEEK 2</span><span>WEEK 3</span><span>WEEK 4</span>
             </div>
           </template>
        </AUCARD>
      </section>

      <!-- Manage Priests -->
      <section class="section">
        <div class="section-header">
          <h2 class="section-title">Manage Priests</h2>
          <button class="view-all-btn">View All</button>
        </div>
        <div class="priests-list">
          <div v-for="priest in priests" :key="priest.name" class="priest-row-card">
            <div class="priest-avatar-sm" :style="{ backgroundImage: `url(${priest.image})` }"></div>
            <div class="priest-info">
              <p class="priest-name">{{ priest.name }}</p>
              <p class="priest-desc">{{ priest.desc }}</p>
            </div>
            <div class="priest-status">
              <span class="status-pill" :class="priest.statusClass">{{ priest.status }}</span>
              <div class="flex-center text-primary">
                 <span class="material-symbols-outlined icon-xs">star</span>
                 <span class="rating-val">{{ priest.rating }}</span>
              </div>
            </div>
          </div>
          
          <button class="add-priest-btn">
            <span class="material-symbols-outlined">add_circle</span>
            Add New Priest
          </button>
        </div>
      </section>

      <!-- Manage Pujas -->
      <section class="section">
        <h2 class="section-title mb-3">Popular Pujas</h2>
        <div class="pujas-list">
          <div v-for="puja in pujas" :key="puja.name" class="puja-row-card">
            <div>
              <p class="puja-name">{{ puja.name }}</p>
              <p class="puja-dur">Duration: {{ puja.duration }}</p>
            </div>
            <div class="text-right">
              <p class="puja-price">₹{{ puja.price }}</p>
              <button class="edit-btn">Edit Rate</button>
            </div>
          </div>
        </div>
      </section>
      
      <!-- Campaign Performance -->
      <section class="section pb-24">
        <h2 class="section-title mb-3">Campaign Performance</h2>
        <div class="campaign-card">
          <div class="flex-between mb-4">
            <div>
              <p class="camp-label">Active Campaign</p>
              <h3 class="camp-title">Diwali Special 2024</h3>
            </div>
            <span class="live-badge">LIVE</span>
          </div>
          
          <div class="progress-block">
             <div class="flex-between text-xs font-bold mb-1 white-text">
               <span>Target Bookings</span>
               <span>842 / 1000</span>
             </div>
             <div class="progress-track">
               <div class="progress-fill" style="width: 84%"></div>
             </div>
          </div>
          
          <div class="stats-cols">
            <div class="stat-box">
              <p class="stat-box-label">Impressions</p>
              <p class="stat-box-val">124.5k</p>
            </div>
             <div class="stat-box">
              <p class="stat-box-label">Conversion</p>
              <p class="stat-box-val">3.2%</p>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- Bottom Navigation -->
    <nav class="bottom-nav">
      <button class="nav-item active">
        <span class="material-symbols-outlined">dashboard</span>
        <span class="nav-label">Dashboard</span>
      </button>
      <button class="nav-item">
        <span class="material-symbols-outlined">person_pin_circle</span>
        <span class="nav-label">Priests</span>
      </button>
      <button class="nav-item">
        <span class="material-symbols-outlined">calendar_month</span>
        <span class="nav-label">Bookings</span>
      </button>
      <button class="nav-item">
        <span class="material-symbols-outlined">settings</span>
        <span class="nav-label">Settings</span>
      </button>
    </nav>
  </div>
</template>

<script>
import AUBUTTON from "../../../artiqui/src/components/AUBUTTON.vue";
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";

export default {
  name: "PlatformAdmin",
  components: {
    AUBUTTON,
    AUCARD,
  },
  data() {
    return {
      admin: {
        image:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuDXTAMN9Ms8x6ULRgFzsnll-xAbgcELP0S3-1Y6covhb7EX34zX1vw3G38wNbVpBhiBisDtoUE0CHb_XLXvJW_oOKHf9w9PLTThJTAYvheB7HG45u9V-7tpr5iruMtPCiLGAxYhpj0YRD1H3WiXcrvOGixmfseF0NzHB0p4JJ0r_QrhBA6pk-FASeF1lg3aVfzxQMvt3kO9WLME05VWTK4iaH3SGt8Io-NF2bOHqnRQHdA5CJnLJUa2tXJ8HYiBrXVAiWyL0kOAvdfV",
      },
      stats: [
        { label: "Total Bookings", value: "1,240", trend: "+12%", trendColor: "text-green" },
        { label: "Active Priests", value: "85", trend: "+5%", trendColor: "text-green" },
        { label: "Revenue", value: "₹12.5L", trend: "+18%", trendColor: "text-primary" },
        { label: "Campaign ROI", value: "4.2x", trend: "High", trendColor: "text-green" },
      ],
      priests: [
        {
          name: "Pandit Rajesh Sharma",
          desc: "Vedic Rituals • Varanasi",
          status: "ACTIVE",
          statusClass: "status-active",
          rating: 4.9,
          image:
            "https://lh3.googleusercontent.com/aida-public/AB6AXuAU-ACNNVD6_1b6jCPYMO2W4ydeN_dwCJw_hk_BNDDZFFd_vfRavveDz8WMGOvHHmQ6DhUNbQOL7BsMsejAuulNAxtNKoxreEYq6NVfXqjSN3v5JDq5qaAWs_FZNQsDs6snJHBes1meVMFAmzcp9l3AI-npwFOcqI9jWwin00_UyRnIKo_hKFu1-JGWHiT07-JJ_wyiZas__wKxn9oNt1eu251UdmKj1j_7cG7nAHqDwKVWARkUWZirTXZAXk7Ol3mXD9R4BDKdOCWn",
        },
        {
          name: "Acharya Anil Kumar",
          desc: "Vastu Shastra • Haridwar",
          status: "PENDING",
          statusClass: "status-pending",
          rating: 4.7,
          image:
            "https://lh3.googleusercontent.com/aida-public/AB6AXuCtRH3SP0IgggNlSheWKMLy0ZgpTU90fhX_RLX2TKHsw3vQJXEl7rRq-hPPtmIjtAz-3lRRk9ytiVmf_T-dIwKRw_DfP55jdLIMvDxtH7MH0qRgS-MaVgSRwnB9dhxVAb4ui9pglOXEFIj0_CBgsiL5-kyYAbNY-wyV79cgFUnJSfQfilw2JHPKo1H_gyj-18X2HSEX8HdIQjDBJ0G14y4CsN3G5V5dQKZLN-X6VrDT3awSfcVLMmCqnYBgfZmF9FFAf9x-yQdHbJ3n",
        },
      ],
      pujas: [
        { name: "Griha Pravesh Puja", duration: "3-4 Hours", price: "5,100" },
        { name: "Satyanarayan Katha", duration: "2 Hours", price: "2,500" },
      ],
    };
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.admin-container {
  font-family: "Work Sans", sans-serif;
  background-color: #f8f7f5;
  min-height: 100vh;
  color: #181411;
  padding-bottom: 24px;
}

/* Header */
.header {
  position: sticky;
  top: 0;
  z-index: 50;
  background-color: white;
  border-bottom: 1px solid #e6e0db;
  padding: 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.icon-lg {
  font-size: 30px;
}

.text-primary {
  color: #f5993d;
}

.header-title {
  font-size: 18px;
  font-weight: 700;
  margin: 0;
}

.header-right {
  display: flex;
  gap: 8px;
}

.icon-btn {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: none;
  cursor: pointer;
}

.icon-btn:hover {
  background-color: #f3f4f6;
}

.admin-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-size: cover;
  background-position: center;
  background-color: rgba(245, 153, 61, 0.2);
}

/* Main */
.main-content {
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.stats-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}

.stat-card {
  background-color: white;
  padding: 16px;
  border-radius: 12px;
  border: 1px solid #e6e0db;
}

.stat-label {
  font-size: 12px;
  font-weight: 500;
  color: #8a7560;
  margin: 0 0 4px;
}

.stat-row {
  display: flex;
  align-items: flex-end;
  gap: 8px;
}

.stat-val {
  font-size: 24px;
  font-weight: 700;
  margin: 0;
}

.stat-trend {
  font-size: 12px;
  font-weight: 700;
  margin-bottom: 4px;
}

.text-green { color: #07880e; }
.text-primary { color: #f5993d; }

/* Booking Trends */
.chart-card {
  padding: 20px;
  background-color: white;
}

.chart-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.card-title {
  font-size: 18px;
  font-weight: 700;
  margin: 0;
}

.badge-soft {
  background-color: rgba(245, 153, 61, 0.1);
  color: #f5993d;
  font-size: 12px;
  font-weight: 700;
  padding: 4px 8px;
  border-radius: 4px;
}

.total-bookings {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
}

.big-num {
  font-size: 30px;
  font-weight: 700;
  margin: 0;
}

.trend-up {
  color: #07880e;
  font-size: 14px;
  font-weight: 700;
  line-height: 1;
}

.sub-text {
  font-size: 10px;
  color: #8a7560;
  text-transform: uppercase;
}

.mock-chart {
  height: 128px;
  width: 100%;
  margin-top: 16px;
}

.chart-svg {
  width: 100%;
  height: 100%;
}

.chart-axis {
  display: flex;
  justify-content: space-between;
  margin-top: 8px;
  font-size: 10px;
  color: #8a7560;
  font-weight: 700;
}

/* Priests */
.section-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  margin-bottom: 12px;
}

.section-title {
  font-size: 20px;
  font-weight: 700;
  margin: 0;
}

.view-all-btn {
  color: #f5993d;
  font-size: 14px;
  font-weight: 700;
  background: none;
  border: none;
  cursor: pointer;
}

.priests-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.priest-row-card {
  display: flex;
  align-items: center;
  gap: 16px;
  background-color: white;
  padding: 16px;
  border-radius: 12px;
  border: 1px solid #e6e0db;
}

.priest-avatar-sm {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background-size: cover;
  background-position: center;
  flex-shrink: 0;
}

.priest-info {
  flex: 1;
  min-width: 0;
}

.priest-name {
  font-size: 16px;
  font-weight: 700;
  margin: 0;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.priest-desc {
  font-size: 12px;
  color: #8a7560;
  margin: 0;
}

.priest-status {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 4px;
}

.status-pill {
  font-size: 10px;
  font-weight: 700;
  padding: 2px 8px;
  border-radius: 9999px;
}

.status-active {
  background-color: #e8f5e9;
  color: #2e7d32;
}

.status-pending {
  background-color: #fff3e0;
  color: #ef6c00;
}

.flex-center {
  display: flex;
  align-items: center;
}

.icon-xs {
  font-size: 12px;
}

.rating-val {
  font-size: 12px;
  font-weight: 700;
  margin-left: 2px;
}

.add-priest-btn {
  width: 100%;
  padding: 12px;
  border-radius: 12px;
  border: 2px dashed #e6e0db;
  color: #8a7560;
  font-weight: 700;
  font-size: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  background: transparent;
  cursor: pointer;
}

/* Pujas */
.pujas-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.puja-row-card {
  background-color: white;
  padding: 16px;
  border-radius: 12px;
  border: 1px solid #e6e0db;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.puja-name {
  font-weight: 700;
  margin: 0;
}

.puja-dur {
  font-size: 12px;
  color: #8a7560;
  margin: 0;
}

.text-right {
  text-align: right;
}

.puja-price {
  font-weight: 700;
  color: #f5993d;
  margin: 0;
}

.edit-btn {
  font-size: 10px;
  font-weight: 700;
  color: #9ca3af;
  text-transform: uppercase;
  text-decoration: underline;
  background: none;
  border: none;
  cursor: pointer;
}

/* Campaign */
.campaign-card {
  background: linear-gradient(135deg, #f5993d 0%, #d37a1f 100%);
  padding: 20px;
  border-radius: 16px;
  color: white;
}

.flex-between {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.camp-label {
  font-size: 12px;
  font-weight: 700;
  text-transform: uppercase;
  color: rgba(255, 255, 255, 0.8);
  margin: 0;
}

.camp-title {
  font-size: 20px;
  font-weight: 700;
  margin: 0;
}

.live-badge {
  background-color: rgba(255, 255, 255, 0.2);
  font-size: 10px;
  font-weight: 700;
  padding: 4px 8px;
  border-radius: 4px;
}

.progress-block {
  margin-top: 16px;
}

.white-text {
  color: white;
  opacity: 0.9;
}

.progress-track {
  width: 100%;
  height: 8px;
  background-color: rgba(0, 0, 0, 0.1);
  border-radius: 9999px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background-color: white;
  border-radius: 9999px;
}

.stats-cols {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  margin-top: 16px;
}

.stat-box {
  background-color: rgba(255, 255, 255, 0.1);
  padding: 12px;
  border-radius: 8px;
}

.stat-box-label {
  font-size: 10px;
  font-weight: 500;
  text-transform: uppercase;
  opacity: 0.8;
  margin: 0;
}

.stat-box-val {
  font-size: 18px;
  font-weight: 700;
  margin: 0;
}

.mb-3 {
  margin-bottom: 12px;
}

.pb-24 {
  padding-bottom: 96px;
}

/* Bottom Nav */
.bottom-nav {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: white;
  border-top: 1px solid #e6e0db;
  padding: 8px 24px 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 50;
}

.nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  background: none;
  border: none;
  color: #9ca3af;
  cursor: pointer;
}

.nav-item.active {
  color: #f5993d;
}

.nav-label {
  font-size: 10px;
  font-weight: 700;
}
</style>
