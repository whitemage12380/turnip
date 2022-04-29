<template>
  <div id="characters">
    <v-app>
      <v-app-bar app absolute>
        <v-toolbar-title class="headline text-uppercase text-no-wrap">
          <span class="app-title">Characters</span>
        </v-toolbar-title>
      </v-app-bar>
      <v-main>
        <div class="my-8">
          <div>
            <v-btn x-large dark class="ml-3 float-left indigo" @click="newCharacter()">
              New Character
            </v-btn>
            <!-- <v-select :items="settlementTypes" label="New Settlement Type" v-model="newSettlementType" filled dense class="ml-2 float-left">
            </v-select> -->
          </div>
          <v-container fluid>
            <v-expansion-panels>
              <character v-for="character in sortedCharacters" :key="character.name" :character="character" v-on:delete-character="deleteCharacter"></character>
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
  props: ["initial_characters"],
  data: function () {
    return {
      characters: this.initial_characters,
      sortBy: 'created_at',
      sortDirection: 'desc'
    }
  },
  computed: {
    sortedCharacters: function () {
      return this.characters.sort((p1,p2) => {
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
    numCharacters: function () {
      return this.characters.length
    },
    newCharacter: function () {
      let that = this
      axios.post('/characters', {}, {'headers': {'Accept': 'application/json'}})
        .then(function(response) {
          console.log("Created new character")
          that.refresh()
        }).catch(function(error) {
          alert("failure")
        })
    },
    deleteCharacter: function (characterName) { // Gotta be rewritten to use id instead of name
      let that = this
      axios.delete(`/settlements/${this.toSnakeCase(characterName)}.json`, {}, {'headers': {'Accept': 'application/json'}})
        .then(function(response) {
          that.characters = that.characters.filter(function(s) {
            return s.name != characterName
          })
        }).catch(function(error) {
          alert("failure")
        })
    },
    refresh: function () {
      let that = this
      axios.get('/characters.json', {}, {'headers': {'Accept': 'application/json'}, 'responseType': 'json'})
        .then(function(response) {
          that.characters = response.data
          console.log("Refreshed character list")
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
.app-title {
  text-overflow: clip !important;
}
</style>
