<template>
  <button
    class="au-base-btn"
    :class="[`au-base-btn--${variant}`, { 'au-base-btn--loading': loading }]"
    :disabled="disabled || loading"
    @click="$emit('click', $event)"
  >
    <slot />
  </button>
</template>

<script>
export default {
  name: "AUBaseButton",
  props: {
    variant: { type: String, default: 'primary' },
    loading: { type: Boolean, default: false },
    disabled: { type: Boolean, default: false },
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@500;600&display=swap");

.au-base-btn {
  font-family: "Work Sans", sans-serif;
  padding: 10px 20px;
  border-radius: 8px;
  font-weight: 600;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
  border: none;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.au-base-btn--primary {
  background-color: #f5993d;
  color: white;
}
.au-base-btn--primary:hover:not(:disabled) {
  background-color: #e08b34;
}

.au-base-btn--secondary {
  background-color: #fff7ed;
  color: #f5993d;
}
.au-base-btn--secondary:hover:not(:disabled) {
  background-color: #ffedd5;
}

.au-base-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}
</style>
