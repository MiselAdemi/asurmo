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
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'

Vue.use(VueResource)
Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  Vue.component('editable',{
    template:'<div contenteditable="true" @input="update"></div>',
    props:['content'],
    mounted:function(){
      this.$el.innerText = this.content;
    },
    methods:{
      update:function(event){
        this.$emit('update',event.target.innerText);
      }
    }
  })

  var status_element = document.querySelector("#new_status")
  if(status_element != undefined) {
    const app = new Vue({
      el: status_element,
      data: {
        original_text: '',
        textarea_text: '',
        preview_text: '',
      },
      methods: {
        generatePreviewText: function(event){
          // console.log($(event.target).html().trim())
          this.textarea_text = $(event.target).html().trim()

          // Check if original text has url
          this.urlify(this.textarea_text)
        },
        urlify: function(text) {
          var urlRegex = /\b((?:[a-z][\w-]+:(?:\/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))/ig;
          var urls = text.match(urlRegex)
          if (urls != undefined && urls[0] != undefined) {
            console.log(urls[0].toString())
            if (urls[0].indexOf("youtube") != -1) {
              this.preview_text = "<iframe src='https://www.youtube.com/embed/" + urls[0].split("v=")[1] + "'></iframe>"
            } else if (urls[0].indexOf("vimeo") != -1) {
              this.preview_text = "<iframe src='https://player.vimeo.com/video/" + urls[0].split(".com/")[1] + "'></iframe>"
            } else if ((urls[0].indexOf(".jpg") != -1) || (urls[0].indexOf(".png") != -1) || (urls[0].indexOf(".gif") != -1) || (urls[0].indexOf(".jpeg") != -1)) {
              this.preview_text = '<img src="' + urls[0] + '">'
            }
          }
        }
      }
    })
  }
})
