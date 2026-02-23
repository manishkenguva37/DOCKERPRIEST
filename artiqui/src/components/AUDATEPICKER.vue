<template>
  <div class="au-datepicker-wrapper">
    <div class="au-input-wrapper" :class="{ 'disabled': disabled }">
      <span class="material-symbols-outlined au-input-icon">calendar_month</span>
      <input
        ref="datepicker"
        type="text"
        class="au-datepicker-input"
        :class="[`au-datepicker--${variant}`]"
        :placeholder="placeholder"
        :disabled="disabled"
        v-model="formattedDate"
        @focus="openPicker"
      />
    </div>
    
    <div v-if="showShortcuts && !disabled" class="au-datepicker__shortcuts">
      <button
        v-for="shortcut in shortcuts"
        :key="shortcut.label"
        class="au-shortcut-btn"
        @click="applyShortcut(shortcut)"
      >
        {{ shortcut.label }}
      </button>
    </div>
  </div>
</template>

<script>
import flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.css';

export default {
  name: 'AUDATEPICKER',
  props: {
    modelValue: {
      type: [String, Array, Date],
      default: null,
    },
    mode: {
      type: String,
      default: 'single',
      validator: (val) => ['single', 'range', 'multiple'].includes(val),
    },
    variant: {
      type: String,
      default: 'primary',
      validator: (val) => ['primary', 'secondary', 'outline'].includes(val),
    },
    disabled: {
      type: Boolean,
      default: false,
    },
    minDate: {
      type: String,
      default: null,
    },
    maxDate: {
      type: String,
      default: null,
    },
    disabledDates: {
      type: Array,
      default: () => [],
    },
    restrictPastDates: {
      type: [Boolean, String],
      default: false,
    },
    placeholder: {
      type: String,
      default: 'Select date',
    },
    showShortcuts: {
      type: Boolean,
      default: true,
    },
  },
  data() {
    return {
      formattedDate: null,
      picker: null,
      shortcuts: [
        { label: 'Today', value: () => new Date() },
        {
          label: 'Tomorrow',
          value: () => {
            const date = new Date();
            date.setDate(date.getDate() + 1);
            return date;
          },
        },
        {
          label: 'Next Week',
          value: () => {
            const date = new Date();
            date.setDate(date.getDate() + 7);
            return date;
          },
        },
      ],
    };
  },
  computed: {
    effectiveMinDate() {
      if (this.restrictPastDates) {
        if (typeof this.restrictPastDates === 'string') {
          return this.restrictPastDates;
        }
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        return today;
      }
      return this.minDate;
    },
  },
  watch: {
    modelValue(newVal) {
      if (this.picker) {
         this.picker.setDate(newVal, false); // Update picker without firing change
         this.updateFormattedDate(newVal);
      }
    },
    effectiveMinDate() {
      this.updatePickerConfig();
    },
    minDate() {
      this.updatePickerConfig();
    },
    maxDate() {
      this.updatePickerConfig();
    },
    disabledDates() {
      this.updatePickerConfig();
    },
  },
  mounted() {
    this.initializeFlatpickr();
  },
  beforeDestroy() {
    if (this.picker) {
      this.picker.destroy();
    }
  },
  methods: {
    initializeFlatpickr() {
      this.picker = flatpickr(this.$refs.datepicker, {
        mode: this.mode,
        minDate: this.effectiveMinDate,
        maxDate: this.maxDate,
        disable: this.disabledDates,
        dateFormat: 'Y-m-d',
        defaultDate: this.modelValue,
        onChange: (selectedDates) => {
          const val = this.mode === 'single' ? (selectedDates[0] ? this.picker.formatDate(selectedDates[0], 'Y-m-d') : null) : selectedDates.map(d => this.picker.formatDate(d, 'Y-m-d'));
          this.$emit('update:modelValue', val);
          this.$emit('change', val);
          this.updateFormattedDate(val);
        },
      });
      // Initial format update
      if (this.modelValue) {
          this.updateFormattedDate(this.modelValue);
      }
    },
    updatePickerConfig() {
      if (this.picker) {
        this.picker.set('minDate', this.effectiveMinDate);
        this.picker.set('maxDate', this.maxDate);
        this.picker.set('disable', this.disabledDates);
      }
    },
    updateFormattedDate(value) {
        if (!this.picker) return;
        
        if (!value) {
            this.formattedDate = "";
            return;
        }

        if (this.mode === 'single') {
             // Handle string or Date object
             this.formattedDate = this.picker.formatDate(new Date(value), 'Y-m-d');
        } else if (Array.isArray(value)) {
             this.formattedDate = value.map(d => this.picker.formatDate(new Date(d), 'Y-m-d')).join(' to ');
        }
    },
    openPicker() {
      if (!this.disabled && this.picker) {
        this.picker.open();
      }
    },
    applyShortcut(shortcut) {
      const value = shortcut.value();
      const formatted = this.picker.formatDate(value, 'Y-m-d');
      this.picker.setDate(value);
      
      const emitVal = this.mode === 'single' ? formatted : [formatted];
      this.$emit('update:modelValue', emitVal);
      this.$emit('change', emitVal);
      this.updateFormattedDate(emitVal);
    },
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-datepicker-wrapper {
  font-family: "Work Sans", sans-serif;
  width: 100%;
}

.au-input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  background-color: white;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  padding: 0 12px;
  transition: all 0.2s;
}

.au-input-wrapper:focus-within {
  border-color: #f5993d;
  box-shadow: 0 0 0 2px rgba(245, 153, 61, 0.1);
}

.au-input-wrapper.disabled {
  background-color: #f3f4f6;
  opacity: 0.7;
  cursor: not-allowed;
}

.au-input-icon {
  color: #9ca3af;
  font-size: 20px;
  margin-right: 8px;
}

.au-datepicker-input {
  width: 100%;
  border: none;
  background: transparent;
  padding: 10px 0;
  font-size: 14px;
  color: #111827;
  outline: none;
  font-family: inherit;
  cursor: pointer;
}

.au-datepicker__shortcuts {
  display: flex;
  gap: 8px;
  margin-top: 8px;
}

.au-shortcut-btn {
  font-size: 12px;
  color: #f5993d;
  background-color: #fff7ed;
  border: 1px solid #ffedd5;
  padding: 4px 8px;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s;
}

.au-shortcut-btn:hover {
  background-color: #ffedd5;
}
</style>
