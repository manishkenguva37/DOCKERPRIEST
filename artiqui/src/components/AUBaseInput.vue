<template>
  <input
    class="au-base-input"
    :type="type"
    :value="value"
    :placeholder="placeholder"
    :disabled="disabled"
    @input="$emit('input', $event.target.value)"
  />
</template>

<script>
export default {
  name: "AUBaseInput",
  props: {
    value: String,
    placeholder: String,
    type: { type: String, default: "text" },
    disabled: { type: Boolean, default: false }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400&display=swap");

.au-base-input {
  font-family: "Work Sans", sans-serif;
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 14px;
  outline: none;
  transition: all 0.2s;
}

.au-base-input:focus {
  border-color: #f5993d;
  box-shadow: 0 0 0 2px rgba(245, 153, 61, 0.1);
}

.au-base-input:disabled {
  background-color: #f3f4f6;
  opacity: 0.7;
  cursor: not-allowed;
}
</style>
