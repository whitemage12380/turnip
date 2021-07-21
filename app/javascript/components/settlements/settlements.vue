<template>
  <div id="settlements">
    <v-app>
      <v-app-bar app absolute>
        <v-app-bar-title class="headline text-uppercase text-no-wrap">
          Settlements
        </v-app-bar-title>
      </v-app-bar>
      <v-main>
        <div class="my-8">
          <v-btn class="ml-3" @click="newSettlement()">
            New Settlement
          </v-btn>
          <v-container fluid>
            <v-expansion-panels>
              <settlement v-for="settlement in sortedSettlements" :key="settlement.name" :settlement="settlement" v-on:delete-settlement="deleteSettlement"></settlement>
            </v-expansion-panels>
          </v-container>
        </div>
      </v-main>
    </v-app>
  </div>

</template>

<script>
import axios from "axios"
import string_helpers from '../../packs/mixins.js'
export default {
  props: ["initial_settlements"],
  data: function () {
    return {
      settlements: this.initial_settlements,
      sortBy: 'created_at',
      sortDirection: 'desc'
    }
  },
  computed: {
    sortedSettlements: function () {
      return this.settlements.sort((p1,p2) => {
        let modifier = 1
        if (this.sortDirection === 'desc') {
          modifier = -1
        }
        if (p1[this.sortBy] < p2[this.sortBy]) {
          return -1 * modifier
        }
        if (p1[this.sortBy] > p2[this.sortBy]) {
          return 1 * modifier
        }
        return 0
      })
    }
  },
  methods: {
    numSettlements: function () {
      return this.settlements.length
    },
    sortSettlements: function () {
      this.settlements.sort((a, b) => {a.name - b.name})
    },
    newSettlement: function () {
      let that = this
      axios.post('/settlements', {}, {'headers': {'Accept': 'application/json'}})
        .then(function(response) {
          console.log("Created new settlement")
          that.refresh()
        }).catch(function(error) {
          alert("failure")
        })
    },
    deleteSettlement: function (settlementName) {
      console.log("got here!")
      let that = this
      axios.delete(`/settlements/${this.toSnakeCase(settlementName)}.json`, {}, {'headers': {'Accept': 'application/json'}})
        .then(function(response) {
          that.settlements = that.settlements.filter(function(s) {
            return s.name != settlementName
          })
        }).catch(function(error) {
          alert("failure")
        })
    },
    refresh: function () {
      let that = this
      axios.get('/settlements.json', {}, {'headers': {'Accept': 'application/json'}, 'responseType': 'json'})
        .then(function(response) {
          that.settlements = response.data
          console.log("Refreshed settlement list")
        }).catch(function(error) {
          alert("failure")
        })
    }
  },
  mixins: [
    string_helpers
  ]
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
