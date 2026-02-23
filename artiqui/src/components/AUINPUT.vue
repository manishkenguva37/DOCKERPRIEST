<template>
  <div class="au-input-wrapper">
    <label v-if="label" class="au-input-label">{{ label }}</label>
    <div 
      :class="[
        'au-input-container',
        { 'au-input-container--focus': isFocused }
      ]"
    >
      <span v-if="icon" :class="['material-symbols-outlined', 'au-input-icon']">{{ icon }}</span>
      <input
        :type="type"
        :value="value"
        :placeholder="placeholder"
        :disabled="disabled"
        class="au-input-field"
        @input="$emit('input', $event.target.value)"
        @focus="isFocused = true"
        @blur="isFocused = false"
      />
      <slot name="suffix"></slot>
    </div>
    <p v-if="hint" class="au-input-hint">{{ hint }}</p>
  </div>
</template>

<script>
export default {
  name: 'AUInput',
  props: {
    value: {
      type: [String, Number],
      default: ''
    },
    label: {
      type: String,
      default: ''
    },
    placeholder: {
      type: String,
      default: ''
    },
    type: {
      type: String,
      default: 'text'
    },
    icon: {
      type: String,
      default: null
    },
    hint: {
      type: String,
      default: ''
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      isFocused: false
    }
  }
}
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600&display=swap");

.au-input-wrapper {
  font-family: 'Work Sans', sans-serif;
  width: 100%;
  display: flex;
  flex-direction: column;
}

.au-input-label {
  font-size: 14px;
  font-weight: 500;
  color: #374151; /* text-gray-700 */
  margin-bottom: 6px;
}

.au-input-container {
  display: flex;
  align-items: center;
  background-color: white;
  border: 1px solid #d1d5db; /* border-gray-300 */
  border-radius: 8px; /* rounded-lg */
  padding: 0 12px;
  transition: all 0.2s ease;
  height: 48px;
}

.au-input-container--focus {
  border-color: #f5993d; /* primary */
  box-shadow: 0 0 0 2px rgba(245, 153, 61, 0.1);
}

.au-input-icon {
  color: #9ca3af; /* text-gray-400 */
  font-size: 20px;
  margin-right: 8px;
}

.au-input-field {
  flex: 1;
  border: none;
  background: transparent;
  outline: none;
  font-size: 15px;
  color: #111827; /* text-gray-900 */
  width: 100%;
}

.au-input-field::placeholder {
  color: #9ca3af;
}

.au-input-hint {
  font-size: 12px;
  color: #6b7280; /* text-gray-500 */
  margin-top: 4px;
}
</style>
