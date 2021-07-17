<template>
  <div id="settlements">
    <v-app>
      <v-app-bar app absolute>
        <v-app-bar-title class="headline text-uppercase text-no-wrap">
          Settlements
        </v-app-bar-title>
      </v-app-bar>
      <v-main>
        <v-container fluid>
          <v-expansion-panels>
            <settlement v-for="settlement in settlements" :key="settlement.name" v-bind:settlement="settlement"></settlement>
          </v-expansion-panels>
        </v-container>
      </v-main>
    </v-app>
  </div>

</template>

<script>
export default {
  props: ["initial_settlements"],
  data: function () {
    return {
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
.v-app-bar-title__content {
  text-overflow: clip;
}
</style>
