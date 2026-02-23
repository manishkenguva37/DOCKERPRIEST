<template>
  <div class="au-stats-card">
    <div class="au-stats-card__content">
      <div class="au-stats-card__icon-wrapper" :class="[`au-stats-card__icon--${iconStyle}`]">
        <span class="material-symbols-outlined au-stats-card__icon">{{ icon }}</span>
      </div>
      <div class="au-stats-card__info">
        <div v-if="value" class="au-stats-card__value">{{ value }}</div>
        <div v-if="label" class="au-stats-card__label">{{ label }}</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AUSTATSCARD",
  props: {
    icon: {
      type: String,
      required: true
    },
    label: {
      type: String,
      default: ""
    },
    value: {
      type: [String, Number],
      default: ""
    },
    iconStyle: {
      type: String,
      default: "default",
      validator: (value) => ["default", "solid", "light", "dark", "primary", "success", "warning", "danger"].includes(value)
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-stats-card {
  background-color: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  font-family: "Work Sans", sans-serif;
  border: 1px solid #f3f4f6;
}

.au-stats-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
}

.au-stats-card__content {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  gap: 16px;
}

.au-stats-card__icon-wrapper {
  width: 56px;
  height: 56px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.au-stats-card__icon {
  font-size: 28px;
}

/* Icon Styles */
.au-stats-card__icon--default,
.au-stats-card__icon--light {
  background-color: #f3f4f6;
  color: #4b5563;
}

.au-stats-card__icon--solid,
.au-stats-card__icon--dark {
  background-color: #1f2937;
  color: white;
}

.au-stats-card__icon--primary {
  background-color: rgba(245, 153, 61, 0.1);
  color: #f5993d;
}

.au-stats-card__icon--success {
  background-color: #ecfdf5;
  color: #10b981;
}

.au-stats-card__icon--warning {
  background-color: #fffbeb;
  color: #f59e0b;
}

.au-stats-card__icon--danger {
  background-color: #fef2f2;
  color: #ef4444;
}

.au-stats-card__info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.au-stats-card__value {
  font-size: 24px;
  font-weight: 700;
  color: #111827;
  line-height: 1.2;
}

.au-stats-card__label {
  font-size: 14px;
  font-weight: 500;
  color: #6b7280;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}
</style>
