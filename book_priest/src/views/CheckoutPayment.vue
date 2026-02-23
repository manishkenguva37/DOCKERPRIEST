<template>
  <div class="page-container">
    <!-- Header -->
    <header class="header glass-effect">
      <button class="icon-btn hover-scale" @click="$router.back()">
        <span class="material-symbols-outlined">arrow_back_ios_new</span>
      </button>
      <h1 class="header-title gradient-text">Checkout</h1>
      <div class="w-10"></div>
    </header>

    <main class="main-content">
      <!-- Booking Summary -->
      <section class="section animate-fade-up">
        <h2 class="section-title">Booking Summary</h2>
        <AUCARD class="summary-card premium-shadow">
          <template #default>
            <div class="flex gap-4 mb-4">
              <div class="summary-img-container">
                <div class="summary-img" :style="summaryImage"></div>
              </div>
              <div class="flex-1">
                <h3 class="summary-title">{{ pujaTitle }}</h3>
                <p class="summary-date">Mon, 24 Oct &bull; 09:00 AM</p>
                <div class="summary-loc-badge">
                   <span class="material-symbols-outlined text-xs">home</span>
                   <span>Home Visit</span>
                </div>
              </div>
            </div>
            <div class="divider"></div>
            <div class="price-row font-semibold">
              <span class="text-muted">Priest</span>
              <span>{{ priestName }}</span>
            </div>
            <div class="divider"></div>
            <div class="price-breakdown">
              <div class="price-row">
                <span class="text-muted">Base Price</span>
                <span class="font-bold">₹{{ priestPrice }}</span>
              </div>
              <div class="price-row">
                <span class="text-muted">Samagri Kit</span>
                <span class="font-bold">₹500</span>
              </div>
              <div class="price-row">
                <span class="text-muted">Convenience Fee</span>
                <span class="font-bold">₹50</span>
              </div>
            </div>
            <div class="divider"></div>
            <div class="total-row animate-fade-up animate-delay-1">
              <span>Total Payable</span>
              <span class="total-amount">₹{{ totalPayable }}</span>
            </div>
          </template>
        </AUCARD>
      </section>

      <!-- Coupon -->
      <section class="section animate-fade-up animate-delay-2">
        <div class="coupon-container">
          <div class="coupon-dashed-border">
            <div class="coupon-input">
              <span class="material-symbols-outlined icon-coupon">local_offer</span>
              <input
                type="text"
                placeholder="Enter Coupon Code"
                class="coupon-field"
                v-model="couponCode"
              />
              <button class="apply-btn hover-scale" @click="applyCoupon">APPLY</button>
            </div>
          </div>
        </div>
        <div v-if="couponApplied" class="coupon-feedback success animate-fade-up">
          <span class="material-symbols-outlined">verified</span>
          <span>Coupon applied! You saved ₹100</span>
        </div>
        <div v-if="couponError" class="coupon-feedback error animate-fade-up">
          <span class="material-symbols-outlined">error</span>
          <span>Invalid coupon code.</span>
        </div>
      </section>

      <!-- Payment Method -->
      <section class="section pb-24 animate-fade-up animate-delay-3">
        <h2 class="section-title">Payment Method</h2>
        <div class="payment-options">
          <AUCARD
            class="payment-card premium-shadow"
            :class="{ active: selectedPayment === 'upi' }"
            no-padding
            @click="selectedPayment = 'upi'"
          >
            <template #default>
              <div class="payment-content">
                <div class="radio-outer" :class="{ selected: selectedPayment === 'upi' }">
                  <div v-if="selectedPayment === 'upi'" class="radio-inner"></div>
                </div>
                <div class="flex-1">
                  <div class="flex items-center gap-2">
                    <span class="material-symbols-outlined text-primary">contactless</span>
                    <span class="font-bold">UPI / Cards</span>
                  </div>
                  <p class="text-xs text-muted mt-1">Google Pay, PhonePe, Paytm, Cards</p>
                </div>
              </div>
            </template>
          </AUCARD>
          
          <AUCARD
            class="payment-card premium-shadow"
            :class="{ active: selectedPayment === 'cash' }"
            no-padding
            @click="selectedPayment = 'cash'"
          >
            <template #default>
              <div class="payment-content">
                <div class="radio-outer" :class="{ selected: selectedPayment === 'cash' }">
                  <div v-if="selectedPayment === 'cash'" class="radio-inner"></div>
                </div>
                <div class="flex-1">
                  <div class="flex items-center gap-2">
                    <span class="material-symbols-outlined text-muted">wallet</span>
                    <span class="font-bold">Pay After Service</span>
                  </div>
                  <p class="text-xs text-muted mt-1">Cash or Online after pujan</p>
                </div>
              </div>
            </template>
          </AUCARD>
        </div>
      </section>
    </main>

    <!-- Bottom Bar -->
    <div class="bottom-bar glass-effect">
      <div class="flex items-center justify-between gap-4">
        <div>
          <p class="price-bottom">₹{{ totalPayable }}</p>
          <p class="price-details-link">View Details</p>
        </div>
        <AUBUTTON label="Proceed to Pay" variant="primary" class="pay-btn hover-scale" @click="proceedToPay" />
      </div>
    </div>
  </div>
</template>

<script>
import AUBUTTON from "../../../artiqui/src/components/AUBUTTON.vue";
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";
import AUINPUT from "../../../artiqui/src/components/AUINPUT.vue";

export default {
  name: "CheckoutPayment",
  components: { AUBUTTON, AUCARD, AUINPUT },
  data() {
    return {
      selectedPayment: "upi",   // 'upi' | 'cash'
      couponCode: "",
      couponApplied: false,
      couponError: false,
    };
  },
  computed: {
    pujaTitle() {
      return this.$route.query.pujaTitle || "Ganesh Puja & Havan";
    },
    pujaImage() {
      return this.$route.query.pujaImage || "";
    },
    priestName() {
      return this.$route.query.priestName || "Pandit Rajesh Sharma";
    },
    priestPrice() {
      return this.$route.query.priestPrice || "2,100";
    },
    totalPayable() {
      const base = parseInt((this.$route.query.priestPrice || "2100").replace(/,/g, ""));
      const disc = this.couponApplied ? 100 : 0;
      return (base + 550 - disc).toLocaleString("en-IN");
    },
    summaryImage() {
      const img = this.$route.query.pujaImage;
      return img
        ? { backgroundImage: `url(${img})` }
        : { backgroundImage: "url('https://lh3.googleusercontent.com/aida-public/AB6AXuAKFd60kcp4bMlebY4X-OZL4ycI52rCGMCwKc-qOdZm1BAizA5FTMBxIXeOKMDlopoIfSUT3AuytcC4hymH5uVfJY8Som2VUMTRP6MdnVtz8h6c7YiGserqxglB-HluCjInMjfdmagXlEX4NzokyMum5pxjQs-liBzp_cBiyfb7tFtPnwRfi9ngAsAJwIP3kRJTyTPGO8YcHdiQmkTSY6nCjzghcphMCEOHPvYuRifxjnspgXj5UmIgWl-Mx6cWcQf5shtqMWLDv0P-')" };
    },
  },
  methods: {
    applyCoupon() {
      const valid = ["BLESS10", "PUJA100", "FIRST"];
      if (valid.includes(this.couponCode.trim().toUpperCase())) {
        this.couponApplied = true;
        this.couponError = false;
      } else {
        this.couponError = true;
        this.couponApplied = false;
      }
    },
    proceedToPay() {
      this.$router.push({
        name: "BookingConfirmed",
        query: {
          pujaTitle: this.pujaTitle,
          priestName: this.priestName,
          total: this.totalPayable,
          paymentMethod: this.selectedPayment,
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
  display: flex;
  align-items: center;
  justify-content: space-between;
  box-shadow: var(--shadow-sm);
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
  transition: var(--transition);
}

.hover-scale:active {
  transform: scale(0.95);
}

.w-10 { width: 44px; }

/* Content */
.main-content {
  padding: 24px 16px;
}

.section {
  margin-bottom: 32px;
}

.section-title {
  font-size: 17px;
  font-weight: 700;
  margin: 0 0 16px;
}

.summary-card {
  border: 1px solid rgba(0,0,0,0.03);
  background: white;
}

.summary-img-container {
  padding: 4px;
  background: var(--bg-main);
  border-radius: 12px;
}

.summary-img {
  width: 60px;
  height: 60px;
  border-radius: 10px;
  background-size: cover;
  background-position: center;
}

.summary-title {
  font-size: 16px;
  font-weight: 800;
  margin: 0 0 4px;
}

.summary-date {
  font-size: 12px;
  color: var(--text-muted);
  font-weight: 600;
  margin: 0 0 6px;
}

.summary-loc-badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  background: #EFF6FF;
  color: #2563EB;
  padding: 2px 8px;
  border-radius: 6px;
  font-size: 11px;
  font-weight: 700;
}

.divider {
  height: 1px;
  background-color: rgba(0,0,0,0.05);
  margin: 16px 0;
}

.text-muted { color: var(--text-muted); }

.price-row {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  margin-bottom: 10px;
}

.total-row {
  display: flex;
  justify-content: space-between;
  font-size: 17px;
  font-weight: 800;
  color: var(--text-main);
  padding-top: 4px;
}

.total-amount {
  color: var(--primary);
  font-size: 20px;
}

/* Coupon */
.coupon-container {
  background: white;
  padding: 4px;
  border-radius: 16px;
  box-shadow: var(--shadow-sm);
}

.coupon-dashed-border {
  border: 2px dashed #E5E7EB;
  border-radius: 14px;
  padding: 10px 14px;
}

.coupon-input {
  display: flex;
  align-items: center;
}

.icon-coupon {
  color: var(--primary);
  margin-right: 12px;
  font-size: 20px;
}

.coupon-field {
  flex: 1;
  border: none;
  outline: none;
  font-size: 14px;
  background: transparent;
  font-weight: 600;
  color: var(--text-main);
}

.apply-btn {
  color: var(--primary);
  font-weight: 800;
  font-size: 13px;
  background: none;
  border: none;
  cursor: pointer;
  letter-spacing: 0.5px;
}

.coupon-feedback {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 12px;
  font-size: 13px;
  font-weight: 700;
  padding: 10px 14px;
  border-radius: 12px;
}

.coupon-feedback.success {
  background: #F0FDF4;
  color: #16A34A;
}

.coupon-feedback.error {
  background: #FEF2F2;
  color: #DC2626;
}

/* Payment */
.payment-options {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.payment-card {
  border: 1px solid rgba(0,0,0,0.03);
  cursor: pointer;
}

.payment-card.active {
  border-color: var(--primary);
  background-color: rgba(255, 140, 0, 0.03);
}

.payment-content {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  padding: 20px;
}

.radio-outer {
  width: 22px;
  height: 22px;
  border-radius: 50%;
  border: 2px solid #D1D5DB;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 2px;
}

.radio-outer.selected {
  border-color: var(--primary);
}

.radio-inner {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background-color: var(--primary);
}

.text-primary { color: var(--primary); }

.pb-24 { padding-bottom: 120px; }

/* Bottom Bar */
.bottom-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 20px 24px 36px;
  border-top: 1px solid var(--glass-border);
  z-index: 50;
  display: flex;
  flex-direction: column;
}

.price-bottom {
  font-size: 24px;
  font-weight: 800;
  margin: 0;
  color: var(--text-main);
}

.price-details-link {
  font-size: 12px;
  color: var(--primary);
  font-weight: 700;
  cursor: pointer;
  margin: 2px 0 0;
}

.pay-btn {
  padding: 0 40px;
  height: 52px;
  border-radius: 16px;
  font-weight: 700;
}
</style>
