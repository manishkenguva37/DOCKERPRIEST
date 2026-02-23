<template>
  <div class="au-textarea-wrapper">
    <textarea
      class="au-textarea"
      :rows="rows"
      :value="value"
      :placeholder="placeholder"
      :disabled="disabled"
      @input="$emit('input', $event.target.value)"
    ></textarea>
  </div>
</template>

<script>
export default {
  name: "AUBaseTextarea",
  props: {
    rows: { type: Number, default: 3 },
    value: String,
    placeholder: String,
    disabled: { type: Boolean, default: false }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500&display=swap");

.au-textarea-wrapper {
  font-family: "Work Sans", sans-serif;
  width: 100%;
}

.au-textarea {
  width: 100%;
  padding: 12px;
  background-color: white;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 14px;
  color: #111827;
  font-family: inherit;
  resize: vertical;
  outline: none;
  transition: all 0.2s;
}

.au-textarea:focus {
  border-color: #f5993d;
  box-shadow: 0 0 0 2px rgba(245, 153, 61, 0.1);
}

.au-textarea:disabled {
  background-color: #f3f4f6;
  color: #9ca3af;
  cursor: not-allowed;
}

.au-textarea::placeholder {
  color: #9ca3af;
}
</style>
