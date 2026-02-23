<template>
  <div 
    :class="[
      'au-card',
      {
        'au-card--outlined': variant === 'outlined',
        'au-card--highlighted': variant === 'highlighted',
        'au-card--flat': variant === 'flat',
        'au-card--hoverable': hoverable,
        'au-card--no-padding': noPadding
      }
    ]"
    @click="$emit('click', $event)"
  >
    <div class="au-card__content">
      <slot name="default"></slot>
    </div>
    <div v-if="$slots.footer" class="au-card__footer">
      <slot name="footer"></slot>
    </div>
  </div>
</template>

<script>
export default {
  name: 'AUCard',
  props: {
    variant: {
      type: String,
      default: 'default', // default, outlined, highlighted, flat
      validator: (val) => ['default', 'outlined', 'highlighted', 'flat'].includes(val),
    },
    hoverable: {
      type: Boolean,
      default: false,
    },
    noPadding: {
      type: Boolean,
      default: false,
    }
  }
};
</script>

<style scoped>
.au-card {
  background-color: white;
  border-radius: 12px; /* matching rounded-xl */
  overflow: hidden;
  transition: all 0.2s ease;
  border: 1px solid transparent;
  /* Default shadow similar to shadow-sm */
  box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
}

.au-card__content {
  padding: 16px; /* p-4 */
}

.au-card--no-padding .au-card__content {
  padding: 0;
}

/* Variants */
.au-card--outlined {
  box-shadow: none;
  border: 1px solid #e5e7eb; /* border-zinc-200 */
}

.au-card--flat {
  box-shadow: none;
  background-color: #f3f4f6; /* bg-gray-100 */
}

.au-card--highlighted {
  background-color: rgba(245, 153, 61, 0.05); /* bg-primary/5 */
  border: 1px solid rgba(245, 153, 61, 0.1);
}

/* Hoverable */
.au-card--hoverable:hover {
  cursor: pointer;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); /* shadow-md */
  transform: translateY(-1px);
}

/* Dark Mode Overrides (Assumes a parent class .dark usually, but applied directly here for simplicity with standard media queries if needed, or variable based) */
@media (prefers-color-scheme: dark) {
  /* This is a simple fallback, real dark mode usually handled by class strategy */
}
</style>