<template>
  <button
    :class="[
      'au-button',
      `au-button--${variant}`,
      `au-button--${size}`,
      {
        'au-button--block': block,
        'au-button--disabled': disabled,
        'au-button--loading': loading,
        'au-button--icon-only': !label && ($slots.default && !$slots.default.length) && icon
      }
    ]"
    :disabled="disabled"
    @click="$emit('click', $event)"
    :style="customStyle"
  >
    <span v-if="loading" class="au-button__spinner"></span>
    
    <span v-if="icon && iconPosition === 'left' && !loading" :class="['material-symbols-outlined', 'au-icon', 'au-icon--left']">{{ icon }}</span>
    
    <span v-if="label" class="au-button__label">{{ label }}</span>
    <slot v-else></slot>
    
    <span v-if="icon && iconPosition === 'right' && !loading" :class="['material-symbols-outlined', 'au-icon', 'au-icon--right']">{{ icon }}</span>
  </button>
</template>

<script>
export default {
  name: 'AUButton',
  props: {
    variant: {
      type: String,
      default: 'primary',
      validator: (val) => ['primary', 'secondary', 'outline', 'text', 'ghost', 'white'].includes(val),
    },
    size: {
      type: String,
      default: 'medium',
      validator: (val) => ['small', 'medium', 'large', 'xl'].includes(val),
    },
    block: {
      type: Boolean,
      default: false,
    },
    disabled: {
      type: Boolean,
      default: false,
    },
    loading: {
      type: Boolean,
      default: false,
    },
    label: {
      type: String,
      default: '',
    },
    icon: {
      type: String,
      default: null,
    },
    iconPosition: {
      type: String,
      default: 'left',
      validator: (val) => ['left', 'right'].includes(val),
    },
    customStyle: {
      type: Object,
      default: () => ({})
    }
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@500;600;700&display=swap");

.au-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-family: 'Work Sans', sans-serif;
  font-weight: 700;
  border-radius: 12px; /* Rounded-xl match */
  cursor: pointer;
  transition: all 0.2s ease;
  border: 1px solid transparent;
  line-height: 1;
  white-space: nowrap;
  user-select: none;
}

.au-button:active {
  transform: scale(0.98);
}

.au-button--block {
  width: 100%;
  display: flex;
}

/* Sizes */
.au-button--small {
  height: 32px;
  padding: 0 12px;
  font-size: 12px;
}

.au-button--medium {
  height: 40px;
  padding: 0 16px;
  font-size: 14px;
}

.au-button--large {
  height: 48px;
  padding: 0 24px;
  font-size: 16px;
}

.au-button--xl {
  height: 56px;
  padding: 0 32px;
  font-size: 18px;
}

/* Variants */
.au-button--primary {
  background-color: #f5993d;
  color: white;
  box-shadow: 0 4px 6px -1px rgba(245, 153, 61, 0.2), 0 2px 4px -1px rgba(245, 153, 61, 0.1);
}

.au-button--primary:hover {
  background-color: #e0852c;
}

.au-button--secondary {
  background-color: rgba(245, 153, 61, 0.1);
  color: #f5993d;
  border: 1px solid rgba(245, 153, 61, 0.2);
}

.au-button--secondary:hover {
  background-color: rgba(245, 153, 61, 0.2);
}

.au-button--outline {
  background-color: transparent;
  border: 1px solid #e5e7eb;
  color: #374151;
}

.au-button--outline:hover {
  border-color: #d1d5db;
  background-color: #f9fafb;
}

.au-button--text {
  background-color: transparent;
  color: #6b7280;
  font-weight: 600;
  padding-left: 8px;
  padding-right: 8px;
}

.au-button--text:hover {
  color: #111827;
  background-color: #f3f4f6;
}

.au-button--ghost {
  background-color: transparent;
  color: #f5993d;
}

.au-button--ghost:hover {
  background-color: rgba(245, 153, 61, 0.05);
}

.au-button--white {
  background-color: white;
  color: #111827;
  border: 1px solid #e5e7eb;
}

.au-button--white:hover {
  background-color: #f9fafb;
}

/* Disabled */
.au-button--disabled {
  opacity: 0.6;
  cursor: not-allowed;
  pointer-events: none;
}

/* Icons */
.au-icon {
  font-size: 1.2em; /* Relative to button text size */
  line-height: 1;
}

.au-icon--left {
  margin-right: 8px;
}

.au-icon--right {
  margin-left: 8px;
}

/* Loading */
.au-button--loading {
  color: transparent !important;
  position: relative;
}

.au-button__spinner {
  position: absolute;
  width: 1em;
  height: 1em;
  border: 2px solid currentColor;
  border-right-color: transparent;
  border-radius: 50%;
  animation: au-spin 0.75s linear infinite;
  color: #ccc; /* Default spinner color if text is transparent */
}

.au-button--primary .au-button__spinner {
  color: white;
}

.au-button--secondary .au-button__spinner {
  color: #f5993d;
}

@keyframes au-spin {
  to { transform: rotate(360deg); }
}
</style>
