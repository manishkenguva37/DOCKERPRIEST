<template>
  <div class="festival-container">
    <!-- Header -->
    <header class="header">
       <div class="header-overlay"></div>
       <div class="header-content">
          <div class="header-top">
            <button class="icon-btn-white">
              <span class="material-symbols-outlined">arrow_back_ios_new</span>
            </button>
            <button class="icon-btn-white">
              <span class="material-symbols-outlined">share</span>
            </button>
          </div>
          <div class="header-hero">
            <AUBADGE variant="warning" size="small" pill class="mb-2">UPCOMING</AUBADGE>
            <h1 class="hero-title">Diwali Mahotsav</h1>
            <p class="hero-subtitle">Celebrate the festival of lights with divine blessings.</p>
            
            <div class="countdown-row">
               <div class="countdown-box">
                 <span class="cd-num">02</span>
                 <span class="cd-label">Days</span>
               </div>
               <span class="cd-sep">:</span>
               <div class="countdown-box">
                 <span class="cd-num">14</span>
                 <span class="cd-label">Hrs</span>
               </div>
               <span class="cd-sep">:</span>
               <div class="countdown-box">
                 <span class="cd-num">35</span>
                 <span class="cd-label">Mins</span>
               </div>
            </div>
          </div>
       </div>
    </header>

    <main class="main-content">
      <!-- Special Pujas -->
      <section class="section">
        <h2 class="section-title">Special Rituals</h2>
        <div class="puja-list">
          <AUCARD class="mb-3" v-for="puja in specialPujas" :key="puja.title" no-padding>
             <template #default>
               <div class="puja-row">
                 <div class="puja-bg" :style="{ backgroundImage: `url(${puja.image})` }">
                    <div class="price-badge">₹{{ puja.price }}</div>
                 </div>
                 <div class="puja-info">
                   <h3 class="puja-title">{{ puja.title }}</h3>
                   <div class="meta-row">
                     <span class="material-symbols-outlined text-xs">schedule</span>
                     <span>{{ puja.duration }}</span>
                   </div>
                   <p class="desc">{{ puja.desc }}</p>
                   <AUBUTTON label="Book Now" size="small" variant="primary" class="w-full mt-2" />
                 </div>
               </div>
             </template>
          </AUCARD>
        </div>
      </section>

      <!-- Community Events -->
      <section class="section">
        <h2 class="section-title">Community Events</h2>
        <div class="horizontal-scroll no-scrollbar">
           <AUCARD class="event-card mr-3" no-padding>
              <template #default>
                <div class="event-img" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCg_bZfifsYg9FTPU5lxKO3vCfypWs1g-rliNrx4DpiuBvRhDsGVbFm7U_IgMV6c7jrUP_KALhslHPvQhL2rarbuCuFgkY6qEMdC1vsdPeBBj7-lJbIX0tFAlEXTK4z79us4B-8Rbj1DHQ9XOmU6w4Z2POPo9M2juMBSSu0BdfDET3l3HVGCmZiZMul1ANihWSK8fI75rzYorYK8TJmiPWc0BS5UZ9-3ZLBzJ5k52XHtZnIHEkCWva0RejZK8QyNbUq1O-ASECzSRth')"></div>
                <div class="event-content">
                  <p class="event-date">Oct 24 • 6 PM</p>
                  <h3 class="event-title">Grand Maha Aarti</h3>
                  <div class="flex items-center gap-1 mt-1 text-gray-500">
                    <span class="material-symbols-outlined text-xs">location_on</span>
                    <span class="text-xs">Prem Mandir</span>
                  </div>
                  <AUBUTTON label="Join for Free" size="small" variant="outline" class="mt-3 w-full" />
                </div>
              </template>
           </AUCARD>
           <AUCARD class="event-card mr-3" no-padding>
              <template #default>
                <div class="event-img" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDNN78n48aGhFSyq8xjyB9CSGjOss8wfcOW_O_op0V8sj63UpVkRLcbVod6ZmaU6G6W78VFsXO4jFqfmZ2kcxTqaeysuz0C94Uh7zGPBjFgkgGI-WGbAy78J0zHbA1CxqoKR8dn6lQfLKxic-M8R5-JfthXHlzMJvcADjUCQ8oJHorMrgJPtPWb5VPSHxXl0Dw0mQqS0l0A8fnr3c3sAuVlsah-S8HTIVr3eIV17Jn64rYtrqi_p5-3XkUsxhzgscejQNpa_VRtADO5')"></div>
                <div class="event-content">
                  <p class="event-date">Oct 25 • 10 AM</p>
                  <h3 class="event-title">Community Havan</h3>
                  <div class="flex items-center gap-1 mt-1 text-gray-500">
                    <span class="material-symbols-outlined text-xs">location_on</span>
                    <span class="text-xs">City Center</span>
                  </div>
                  <AUBUTTON label="Register" size="small" variant="outline" class="mt-3 w-full" />
                </div>
              </template>
           </AUCARD>
        </div>
      </section>

      <!-- Featured Priests -->
      <section class="section pb-8">
        <h2 class="section-title">Specialist Priests</h2>
        <div class="priests-grid">
           <div class="priest-col">
              <div class="priest-av" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAU-ACNNVD6_1b6jCPYMO2W4ydeN_dwCJw_hk_BNDDZFFd_vfRavveDz8WMGOvHHmQ6DhUNbQOL7BsMsejAuulNAxtNKoxreEYq6NVfXqjSN3v5JDq5qaAWs_FZNQsDs6snJHBes1meVMFAmzcp9l3AI-npwFOcqI9jWwin00_UyRnIKo_hKFu1-JGWHiT07-JJ_wyiZas__wKxn9oNt1eu251UdmKj1j_7cG7nAHqDwKVWARkUWZirTXZAXk7Ol3mXD9R4BDKdOCWn')"></div>
              <p class="p-name">Pt. Rajesh</p>
           </div>
           <div class="priest-col">
              <div class="priest-av" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCtRH3SP0IgggNlSheWKMLy0ZgpTU90fhX_RLX2TKHsw3vQJXEl7rRq-hPPtmIjtAz-3lRRk9ytiVmf_T-dIwKRw_DfP55jdLIMvDxtH7MH0qRgS-MaVgSRwnB9dhxVAb4ui9pglOXEFIj0_CBgsiL5-kyYAbNY-wyV79cgFUnJSfQfilw2JHPKo1H_gyj-18X2HSEX8HdIQjDBJ0G14y4CsN3G5V5dQKZLN-X6VrDT3awSfcVLMmCqnYBgfZmF9FFAf9x-yQdHbJ3n')"></div>
              <p class="p-name">Ach. Anil</p>
           </div>
           <div class="priest-col">
              <div class="priest-av" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCN15_oP07n6yFj1CxyxN8P0O0l6rA4tqLzGv3e8pM2kJO7wXo6hR4u9iV5yT0lq3nB1aW4dE5fG6hK7j8mL9n0oP1qR2s3tU4vW5xY6z7A8bC9dE0f1g2h3i4jK5lM6n7oP8qR9s0tU1v2w3xY4z5A6bC7dE8f9g0h1i2jK3lM4n5oP6qR7s8tU9v0w1x2y3z4A5b6c7d8e9f0g1h2i3j4k5l6m7n8o9p0q1r2s3t4u5v6w7x8y9z0A1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6')"></div>
              <p class="p-name">Sh. Vikram</p>
           </div>
           <div class="priest-col">
              <div class="priest-av bg-gray-200 flex items-center justify-center">
                <span class="material-symbols-outlined">arrow_forward</span>
              </div>
              <p class="p-name">View All</p>
           </div>
        </div>
      </section>
    </main>
  </div>
</template>

<script>
import AUBUTTON from "../../../artiqui/src/components/AUBUTTON.vue";
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";
import AUBADGE from "../../../artiqui/src/components/AUBADGE.vue";

export default {
  name: "FestivalSpecial",
  components: {
    AUBUTTON,
    AUCARD,
    AUBADGE
  },
  data() {
    return {
      specialPujas: [
        {
          title: "Lakshmi Kubera Homam",
          duration: "2-3 Hours",
          price: "5,100",
          desc: "For wealth, prosperity and rapid financial growth.",
          image: "https://lh3.googleusercontent.com/aida-public/AB6AXuCg_bZfifsYg9FTPU5lxKO3vCfypWs1g-rliNrx4DpiuBvRhDsGVbFm7U_IgMV6c7jrUP_KALhslHPvQhL2rarbuCuFgkY6qEMdC1vsdPeBBj7-lJbIX0tFAlEXTK4z79us4B-8Rbj1DHQ9XOmU6w4Z2POPo9M2juMBSSu0BdfDET3l3HVGCmZiZMul1ANihWSK8fI75rzYorYK8TJmiPWc0BS5UZ9-3ZLBzJ5k52XHtZnIHEkCWva0RejZK8QyNbUq1O-ASECzSRth"
        },
        {
          title: "Diwali Special Puja",
          duration: "1.5 Hours",
          price: "2,500",
          desc: "Complete ritual for home and family well-being.",
          image: "https://lh3.googleusercontent.com/aida-public/AB6AXuANvZVHFh8PM5ihuAH5nS6oPDQvQNlV8mLMm1hxjHLy71-1V68tmolMQ6sMGAsQGqy8uNVheYOYmaFrBNH6sFTiBOmG2WXgnwMd_-MeBpvvci0au5xiG3fYry95__H01lgIkMMYcyY79wKu8zkuq4p6azrgO8OVt6thY0pH4bu944ov1S739NCeh1b-JtlrtG4am1HNVwiSlMKTUucKxNzKXgATlUqRRjPpfCB3wOVy2a4ylm1lkT2nY_V0wH-yHsYfOyQCfWabajZ5"
        }
      ]
    };
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.festival-container {
  font-family: "Work Sans", sans-serif;
  background-color: #f8f7f5;
  min-height: 100vh;
  color: #181411;
}

/* Header */
.header {
  position: relative;
  height: 380px;
  background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuANvZVHFh8PM5ihuAH5nS6oPDQvQNlV8mLMm1hxjHLy71-1V68tmolMQ6sMGAsQGqy8uNVheYOYmaFrBNH6sFTiBOmG2WXgnwMd_-MeBpvvci0au5xiG3fYry95__H01lgIkMMYcyY79wKu8zkuq4p6azrgO8OVt6thY0pH4bu944ov1S739NCeh1b-JtlrtG4am1HNVwiSlMKTUucKxNzKXgATlUqRRjPpfCB3wOVy2a4ylm1lkT2nY_V0wH-yHsYfOyQCfWabajZ5');
  background-size: cover;
  background-position: center;
}

.header-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to bottom, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0.8) 100%);
}

.header-content {
  position: relative;
  z-index: 10;
  padding: 16px;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.header-top {
  display: flex;
  justify-content: space-between;
}

.icon-btn-white {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(4px);
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  cursor: pointer;
}

.header-hero {
  margin-top: auto;
  padding-bottom: 32px;
}

.hero-title {
  color: white;
  font-size: 32px;
  font-weight: 700;
  margin: 0;
  line-height: 1.1;
}

.hero-subtitle {
  color: rgba(255, 255, 255, 0.9);
  margin: 8px 0 24px;
  font-size: 14px;
}

/* Countdown */
.countdown-row {
  display: flex;
  align-items: center;
  gap: 12px;
}

.countdown-box {
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 8px;
  padding: 8px 12px;
  text-align: center;
  min-width: 60px;
}

.cd-num {
  display: block;
  font-size: 20px;
  font-weight: 700;
  color: white;
  line-height: 1;
}

.cd-label {
  font-size: 10px;
  color: rgba(255, 255, 255, 0.8);
  text-transform: uppercase;
}

.cd-sep {
  color: white;
  font-weight: 700;
  font-size: 20px;
  margin-top: -16px;
}

/* Main */
.main-content {
  background-color: #f8f7f5;
  border-radius: 24px 24px 0 0;
  margin-top: -24px;
  position: relative;
  z-index: 20;
  padding: 24px 16px;
}

.section {
  margin-bottom: 32px;
}

.section-title {
  font-size: 18px;
  font-weight: 700;
  margin: 0 0 16px;
}

.mb-3 { margin-bottom: 12px; }
.mr-3 { margin-right: 12px; }
.mb-2 { margin-bottom: 8px; }

/* Puja Row */
.puja-row {
  display: flex;
  gap: 12px;
  align-items: center;
}

.puja-bg {
  width: 100px;
  height: 100px;
  background-size: cover;
  background-position: center;
  border-radius: 8px;
  position: relative;
  flex-shrink: 0;
}

.price-badge {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: rgba(0, 0, 0, 0.6);
  color: white;
  font-size: 10px;
  font-weight: 700;
  text-align: center;
  padding: 4px;
  border-radius: 0 0 8px 8px;
}

.puja-info {
  flex: 1;
}

.puja-title {
  font-size: 16px;
  font-weight: 700;
  margin: 0 0 4px;
}

.meta-row {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  color: #6b7280;
  margin-bottom: 6px;
}

.desc {
  font-size: 12px;
  color: #4b5563;
  margin: 0 0 8px;
  line-height: 1.4;
}

.w-full { width: 100%; }

/* Events */
.horizontal-scroll {
  display: flex;
  overflow-x: auto;
  padding-bottom: 8px;
}

.event-card {
  min-width: 240px;
  width: 240px;
}

.event-img {
  height: 120px;
  background-size: cover;
  background-position: center;
}

.event-content {
  padding: 12px;
}

.event-date {
  font-size: 10px;
  color: #f5993d;
  font-weight: 700;
  text-transform: uppercase;
  margin: 0 0 4px;
}

.event-title {
  font-size: 16px;
  font-weight: 700;
  margin: 0;
}

.text-xs { font-size: 12px; }

/* Priests */
.priests-grid {
  display: flex;
  gap: 16px;
}

.priest-col {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.priest-av {
  width: 64px;
  height: 64px;
  border-radius: 50%;
  background-size: cover;
  background-position: center;
  border: 1px solid #e6e0db;
}

.p-name {
  font-size: 12px;
  font-weight: 500;
  margin: 0;
}

.no-scrollbar::-webkit-scrollbar { display: none; }
.no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
</style>
