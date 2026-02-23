<template>
  <div class="au-select-wrapper" :class="{ 'au-select--disabled': disabled }">
    <select
      :value="modelValue"
      class="au-select"
      :class="[`au-select--${size}`]"
      :disabled="disabled"
      @change="handleChange"
    >
      <option v-if="placeholder" :value="null" disabled selected class="placeholder-option">
        {{ placeholder }}
      </option>
      <option
        v-for="option in options"
        :key="option.value"
        :value="option.value"
      >
        {{ option.label }}
      </option>
    </select>
    <span class="material-symbols-outlined au-select-arrow">expand_more</span>
  </div>
</template>

<script>
export default {
  name: "AUSELECT",
  model: {
    prop: "modelValue",
    event: "update:modelValue"
  },
  props: {
    options: {
      type: Array,
      required: true
    },
    modelValue: {
      type: [String, Number, Boolean, Object],
      default: null
    },
    placeholder: {
      type: String,
      default: "Select option"
    },
    size: {
      type: String,
      default: "medium",
      validator: (val) => ["small", "medium", "large"].includes(val)
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    handleChange(event) {
      this.$emit("update:modelValue", event.target.value);
      this.$emit("change", event.target.value);
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-select-wrapper {
  position: relative;
  font-family: "Work Sans", sans-serif;
  width: 100%;
}

.au-select {
  width: 100%;
  appearance: none;
  background-color: white;
  border: 1px solid #d1d5db; /* gray-300 */
  border-radius: 8px;
  padding-left: 12px;
  padding-right: 32px; /* Space for arrow */
  color: #181411;
  font-family: inherit;
  outline: none;
  transition: all 0.2s;
  cursor: pointer;
}

/* Sizes */
.au-select--small {
  height: 32px;
  font-size: 12px;
}
.au-select--medium {
  height: 40px;
  font-size: 14px;
}
.au-select--large {
  height: 48px;
  font-size: 16px;
}

/* Focus */
.au-select:focus {
  border-color: #f5993d;
  box-shadow: 0 0 0 2px rgba(245, 153, 61, 0.1);
}

/* Disabled */
.au-select:disabled {
  background-color: #f3f4f6;
  color: #9ca3af;
  cursor: not-allowed;
}
.au-select--disabled {
  opacity: 0.7;
}

/* Arrow */
.au-select-arrow {
  position: absolute;
  right: 8px;
  top: 50%;
  transform: translateY(-50%);
  pointer-events: none;
  color: #6b7280;
  font-size: 20px;
}

.placeholder-option {
  color: #9ca3af;
}
</style>
