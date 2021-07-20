<template>
  <v-card @click="toggleExpanded()">
    <v-card-title>{{ locationTitle(settlement_location, location_type) }}</v-card-title>
    <v-card-subtitle v-if="locationNeedsSubtitle(settlement_location)">{{ locationSubtitle(settlement_location) }}</v-card-subtitle>
    <div v-show="expanded" class="expanded_content px-4 pb-4" @click.stop.prevent>
      <p>{{ settlement_location["description"] }}</p>
      <div v-if="settlement_location.hasOwnProperty('owners')">
      <h4>Owners</h4>
        <v-expansion-panels >
          <v-expansion-panel v-for="(owner, index) in settlement_location.owners" :key="index">
            <v-expansion-panel-header><b>{{ owner.full_name }}</b> ({{ ownerRaceStr(owner) }})</v-expansion-panel-header>
            <v-expansion-panel-content>
              <p v-if="typeof ownerDescriptionName(owner) !== 'undefined'">{{ ownerDescriptionName(owner) }}</p>
              <p v-if="typeof ownerDescriptionFamily(owner) !== 'undefined'">{{ ownerDescriptionFamily(owner) }}</p>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
      </div>
    </div>
  </v-card>
</template>

<script>
import string_helpers from '../../packs/mixins.js'
export default {
  props: {
    settlement_location: {
      type: Object,
      require: true
    },
    location_type: {
      type: String,
      require: true
    }
  },
  data: function () {
    return {
      expanded: false
    }
  },
  mixins: [
    string_helpers
  ],
  methods: {
    locationTitle: function (location, location_type) {
      if (location.hasOwnProperty('title')) {
        return location.title
      } else if (location.hasOwnProperty('name')) {
        return location.name
      } else if (location.hasOwnProperty('size')) {
        return location.size.name
      } else {
        return location_type
      }
    },
    locationSubtitle: function (location) {
      if (location.hasOwnProperty('quality')) {
        return `${location.name} - ${location.quality.name} Quality`
      } else if (location.hasOwnProperty('name')) {
        return location.name
      } else if (location.hasOwnProperty('fervency')) {
        return `${location.alignment} - Local following is ${location.fervency.name}`
      }
      
    },
    locationNeedsSubtitle: function (location) {
      return (location.hasOwnProperty('name') && location.hasOwnProperty('title')) || location.hasOwnProperty('fervency')
    },
    toggleExpanded: function () {
      this.expanded = !(this.expanded)
    },
    ownerDescription: function(owner) {
      return "description here"
    },
    ownerDescriptionName: function (owner) {
      let includeDescription = false
      let nameRace = ""
      let nameCategory = ""
      if (owner.name_race != owner.race || owner.name_ethnicity != owner.ethnicity || owner.race != owner.family_race) {
        nameRace = " " + this.ownerNameRaceStr(owner)
        includeDescription = true
      }
      if (typeof owner.category !== 'undefined' && owner.category != 'any') {
        nameCategory = " " + owner.category
        includeDescription = true
      }
      if (includeDescription) {
        return `Name origin:${nameRace}${nameCategory}`
      } else {
        return undefined
      }
    },
    ownerDescriptionFamily: function (owner) {
      if (owner.race != owner.family_race) {
        const ethnicity = owner.hasOwnProperty('family_ethnicity') ? ` (${this.toTitleCase(owner.family_ethnicity)})` : ''
        return `Raised by a ${this.toTitleCase(owner.family_race)} family${ethnicity}`
      } else {
        return undefined
      }
    },
    ownerRaceStr: function(owner) {
      const ethnicity = owner.hasOwnProperty('ethnicity') ? ` - ${this.toTitleCase(owner.ethnicity)}` : ''
      return this.toTitleCase(owner.race) + ethnicity
    },
    ownerNameRaceStr: function(owner) {
      const ethnicity = owner.hasOwnProperty('name_ethnicity') ? ` - ${this.toTitleCase(owner.name_ethnicity)}` : ''
      return this.toTitleCase(owner.name_race) + ethnicity
    }
  }
}
</script>

<style scoped>

.expanded_content {

}

</style>
