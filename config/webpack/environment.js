const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.loaders.prepend('erb', erb)

environment.config.merge({
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    },
  },
})

module.exports = environment
