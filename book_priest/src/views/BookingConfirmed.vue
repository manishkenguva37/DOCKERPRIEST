<template>
  <div class="confirmed-container">
    <main class="main-content">
      <!-- Success Animation Area -->
      <div class="success-area">
        <div class="success-icon-bg">
          <span class="material-symbols-outlined success-icon">check_circle</span>
        </div>
        <h1 class="success-title">Booking Confirmed!</h1>
        <p class="success-msg">Your puja has been successfully booked.</p>
        <p class="order-id">Order ID: #BP-84920</p>
      </div>

      <!-- Booking Details Card -->
      <div class="section">
        <AUCARD class="booking-card">
          <template #default>
            <div class="card-content">
              <div class="detail-row">
                 <div class="label-col">
                   <p class="label">Puja</p>
                   <p class="value">{{ pujaTitle }}</p>
                 </div>
                 <div class="text-right">
                   <p class="label">Date &amp; Time</p>
                   <p class="value">24 Oct &bull; 09:00 AM</p>
                 </div>
              </div>
              
              <div class="divider"></div>

              <div class="priest-row">
                <div class="priest-info">
                  <p class="label">Priest</p>
                  <p class="value">{{ priestName }}</p>
                  <p class="sub-text">Vedic Acharya &bull; Varanasi</p>
                </div>
                <div class="priest-img" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAU-ACNNVD6_1b6jCPYMO2W4ydeN_dwCJw_hk_BNDDZFFd_vfRavveDz8WMGOvHHmQ6DhUNbQOL7BsMsejAuulNAxtNKoxreEYq6NVfXqjSN3v5JDq5qaAWs_FZNQsDs6snJHBes1meVMFAmzcp9l3AI-npwFOcqI9jWwin00_UyRnIKo_hKFu1-JGWHiT07-JJ_wyiZas__wKxn9oNt1eu251UdmKj1j_7cG7nAHqDwKVWARkUWZirTXZAXk7Ol3mXD9R4BDKdOCWn')"></div>
              </div>
            </div>
          </template>
        </AUCARD>
      </div>

      <!-- Action Buttons -->
      <div class="actions-area">
        <div class="grid grid-cols-2 gap-3 mb-4">
           <AUBUTTON variant="secondary" label="Call Priest" icon="call" />
           <AUBUTTON variant="secondary" label="Get Directions" icon="directions" />
        </div>
        <AUBUTTON variant="outline" label="Download Receipt" icon="download" class="w-full mb-3" />
        <AUBUTTON variant="primary" label="Go to Dashboard" class="w-full home-btn" @click="$router.push('/dashboard')" />
      </div>
      
      <!-- Safe Banner -->
      <div class="safe-banner">
        <span class="material-symbols-outlined icon-shield">verified_user</span>
        <p class="safe-text">100% Secure & Verified Booking</p>
      </div>
    </main>
  </div>
</template>

<script>
import AUBUTTON from "../../../artiqui/src/components/AUBUTTON.vue";
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";

export default {
  name: "BookingConfirmed",
  components: { AUBUTTON, AUCARD },
  computed: {
    pujaTitle() {
      return this.$route.query.pujaTitle || "Satyanarayan Katha";
    },
    priestName() {
      return this.$route.query.priestName || "Pandit Rajesh Sharma";
    },
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.confirmed-container {
  font-family: "Work Sans", sans-serif;
  background-color: #f8f7f5;
  min-height: 100vh;
  color: #181411;
  display: flex;
  flex-direction: column;
}

.main-content {
  flex: 1;
  padding: 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* Success Area */
.success-area {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  margin-top: 32px;
  margin-bottom: 40px;
}

.success-icon-bg {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background-color: #e8f5e9;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 16px;
  animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.success-icon {
  font-size: 48px;
  color: #2e7d32;
}

.success-title {
  font-size: 24px;
  font-weight: 700;
  margin: 0 0 8px;
  color: #181411;
}

.success-msg {
  font-size: 16px;
  color: #4b5563;
  margin: 0 0 4px;
}

.order-id {
  font-size: 14px;
  color: #9ca3af;
  font-weight: 600;
  margin: 0;
}

@keyframes popIn {
  from { transform: scale(0); opacity: 0; }
  to { transform: scale(1); opacity: 1; }
}

/* Section */
.section {
  width: 100%;
  margin-bottom: 32px;
}

.booking-card {
  width: 100%;
}

.card-content {
  padding: 20px;
}

.detail-row {
  display: flex;
  justify-content: space-between;
}

.label {
  font-size: 12px;
  color: #8a7560;
  margin: 0 0 4px;
  text-transform: uppercase;
  font-weight: 600;
  letter-spacing: 0.05em;
}

.value {
  font-size: 16px;
  font-weight: 700;
  color: #181411;
  margin: 0;
}

.text-right {
  text-align: right;
}

.divider {
  height: 1px;
  background-color: #f3f4f6;
  margin: 16px 0;
}

.priest-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.sub-text {
  font-size: 12px;
  color: #6b7280;
  margin: 2px 0 0;
}

.priest-img {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background-size: cover;
  background-position: center;
  border: 1px solid #e5e7eb;
}

/* Actions */
.actions-area {
  width: 100%;
  margin-top: auto;
}

.grid {
  display: grid;
}

.grid-cols-2 {
  grid-template-columns: 1fr 1fr;
}

.gap-3 {
  gap: 12px;
}

.mb-4 { margin-bottom: 16px; }
.mb-3 { margin-bottom: 12px; }

.w-full { width: 100%; }

.home-btn {
  height: 48px;
  font-size: 16px !important;
}

/* Safe Banner */
.safe-banner {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  margin-top: 24px;
  color: #6b7280;
}

.icon-shield {
  font-size: 16px;
  color: #2e7d32;
}

.safe-text {
  font-size: 12px;
  font-weight: 500;
  margin: 0;
}
</style>
