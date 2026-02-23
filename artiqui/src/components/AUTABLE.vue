<template>
  <div class="au-table-container">
    <div class="au-table-wrapper">
      <table class="au-table">
        <thead>
          <tr>
            <th v-if="selectable" class="au-table__th au-table__th--select">
              <!-- Header checkbox for select all could go here if multi-select -->
            </th>
            <th
              v-for="column in columns"
              :key="column.key"
              class="au-table__th"
              :class="{ 'au-table__th--sortable': column.sortable }"
              @click="column.sortable && sortBy(column.key)"
            >
              <div class="au-th-content">
                {{ column.label }}
                <span v-if="column.sortable" class="sort-icon-wrapper">
                  <span
                    class="material-symbols-outlined sort-icon"
                    :class="{ 'active': sortKey === column.key }"
                  >
                    {{ getSortIcon(column.key) }}
                  </span>
                </span>
              </div>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="row in paginatedData"
            :key="row.id"
            class="au-table__tr"
            :class="{ 'au-table__tr--selected': selectedRow === row.id }"
            @click="selectable ? selectRow(row.id) : null"
          >
            <td v-if="selectable" class="au-table__td au-table__td--select">
              <div class="radio-circle" :class="{ 'checked': selectedRow === row.id }">
                <div class="radio-dot"></div>
              </div>
            </td>
            <td v-for="column in columns" :key="column.key" class="au-table__td">
              <slot :name="`cell-${column.key}`" :row="row" :value="row[column.key]">
                {{ row[column.key] }}
              </slot>
            </td>
          </tr>
          <tr v-if="paginatedData.length === 0">
            <td :colspan="columns.length + (selectable ? 1 : 0)" class="au-table__td au-table__td--empty">
              No data available
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Pagination -->
    <div class="au-table-pagination" v-if="data.length > 0">
      <AUPAGINATION
        :total-items="data.length"
        :page-size="pageSize"
        :current-page="currentPage"
        :page-sizes="pageSizes"
        @update:currentPage="onPageChange"
        @update:pageSize="onPageSizeChange"
      />
    </div>
  </div>
</template>

<script>
import AUPAGINATION from "./AUPAGINATION.vue";

export default {
  name: "AUTABLE",
  components: {
    AUPAGINATION
  },
  props: {
    data: {
      type: Array,
      required: true
    },
    columns: {
      type: Array,
      required: true,
      // { key: string, label: string, sortable?: boolean }
    },
    selectable: {
      type: Boolean,
      default: false
    },
    pageSize: {
      type: Number,
      default: 10
    },
    pageSizes: {
      type: Array,
      default: () => [10, 25, 50]
    }
  },
  data() {
    return {
      currentPage: 1,
      selectedRow: null,
      sortKey: "",
      sortOrder: "asc"
    };
  },
  computed: {
    sortedData() {
      if (!this.sortKey) return this.data;
      return [...this.data].sort((a, b) => {
        const valA = a[this.sortKey];
        const valB = b[this.sortKey];
        if (valA < valB) return this.sortOrder === "asc" ? -1 : 1;
        if (valA > valB) return this.sortOrder === "asc" ? 1 : -1;
        return 0;
      });
    },
    paginatedData() {
      const start = (this.currentPage - 1) * this.pageSize;
      return this.sortedData.slice(start, start + this.pageSize);
    }
  },
  watch: {
    pageSize() {
      this.currentPage = 1;
    }
  },
  methods: {
    sortBy(key) {
      if (this.sortKey === key) {
        this.sortOrder = this.sortOrder === "asc" ? "desc" : "asc";
      } else {
        this.sortKey = key;
        this.sortOrder = "asc";
      }
      this.$emit("sort", { key: this.sortKey, order: this.sortOrder });
    },
    getSortIcon(key) {
      if (this.sortKey !== key) return "unfold_more";
      return this.sortOrder === "asc" ? "expand_less" : "expand_more";
    },
    selectRow(id) {
      this.selectedRow = id;
      this.$emit("row-select", id);
    },
    onPageChange(page) {
      this.currentPage = page;
      this.$emit("page-change", page);
    },
    onPageSizeChange(size) {
      this.$emit("update:pageSize", size); // Propagate up if v-model used on usage
      this.$emit("page-size-change", size);
      this.currentPage = 1;
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-table-container {
  font-family: "Work Sans", sans-serif;
  width: 100%;
  background-color: white;
  border-radius: 12px;
  border: 1px solid #e5e7eb;
  overflow: hidden;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.au-table-wrapper {
  overflow-x: auto;
}

.au-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
}

/* Header */
.au-table__th {
  background-color: #f9fafb;
  padding: 12px 16px;
  font-size: 12px;
  font-weight: 600;
  color: #6b7280;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  border-bottom: 1px solid #e5e7eb;
}

.au-table__th--sortable {
  cursor: pointer;
}
.au-table__th--sortable:hover {
  background-color: #f3f4f6;
  color: #111827;
}

.au-th-content {
  display: flex;
  align-items: center;
  gap: 4px;
}

.sort-icon {
  font-size: 16px;
  color: #9ca3af;
}

.sort-icon.active {
  color: #f5993d;
}

/* Body */
.au-table__tr {
  background-color: white;
  transition: background-color 0.1s;
}

.au-table__tr:hover {
  background-color: #f9fafb;
}

.au-table__tr:not(:last-child) {
  border-bottom: 1px solid #f3f4f6;
}

.au-table__tr--selected {
  background-color: #fff7ed;
}

.au-table__td {
  padding: 16px;
  font-size: 14px;
  color: #111827;
}

.au-table__td--empty {
  text-align: center;
  color: #6b7280;
  padding: 32px;
}

/* Selection Radio */
.radio-circle {
  width: 16px;
  height: 16px;
  border: 2px solid #d1d5db;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.radio-circle.checked {
  border-color: #f5993d;
}

.radio-dot {
  width: 8px;
  height: 8px;
  background-color: #f5993d;
  border-radius: 50%;
  opacity: 0;
  transform: scale(0);
  transition: all 0.2s;
}

.radio-circle.checked .radio-dot {
  opacity: 1;
  transform: scale(1);
}

/* Pagination Area */
.au-table-pagination {
  padding: 12px 16px;
  border-top: 1px solid #e5e7eb;
  background-color: white;
}
</style>
