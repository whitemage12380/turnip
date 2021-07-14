<template>
  <v-col>
    <v-card class="pa2" outlined tile>
      {{ settlement_attribute.table_name}}: {{ settlement_attribute.name }}
    </v-card>
  </v-col> 
</template>

<script>
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
  }
}
</script>

<!-- <style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style> -->
