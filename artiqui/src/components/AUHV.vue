<template>
  <div class="au-hv-container">
    <div class="au-hv-controls">
      <div class="au-hv-search">
        <span class="material-symbols-outlined search-icon">search</span>
        <input
          v-model="searchTerm"
          type="text"
          class="au-hv-input"
          placeholder="Search by location or type..."
          aria-label="Search"
        />
      </div>
      <div class="au-hv-dates">
        <input
          v-model="filterStartDate"
          type="date"
          class="au-hv-date"
          title="Filter from date"
          aria-label="Start date"
        />
        <input
          v-model="filterEndDate"
          type="date"
          class="au-hv-date"
          title="Filter to date"
          aria-label="End date"
        />
      </div>
      <button class="au-hv-clear-btn" @click="clearFilters">
        Clear Filters
      </button>
    </div>

    <!-- Tabs -->
    <div class="au-hv-tabs" role="tablist">
      <button
        v-for="(tab, index) in Tabs"
        :key="index"
        class="au-hv-tab"
        :class="{ 'active': internalActiveTab === tab.name }"
        @click="selectTab(tab.name)"
        role="tab"
        :aria-selected="internalActiveTab === tab.name"
      >
        <span class="material-symbols-outlined tab-icon">{{ getIconName(tab.icon) }}</span>
        {{ tab.label }}
      </button>
    </div>

    <!-- Content -->
    <div
      v-for="(table, index) in tabledata"
      :key="index"
      v-show="true /* Logic for showing specific table based on tab if needed, but original code showed all in loop */"
      class="au-hv-content"
    >
      <div class="au-card">
        <div class="au-card-header">
          <span class="header-title">{{ table.title }}</span>
          <span class="badge">{{ table.deliveries.length }}</span>
        </div>
        <div class="au-card-body">
          <div v-if="isLoading" class="au-loading-state">
            <div class="spinner"></div>
            <p>Fetching ...</p>
          </div>
          <div v-else>
            <ul v-if="table.deliveries.length" class="au-list">
              <li
                v-for="(item, itemIndex) in table.deliveries"
                :key="itemIndex"
                class="au-list-item"
              >
                <slot :name="table.title" :data="table">
                  <a href="#" class="au-list-link">
                    <div class="au-item-header">
                      <h6 class="au-item-title">{{ item.item_type }}</h6>
                      <small class="au-item-budget">Budget: <span class="fw-bold">₹{{ item.budget }}</span></small>
                    </div>
                    <p class="au-item-route">
                      <span class="material-symbols-outlined route-icon">location_on</span>
                      {{ item.pickup_address }}
                      <span class="material-symbols-outlined route-arrow">arrow_forward</span>
                      {{ item.dropoff_address }}
                    </p>
                    <small class="au-item-date">
                      <span class="material-symbols-outlined date-icon">event</span>
                      Pickup Date: {{ item.pickup_date }}
                    </small>
                  </a>
                </slot>
              </li>
            </ul>
            <div v-else class="au-empty-state">
              <span class="material-symbols-outlined empty-icon">package_2</span>
              <p>No delivery requests found. Ready to send something?</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AUHV",
  props: {
    Tabs: {
      type: Array,
      required: true,
    },
    activeTab: {
      type: String,
      required: true,
    },
    tabledata: {
      type: Array,
      default: () => [],
    },
  },
  emits: ["update:activeTab"],
  data() {
    return {
      internalActiveTab: this.activeTab,
      isLoading: false,
      searchTerm: "",
      filterStartDate: "",
      filterEndDate: "",
    };
  },
  methods: {
    selectTab(tabName) {
      this.isLoading = true;
      this.$emit("update:activeTab", tabName);
      this.internalActiveTab = tabName;
      setTimeout(() => {
        this.isLoading = false;
      }, 500);
    },
    clearFilters() {
      this.searchTerm = "";
      this.filterStartDate = "";
      this.filterEndDate = "";
    },
    getIconName(biClass) {
        // Map bootstrap icons to material symbols if possible, or return as is if user uses material symbols
        if(biClass && biClass.includes('bi-search')) return 'search';
        if(biClass && biClass.includes('bi-box-seam')) return 'package_2'; // nearest
        if(biClass && biClass.includes('bi-truck')) return 'local_shipping';
        if(biClass && biClass.includes('bi-patch-check')) return 'verified';
        if(biClass && biClass.includes('bi-chat-dots')) return 'chat';
        // fallback
        return 'circle'; 
    }
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-hv-container {
  font-family: "Work Sans", sans-serif;
  padding: 24px 0;
}

/* Controls */
.au-hv-controls {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  margin-bottom: 24px;
}

.au-hv-search {
  flex: 1;
  min-width: 280px;
  position: relative;
}

.au-hv-input {
  width: 100%;
  padding: 10px 16px 10px 40px;
  border: 1px solid #d1d5db;
  border-radius: 9999px;
  font-family: inherit;
  font-size: 14px;
}
.au-hv-input:focus {
  outline: none;
  border-color: #f5993d;
  box-shadow: 0 0 0 2px rgba(245, 153, 61, 0.1);
}

.search-icon {
  position: absolute;
  left: 12px;
  top: 50%;
  transform: translateY(-50%);
  color: #9ca3af;
  font-size: 20px;
}

.au-hv-dates {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
}

.au-hv-date {
  padding: 10px 16px;
  border: 1px solid #d1d5db;
  border-radius: 9999px;
  font-family: inherit;
  font-size: 14px;
  color: #374151;
}

.au-hv-clear-btn {
  padding: 10px 24px;
  background-color: white;
  border: 1px solid #d1d5db;
  border-radius: 9999px;
  font-weight: 600;
  color: #4b5563;
  cursor: pointer;
  white-space: nowrap;
}
.au-hv-clear-btn:hover {
  background-color: #f3f4f6;
  color: #111827;
}

/* Tabs */
.au-hv-tabs {
  display: flex;
  background-color: #f3f4f6;
  padding: 4px;
  border-radius: 9999px;
  margin-bottom: 24px;
  overflow-x: auto;
}

.au-hv-tab {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 10px 16px;
  border: none;
  background: transparent;
  border-radius: 9999px;
  font-weight: 500;
  color: #6b7280;
  cursor: pointer;
  white-space: nowrap;
  transition: all 0.2s;
}

.au-hv-tab.active {
  background-color: white;
  color: #f5993d;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  font-weight: 600;
}

.tab-icon {
  font-size: 18px;
}

/* Content Card */
.au-card {
  background-color: white;
  border-radius: 16px;
  border: none;
  box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
  overflow: hidden;
  margin-bottom: 24px;
}

.au-card-header {
  background-color: #f5993d;
  color: white;
  padding: 16px 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-title {
  font-weight: 700;
  font-size: 16px;
  text-transform: capitalize;
}

.badge {
  background-color: white;
  color: #f5993d;
  font-size: 12px;
  font-weight: 700;
  padding: 4px 12px;
  border-radius: 9999px;
}

.au-card-body {
  padding: 0;
}

/* List */
.au-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.au-list-item {
  border-bottom: 1px solid #f3f4f6;
}
.au-list-item:last-child {
  border-bottom: none;
}

.au-list-link {
  display: block;
  padding: 20px 24px;
  text-decoration: none;
  color: inherit;
  transition: background-color 0.1s;
}
.au-list-link:hover {
  background-color: #f9fafb;
}

.au-item-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 4px;
}

.au-item-title {
  font-size: 16px;
  font-weight: 700;
  color: #111827;
  margin: 0;
}

.au-item-budget {
  font-size: 14px;
  color: #6b7280;
}
.au-item-budget .fw-bold {
  color: #10b981;
  font-weight: 700;
}

.au-item-route {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  color: #4b5563;
  margin: 8px 0;
}

.route-icon, .route-arrow {
  font-size: 16px;
  color: #9ca3af;
}

.au-item-date {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: #6b7280;
}

.date-icon {
  font-size: 14px;
}

/* Loading/Empty */
.au-loading-state, .au-empty-state {
  padding: 48px;
  text-align: center;
  color: #6b7280;
}

.spinner {
  width: 24px;
  height: 24px;
  border: 3px solid #f3f4f6;
  border-top-color: #f5993d;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 12px;
}

.empty-icon {
  font-size: 48px;
  color: #d1d5db;
  margin-bottom: 12px;
  display: block;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}
</style>