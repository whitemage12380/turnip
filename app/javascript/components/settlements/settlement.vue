<template>
  <v-expansion-panel>
    <v-expansion-header>
      {{ settlement }}
    </v-expansion-header>
  </v-expansion-panel>
  
</template>

<script>
export default {
  props: ["settlement"],
  data: function () {
    return {
    }
  },
  methods: {
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
