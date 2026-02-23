<template>
  <div class="au-page-card">
    <div class="au-page-card__content">
      <div v-if="pageIcon" class="au-page-card__icon-wrapper">
        <span class="material-symbols-outlined au-page-card__icon">{{ pageIcon }}</span>
      </div>
      <h2 class="au-page-card__title">{{ pagetitle }}</h2>
      <p v-if="pagedesc" class="au-page-card__desc">{{ pagedesc }}</p>
    </div>
  </div>
</template>

<script>
export default {
  name: "AUPAGECARD",
  props: {
    pagetitle: {
      type: String,
      required: true
    },
    pageIcon: {
      type: String,
      default: null
    },
    pagedesc: {
      type: String,
      default: ""
    }
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap");

.au-page-card {
  font-family: "Work Sans", sans-serif;
  text-align: center;
  padding: 40px 20px;
  background-color: transparent; /* Assuming this sits on a page background */
}

.au-page-card__content {
  display: flex;
  flex-direction: column;
  align-items: center;
  max-width: 600px;
  margin: 0 auto;
}

.au-page-card__icon-wrapper {
  width: 64px;
  height: 64px;
  background-color: #fff7ed;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 24px;
}

.au-page-card__icon {
  font-size: 32px;
  color: #f5993d;
}

.au-page-card__title {
  font-size: 32px;
  font-weight: 700;
  color: #111827;
  margin: 0 0 12px;
}

.au-page-card__desc {
  font-size: 16px;
  color: #6b7280;
  line-height: 1.5;
  margin: 0;
}
</style>