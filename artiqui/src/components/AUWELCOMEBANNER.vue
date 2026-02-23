<template>
  <div class="au-welcome-banner" :class="[`au-welcome-banner--${variant}`, { 'au-welcome-banner--disabled': disabled }]">
    <div class="au-welcome-banner__content">
      <div class="au-welcome-banner__text">
        <h1 class="au-welcome-banner__title">
          {{ bannerTitle.title }}
          <span class="au-welcome-banner__username">{{ userDetails.username }}</span>! 👋
        </h1>
        <p class="au-welcome-banner__subtitle">{{ bannerTitle.subtitle }}</p>
      </div>

      <div v-if="userDetails.userVerified" class="au-welcome-banner__badge">
        <span class="material-symbols-outlined badge-icon">verified</span>
        <span>Verified User</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AUWELCOMEBANNER",
  props: {
    userDetails: {
      type: Object,
      default: () => ({ username: "Guest", userVerified: false })
    },
    bannerTitle: {
      type: Object,
      default: () => ({ title: "Welcome back", subtitle: "Good to see you again!" })
    },
    variant: {
      type: String,
      default: "primary",
      validator: (val) => ["primary", "secondary", "outline"].includes(val)
    },
    disabled: {
      type: Boolean,
      default: false
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-welcome-banner {
  background-color: white;
  border-radius: 16px;
  padding: 32px;
  font-family: "Work Sans", sans-serif;
  border: 1px solid #f3f4f6;
  position: relative;
  overflow: hidden;
}

.au-welcome-banner--primary {
  background: linear-gradient(135deg, #fff7ed 0%, #fff 100%);
  border-color: #ffedd5;
}

.au-welcome-banner--secondary {
  background-color: #f3f4f6;
}

.au-welcome-banner--outline {
  border: 1px solid #d1d5db;
}

.au-welcome-banner__content {
  display: flex;
  flex-direction: column;
  gap: 16px;
  position: relative;
  z-index: 1;
}

@media (min-width: 768px) {
  .au-welcome-banner__content {
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
  }
}

.au-welcome-banner__title {
  font-size: 24px;
  font-weight: 700;
  color: #111827;
  margin: 0 0 8px;
}

.au-welcome-banner__username {
  color: #f5993d;
}

.au-welcome-banner__subtitle {
  font-size: 16px;
  color: #6b7280;
  margin: 0;
}

/* Badge */
.au-welcome-banner__badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 8px 16px;
  background-color: white;
  border-radius: 9999px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  font-size: 14px;
  font-weight: 600;
  color: #059669;
}

.badge-icon {
  font-size: 18px;
  color: #10b981;
}
</style>
