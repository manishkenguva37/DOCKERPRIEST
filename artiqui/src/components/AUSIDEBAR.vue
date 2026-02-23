<template>
  <div class="au-sidebar-wrapper">
    <!-- Mobile Overlay -->
    <div
      class="au-sidebar-overlay"
      v-if="isOpen && isMobile"
      @click="toggleSidebar"
    ></div>

    <!-- Sidebar -->
    <aside
      class="au-sidebar"
      :class="{ 'au-sidebar--collapsed': !isMobile && !isOpen, 'au-sidebar--mobile-open': isMobile && isOpen }"
    >
      <div class="au-sidebar__header">
        <h2 v-if="isOpen || isMobile" class="au-sidebar__title">Menu</h2>
        <button v-if="isMobile && isOpen" class="au-icon-btn" @click="toggleSidebar">
          <span class="material-symbols-outlined">close</span>
        </button>
      </div>

      <nav class="au-sidebar__nav">
        <a href="#" class="au-nav-item active">
          <span class="material-symbols-outlined au-nav-icon">dashboard</span>
          <span v-if="isOpen || isMobile" class="au-nav-label">Dashboard</span>
        </a>
        <a href="#" class="au-nav-item">
          <span class="material-symbols-outlined au-nav-icon">person</span>
          <span v-if="isOpen || isMobile" class="au-nav-label">Profile</span>
        </a>
        <a href="#" class="au-nav-item">
          <span class="material-symbols-outlined au-nav-icon">settings</span>
          <span v-if="isOpen || isMobile" class="au-nav-label">Settings</span>
        </a>
        <a href="#" class="au-nav-item mt-auto text-danger">
          <span class="material-symbols-outlined au-nav-icon">logout</span>
          <span v-if="isOpen || isMobile" class="au-nav-label">Logout</span>
        </a>
      </nav>

      <!-- Formatting Toggle (Desktop) -->
      <button
        v-if="!isMobile"
        class="au-sidebar__toggle"
        @click="toggleSidebar"
      >
        <span class="material-symbols-outlined">{{ isOpen ? 'chevron_left' : 'chevron_right' }}</span>
      </button>
    </aside>

    <!-- Mobile Toggle Button -->
    <button
      class="au-mobile-toggle"
      v-if="isMobile && !isOpen"
      @click="toggleSidebar"
    >
      <span class="material-symbols-outlined">menu</span>
    </button>
  </div>
</template>

<script>
export default {
  name: "AUSIDEBAR",
  data() {
    return {
      isOpen: true,
      isMobile: false
    };
  },
  mounted() {
    this.checkScreen();
    window.addEventListener("resize", this.checkScreen);
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.checkScreen);
  },
  methods: {
    toggleSidebar() {
      this.isOpen = !this.isOpen;
    },
    checkScreen() {
      if (typeof window !== "undefined") {
        this.isMobile = window.innerWidth < 768;
        if (this.isMobile) {
          this.isOpen = false;
        } else {
          this.isOpen = true;
        }
      }
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-sidebar-wrapper {
  font-family: "Work Sans", sans-serif;
}

/* Sidebar Box */
.au-sidebar {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  width: 240px;
  background-color: white;
  border-right: 1px solid #e5e7eb;
  padding: 16px;
  display: flex;
  flex-direction: column;
  transition: width 0.3s ease, transform 0.3s ease;
  z-index: 100;
}

.au-sidebar--collapsed {
  width: 80px;
}

/* Mobile Sidebar */
.au-sidebar--mobile-open {
  transform: translateX(0);
}

@media (max-width: 768px) {
  .au-sidebar {
    transform: translateX(-100%);
    width: 280px;
  }
}

/* Overlay */
.au-sidebar-overlay {
  position: fixed;
  inset: 0;
  background-color: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(2px);
  z-index: 90;
}

/* Header */
.au-sidebar__header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 24px;
  height: 40px;
}

.au-sidebar__title {
  font-size: 20px;
  font-weight: 700;
  color: #111827;
  margin: 0;
}

.au-icon-btn {
  background: none;
  border: none;
  cursor: pointer;
  padding: 4px;
  color: #6b7280;
}

/* Nav */
.au-sidebar__nav {
  display: flex;
  flex-direction: column;
  gap: 8px;
  flex: 1;
}

.au-nav-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  border-radius: 8px;
  color: #4b5563;
  text-decoration: none;
  transition: all 0.2s;
  white-space: nowrap;
  overflow: hidden;
}

.au-nav-item:hover {
  background-color: #f3f4f6;
  color: #111827;
}

.au-nav-item.active {
  background-color: #fff7ed;
  color: #f5993d;
}

.au-nav-icon {
  font-size: 24px;
  flex-shrink: 0;
}

.au-nav-label {
  font-size: 14px;
  font-weight: 500;
}

.mt-auto {
  margin-top: auto;
}

.text-danger {
  color: #ef4444;
}
.text-danger:hover {
  background-color: #fef2f2;
  color: #dc2626;
}

/* Toggle Button Desktop */
.au-sidebar__toggle {
  position: absolute;
  bottom: 24px;
  right: -12px;
  width: 24px;
  height: 24px;
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: #6b7280;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  z-index: 101;
}

.au-sidebar__toggle:hover {
  color: #111827;
  border-color: #d1d5db;
}

/* Mobile Toggle */
.au-mobile-toggle {
  position: fixed;
  top: 16px;
  left: 16px;
  z-index: 50;
  background-color: white;
  border: 1px solid #e5e7eb;
  padding: 8px;
  border-radius: 8px;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  cursor: pointer;
}
</style>
