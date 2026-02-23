<template>
  <div class="home-container">
    <!-- Top Navigation -->
    <nav class="top-nav">
      <div class="nav-left">
        <div class="user-avatar-container">
          <img
            class="user-avatar"
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuD0gaUTGoFNf2rBy7zvzJNIt8tzWp6LXxj-VgTI_6LdIkKQneWFLXX5xR1ay68ignj38ZfRoCMYvKjmriygCNe2CMDACVeD2dCgV8gSgfxbQ7TMjeBKDila7UFqXgoeS9giAGd4A5adYwpW5R9OjIw1DWRiZKrEhBT1Vedzbo0ZmwP44pbCvzFtk3sVQEJYn5uKQ54aFXK0RRB11HWSMcjuDU4QtdxiHh2pZ30YSwzzMZNUFTyS_tC6LsmkLWwp_RiodqXXfd0fnhVZ"
            alt="User profile"
          />
        </div>
        <div class="location-info">
          <span class="location-label">Your Location</span>
          <div class="location-value">
            <span class="material-symbols-outlined icon-primary"
              >location_on</span
            >
            <h2 class="location-text">Bangalore, KA</h2>
          </div>
        </div>
      </div>
      <button class="notification-btn">
        <span class="material-symbols-outlined">notifications</span>
      </button>
    </nav>

    <!-- Hero & Search -->
    <div class="hero-section">
      <div class="hero-pattern"></div>
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">
            Seek Divine <br /><span class="text-primary">Blessings Today</span>
          </h1>
          <p class="hero-subtitle">Verified Vedic Pandits for all rituals</p>
        </div>
        <!-- Search Bar -->
        <div class="search-container">
          <div class="search-bar">
            <div class="search-icon">
              <span class="material-symbols-outlined">search</span>
            </div>
            <input
              class="search-input"
              placeholder="Search for Pujas, Priests, or Rituals"
            />
            <button class="search-btn">Find</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Popular Pujas -->
    <div class="pujas-section">
      <div class="section-header">
        <h2 class="section-title">Popular Pujas</h2>
        <button class="see-all-btn" @click="$router.push('/pujas')">See All</button>
      </div>
      <div class="pujas-scroll no-scrollbar">
        <AUCARD
          v-for="puja in popularPujas"
          :key="puja.id"
          class="puja-card"
        >
          <template #default>
            <div class="card-image-container">
              <img class="card-image" :src="puja.image" :alt="puja.title" />
              <div class="rating-badge">
                <span class="material-symbols-outlined icon-star">star</span>
                <span class="rating-value">{{ puja.rating }}</span>
              </div>
            </div>
            <div class="card-content">
              <h3 class="card-title">{{ puja.title }}</h3>
              <div class="card-meta">
                <span class="material-symbols-outlined icon-meta">schedule</span>
                <span class="meta-text">{{ puja.duration }}</span>
              </div>
              <div class="card-footer">
                <p class="price">{{ puja.price }}</p>
                <AUBUTTON
                  variant="primary"
                  label="Book"
                  size="small"
                  @click="bookPuja(puja)"
                />
              </div>
            </div>
          </template>
        </AUCARD>
      </div>
    </div>

    <!-- Festival Special Banner -->
    <div class="banner-section">
      <div class="special-banner">
        <div class="banner-bg">
            <span class="material-symbols-outlined banner-icon">celebration</span>
        </div>
        <div class="banner-content">
          <span class="banner-tag">Upcoming: Diwali</span>
          <h3 class="banner-title">Lakshmi Puja Specials</h3>
          <p class="banner-desc">
            Limited slots available for Diwali rituals. Book your divine blessing
            now.
          </p>
          <AUBUTTON
            label="View Details"
            class="banner-btn"
            @click="$router.push('/festival-special')"
          />
        </div>
      </div>
    </div>

    <!-- How It Works -->
    <div class="how-it-works-section">
      <h2 class="section-title mb-6">How it Works</h2>
      <div class="steps-container">
        <!-- Step 1 -->
        <div class="step-item">
          <div class="step-icon">
            <span class="material-symbols-outlined icon-primary"
              >auto_awesome</span
            >
          </div>
          <div class="step-content">
            <h4 class="step-title">Choose Your Ritual</h4>
            <p class="step-desc">Select from 100+ different pujas and rituals.</p>
          </div>
        </div>
        <!-- Step 2 -->
        <div class="step-item">
          <div class="step-icon">
            <span class="material-symbols-outlined icon-primary"
              >person_search</span
            >
          </div>
          <div class="step-content">
            <h4 class="step-title">Select a Verified Priest</h4>
            <p class="step-desc">Browse profiles, ratings, and experience.</p>
          </div>
        </div>
        <!-- Step 3 -->
        <div class="step-item">
          <div class="step-icon">
            <span class="material-symbols-outlined icon-primary"
              >calendar_check</span
            >
          </div>
          <div class="step-content">
            <h4 class="step-title">Book & Celebrate</h4>
            <p class="step-desc">Confirm slot and complete the ceremony.</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Bottom Navigation (iOS Style) -->
    <div class="bottom-nav-container">
      <div class="bottom-nav">
        <div class="nav-item active" @click="$router.push('/')">
            <span class="material-symbols-outlined nav-icon icon-fill">home</span>
            <span class="nav-label">Home</span>
        </div>
        <div class="nav-item" @click="$router.push('/dashboard')">
            <span class="material-symbols-outlined nav-icon">book_online</span>
            <span class="nav-label">Bookings</span>
        </div>
        <div class="nav-item" @click="$router.push('/pujas')">
            <span class="material-symbols-outlined nav-icon">temple_hindu</span>
            <span class="nav-label">Rituals</span>
        </div>
        <div class="nav-item" @click="$router.push('/dashboard')">
            <span class="material-symbols-outlined nav-icon">person</span>
            <span class="nav-label">Profile</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import AUBUTTON from "../../../artiqui/src/components/AUBUTTON.vue";
import AUCARD from "../../../artiqui/src/components/AUCARD.vue";

export default {
  name: "SpiritualPlatformHome",
  components: { AUBUTTON, AUCARD },
  data() {
    return {
      popularPujas: [
        {
          id: 1,
          title: "Griha Pravesh",
          duration: "3-4 Hours",
          price: "₹5,100",
          rating: 4.9,
          image: "https://lh3.googleusercontent.com/aida-public/AB6AXuCVSBCJBZNxuDNMBLRMq3LxiYvUlrZJKUhmzVy1f-eWJKixz0tFfPlqbOBKaLhaAkaIS-LTUPwQytysgbC1oya2W_eDbZ5r4dPFGtOwKIUwQY-pTMLz-lOMM69sQbfF4-Yvd31YW-St0XORtkgBHlW2-O9-aL1UMrdrc5V7uoAfygsZ9VbI-5woSHXhln3xOJyXnsAEd-O8idR_jQyAvE_CFn4BXXHKN-hp9FxV1NZaG3gxzr9lYducrGgfvOp5WKpfZ9fy2zcZhbDC"
        },
        {
          id: 2,
          title: "Satyanarayana Puja",
          duration: "2-3 Hours",
          price: "₹3,100",
          rating: 4.8,
          image: "https://lh3.googleusercontent.com/aida-public/AB6AXuBVDXdJUqXj8WTolIoR7i2rhoDTrj4BRtmcCN79Gmw2vuOoo5d6enZXkkM4P_JvA0cMwvyscX1a4FjWt5-9olR0Qd4w-B_kJYkkmG3Mp4slpsQq5rU1gVXvoz0ziLZhnOR24DgS5tINTPTXLMZknksjQ4frtXkFr7rhUKj7hj0fIs9Xn5fHRIUVz181B4IJYuh-z9Vwsn_AhqbClHdBkFbjp1xGnwD4uq4fmJHvazlN4ux7hho3ZVy7ZoNKOPd60uAZztJBoVp92nmG"
        },
      ],
    };
  },
  methods: {
    bookPuja(puja) {
      this.$router.push({
        name: "PujaDetails",
        params: { id: puja.id },
        query: { title: puja.title, image: puja.image, price: puja.price, duration: puja.duration }
      });
    },
  },
};
</script>

<style scoped>
/* ── fonts now loaded globally via index.html ── */

.home-container {
  font-family: "Work Sans", sans-serif;
  background-color: #f8f7f5;
  min-height: 100vh;
  padding-bottom: 96px;
  color: #181411;
  width: 100%;
  max-width: 480px;
  margin: 0 auto;
  background-color: white;
  position: relative;
  overflow-x: hidden;
}

/* ─── Tablet (≥576px) ────────────────────────── */
@media (min-width: 576px) {
  .home-container {
    max-width: 640px;
    box-shadow: 0 0 40px rgba(0,0,0,0.07);
  }
}

/* ─── Desktop (≥992px) ───────────────────────── */
@media (min-width: 992px) {
  .home-container {
    max-width: 1140px;
    padding-bottom: 40px; /* no bottom nav on desktop */
  }

  .top-nav {
    padding: 0 48px !important;
    height: 72px !important;
  }

  .hero-section {
    padding: 48px 48px 32px !important;
  }

  .hero-title {
    font-size: 48px !important;
  }

  .hero-content {
    flex-direction: row !important;
    align-items: center;
    justify-content: space-between;
  }

  .search-container {
    max-width: 480px;
  }

  /* Cards become a wrapping grid */
  .pujas-scroll {
    overflow-x: visible !important;
    flex-wrap: wrap !important;
  }

  .puja-card {
    min-width: 260px;
    flex: 1 1 calc(33.33% - 16px);
    max-width: calc(33.33% - 16px);
    scroll-snap-align: none;
  }

  /* Steps go horizontal */
  .steps-container {
    flex-direction: row !important;
    justify-content: space-between;
  }

  .step-item {
    flex-direction: column !important;
    align-items: center;
    text-align: center;
    flex: 1;
  }

  /* Section paddings */
  .pujas-section,
  .banner-section,
  .how-it-works-section {
    padding-left: 48px !important;
    padding-right: 48px !important;
  }
  .section-header {
    padding-left: 0 !important;
    padding-right: 0 !important;
  }
  .pujas-scroll {
    padding-left: 0 !important;
    padding-right: 0 !important;
  }

  /* Hide mobile bottom nav */
  .bottom-nav-container {
    display: none !important;
  }
}

/* Top Nav */
.top-nav {
  position: sticky;
  top: 0;
  z-index: 50;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background-color: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(12px);
  padding: 16px;
  padding-bottom: 8px;
  border-bottom: 1px solid #e6e0db;
}

.nav-left {
    display: flex;
    align-items: center;
    gap: 12px;
}

.user-avatar-container {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    border: 2px solid #f5993d;
}

.user-avatar {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.location-info {
    display: flex;
    flex-direction: column;
}

.location-label {
    font-size: 10px;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    font-weight: 700;
    color: #8a7560;
}

.location-value {
    display: flex;
    align-items: center;
    gap: 4px;
}

.icon-primary {
    color: #f5993d;
    font-size: 14px;
}

.location-text {
    font-size: 14px;
    font-weight: 700;
    line-height: 1.25;
    color: #181411;
    margin: 0;
}

.notification-btn {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    background-color: #f8f7f5;
    border: none;
    color: #181411;
}

/* Hero */
.hero-section {
    position: relative;
    padding: 24px 16px 16px;
    overflow: hidden;
}

.hero-pattern {
    position: absolute;
    inset: 0;
    pointer-events: none;
    background-color: #ffffff;
    background-image: radial-gradient(#f5993d 0.5px, transparent 0.5px), radial-gradient(#f5993d 0.5px, #ffffff 0.5px);
    background-size: 20px 20px;
    background-position: 0 0,10px 10px;
    opacity: 0.05;
}

.hero-content {
    position: relative;
    z-index: 10;
    display: flex;
    flex-direction: column;
    gap: 24px;
}

.hero-text {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.hero-title {
    font-size: 30px;
    font-weight: 900;
    line-height: 1.1;
    letter-spacing: -0.02em;
    color: #181411;
    margin: 0;
}

.text-primary {
    color: #f5993d;
}

.hero-subtitle {
    font-size: 14px;
    color: #8a7560;
    margin: 0;
}

.search-container {
    display: flex;
    flex-direction: column;
    width: 100%;
}

.search-bar {
    display: flex;
    align-items: center;
    background-color: white;
    border-radius: 12px;
    border: 1px solid #e6e0db;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    height: 56px;
    overflow: hidden;
}

.search-icon {
    padding-left: 16px;
    color: #8a7560;
    display: flex;
    align-items: center;
}

.search-input {
    flex: 1;
    background: transparent;
    border: none;
    font-size: 14px;
    padding: 16px 12px;
    outline: none;
}

.search-btn {
    margin-right: 8px;
    background-color: #f5993d;
    color: white;
    font-weight: 700;
    font-size: 12px;
    padding: 8px 16px;
    border-radius: 8px;
    border: none;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    cursor: pointer;
}

/* Pujas */
.pujas-section {
    padding: 24px 0;
}

.section-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 16px 16px;
}

.section-title {
    font-size: 20px;
    font-weight: 700;
    color: #181411;
    margin: 0;
}

.see-all-btn {
    color: #f5993d;
    font-size: 14px;
    font-weight: 600;
    background: none;
    border: none;
    cursor: pointer;
}

.pujas-scroll {
    display: flex;
    gap: 16px;
    overflow-x: auto;
    padding: 0 16px;
    scroll-snap-type: x mandatory;
}

.puja-card {
    scroll-snap-align: start;
    display: flex;
    flex-direction: column;
    min-width: 260px;
    background-color: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    border: 1px solid #e6e0db;
}

.card-image-container {
    height: 160px;
    width: 100%;
    position: relative;
}

.card-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.rating-badge {
    position: absolute;
    top: 8px;
    right: 8px;
    background-color: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(4px);
    padding: 4px 8px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    gap: 4px;
}

.icon-star {
    font-size: 14px;
    color: #f5993d;
    font-variation-settings: 'FILL' 1;
}

.rating-value {
    font-size: 11px;
    font-weight: 700;
}

.card-content {
    padding: 12px;
}

.card-title {
    font-size: 16px;
    font-weight: 700;
    margin: 0 0 4px;
    color: #181411;
}

.card-meta {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 12px;
}

.icon-meta {
    font-size: 12px;
    color: #8a7560;
}

.meta-text {
    font-size: 12px;
    color: #8a7560;
}

.card-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.price {
    font-size: 18px;
    font-weight: 700;
    color: #f5993d;
    margin: 0;
}

.book-btn {
    background-color: rgba(245, 153, 61, 0.1);
    color: #f5993d;
    padding: 4px 12px;
    border-radius: 9999px;
    font-size: 12px;
    font-weight: 700;
    border: 1px solid rgba(245, 153, 61, 0.2);
    cursor: pointer;
}

/* Banner */
.banner-section {
    padding: 16px;
}

.special-banner {
    position: relative;
    width: 100%;
    border-radius: 16px;
    overflow: hidden;
    background: linear-gradient(to right, #b45309, #f5993d);
    padding: 24px;
    color: white;
}

.banner-bg {
    position: absolute;
    top: 0;
    right: 0;
    padding: 8px;
    opacity: 0.2;
    transform: translate(25%, -25%);
}

.banner-icon {
    font-size: 120px;
}

.banner-content {
    position: relative;
    z-index: 10;
}

.banner-tag {
    display: inline-block;
    background-color: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(4px);
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 10px;
    font-weight: 900;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    margin-bottom: 8px;
}

.banner-title {
    font-size: 24px;
    font-weight: 900;
    margin: 0 0 8px;
}

.banner-desc {
    font-size: 12px;
    opacity: 0.9;
    margin: 0 0 16px;
    max-width: 200px;
}

.banner-btn {
    background-color: white;
    color: #f5993d;
    font-weight: 700;
    font-size: 14px;
    padding: 10px 20px;
    border-radius: 12px;
    border: none;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
    cursor: pointer;
}

/* How It Works */
.how-it-works-section {
    padding: 32px 16px;
}

.mb-6 {
    margin-bottom: 24px;
}

.steps-container {
    display: flex;
    flex-direction: column;
    gap: 24px;
}

.step-item {
    display: flex;
    align-items: center;
    gap: 16px;
}

.step-icon {
    flex-shrink: 0;
    width: 48px;
    height: 48px;
    border-radius: 12px;
    background-color: rgba(245, 153, 61, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid rgba(245, 153, 61, 0.2);
}

.step-content {
    display: flex;
    flex-direction: column;
}

.step-title {
    font-size: 14px;
    font-weight: 700;
    margin: 0;
}

.step-desc {
    font-size: 12px;
    color: #8a7560;
    margin: 0;
}

/* Bottom Nav */
.bottom-nav-container {
    position: fixed;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 100%;
    max-width: 480px;
    height: 80px;
    background-color: rgba(255, 255, 255, 0.8);
    backdrop-filter: blur(20px);
    border-top: 1px solid #e6e0db;
    padding: 0 24px 8px;
    box-shadow: 0 -1px 10px rgba(0,0,0,0.05);
    z-index: 50;
}

.bottom-nav {
    display: flex;
    height: 100%;
    align-items: center;
    justify-content: space-between;
}

.nav-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 4px;
    color: #8a7560;
    cursor: pointer;
}

.nav-item.active {
    color: #f5993d;
}

.nav-icon {
    font-size: 28px;
}

.icon-fill {
    font-variation-settings: 'FILL' 1;
}

.nav-label {
    font-size: 10px;
    font-weight: 700;
}

.no-scrollbar::-webkit-scrollbar {
    display: none;
}
.no-scrollbar {
    -ms-overflow-style: none;
    scrollbar-width: none;
}
</style>
