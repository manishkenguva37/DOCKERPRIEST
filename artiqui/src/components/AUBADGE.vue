<template>
  <span 
    :class="[
      'au-badge', 
      `au-badge--${variant}`,
      `au-badge--${size}`,
      { 'au-badge--pill': pill }
    ]"
  >
    <span v-if="icon" :class="['material-symbols-outlined', 'au-badge__icon']">{{ icon }}</span>
    <slot>{{ label }}</slot>
  </span>
</template>

<script>
export default {
  name: 'AUBadge',
  props: {
    label: {
      type: String,
      default: ''
    },
    variant: {
      type: String,
      default: 'default',
      validator: (val) => ['default', 'primary', 'success', 'warning', 'danger', 'info', 'maroon'].includes(val)
    },
    size: {
      type: String,
      default: 'medium',
      validator: (val) => ['small', 'medium'].includes(val)
    },
    pill: {
      type: Boolean,
      default: false
    },
    icon: {
      type: String,
      default: null
    }
  }
}
</script>

<style scoped>
.au-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-family: 'Work Sans', sans-serif;
  font-weight: 700;
  border-radius: 6px;
  line-height: 1;
  white-space: nowrap;
}

.au-badge--pill {
  border-radius: 9999px;
}

/* Sizes */
.au-badge--small {
  font-size: 10px;
  padding: 2px 6px;
  height: 20px;
}

.au-badge--medium {
  font-size: 12px;
  padding: 4px 8px;
  height: 24px;
}

/* Variants */
.au-badge--default {
  background-color: #f3f4f6;
  color: #4b5563;
}

.au-badge--primary {
  background-color: rgba(245, 153, 61, 0.1); /* primary/10 */
  color: #f5993d;
}

.au-badge--success {
  background-color: #e8f5e9;
  color: #2e7d32;
}

.au-badge--warning {
  background-color: #fff3e0;
  color: #eab308;
}

.au-badge--danger {
  background-color: #fee2e2;
  color: #ef4444;
}

.au-badge--info {
  background-color: #eff6ff;
  color: #3b82f6;
}

.au-badge--maroon {
  background-color: #800000;
  color: white;
}

.au-badge__icon {
  font-size: 1.2em;
  margin-right: 4px;
}
</style>
