<template>
  <label class="au-toggle" :class="{ 'au-toggle--disabled': disabled }">
    <input
      type="checkbox"
      class="au-toggle__input"
      :checked="value"
      :disabled="disabled"
      @change="$emit('change', $event.target.checked); $emit('input', $event.target.checked)"
    />
    <span class="au-toggle__slider"></span>
  </label>
</template>

<script>
export default {
  name: "AUBaseToggle",
  props: {
    value: {
      type: Boolean,
      default: false
    },
    disabled: {
      type: Boolean,
      default: false
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500&display=swap");

.au-toggle {
  position: relative;
  display: inline-block;
  width: 44px;
  height: 24px;
  font-family: "Work Sans", sans-serif;
  cursor: pointer;
}

.au-toggle--disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.au-toggle__input {
  opacity: 0;
  width: 0;
  height: 0;
}

.au-toggle__slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #d1d5db; /* gray-300 */
  transition: .4s;
  border-radius: 24px;
}

.au-toggle__slider:before {
  position: absolute;
  content: "";
  height: 18px;
  width: 18px;
  left: 3px;
  bottom: 3px;
  background-color: white;
  transition: .4s;
  border-radius: 50%;
  box-shadow: 0 1px 2px rgba(0,0,0,0.1);
}

.au-toggle__input:checked + .au-toggle__slider {
  background-color: #f5993d; /* primary */
}

.au-toggle__input:focus + .au-toggle__slider {
  box-shadow: 0 0 1px #f5993d;
}

.au-toggle__input:checked + .au-toggle__slider:before {
  transform: translateX(20px);
}
</style>
