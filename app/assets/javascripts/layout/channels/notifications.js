App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
  	$("#notifications").prepend(data.html);

    $.ajax({
      url: "/notifications.json",
      dataType: "JSON",
      method: "GET",
      success: function(data) {
        console.log(data)
        var count = 0;

        $.map(data, function(notification) {
          if (notification.read === false) {
            count++;
          }
        });

        if (count > 0) {
          $(".notification-btn span").text(count);
        } else {
          $(".notification-btn span").text("");
        }
      }
    })
  }

});
