<template>
  <div id="settlements">
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  name: "Settlements",
  data: function () {
    return {
      message: "Hello Settlements! (vue)"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
