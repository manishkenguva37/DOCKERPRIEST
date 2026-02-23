<template>
  <label
    class="au-checkbox"
    :class="{
      'au-checkbox--disabled': disabled,
      [`au-checkbox--${size}`]: true
    }"
  >
    <input
      type="checkbox"
      class="au-checkbox__input"
      :disabled="disabled"
      :checked="isChecked"
      @change="handleChange"
    />
    <span class="au-checkbox__box">
      <span class="material-symbols-outlined au-checkbox__icon">check</span>
    </span>
    <span v-if="label || $slots.default" class="au-checkbox__label">
      <slot>{{ label }}</slot>
    </span>
  </label>
</template>

<script>
export default {
  name: "AUCHECKBOX",
  model: {
    prop: "checked",
    event: "change"
  },
  props: {
    checked: {
      type: [Boolean, Array],
      default: false
    },
    value: {
      type: [String, Number, Boolean],
      default: true
    },
    label: {
      type: String,
      default: ""
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
  },
  computed: {
    isChecked() {
      if (Array.isArray(this.checked)) {
        return this.checked.includes(this.value);
      }
      return this.checked;
    }
  },
  methods: {
    handleChange(event) {
      const isChecked = event.target.checked;
      let newValue;

      if (Array.isArray(this.checked)) {
        newValue = [...this.checked];
        if (isChecked) {
          newValue.push(this.value);
        } else {
          newValue.splice(newValue.indexOf(this.value), 1);
        }
      } else {
        newValue = isChecked;
      }

      this.$emit("change", newValue);
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-checkbox {
  display: inline-flex;
  align-items: center;
  cursor: pointer;
  font-family: "Work Sans", sans-serif;
  user-select: none;
}

.au-checkbox--disabled {
  cursor: not-allowed;
  opacity: 0.6;
}

.au-checkbox__input {
  position: absolute;
  width: 0;
  height: 0;
  opacity: 0;
  margin: 0;
}

.au-checkbox__box {
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid #d1d5db; /* gray-300 */
  border-radius: 4px;
  background-color: white;
  transition: all 0.2s ease;
  flex-shrink: 0;
}

/* Sizes */
.au-checkbox--small .au-checkbox__box {
  width: 16px;
  height: 16px;
}
.au-checkbox--medium .au-checkbox__box {
  width: 20px;
  height: 20px;
}
.au-checkbox--large .au-checkbox__box {
  width: 24px;
  height: 24px;
}

/* Icon */
.au-checkbox__icon {
  font-size: 14px;
  color: white;
  opacity: 0;
  transform: scale(0.5);
  transition: all 0.2s ease;
  font-weight: 700;
}

.au-checkbox--small .au-checkbox__icon { font-size: 12px; }
.au-checkbox--large .au-checkbox__icon { font-size: 18px; }

/* Checked State */
.au-checkbox__input:checked + .au-checkbox__box {
  background-color: #f5993d; /* primary */
  border-color: #f5993d;
}

.au-checkbox__input:checked + .au-checkbox__box .au-checkbox__icon {
  opacity: 1;
  transform: scale(1);
}

/* Label */
.au-checkbox__label {
  margin-left: 8px;
  font-size: 14px;
  color: #181411;
}

.au-checkbox--small .au-checkbox__label { font-size: 12px; }
.au-checkbox--large .au-checkbox__label { font-size: 16px; }

/* Focus */
.au-checkbox__input:focus + .au-checkbox__box {
  box-shadow: 0 0 0 3px rgba(245, 153, 61, 0.2);
}
</style>
