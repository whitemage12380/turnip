<template>
  <v-expansion-panel>
    <v-expansion-panel-header>
      <template v-slot:default="{ open }">
        <v-row class="settlement-header-labels">
          <v-col class="settlement-name-label">{{ settlement.name }}</v-col>
          <v-col class="settlement-type-label">{{ toTitleCase(settlement.settlement_type) }}</v-col>
          <v-col class="settlement-buttons">
            <v-fade-transition leave-absolute>
              <div v-show="open">
                <v-btn @click.stop="dialogDelete = true" small dark class="settlement-button red"><v-icon>delete</v-icon></v-btn>
                <v-btn @click="saveAsMd" small class="settlement-button"><v-icon>save</v-icon></v-btn>
                <v-btn @click.stop="dialogRename = true" small class="settlement-button">Rename</v-btn>
              </div>
            </v-fade-transition>
          </v-col>
        </v-row>
        <!-- Dialogs associated with settlement buttons -->
        <v-dialog v-if="open" v-model="dialogDelete" max-width="500">
          <v-card>
            <v-row no-gutters class="align-center">
              <v-col class="pa-2">
                Really delete settlement "{{ settlement.name }}?"
              </v-col>
              <v-col class="pa-2 flex-grow-0">
                <v-btn @click="deleteSettlement">Delete</v-btn>
              </v-col>
            </v-row>
          </v-card>
        </v-dialog>
        <v-dialog v-if="open" v-model="dialogRename" max-width="500">
          <v-card>
            <v-row no-gutters class="align-center">
              <v-col class="px-2">
                <v-text-field label="Settlement Name" v-model="newName"></v-text-field>
              </v-col>
              <v-col class="px-2 flex-grow-0">
                <v-btn @click="renameSettlement">Rename</v-btn>
              </v-col>
            </v-row>
          </v-card>
        </v-dialog>
      </template>
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
                  <v-col v-for="(location, index) in locations" :key="index" class="location-col">
                    <settlement-location :settlementLocation="location" :locationType="category"></settlement-location>
                  </v-col>
                </v-row>
              </v-container>
            </div>
          </div>
          <div v-if="category == 'Farms and Resources'">
            <v-container>
              <v-card v-for="(resource, index) in tables" :key="index">
                <v-card-title>{{ resource.name }}</v-card-title>
                <v-card-subtitle>{{ resource.description }}</v-card-subtitle>
              </v-card>
            </v-container>
          </div>
          <div v-if="category == 'Hardships'">
            <v-card v-for="(hardship, index) in tables" :key="index">
              <v-card-title>{{ hardship.name }}</v-card-title>
              <v-card-subtitle>{{ hardship.description }}</v-card-subtitle>
              <div>
                <b>Outcome:</b> {{ hardship.outcome }}
              </div>
            </v-card>
          </div>
        </v-tab-item>
      </v-tabs-items>
    </v-expansion-panel-content>
  </v-expansion-panel>
</template>

<script>
import axios from 'axios'
import download from 'downloadjs'
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
      tab: null,
      dialogRename: false,
      dialogDelete: false,
      newName: this.settlement.name
    }
  },
  methods: {
    tabList: function (settlement) {
      let tabs = {
        ...settlement.tables,
        "Points of Interest": settlement.points_of_interest
      }
      if (settlement.hasOwnProperty('farms_and_resources')) {
        tabs["Farms and Resources"] = settlement.farms_and_resources
      }
      if (settlement.hasOwnProperty('hardships')) {
        tabs["Hardships"] = settlement.hardships
      }
      return tabs
    },
    hasTables: function (tables) {
      return (Array.isArray(tables) && tables.length > 0 && tables[0].hasOwnProperty('table_name'))
    },
    hasNameOrDescription: function (tables) {
      return tables.filter(table => table.hasOwnProperty('name') || table.hasOwnProperty('description'))
    },
    renameSettlement: function () {
      this.dialog = false
      if (this.newName == '' || this.newName == this.settlement.name) {
        return
      }
      let that = this
      axios.patch(`/settlements/${this.toSnakeCase(this.settlement.name)}.json`, {'settlement': {'name': this.newName}}, {'headers': {'Accept': 'application/json'}, 'responseType': 'json'})
        .then(function(response) {
          that.settlement.name = response.data.name
        }).catch(function(error) {
          alert("failure")
        })
    },
    saveAsMd: function () {
      let that = this
      axios.get(`/settlements/markdown/${this.toSnakeCase(this.settlement.name)}.json`, {}, {'headers': {'Accept': 'application/json'}, 'responseType': 'json'})
        .then(function(response) {
          download(response.data, `${that.toSnakeCase(that.settlement.name)}.md`, "text/markdown")
        }).catch(function(error) {
          alert("failure")
        })
    },
    deleteSettlement: function () {
      this.dialogDelete = false
      this.$emit('delete-settlement', this.settlement.name)
    }
  },
  mixins: [
    string_helpers
  ]
}
</script>

<style scoped>
.location-col {
  flex: 1 0 50%;
}
.settlement-button-bar {
  float:  right;
  margin-right:  16px;
}
.settlement-button {
  float: right;
  margin:  0 4px;
}
.settlement-header-labels {
  justify-content:  space-between;
}
.settlement-name-label {
  flex-grow:  2;
}
.settlement-type-label {
  flex-grow: 1;
  color:  gray;
}
.settlement-buttons {
  margin-right:  1rem;
}
</style>
