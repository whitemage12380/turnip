<template>
  <v-card>
    <v-card-title>{{ locationTitle(settlement_location, location_type) }}</v-card-title>
    <v-card-subtitle v-if="locationNeedsSubtitle(settlement_location)">{{ locationSubtitle(settlement_location) }}</v-card-subtitle>
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
    }
  },
  methods: {
    locationTitle: function (location, location_type) {
      if (location.hasOwnProperty('title')) {
        return location['title']
      } else if (location.hasOwnProperty('name')) {
        return location['name']
      } else if (location.hasOwnProperty('size')) {
        return location['size']['name']
      } else {
        return location_type
      }
    },
    locationSubtitle: function (location) {
      if (location.hasOwnProperty('quality')) {
        return `${location['name']} - ${location['quality']['name']} Quality`
      } else if (location.hasOwnProperty('name')) {
        return location['name']
      } else if (location.hasOwnProperty('fervency')) {
        return `${location['alignment']} - Local following is ${location['fervency']['name']}`
      }
      
    },
    locationNeedsSubtitle: function (location) {
      return (location.hasOwnProperty('name') && location.hasOwnProperty('title')) || location.hasOwnProperty('fervency')
    }
  },
  mixins: [
    string_helpers
  ]
}
</script>

<style scoped>

</style>
