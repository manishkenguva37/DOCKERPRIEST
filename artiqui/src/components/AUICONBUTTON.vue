<template>
  <button
    class="au-icon-btn"
    :class="[
      `au-icon-btn--${variant}`,
      `au-icon-btn--${size}`,
      { 'au-icon-btn--disabled': disabled, 'au-icon-btn--loading': loading }
    ]"
    :disabled="disabled || loading"
    @click="$emit('click', $event)"
  >
    <div v-if="loading" class="au-spinner"></div>
    <span v-else class="material-symbols-outlined icon-display">{{ icon }}</span>
  </button>
</template>

<script>
export default {
  name: "AUICONBUTTON",
  props: {
    icon: {
      type: String,
      required: true
    },
    variant: {
      type: String,
      default: "primary", // primary, secondary, outline, ghost
      validator: (val) => ["primary", "secondary", "outline", "ghost", "white"].includes(val)
    },
    size: {
      type: String, // small, medium, large
      default: "medium",
      validator: (val) => ["small", "medium", "large"].includes(val)
    },
    disabled: {
      type: Boolean,
      default: false
    },
    loading: {
      type: Boolean,
      default: false
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-icon-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  border: none;
  cursor: pointer;
  transition: all 0.2s ease;
  flex-shrink: 0;
  padding: 0;
}

.au-icon-btn--disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.icon-display {
  font-size: inherit;
  font-weight: normal;
}

/* Sizes */
.au-icon-btn--small {
  width: 32px;
  height: 32px;
  font-size: 16px;
}
.au-icon-btn--medium {
  width: 40px;
  height: 40px;
  font-size: 20px;
}
.au-icon-btn--large {
  width: 48px;
  height: 48px;
  font-size: 24px;
}

/* Variants */
.au-icon-btn--primary {
  background-color: #f5993d;
  color: white;
}
.au-icon-btn--primary:hover:not(:disabled) {
  background-color: #e08b34;
}

.au-icon-btn--secondary {
  background-color: rgba(245, 153, 61, 0.1);
  color: #f5993d;
}
.au-icon-btn--secondary:hover:not(:disabled) {
  background-color: rgba(245, 153, 61, 0.2);
}

.au-icon-btn--white {
  background-color: white;
  color: #181411;
  border: 1px solid #e5e7eb;
}
.au-icon-btn--white:hover:not(:disabled) {
  background-color: #f9fafb;
}

.au-icon-btn--outline {
  background-color: transparent;
  border: 1px solid #d1d5db;
  color: #4b5563;
}
.au-icon-btn--outline:hover:not(:disabled) {
  border-color: #9ca3af;
  color: #111827;
}

.au-icon-btn--ghost {
  background-color: transparent;
  color: #4b5563;
}
.au-icon-btn--ghost:hover:not(:disabled) {
  background-color: rgba(0, 0, 0, 0.05);
  color: #111827;
}

/* Spinner */
.au-spinner {
  width: 1em;
  height: 1em;
  border: 2px solid currentColor;
  border-right-color: transparent;
  border-radius: 50%;
  animation: spin 0.75s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
</style>
