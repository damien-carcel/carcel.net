<template>
  <div class="home">
    <Nothing />
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import Nothing from "@/components/Nothing.vue"; // @ is an alias to /src

export default Vue.extend({
  name: "Home",
  components: {
    Nothing
  }
});
</script>
