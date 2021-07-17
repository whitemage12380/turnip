<template>
  <v-expansion-panel>
    <v-expansion-panel-header>
      {{ settlement.name }}
    </v-expansion-panel-header>
    <v-expansion-panel-content>
      <v-tabs v-model="tab" class="mb-2">
        <v-tab v-for="(tables, category) in tabList(settlement)" :key="category">
          {{ category }}
        </v-tab>
      </v-tabs>
      <v-tabs-items v-model="tab">
        <v-tab-item v-for="(tables, category) in tabList(settlement)" :key="category">
          <v-simple-table v-if="hasTables(tables)">
            <tbody>
              <settlement-attribute v-for="table in hasNameOrDescription(tables)" :key="table.table_name" :settlement_attribute="table"></settlement-attribute>
            </tbody>
          </v-simple-table>
          <div v-if="category == 'Points of Interest'">
            <div v-for="(locations, category) in tables" :key="category">
              <h3>{{ toTitleCase(category) }}</h3>
              <v-container>
                <v-row>
                  <v-col v-for="location in locations" class="location_col">
                    <settlement-location :settlement_location="location" :location_type="category"></settlement-location>
                  </v-col>
                </v-row>
              </v-container>
            </div>
          </div>
        </v-tab-item>
      </v-tabs-items>
    </v-expansion-panel-content>
  </v-expansion-panel>
</template>

<script>
import string_helpers from '../../packs/mixins.js'
export default {
  props: {
    settlement: {
      type: Object,
      require: true
    }
  },
  data: function () {
    return {
      tab: null
    }
  },
  methods: {
    tabList: function (settlement) {
      return {
        ...settlement.tables,
        "Points of Interest": settlement.points_of_interest
      }
    },
    hasTables: function (tables) {
      return (Array.isArray(tables) && tables.length > 0)
    },
    hasNameOrDescription: function (tables) {
      return tables.filter(table => table.hasOwnProperty('name') || table.hasOwnProperty('description'))
    }
  },
  mixins: [
    string_helpers
  ]
}
</script>

<style scoped>
.location_col {
  flex: 1 0 50%;
}
</style>
