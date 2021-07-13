<template>
  <v-app>
    <div id="settlements">
      <p>{{ message }}</p>
      <p>{{ num_settlements() }}</p>
    </div>
  </v-app>
</template>

<script>
export default {
  props: ["initial_settlements"],
  data: function () {
    return {
      message: "Hello Settlements! (vue)",
      settlements: this.initial_settlements
    }
  },
  methods: {
    num_settlements: function () {
      return this.settlements.length
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
