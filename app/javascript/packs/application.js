/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import "../css/application.css"
import Vue from 'vue/dist/vue.js'
import App from '../app.vue'
// import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'

Vue.use(VueResource)
// Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  var element = document.querySelector("#comments")
  if(element != undefined) {
    const app = new Vue({
      el: element,
      data: {
        comments: JSON.parse(element.dataset.comments),
        status_id: JSON.parse(element.dataset.statusId),
        status_type: JSON.parse(element.dataset.statusType)
      },
      template: "<App :original_comments='comments' :status_id='status_id' :status_type='status_type' />",
      components: { App }
    })
  }
})
