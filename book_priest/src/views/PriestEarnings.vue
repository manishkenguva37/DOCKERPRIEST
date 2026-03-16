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
            <h1 class="greeting">Earnings</h1>
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
      <!-- Total Balance Card -->
      <section class="section">
        <div class="balance-card">
          <div class="balance-header">
            <span class="balance-label">Total Balance</span>
            <button class="withdraw-btn">
              Withdraw
              <span class="material-symbols-outlined text-xs">arrow_forward</span>
            </button>
          </div>
          <div class="balance-amount">₹{{ earnings.totalBalance }}</div>
          <div class="balance-stats">
            <div class="balance-stat">
              <span class="stat-icon income">
                <span class="material-symbols-outlined">arrow_downward</span>
              </span>
              <div>
                <p class="stat-value">₹{{ earnings.thisMonth }}</p>
                <p class="stat-label">This Month</p>
              </div>
            </div>
            <div class="balance-stat">
              <span class="stat-icon pending">
                <span class="material-symbols-outlined">schedule</span>
              </span>
              <div>
                <p class="stat-value">₹{{ earnings.pending }}</p>
                <p class="stat-label">Pending</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Earnings Chart -->
      <section class="section">
        <div class="section-header">
          <h3 class="section-title">Earnings Overview</h3>
          <div class="period-selector">
            <button 
              v-for="period in periods" 
              :key="period.id"
              :class="['period-btn', { active: selectedPeriod === period.id }]"
              @click="selectedPeriod = period.id"
            >
              {{ period.label }}
            </button>
          </div>
        </div>
        <div class="chart-card">
          <div class="chart-container">
            <div 
              v-for="(bar, index) in chartData" 
              :key="index"
              class="chart-bar-wrapper"
            >
              <div class="chart-bar-track">
                <div 
                  class="chart-bar"
                  :style="{ height: bar.percentage + '%' }"
                ></div>
              </div>
              <span class="chart-label">{{ bar.label }}</span>
            </div>
          </div>
        </div>
      </section>

      <!-- Quick Stats -->
      <section class="section">
        <h3 class="section-title mb-3">Performance</h3>
        <div class="stats-grid">
          <div class="stat-box">
            <div class="stat-box-icon primary">
              <span class="material-symbols-outlined">calendar_today</span>
            </div>
            <div class="stat-box-content">
              <p class="stat-box-value">{{ stats.completedPujas }}</p>
              <p class="stat-box-label">Pujas Done</p>
            </div>
          </div>
          <div class="stat-box">
            <div class="stat-box-icon success">
              <span class="material-symbols-outlined">group</span>
            </div>
            <div class="stat-box-content">
              <p class="stat-box-value">{{ stats.happyDevotees }}</p>
              <p class="stat-box-label">Happy Devotees</p>
            </div>
          </div>
          <div class="stat-box">
            <div class="stat-box-icon warning">
              <span class="material-symbols-outlined">star</span>
            </div>
            <div class="stat-box-content">
              <p class="stat-box-value">{{ stats.rating }}</p>
              <p class="stat-box-label">Rating</p>
            </div>
          </div>
          <div class="stat-box">
            <div class="stat-box-icon info">
              <span class="material-symbols-outlined">trending_up</span>
            </div>
            <div class="stat-box-content">
              <p class="stat-box-value">+{{ stats.growth }}%</p>
              <p class="stat-box-label">Growth</p>
            </div>
          </div>
        </div>
      </section>

      <!-- Recent Transactions -->
      <section class="section">
        <div class="section-header">
          <h3 class="section-title">Recent Transactions</h3>
          <span class="see-all">View All</span>
        </div>
        <div class="transactions-list">
          <div 
            v-for="transaction in transactions" 
            :key="transaction.id"
            class="transaction-item"
          >
            <div class="transaction-icon" :class="transaction.type">
              <span class="material-symbols-outlined">{{ transaction.icon }}</span>
            </div>
            <div class="transaction-info">
              <h4 class="transaction-title">{{ transaction.title }}</h4>
              <p class="transaction-date">{{ transaction.date }}</p>
            </div>
            <div class="transaction-amount" :class="transaction.type">
              {{ transaction.type === 'credit' ? '+' : '-' }}₹{{ transaction.amount }}
            </div>
          </div>
        </div>
      </section>

      <!-- Upcoming Payouts -->
      <section class="section">
        <h3 class="section-title mb-3">Upcoming Payouts</h3>
        <AUCARD class="payout-card">
          <template #default>
            <div class="payout-item">
              <div class="payout-info">
                <span class="material-symbols-outlined payout-icon">account_balance</span>
                <div>
                  <p class="payout-title">Bank Transfer</p>
                  <p class="payout-account">**** 4521</p>
                </div>
              </div>
              <div class="payout-amount">₹{{ earnings.upcomingPayout }}</div>
            </div>
            <div class="payout-date">
              <span class="material-symbols-outlined text-xs">event</span>
              Expected by {{ earnings.payoutDate }}
            </div>
          </template>
        </AUCARD>
      </section>
    </main>

    <!-- Bottom Navigation Bar (iOS Style) -->
    <nav class="bottom-nav">
      <button
        v-for="item in navItems"
        :key="item.label"
        class="nav-item"
        :class="{ active: activeTab === item.id }"
        @click="navigateTo(item)"
      >
        <span
          class="material-symbols-outlined"
          :class="{ 'font-variation-fill': activeTab === item.id }"
          >{{ item.icon }}</span
        >
        <span class="nav-label">{{ item.label }}</span>
      </button>
    </nav>
  </div>
</template>

<script>
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";

export default {
  name: "PriestEarnings",
  components: {
    AUCARD,
  },
  data() {
    return {
      activeTab: "earnings",
      selectedPeriod: "week",
      user: {
        name: "Pandit Sharma Ji",
        profileImage:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuCJQQTuEBJK6ea4BCBKWf7kptOWNE7mqruhspOmuBmGxAerBQd0b7xMk3XJN1QVbvcCYaePdo51GsRU2qM5ld1Z3MkWbsn__TJXwdpuI19fBkzS5bJebTNRajhGNhNWNsH6DDqYEVHNO2PL-DGNq3vULinzL5UVHCJvf_B3NAj_5IN9dZQ2y0jvEKmaAt5fs1z_-iEUFDwEcJopXTH5NAEoTLLYKdebF9snhuYYrlHC251f42myiN9x8YuvYaHRxrG3wWRrvp6M-R2i",
      },
      earnings: {
        totalBalance: "24,580",
        thisMonth: "14,280",
        pending: "3,200",
        upcomingPayout: "8,500",
        payoutDate: "Nov 5, 2024",
      },
      periods: [
        { id: "week", label: "Week" },
        { id: "month", label: "Month" },
        { id: "year", label: "Year" },
      ],
      chartData: [
        { label: "Mon", percentage: 45 },
        { label: "Tue", percentage: 70 },
        { label: "Wed", percentage: 55 },
        { label: "Thu", percentage: 85 },
        { label: "Fri", percentage: 60 },
        { label: "Sat", percentage: 90 },
        { label: "Sun", percentage: 40 },
      ],
      stats: {
        completedPujas: 24,
        happyDevotees: 18,
        rating: "4.9",
        growth: 12.5,
      },
      transactions: [
        {
          id: 1,
          type: "credit",
          icon: "temple_hindu",
          title: "Satyanarayan Puja",
          date: "Today, 10:30 AM",
          amount: "2,500",
        },
        {
          id: 2,
          type: "credit",
          icon: "diversity_3",
          title: "Griha Pravesh",
          date: "Yesterday, 4:00 PM",
          amount: "5,500",
        },
        {
          id: 3,
          type: "debit",
          icon: "account_balance",
          title: "Withdrawal to Bank",
          date: "Oct 28, 2024",
          amount: "10,000",
        },
        {
          id: 4,
          type: "credit",
          icon: "child_care",
          title: "Naming Ceremony",
          date: "Oct 25, 2024",
          amount: "3,200",
        },
        {
          id: 5,
          type: "credit",
          icon: "temple_hindu",
          title: "Ganesh Puja",
          date: "Oct 22, 2024",
          amount: "1,800",
        },
      ],
      navItems: [
        { id: "home", label: "Home", icon: "grid_view", path: "/priest/dashboard" },
        { id: "calendar", label: "Calendar", icon: "calendar_month", path: "/priest/calendar" },
        { id: "earnings", label: "Earnings", icon: "payments", path: "/priest/earnings" },
        { id: "profile", label: "Profile", icon: "account_circle", path: "/priest/profile" },
      ],
    };
  },
  methods: {
    navigateTo(item) {
      this.activeTab = item.id;
      if (item.path && this.$route.path !== item.path) {
        this.$router.push(item.path);
      }
    },
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
  padding-bottom: 80px;
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
  margin: 0;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.section-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
}

.see-all {
  font-size: 12px;
  color: #f5993d;
  cursor: pointer;
  font-weight: 500;
}

.mb-3 {
  margin-bottom: 12px;
}

/* Balance Card */
.balance-card {
  background: linear-gradient(135deg, #f5993d 0%, #e0852c 100%);
  border-radius: 16px;
  padding: 24px;
  color: white;
  box-shadow: 0 10px 25px -5px rgba(245, 153, 61, 0.4);
}

.balance-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 8px;
}

.balance-label {
  font-size: 12px;
  font-weight: 500;
  opacity: 0.9;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.withdraw-btn {
  display: flex;
  align-items: center;
  gap: 4px;
  background: rgba(255, 255, 255, 0.2);
  border: none;
  color: white;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.2s;
}

.withdraw-btn:hover {
  background: rgba(255, 255, 255, 0.3);
}

.balance-amount {
  font-size: 36px;
  font-weight: 700;
  margin-bottom: 20px;
}

.balance-stats {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  padding-top: 16px;
  border-top: 1px solid rgba(255, 255, 255, 0.2);
}

.balance-stat {
  display: flex;
  align-items: center;
  gap: 12px;
}

.stat-icon {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.2);
}

.stat-icon.income {
  background: rgba(34, 197, 94, 0.2);
}

.stat-icon.pending {
  background: rgba(251, 191, 36, 0.2);
}

.stat-icon .material-symbols-outlined {
  font-size: 20px;
}

.stat-value {
  font-size: 16px;
  font-weight: 700;
  margin: 0;
  line-height: 1.2;
}

.stat-label {
  font-size: 11px;
  opacity: 0.8;
  margin: 0;
}

/* Period Selector */
.period-selector {
  display: flex;
  gap: 8px;
  background: #f3f4f6;
  padding: 4px;
  border-radius: 8px;
}

.period-btn {
  padding: 6px 12px;
  border-radius: 6px;
  border: none;
  background: transparent;
  font-size: 12px;
  font-weight: 600;
  color: #6b7280;
  cursor: pointer;
  transition: all 0.2s;
}

.period-btn.active {
  background: white;
  color: #f5993d;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* Chart */
.chart-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.chart-container {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  height: 150px;
  gap: 12px;
}

.chart-bar-wrapper {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.chart-bar-track {
  width: 100%;
  height: 120px;
  background: #f3f4f6;
  border-radius: 8px;
  position: relative;
  overflow: hidden;
}

.chart-bar {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(180deg, #f5993d 0%, #e0852c 100%);
  border-radius: 8px;
  transition: height 0.5s ease;
}

.chart-label {
  font-size: 11px;
  font-weight: 600;
  color: #9ca3af;
}

/* Stats Grid */
.stats-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.stat-box {
  background: white;
  border-radius: 12px;
  padding: 16px;
  display: flex;
  align-items: center;
  gap: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.stat-box-icon {
  width: 44px;
  height: 44px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.stat-box-icon.primary {
  background: rgba(245, 153, 61, 0.1);
  color: #f5993d;
}

.stat-box-icon.success {
  background: rgba(34, 197, 94, 0.1);
  color: #22c55e;
}

.stat-box-icon.warning {
  background: rgba(251, 191, 36, 0.1);
  color: #f59e0b;
}

.stat-box-icon.info {
  background: rgba(59, 130, 246, 0.1);
  color: #3b82f6;
}

.stat-box-icon .material-symbols-outlined {
  font-size: 22px;
}

.stat-box-content {
  flex: 1;
}

.stat-box-value {
  font-size: 18px;
  font-weight: 700;
  margin: 0;
  line-height: 1.2;
}

.stat-box-label {
  font-size: 11px;
  color: #9ca3af;
  margin: 0;
}

/* Transactions */
.transactions-list {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  overflow: hidden;
}

.transaction-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px;
  border-bottom: 1px solid #f3f4f6;
}

.transaction-item:last-child {
  border-bottom: none;
}

.transaction-icon {
  width: 44px;
  height: 44px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.transaction-icon.credit {
  background: rgba(34, 197, 94, 0.1);
  color: #22c55e;
}

.transaction-icon.debit {
  background: rgba(239, 68, 68, 0.1);
  color: #ef4444;
}

.transaction-icon .material-symbols-outlined {
  font-size: 22px;
}

.transaction-info {
  flex: 1;
}

.transaction-title {
  font-size: 14px;
  font-weight: 600;
  margin: 0 0 4px 0;
}

.transaction-date {
  font-size: 11px;
  color: #9ca3af;
  margin: 0;
}

.transaction-amount {
  font-size: 14px;
  font-weight: 700;
}

.transaction-amount.credit {
  color: #22c55e;
}

.transaction-amount.debit {
  color: #ef4444;
}

/* Payout Card */
.payout-card {
  background: white;
  border-radius: 12px;
  padding: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.payout-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
}

.payout-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.payout-icon {
  width: 44px;
  height: 44px;
  border-radius: 10px;
  background: rgba(245, 153, 61, 0.1);
  color: #f5993d;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22px;
}

.payout-title {
  font-size: 14px;
  font-weight: 600;
  margin: 0 0 4px 0;
}

.payout-account {
  font-size: 12px;
  color: #9ca3af;
  margin: 0;
}

.payout-amount {
  font-size: 18px;
  font-weight: 700;
  color: #f5993d;
}

.payout-date {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: #6b7280;
  padding-top: 12px;
  border-top: 1px solid #f3f4f6;
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

.font-variation-fill {
  font-variation-settings: 'FILL' 1;
}

/* Utilities */
.text-xs {
  font-size: 12px !important;
}
</style>
