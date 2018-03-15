<template>
  <div id="app" class="comments-container">
    <div v-for="comment in comments_list">
      {{ comment.body }}
    </div>

    <textarea v-on:keyup="submitComments($event, status_id, status_type)" v-model="messages[status_id]" class="border"></textarea>
    <!-- <button v-on:click.prevent="submitComments(status_id, status_type)">Comment</button> -->
  </div>
</template>

<script>
var state = {
  user_token: localStorage.user_token
}

export default {
  props: ["original_comments", "status_id", "status_type"],
  data: function() {
    return {
      messages: {},
      comments_list: this.original_comments
    }
  },
  methods: {
    submitComments: function(e, status_id, status_type) {
      e.stopPropagation()
      var code = (e.keyCode ? e.keyCode : e.which);

      if (code == 13) {
        var data = new FormData
        data.append("comment[commentable_id]", status_id)
        data.append("comment[commentable_type]", status_type)
        data.append("comment[body]", this.messages[status_id])

        $.ajax({
          url: "/comments",
          type: "POST",
          data: data,
          processData: false,
          contentType: false,
          beforeSend: function(xhr) { xhr.setRequestHeader("Authorization", "Bearer " + state.user_token); },
          success: (data) => {
            this.comments_list.push(data)
            this.messages[status_id] = undefined
          }
        })
      }
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
