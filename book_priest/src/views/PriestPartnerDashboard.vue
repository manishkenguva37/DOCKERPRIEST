<template>
  <div class="app-container">
    <!-- Top AppBar -->
    <header class="header">
      <div class="header-content">
        <div class="user-profile">
          <div
            class="profile-pic"
            role="img"
            aria-label="Professional portrait of a priest"
            :style="{ backgroundImage: `url(${user.profileImage})` }"
          ></div>
          <div>
            <h1 class="greeting">Namaste,</h1>
            <h2 class="username">{{ user.name }}</h2>
          </div>
        </div>
        <div class="actions">
          <button class="icon-btn">
            <span class="material-symbols-outlined">notifications</span>
          </button>
        </div>
      </div>
    </header>

    <main class="main-content">
      <!-- Status & Earnings -->
      <section class="section">
        <div class="status-bar">
          <div class="status-badge">
            <span class="status-dot"></span>
            <span class="status-text">Online</span>
          </div>
          <button class="manage-btn">
            Manage Availability
            <span class="material-symbols-outlined text-xs"
              >arrow_forward_ios</span
            >
          </button>
        </div>

        <div class="stats-grid">
          <AUCARD class="stat-card primary">
            <template #default>
              <p class="stat-label-light">Total Earnings</p>
              <p class="stat-value">₹{{ stats.earnings }}</p>
              <div class="stat-trend">
                <span class="material-symbols-outlined icon-small"
                  >trending_up</span
                >
                <span>+{{ stats.earningsGrowth }}%</span>
              </div>
            </template>
          </AUCARD>
          <AUCARD class="stat-card secondary">
            <template #default>
              <p class="stat-label-dark">Rituals Done</p>
              <p class="stat-value text-primary">{{ stats.rituals }}</p>
              <p class="stat-subtext">{{ stats.pendingRituals }} pending this week</p>
            </template>
          </AUCARD>
        </div>
      </section>

      <!-- Availability Calendar (Simplified Weekly) -->
      <section class="section schedule-section">
        <h3 class="section-title">
          Your Schedule
          <span class="section-subtitle">{{ schedule.dateRange }}</span>
        </h3>
        <div class="calendar-strip">
          <div
            v-for="(day, index) in schedule.days"
            :key="index"
            class="calendar-day"
            :class="{ active: day.isActive }"
          >
            <span :class="['day-name', day.isActive ? 'text-primary' : '']">{{
              day.name
            }}</span>
            <div
              class="day-number"
              :class="{
                'active-number': day.isActive,
                'has-dot': day.hasEvent,
              }"
            >
              {{ day.date }}
              <span v-if="day.hasEvent" class="event-dot"></span>
            </div>
          </div>
        </div>
      </section>

      <!-- Booking Requests -->
      <section class="section">
        <div class="section-header">
          <h3 class="section-title">New Requests ({{ requests.length }})</h3>
          <span class="see-all">See All</span>
        </div>

        <AUCARD v-for="request in requests" :key="request.id" class="request-card">
          <template #default>
            <div class="request-header">
              <div class="request-info">
                <div class="request-icon">
                  <span class="material-symbols-outlined">{{
                    request.icon
                  }}</span>
                </div>
                <div>
                  <h4 class="request-title">{{ request.title }}</h4>
                  <p class="request-devotee">Devotee: {{ request.devotee }}</p>
                </div>
              </div>
              <div class="request-time">
                <p class="time-label">{{ request.timeLabel }}</p>
                <p class="time-value">{{ request.time }}</p>
              </div>
            </div>
            <div class="location-badge">
              <span class="material-symbols-outlined icon-small"
                >location_on</span
              >
              <span>{{ request.location }}</span>
            </div>
            <div class="action-buttons">
              <AUBUTTON
                variant="primary"
                label="Accept"
                icon="bi bi-check"
                class="w-100"
              />
              <AUBUTTON
                variant="secondary"
                label="Decline"
                icon="bi bi-x"
                class="w-100"
              />
            </div>
          </template>
        </AUCARD>
      </section>

      <!-- Upcoming Highlights -->
      <section class="section">
        <h3 class="section-title mb-3">Completed Recently</h3>
        <div class="highlights-scroll">
          <AUCARD
            v-for="completed in completedRituals"
            :key="completed.id"
            class="highlight-card"
          >
           <template #default>
            <div class="highlight-header">
              <span class="highlight-date">{{ completed.date }}</span>
              <span class="highlight-status">Paid</span>
            </div>
            <h4 class="highlight-title">{{ completed.title }}</h4>
            <p class="highlight-location">{{ completed.location }}</p>
            <p class="highlight-amount">₹{{ completed.amount }}</p>
           </template>
          </AUCARD>
        </div>
      </section>
    </main>

    <!-- Bottom Navigation Bar (iOS Style) -->
    <nav class="bottom-nav">
      <button
        v-for="item in navItems"
        :key="item.label"
        class="nav-item"
        :class="{ active: activeTab === item.id }"
        @click="activeTab = item.id"
      >
        <span
          class="material-symbols-outlined"
          :class="{ 'font-variation-fill': activeTab === item.id }"
          >{{ item.icon }}</span
        >
        <span class="nav-label">{{ item.label }}</span>
      </button>
    </nav>

    <!-- Floating Action Button -->
    <div class="fab-container">
      <button class="fab">
        <span class="material-symbols-outlined icon-large">bolt</span>
      </button>
    </div>
  </div>
</template>

<script>
import AUBUTTON from "../../../artiqui/src/components/AUBUTTON.vue";
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";

export default {
  name: "PriestPartnerDashboard",
  components: {
    AUBUTTON,
    AUCARD,
  },
  data() {
    return {
      activeTab: "home",
      user: {
        name: "Pandit Sharma Ji",
        profileImage:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuCJQQTuEBJK6ea4BCBKWf7kptOWNE7mqruhspOmuBmGxAerBQd0b7xMk3XJN1QVbvcCYaePdo51GsRU2qM5ld1Z3MkWbsn__TJXwdpuI19fBkzS5bJebTNRajhGNhNWNsH6DDqYEVHNO2PL-DGNq3vULinzL5UVHCJvf_B3NAj_5IN9dZQ2y0jvEKmaAt5fs1z_-iEUFDwEcJopXTH5NAEoTLLYKdebF9snhuYYrlHC251f42myiN9x8YuvYaHRxrG3wWRrvp6M-R2i",
      },
      stats: {
        earnings: "14,280",
        earningsGrowth: "12.5",
        rituals: 24,
        pendingRituals: 4,
      },
      schedule: {
        dateRange: "Oct 24 - 30",
        days: [
          { name: "Mon", date: 24, isActive: false, hasEvent: false },
          { name: "Tue", date: 25, isActive: false, hasEvent: false },
          { name: "Wed", date: 26, isActive: true, hasEvent: false },
          { name: "Thu", date: 27, isActive: false, hasEvent: false },
          { name: "Fri", date: 28, isActive: false, hasEvent: false },
          { name: "Sat", date: 29, isActive: false, hasEvent: true },
        ],
      },
      requests: [
        {
          id: 1,
          icon: "temple_hindu",
          title: "Satyanarayan Puja",
          devotee: "Rajesh Kumar",
          timeLabel: "Today",
          time: "10:30 AM",
          location: "Saket, New Delhi (2.4 km away)",
        },
        {
          id: 2,
          icon: "diversity_3",
          title: "Ganesh Vandana",
          devotee: "Amit Sharma",
          timeLabel: "Tomorrow",
          time: "08:00 AM",
          location: "Dwarka, New Delhi (5 km away)",
        },
        {
          id: 3,
          icon: "temple_hindu",
          title: "Griha Pravesh",
          devotee: "Rahul Singh",
          timeLabel: "Tomorrow",
          time: "10:00 AM",
          location: "Gurugram, Haryana (10 km away)",
        },
      ],
      completedRituals: [
        {
          id: 1,
          date: "Oct 22",
          title: "Griha Pravesh",
          location: "Mehrauli, DL",
          amount: "5,500",
        },
        {
          id: 2,
          date: "Oct 21",
          title: "Naming Ceremony",
          location: "Gurugram, HR",
          amount: "3,200",
        },
      ],
      navItems: [
        { id: "home", label: "Home", icon: "grid_view" },
        { id: "calendar", label: "Calendar", icon: "calendar_month" },
        { id: "earnings", label: "Earnings", icon: "payments" },
        { id: "profile", label: "Profile", icon: "account_circle" },
      ],
    };
  },
};
</script>

<style scoped>
/* Import Fonts */
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.app-container {
  font-family: "Work Sans", sans-serif;
  background-color: #f8f7f5;
  min-height: 100vh;
  padding-bottom: 80px; /* Space for bottom nav */
  color: #181411;
}

/* Header */
.header {
  position: sticky;
  top: 0;
  z-index: 50;
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
  padding: 12px 16px;
  border-bottom: 1px solid #f3f4f6;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.user-profile {
  display: flex;
  align-items: center;
  gap: 12px;
}

.profile-pic {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-size: cover;
  background-position: center;
  border: 2px solid #f5993d;
}

.greeting {
  font-size: 14px;
  font-weight: 400;
  color: #6b7280;
  margin: 0;
  line-height: 1;
}

.username {
  font-size: 18px;
  font-weight: 700;
  margin: 0;
  line-height: 1.25;
}

.icon-btn {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: #f3f4f6;
  border: none;
  cursor: pointer;
}

/* Section */
.section {
  padding: 16px;
}

.section-title {
  font-size: 18px;
  font-weight: 700;
  margin-bottom: 12px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.section-subtitle {
  font-size: 12px;
  font-weight: 400;
  color: #9ca3af;
  font-style: italic;
}

/* Status Bar */
.status-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
}

.status-badge {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 6px 12px;
  background-color: #dcfce7;
  border-radius: 9999px;
}

.status-dot {
  width: 8px;
  height: 8px;
  background-color: #22c55e;
  border-radius: 50%;
  /* Animation could be added here */
}

.status-text {
  font-size: 12px;
  font-weight: 700;
  color: #15803d;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.manage-btn {
  font-size: 12px;
  font-weight: 500;
  color: #f5993d;
  background: none;
  border: none;
  display: flex;
  align-items: center;
  gap: 4px;
  cursor: pointer;
}

/* Stats Cards */
.stats-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  margin-bottom: 8px;
}

.stat-card {
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.stat-card.primary {
  background-color: #f5993d;
  color: white;
}

.stat-card.secondary {
  background-color: white;
  border: 1px solid #f3f4f6;
}

.stat-label-light {
  font-size: 12px;
  font-weight: 500;
  opacity: 0.8;
  text-transform: uppercase;
  letter-spacing: 0.025em;
  margin-bottom: 4px;
}

.stat-label-dark {
  font-size: 12px;
  font-weight: 500;
  color: #6b7280;
  text-transform: uppercase;
  letter-spacing: 0.025em;
  margin-bottom: 4px;
}

.stat-value {
  font-size: 24px;
  font-weight: 700;
  margin-bottom: 8px;
}

.stat-value.text-primary {
  color: #f5993d;
}

.stat-trend {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  font-weight: 500;
  background-color: rgba(255, 255, 255, 0.2);
  width: fit-content;
  padding: 2px 8px;
  border-radius: 9999px;
}

.stat-subtext {
  font-size: 10px;
  color: #9ca3af;
  margin-top: 8px;
}

/* Schedule */
.calendar-strip {
  display: flex;
  justify-content: space-between;
  background-color: white;
  padding: 16px;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.calendar-day {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.day-name {
  font-size: 10px;
  font-weight: 700;
  text-transform: uppercase;
  color: #9ca3af;
}

.day-name.text-primary {
  color: #f5993d;
}

.day-number {
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  font-size: 14px;
  font-weight: 600;
  position: relative;
}

.day-number.active-number {
  background-color: #f5993d;
  color: white;
  border-color: #f5993d;
  box-shadow: 0 4px 6px -1px rgba(245, 153, 61, 0.3);
}

.event-dot {
  position: absolute;
  top: -4px;
  right: -4px;
  width: 8px;
  height: 8px;
  background-color: #f5993d;
  border-radius: 50%;
}

/* Requests */
.section-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
}

.see-all {
  font-size: 12px;
  color: #9ca3af;
  cursor: pointer;
}

.request-card {
  background-color: white;
  border-radius: 12px;
  border: 1px solid #f3f4f6;
  padding: 16px;
  margin-bottom: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.request-header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  margin-bottom: 12px;
}

.request-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.request-icon {
  width: 48px;
  height: 48px;
  border-radius: 8px;
  background-color: rgba(245, 153, 61, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #f5993d;
}

.request-title {
  font-size: 16px;
  font-weight: 700;
  line-height: 1.2;
  margin: 0;
}

.request-devotee {
  font-size: 14px;
  color: #6b7280;
  margin: 0;
}

.request-time {
  text-align: right;
}

.time-label {
  font-size: 14px;
  font-weight: 700;
  color: #374151;
  margin: 0;
}

.time-value {
  font-size: 12px;
  color: #9ca3af;
  margin: 0;
}

.location-badge {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 12px;
  color: #6b7280;
  background-color: #f8f7f5;
  padding: 8px;
  border-radius: 8px;
  margin-bottom: 16px;
}

.action-buttons {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.btn {
  padding: 10px 16px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  border: none;
  cursor: pointer;
}

.btn-primary {
  background-color: #f5993d;
  color: white;
}

.btn-secondary {
  background-color: #f3f4f6;
  color: #4b5563;
}

/* Highlights */
.highlights-scroll {
  display: flex;
  gap: 16px;
  overflow-x: auto;
  padding-bottom: 16px;
  scrollbar-width: none;
}

.highlights-scroll::-webkit-scrollbar {
  display: none;
}

.highlight-card {
  min-width: 200px;
  background-color: white;
  padding: 16px;
  border-radius: 12px;
  border: 1px solid #f3f4f6;
}

.highlight-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 8px;
}

.highlight-date {
  font-size: 10px;
  font-weight: 700;
  color: #9ca3af;
  text-transform: uppercase;
  letter-spacing: 0.1em;
}

.highlight-status {
  font-size: 12px;
  font-weight: 700;
  color: #22c55e;
}

.highlight-title {
  font-size: 14px;
  font-weight: 700;
  margin-bottom: 4px;
}

.highlight-location {
  font-size: 12px;
  color: #6b7280;
}

.highlight-amount {
  font-size: 18px;
  font-weight: 700;
  margin-top: 8px;
}

/* Bottom Nav */
.bottom-nav {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border-top: 1px solid #e5e7eb;
  padding: 8px 24px 24px 24px;
  display: flex;
  align-items: center;
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
  color: #9ca3af;
  cursor: pointer;
}

.nav-item.active {
  color: #f5993d;
}

.nav-label {
  font-size: 10px;
  font-weight: 500;
}

/* FAB */
.fab-container {
  position: fixed;
  bottom: 96px;
  right: 16px;
}

.fab {
  width: 56px;
  height: 56px;
  border-radius: 50%;
  background-color: #f5993d;
  color: white;
  border: none;
  box-shadow: 0 10px 15px -3px rgba(245, 153, 61, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: transform 0.2s;
}

.fab:active {
  transform: scale(0.95);
}

.icon-small {
  font-size: 16px !important;
}

.icon-large {
  font-size: 32px !important;
}

/* Utilities */
.mb-3 {
  margin-bottom: 12px;
}

.text-xs {
  font-size: 12px !important;
}

.font-variation-fill {
  font-variation-settings: 'FILL' 1;
}

/* Utility to hide scrollbar but allow scrolling */
.no-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
.no-scrollbar::-webkit-scrollbar {
  display: none;
}
</style>
