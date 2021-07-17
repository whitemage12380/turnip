<template>
  <tr>
    <td class="attribute_col">{{ toTitleCase(settlement_attribute.table_name) }}</td>
    <td class="name_col"><span v-html="attributeExtended(settlement_attribute)"></span></td>
  </tr>
</template>

<script>
import string_helpers from '../../packs/mixins.js'
export default {
  props: {
    settlement_attribute: {
      type: Object,
      require: true
    },
    size: {
      type: String,
      default: 'small',
      validator: function (value) {
        return [
          'small',
          'large'
        ].indexOf(value) !== -1
      }
    }
  },
  data: function () {
    return {
    }
  },
  methods: {
    attributeBrief: function (settlement_attribute) {
      if (settlement_attribute["table_name"] == "demographics" && settlement_attribute["races"].length > 0) {
        return `${settlement_attribute["name"]} (${settlement_attribute["description"]})`
      } else {
        return settlement_attribute["name"] || settlement_attribute["description"]
      }
    },
    attributeExtended: function (settlement_attribute) {
      const name_str = settlement_attribute.hasOwnProperty("name") ? `<b>${settlement_attribute["name"]}.</b> ` : ""
      const description_str = settlement_attribute["description"] || ""
      return name_str + description_str
    }
  },
  mixins: [
    string_helpers
  ]
}
</script>

<style scoped>
.attribute_col {
  width:  auto;
  white-space: nowrap;
}
.name_col {
  width:  100%;
}
</style>
