<template>
  <div class="autocomplete-input">
    <p class="control has-icon has-icon-right">
      <input
        class="input is-large"
        placeholder="Search..."
      >
      <i class="fa fa-angle-down"></i>
    </p>
    <ul v-show="isOpen" class="options-list">
      <li v-for="option in options">
        <article class="autocomplete-list">
          <figure class="media-left pull-left">
            <p class="image">
              <img :src="option.thumbnail">
            </p>
          </figure>
          <p>
            <strong>{{ option.title }}</strong>
            <br>
            {{ option.description }}
          </p>
        </article>
      </li>
    </ul>
  </div>
</template>

<script>
Vue.component('autocomplete-input', {
    template: '#autocomplete-input-template',
    props: {
    options: {
      type: Array,
      required: true
    },
    data () {
      return {
        isOpen: false
      }
    }
  }
})

export default {
  el: "#autocomplete",
  data: {
      options: [
        {
          title: 'First Scene',
          description: 'lorem ipsum dolor amet.',
          thumbnail: 'http://lorempicsum.com/nemo/200/200/1'
        },
        {
          title: 'Second Scene',
          description: 'lorem ipsum dolor amet.',
          thumbnail: 'http://lorempicsum.com/nemo/200/200/2'
        },
        {
          title: 'Third Scene',
          description: 'lorem ipsum dolor amet.',
          thumbnail: 'http://lorempicsum.com/nemo/200/200/3'
        },
        {
          title: 'Fourth Scene',
          description: 'lorem ipsum dolor amet.',
          thumbnail: 'http://lorempicsum.com/nemo/200/200/4'
        }
      ]
    }
}
</script>

<style scoped>

</style>
