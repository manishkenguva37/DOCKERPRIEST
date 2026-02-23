<template>
  <div class="au-pagination">
    <!-- Page Size Select -->
    <div class="au-pagination__left">
      <span class="au-pagination__text">Rows per page:</span>
      <div class="au-pagination__select-wrapper">
        <select
          :value="pageSize"
          class="au-pagination__select"
          :disabled="disabled"
          @change="handlePageSizeChange"
        >
          <option v-for="size in pageSizes" :key="size" :value="size">{{ size }}</option>
        </select>
        <span class="material-symbols-outlined select-arrow">expand_more</span>
      </div>
    </div>

    <!-- Page Info -->
    <div class="au-pagination__center d-none d-md-block">
      <span class="au-pagination__text">
        Showing {{ startItem }}-{{ endItem }} of {{ totalItems }}
      </span>
    </div>

    <!-- Controls -->
    <div class="au-pagination__right">
      <button
        class="au-page-btn"
        :disabled="currentPage === 1 || disabled"
        @click="goToPage(currentPage - 1)"
      >
        <span class="material-symbols-outlined">chevron_left</span>
      </button>

      <div class="au-page-numbers">
        <button
          v-for="page in visiblePages"
          :key="page"
          class="au-page-num"
          :class="{ 'active': page === currentPage }"
          @click="goToPage(page)"
        >
          {{ page }}
        </button>
      </div>

      <button
        class="au-page-btn"
        :disabled="currentPage === totalPages || disabled"
        @click="goToPage(currentPage + 1)"
      >
        <span class="material-symbols-outlined">chevron_right</span>
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "AUPAGINATION",
  model: {
    prop: "currentPage",
    event: "update:currentPage"
  },
  props: {
    totalItems: {
      type: Number,
      required: true
    },
    pageSize: {
      type: Number,
      default: 10
    },
    currentPage: {
      type: Number,
      default: 1
    },
    pageSizes: {
      type: Array,
      default: () => [10, 25, 50, 100]
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    totalPages() {
      return Math.ceil(this.totalItems / this.pageSize);
    },
    startItem() {
      return (this.currentPage - 1) * this.pageSize + 1;
    },
    endItem() {
      return Math.min(this.currentPage * this.pageSize, this.totalItems);
    },
    visiblePages() {
      const maxVisible = 5;
      let start = Math.max(1, this.currentPage - Math.floor(maxVisible / 2));
      let end = Math.min(this.totalPages, start + maxVisible - 1);

      if (end - start + 1 < maxVisible) {
        start = Math.max(1, end - maxVisible + 1);
      }
      
      const pages = [];
      for (let i = start; i <= end; i++) {
        pages.push(i);
      }
      return pages;
    }
  },
  methods: {
    goToPage(page) {
      if (page >= 1 && page <= this.totalPages && !this.disabled) {
        this.$emit("update:currentPage", page);
        this.$emit("page-change", page);
      }
    },
    handlePageSizeChange(event) {
      const newSize = parseInt(event.target.value, 10);
      this.$emit("update:pageSize", newSize);
      this.$emit("page-size-change", newSize);
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-pagination {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-family: "Work Sans", sans-serif;
  font-size: 14px;
  color: #4b5563;
  flex-wrap: wrap;
  gap: 12px;
}

.au-pagination__text {
  font-size: 12px;
  color: #6b7280;
}

/* Select */
.au-pagination__left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.au-pagination__select-wrapper {
  position: relative;
}

.au-pagination__select {
  appearance: none;
  background-color: white;
  border: 1px solid #d1d5db;
  border-radius: 4px;
  padding: 4px 24px 4px 8px;
  font-size: 12px;
  color: #374151;
  cursor: pointer;
}

.au-pagination__select:focus {
  outline: none;
  border-color: #f5993d;
}

.select-arrow {
  position: absolute;
  right: 4px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 16px;
  pointer-events: none;
}

/* Right Controls */
.au-pagination__right {
  display: flex;
  align-items: center;
  gap: 8px;
}

.au-page-btn {
  width: 32px;
  height: 32px;
  border: 1px solid #e5e7eb;
  background-color: white;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: #6b7280;
  transition: all 0.2s;
}

.au-page-btn:hover:not(:disabled) {
  background-color: #f3f4f6;
  color: #111827;
}

.au-page-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.material-symbols-outlined {
  font-size: 18px;
}

.au-page-numbers {
  display: flex;
  gap: 4px;
}

.au-page-num {
  min-width: 32px;
  height: 32px;
  padding: 0 4px;
  border: none;
  background-color: transparent;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
  color: #4b5563;
  cursor: pointer;
}

.au-page-num:hover {
  background-color: #f3f4f6;
}

.au-page-num.active {
  background-color: #fff7ed;
  color: #c2410c; /* primary dark */
  font-weight: 700;
}

/* Utility */
.d-none { display: none; }
@media (min-width: 768px) {
  .d-md-block { display: block; }
}
</style>
