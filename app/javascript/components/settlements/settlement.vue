<template>
  <v-expansion-panel>
    <v-expansion-panel-header>
      {{ settlement.name }}
    </v-expansion-panel-header>
    <v-expansion-panel-content>
      <v-container>
        <v-row>
          <settlement-attribute v-bind:settlement_attribute="settlement.tables['Basic Information'][0]"></settlement-attribute>
        </v-row>
      </v-container>
    </v-expansion-panel-content>
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

<!-- <style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style> -->
