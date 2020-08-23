<template>
  <div class="Aligner">
    <div class="Aligner-item">
      <h1>Nothing here for now…</h1>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  name: "Nothing",
  props: {}
});
</script>

<style scoped lang="less">
.Aligner {
  display: flex;
  align-items: center;
  min-height: 24em;
  justify-content: center;
}

.Aligner-item {
  flex: none;
}
</style>
