<template>
  <div class="details-container">
    <!-- Header -->
    <header class="header" :style="headerStyle">
      <div class="header-overlay"></div>
      <div class="header-content animate-fade-up">
        <div class="header-top">
          <button class="icon-btn-white hover-scale" @click="$router.back()">
            <span class="material-symbols-outlined">arrow_back_ios</span>
          </button>
          <div class="flex gap-4">
            <button class="icon-btn-white hover-scale">
              <span class="material-symbols-outlined">share</span>
            </button>
            <button class="icon-btn-white hover-scale">
              <span class="material-symbols-outlined">favorite_border</span>
            </button>
          </div>
        </div>
      </div>
    </header>

    <main class="main-content">
      <!-- Title Section -->
      <div class="title-section animate-fade-up animate-delay-1">
        <AUBADGE variant="primary" label="Bestseller" size="small" pill class="mb-3" />
        <h1 class="title-text gradient-text">{{ pujaTitle }}</h1>
        <div class="flex items-center gap-4 text-sm text-gray-500 mt-2">
          <div class="flex items-center gap-1">
             <span class="material-symbols-outlined text-sm text-primary">schedule</span>
             <span>{{ pujaDuration }}</span>
          </div>
          <div class="flex items-center gap-1">
             <span class="material-symbols-outlined text-sm text-primary">group</span>
             <span>1-5 People</span>
          </div>
        </div>
      </div>

      <!-- Description -->
      <section class="section animate-fade-up animate-delay-2">
        <p class="description-text">
          Perform this auspicious puja to invoke Lord Ganesha's blessings for new beginnings, removal of obstacles, and prosperity in your home or office.
        </p>
        <button class="read-more-btn">Read more</button>
      </section>

      <!-- Benefits -->
      <section class="section animate-fade-up animate-delay-2">
        <h3 class="section-title">Key Benefits</h3>
        <div class="grid grid-cols-2 gap-4">
          <div class="benefit-item premium-shadow">
            <span class="material-symbols-outlined text-primary mb-2">check_circle</span>
            <p class="benefit-text">Removes Obstacles</p>
          </div>
          <div class="benefit-item premium-shadow">
            <span class="material-symbols-outlined text-primary mb-2">check_circle</span>
            <p class="benefit-text">Brings Prosperity</p>
          </div>
          <div class="benefit-item premium-shadow">
            <span class="material-symbols-outlined text-primary mb-2">check_circle</span>
            <p class="benefit-text">Peace of Mind</p>
          </div>
          <div class="benefit-item premium-shadow">
            <span class="material-symbols-outlined text-primary mb-2">check_circle</span>
            <p class="benefit-text">Positive Energy</p>
          </div>
        </div>
      </section>

      <!-- What's Included -->
      <section class="section animate-fade-up animate-delay-3">
        <h3 class="section-title">What's Included</h3>
        <AUCARD variant="flat" class="included-card premium-shadow">
          <template #default>
            <ul class="list-none p-0 m-0 space-y-4">
              <li class="flex items-center gap-4">
                <div class="icon-circle">
                  <span class="material-symbols-outlined text-primary">person</span>
                </div>
                <span class="text-sm font-semibold">Certified Vedic Priest</span>
              </li>
              <li class="flex items-center gap-4">
                <div class="icon-circle">
                  <span class="material-symbols-outlined text-primary">inventory_2</span>
                </div>
                <span class="text-sm font-semibold">Complete Puja Samagri</span>
              </li>
              <li class="flex items-center gap-4">
                <div class="icon-circle">
                  <span class="material-symbols-outlined text-primary">local_florist</span>
                </div>
                <span class="text-sm font-semibold">Flowers & Fruits</span>
              </li>
            </ul>
          </template>
        </AUCARD>
      </section>

      <!-- Select Date & Time -->
      <section class="section mb-24 animate-fade-up animate-delay-3">
         <h3 class="section-title">Select Date &amp; Time</h3>
         
         <!-- Date Horizontal Scroll -->
         <div class="dates-scroll no-scrollbar mb-6">
           <div
             v-for="day in upcomingDates"
             :key="day.iso"
             class="date-card premium-shadow hover-scale"
             :class="{ active: selectedDate === day.iso }"
             @click="selectedDate = day.iso"
           >
             <p class="date-day">{{ day.dow }}</p>
             <p class="date-num">{{ day.num }}</p>
             <p class="date-month">{{ day.month }}</p>
           </div>
         </div>

         <!-- Time Slots -->
         <div class="grid grid-cols-3 gap-3">
            <button
              v-for="slot in timeSlots"
              :key="slot"
              class="time-slot hover-scale"
              :class="{ active: selectedTime === slot }"
              @click="selectedTime = slot"
            >{{ slot }}</button>
         </div>

         <!-- Selection feedback -->
         <div v-if="selectedDate && selectedTime" class="selection-info premium-shadow animate-fade-up">
           <span class="material-symbols-outlined">event_available</span>
           <span>Booked for {{ formatSelectedDate }} at {{ selectedTime }}</span>
         </div>
      </section>
    </main>

    <!-- Bottom Action -->
    <div class="bottom-action glass-effect">
      <div class="flex items-center justify-between gap-4">
        <div>
          <p class="price-total">{{ pujaPrice }}</p>
          <p class="price-sub">Total Amount</p>
        </div>
        <AUBUTTON
          label="Proceed to Book"
          variant="primary"
          class="book-btn hover-scale"
          @click="proceedToBook"
        />
      </div>
    </div>
  </div>
</template>

<script>
import AUBUTTON from "../../../artiqui/src/components/AUBUTTON.vue";
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";
import AUBADGE from "../../../artiqui/src/components/AUBADGE.vue";

const DAYS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

export default {
  name: "PujaDetails",
  components: { AUBUTTON, AUCARD, AUBADGE },
  data() {
    // Build next 7 days dynamically from today
    const dates = [];
    const today = new Date();
    for (let i = 0; i < 7; i++) {
      const d = new Date(today);
      d.setDate(today.getDate() + i);
      dates.push({
        iso: d.toISOString().slice(0, 10),
        dow: DAYS[d.getDay()],
        num: d.getDate(),
        month: MONTHS[d.getMonth()],
      });
    }
    return {
      upcomingDates: dates,
      selectedDate: dates[0].iso,   // default = today
      timeSlots: ["09:00 AM", "11:30 AM", "04:00 PM", "06:30 PM", "08:00 PM", "10:00 AM"],
      selectedTime: "09:00 AM",     // default = first slot
      showFullDesc: false,
    };
  },
  computed: {
    pujaTitle() {
      return this.$route.query.title || "Ganesh Puja & Havan";
    },
    pujaDuration() {
      return this.$route.query.duration || "90 Mins";
    },
    pujaPrice() {
      return this.$route.query.price || "₹2,100";
    },
    pujaImage() {
      return this.$route.query.image || "";
    },
    headerStyle() {
      const img = this.$route.query.image;
      return img ? { backgroundImage: `url(${img})` } : {};
    },
    formatSelectedDate() {
      if (!this.selectedDate) return "";
      const d = new Date(this.selectedDate);
      return `${DAYS[d.getDay()]}, ${d.getDate()} ${MONTHS[d.getMonth()]}`;
    },
  },
  methods: {
    proceedToBook() {
      if (!this.selectedDate || !this.selectedTime) {
        alert("Please select a date and time slot.");
        return;
      }
      this.$router.push({
        name: "SelectPriest",
        query: {
          title: this.pujaTitle,
          image: this.pujaImage,
          price: this.pujaPrice,
          date: this.formatSelectedDate,
          time: this.selectedTime,
        },
      });
    },
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.details-container {
  font-family: "Work Sans", sans-serif;
  background-color: var(--bg-main);
  min-height: 100vh;
  color: var(--text-main);
  padding-bottom: 24px;
}

/* Header */
.header {
  position: relative;
  height: 280px;
  background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAKFd60kcp4bMlebY4X-OZL4ycI52rCGMCwKc-qOdZm1BAizA5FTMBxIXeOKMDlopoIfSUT3AuytcC4hymH5uVfJY8Som2VUMTRP6MdnVtz8h6c7YiGserqxglB-HluCjInMjfdmagXlEX4NzokyMum5pxjQs-liBzp_cBiyfb7tFtPnwRfi9ngAsAJwIP3kRJTyTPGO8YcHdiQmkTSY6nCjzghcphMCEOHPvYuRifxjnspgXj5UmIgWl-Mx6cWcQf5shtqMWLDv0P-');
  background-size: cover;
  background-position: center;
  transition: var(--transition);
}

.header-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to bottom, rgba(0,0,0,0.5), transparent 60%);
}

.header-content {
  position: relative;
  z-index: 10;
  padding: 16px;
}

.icon-btn-white {
  width: 44px;
  height: 44px;
  border-radius: 14px;
  background-color: rgba(255, 255, 255, 0.25);
  backdrop-filter: blur(8px);
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid rgba(255, 255, 255, 0.3);
  color: white;
  cursor: pointer;
  transition: var(--transition);
}

.hover-scale:active {
  transform: scale(0.95);
}

/* Content */
.main-content {
  background-color: var(--bg-main);
  border-radius: 32px 32px 0 0;
  margin-top: -32px;
  position: relative;
  z-index: 20;
  padding: 32px 20px;
  min-height: 500px;
  box-shadow: 0 -10px 30px rgba(0,0,0,0.05);
}

.title-text {
  font-size: 28px;
  font-weight: 800;
  margin: 0;
  color: var(--text-main);
}

.gradient-text {
  background: linear-gradient(135deg, var(--primary), #FF4500);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.section {
  margin-top: 32px;
}

.section-title {
  font-size: 19px;
  font-weight: 700;
  margin: 0 0 16px;
  color: var(--text-main);
}

.description-text {
  font-size: 15px;
  line-height: 1.6;
  color: var(--text-muted);
  margin: 0 0 12px;
}

.read-more-btn {
  color: var(--primary);
  font-weight: 700;
  font-size: 14px;
  background: none;
  border: none;
  padding: 0;
  cursor: pointer;
}

/* Benefits */
.benefit-item {
  background-color: white;
  padding: 16px;
  border-radius: 16px;
  display: flex;
  flex-direction: column;
  border: 1px solid rgba(0,0,0,0.03);
}

.benefit-text {
  font-size: 14px;
  font-weight: 700;
  margin: 0;
}

/* Included */
.included-card {
  padding: 4px;
}

.icon-circle {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: var(--bg-main);
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Dates */
.dates-scroll {
  display: flex;
  gap: 12px;
  overflow-x: auto;
  padding: 4px 0;
}

.date-card {
  min-width: 72px;
  height: 88px;
  background: white;
  border: 1px solid rgba(0,0,0,0.05);
  border-radius: 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.date-card.active {
  background: var(--primary);
  color: white;
  border-color: var(--primary);
  box-shadow: 0 8px 16px rgba(255, 140, 0, 0.3);
}

.date-day { font-size: 12px; margin: 0; opacity: 0.8; font-weight: 600; }
.date-num { font-size: 22px; font-weight: 800; margin: 2px 0; }
.date-month { font-size: 10px; margin: 0; text-transform: uppercase; font-weight: 800; letter-spacing: 0.5px; }

/* Time Slots */
.time-slot {
  height: 48px;
  border: 1px solid rgba(0,0,0,0.05);
  border-radius: 12px;
  background: white;
  font-size: 14px;
  font-weight: 700;
  cursor: pointer;
  box-shadow: var(--shadow-sm);
  transition: var(--transition);
}

.time-slot.active {
  background-color: rgba(255, 140, 0, 0.1);
  color: var(--primary);
  border-color: var(--primary);
}

/* Selection feedback */
.selection-info {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-top: 20px;
  font-size: 14px;
  font-weight: 700;
  color: var(--primary);
  background: white;
  border-radius: 14px;
  padding: 12px 16px;
  border-left: 4px solid var(--primary);
}

.mb-24 { margin-bottom: 120px; }

/* Bottom Action */
.bottom-action {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 20px 24px 36px;
  border-top: 1px solid var(--glass-border);
  z-index: 50;
}

.price-total {
  font-size: 24px;
  font-weight: 800;
  margin: 0;
  color: var(--text-main);
}

.price-sub {
  font-size: 12px;
  color: var(--text-muted);
  font-weight: 600;
  margin: 2px 0 0;
}

.book-btn {
  padding: 0 32px;
  height: 52px;
  border-radius: 16px;
  font-weight: 700;
}
</style>
