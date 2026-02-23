<template>
  <div class="au-radio-group">
    <label
      v-for="(option, index) in options"
      :key="index"
      class="au-radio"
      :class="{
        'au-radio--disabled': disabled || option.disabled,
        [`au-radio--${size}`]: true
      }"
    >
      <input
        type="radio"
        class="au-radio__input"
        :name="name"
        :value="option.value"
        :checked="modelValue === option.value"
        :disabled="disabled || option.disabled"
        @change="$emit('update:modelValue', option.value); $emit('change', option.value)"
      />
      <span class="au-radio__circle">
        <span class="au-radio__dot"></span>
      </span>
      <span class="au-radio__label">{{ option.label }}</span>
    </label>
  </div>
</template>

<script>
export default {
  name: "AURADIO",
  model: {
    prop: "modelValue",
    event: "update:modelValue"
  },
  props: {
    options: {
      type: Array,
      required: true,
      // Expects array of objects { label: string, value: any, disabled?: boolean }
    },
    modelValue: {
      type: [String, Number, Boolean],
      default: null
    },
    name: {
      type: String,
      default: () => `radio-group-${Math.random().toString(36).substr(2, 9)}`
    },
    disabled: {
      type: Boolean,
      default: false
    },
    size: {
      type: String,
      default: "medium",
      validator: (val) => ["small", "medium", "large"].includes(val)
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500&display=swap");

.au-radio-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
  font-family: "Work Sans", sans-serif;
}

.au-radio {
  display: inline-flex;
  align-items: center;
  cursor: pointer;
  user-select: none;
}

.au-radio--disabled {
  cursor: not-allowed;
  opacity: 0.6;
}

.au-radio__input {
  position: absolute;
  width: 0;
  height: 0;
  opacity: 0;
  margin: 0;
}

.au-radio__circle {
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid #d1d5db; /* gray-300 */
  border-radius: 50%;
  background-color: white;
  transition: all 0.2s ease;
  flex-shrink: 0;
}

.au-radio__dot {
  width: 50%;
  height: 50%;
  border-radius: 50%;
  background-color: #f5993d;
  opacity: 0;
  transform: scale(0);
  transition: all 0.2s ease;
}

/* Sizes */
.au-radio--small .au-radio__circle {
  width: 16px;
  height: 16px;
}
.au-radio--medium .au-radio__circle {
  width: 20px;
  height: 20px;
}
.au-radio--large .au-radio__circle {
  width: 24px;
  height: 24px;
}

/* Checked State */
.au-radio__input:checked + .au-radio__circle {
  border-color: #f5993d;
}

.au-radio__input:checked + .au-radio__circle .au-radio__dot {
  opacity: 1;
  transform: scale(1);
}

/* Label */
.au-radio__label {
  margin-left: 8px;
  font-size: 14px;
  color: #181411;
}

.au-radio--small .au-radio__label { font-size: 12px; }
.au-radio--large .au-radio__label { font-size: 16px; }

/* Focus */
.au-radio__input:focus + .au-radio__circle {
  box-shadow: 0 0 0 3px rgba(245, 153, 61, 0.2);
}
</style>
