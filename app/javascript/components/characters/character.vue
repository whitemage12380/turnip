<template>
	<div></div>
</template>

<script>
import axios from 'axios'
import download from 'downloadjs'
import string_helpers from '../../packs/mixins.js'
export default {
  props: {
    character: {
      type: Object,
      require: true
    }
  }
}
</script>