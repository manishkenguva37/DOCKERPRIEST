<template>
  <div class="au-verification-card">
    <div v-if="CLABEl" class="au-verification-card__header">
      <div class="au-verification-card__title">
        <span class="material-symbols-outlined icon-shield">verified_user</span>
        {{ CLABEl }}
      </div>
    </div>

    <div class="au-verification-card__body">
      <div class="au-progress-section">
        <div class="au-progress-labels">
          <span class="progress-label">{{ CPROLABEL || "Overall Progress" }}</span>
          <span class="progress-value">{{ Math.round(verificationProgress) }}%</span>
        </div>

        <div class="au-progress-track">
          <div
            class="au-progress-fill"
            :style="{ width: verificationProgress + '%' }"
            :class="getProgressColorClass"
          ></div>
        </div>
      </div>

      <ul class="au-verification-list">
        <li
          v-for="(item, index) in verificationLabels"
          :key="index"
          class="au-verification-item"
        >
          <div class="au-verification-item__left">
            <span
              class="material-symbols-outlined item-icon"
              :class="item.isVerified ? 'item-icon--verified' : 'item-icon--pending'"
            >
              {{ item.isVerified ? "check_circle" : "error" }}
            </span>
            <span class="item-label">{{ item.label }}</span>
          </div>
          <span
            class="au-status-badge"
            :class="item.isVerified ? 'au-status-badge--verified' : 'au-status-badge--pending'"
          >
            {{ item.isVerified ? "Verified" : "Pending" }}
          </span>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: "AUSTUSINDI",
  props: {
    CLABEl: { type: String, default: "" },
    CPROLABEL: { type: String, default: "" },
    verificationLabels: { type: Array, required: true }
  },
  computed: {
    verificationProgress() {
      if (!this.verificationLabels || this.verificationLabels.length === 0) return 0;
      const total = this.verificationLabels.length;
      const verified = this.verificationLabels.filter((label) => label.isVerified).length;
      return (verified / total) * 100;
    },
    getProgressColorClass() {
      if (this.verificationProgress === 100) return "bg-success";
      if (this.verificationProgress > 50) return "bg-primary";
      return "bg-warning";
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-verification-card {
  background-color: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  font-family: "Work Sans", sans-serif;
  border: 1px solid #f3f4f6;
}

.au-verification-card__header {
  margin-bottom: 20px;
  border-bottom: 1px solid #f3f4f6;
  padding-bottom: 12px;
}

.au-verification-card__title {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 18px;
  font-weight: 700;
  color: #111827;
}

.icon-shield {
  color: #f5993d;
  font-size: 24px;
}

/* Progress */
.au-progress-section {
  margin-bottom: 24px;
}

.au-progress-labels {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
  font-size: 14px;
  font-weight: 500;
  color: #4b5563;
}

.progress-value {
  font-weight: 700;
  color: #111827;
}

.au-progress-track {
  width: 100%;
  height: 8px;
  background-color: #f3f4f6;
  border-radius: 9999px;
  overflow: hidden;
}

.au-progress-fill {
  height: 100%;
  transition: width 0.5s ease;
  border-radius: 9999px;
}

.bg-success { background-color: #10b981; }
.bg-primary { background-color: #f5993d; }
.bg-warning { background-color: #f59e0b; }

/* List */
.au-verification-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.au-verification-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px;
  background-color: #f9fafb;
  border-radius: 8px;
  transition: background-color 0.2s;
}

.au-verification-item:hover {
  background-color: #f3f4f6;
}

.au-verification-item__left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.item-icon {
  font-size: 20px;
}

.item-icon--verified { color: #10b981; }
.item-icon--pending { color: #f59e0b; }

.item-label {
  font-size: 14px;
  color: #374151;
  font-weight: 500;
}

/* Badge */
.au-status-badge {
  font-size: 12px;
  font-weight: 600;
  padding: 2px 8px;
  border-radius: 12px;
  text-transform: uppercase;
}

.au-status-badge--verified {
  background-color: #ecfdf5;
  color: #065f46;
}

.au-status-badge--pending {
  background-color: #fffbeb;
  color: #92400e;
}
</style>
