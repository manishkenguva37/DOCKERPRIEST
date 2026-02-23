<template>
  <div class="au-multiselect-container" v-click-outside="closeDropdown">
    <div
      class="au-multiselect-trigger"
      :class="{ 'is-open': isOpen, 'is-disabled': disabled }"
      @click="toggleDropdown"
    >
      <div class="tags-container">
        <span v-if="modelValue.length === 0" class="placeholder">{{ placeholder }}</span>
        <div v-for="val in modelValue" :key="val" class="tag">
          {{ getLabel(val) }}
          <span class="remove-tag" @click.stop="removeValue(val)">×</span>
        </div>
      </div>
      <span class="material-symbols-outlined arrow-icon">expand_more</span>
    </div>

    <div v-if="isOpen" class="au-multiselect-dropdown">
      <div
        v-for="option in options"
        :key="option.value"
        class="dropdown-item"
        :class="{ 'is-selected': isSelected(option.value) }"
        @click="toggleOption(option.value)"
      >
        <span class="checkbox-box">
          <span v-if="isSelected(option.value)" class="material-symbols-outlined check-icon">check</span>
        </span>
        <span class="option-label">{{ option.label }}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AUMULTISELECT",
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
      type: Array,
      default: () => []
    },
    placeholder: {
      type: String,
      default: "Select options"
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      isOpen: false
    };
  },
  directives: {
    "click-outside": {
      bind(el, binding, vnode) {
        el.clickOutsideEvent = function (event) {
          if (!(el == event.target || el.contains(event.target))) {
            vnode.context[binding.expression](event);
          }
        };
        document.body.addEventListener("click", el.clickOutsideEvent);
      },
      unbind(el) {
        document.body.removeEventListener("click", el.clickOutsideEvent);
      }
    }
  },
  methods: {
    getLabel(value) {
      const option = this.options.find((opt) => opt.value === value);
      return option ? option.label : value;
    },
    isSelected(value) {
      return this.modelValue.includes(value);
    },
    toggleDropdown() {
      if (!this.disabled) {
        this.isOpen = !this.isOpen;
      }
    },
    closeDropdown() {
      this.isOpen = false;
    },
    toggleOption(value) {
      const newValue = [...this.modelValue];
      const index = newValue.indexOf(value);

      if (index === -1) {
        newValue.push(value);
      } else {
        newValue.splice(index, 1);
      }

      this.$emit("update:modelValue", newValue);
      this.$emit("change", newValue);
    },
    removeValue(value) {
      if (this.disabled) return;
      const newValue = this.modelValue.filter((v) => v !== value);
      this.$emit("update:modelValue", newValue);
      this.$emit("change", newValue);
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-multiselect-container {
  position: relative;
  font-family: "Work Sans", sans-serif;
  width: 100%;
}

.au-multiselect-trigger {
  min-height: 40px;
  background-color: white;
  border: 1px solid #d1d5db; /* gray-300 */
  border-radius: 8px;
  padding: 4px 32px 4px 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
  position: relative;
  transition: all 0.2s;
}

.au-multiselect-trigger.is-open {
  border-color: #f5993d;
  box-shadow: 0 0 0 2px rgba(245, 153, 61, 0.1);
}

.au-multiselect-trigger.is-disabled {
  background-color: #f3f4f6;
  cursor: not-allowed;
  opacity: 0.7;
}

.tags-container {
  display: flex;
  flex-wrap: wrap;
  gap: 4px;
  width: 100%;
}

.placeholder {
  color: #9ca3af;
  font-size: 14px;
  padding: 4px;
}

.tag {
  background-color: #fff7ed; /* orange-50 */
  border: 1px solid #ffedd5; /* orange-100 */
  color: #9a3412; /* orange-900 */
  font-size: 12px;
  font-weight: 500;
  padding: 2px 6px;
  border-radius: 4px;
  display: flex;
  align-items: center;
  gap: 4px;
}

.remove-tag {
  cursor: pointer;
  font-size: 14px;
  font-weight: 700;
  color: #fb923c;
}
.remove-tag:hover {
  color: #c2410c;
}

.arrow-icon {
  position: absolute;
  right: 8px;
  top: 50%;
  transform: translateY(-50%);
  color: #6b7280;
  pointer-events: none;
}

/* Dropdown */
.au-multiselect-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  margin-top: 4px;
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  z-index: 50;
  max-height: 240px;
  overflow-y: auto;
  padding: 4px;
}

.dropdown-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.1s;
}

.dropdown-item:hover {
  background-color: #f9fafb;
}

.dropdown-item.is-selected {
  background-color: #fff7ed;
  color: #9a3412;
}

.checkbox-box {
  width: 16px;
  height: 16px;
  border: 1px solid #d1d5db;
  border-radius: 3px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: white;
}

.dropdown-item.is-selected .checkbox-box {
  background-color: #f5993d;
  border-color: #f5993d;
}

.check-icon {
  font-size: 12px;
  color: white;
  font-weight: 700;
}

.option-label {
  font-size: 14px;
}
</style>
