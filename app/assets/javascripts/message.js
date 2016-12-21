$(function() {
  function InsertHTML(data) {
    var message = "<li class='chat-messages__list'>"              +
                    "<div class='chat-message'>"                  +
                      "<div class='chat-message__name-and-time'>" +
                        "<div class='user-name'>"                 +
                          "<p>"                                   +
                            data.name                             +
                          "</p>"                                  +
                         "</div>"                                 +
                        "<div class='time'>"                      +
                          "<p>"                                   +
                            data.created_at                       +
                          "</p>"                                  +
                        "</div>"                                  +
                      "</div>"                                    +
                      "<div class='chat-message__message'>"       +
                        "<P>"                                     +
                         data.body                                +
                        "</p>"                                    +
                      "</div>"                                    +
                    "</div>"                                      +
                  "</li>";
    $('.chat-messages').append(message);
    $('input').removeAttr("disabled");
  }

  $('.new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_form');
    var message = textField.val();

    $.ajax({
      type: 'POST',
      url:  './messages.json',
      data: {
        message: {
          body: message
        }
      },
      dataType: "json"
    })
    .done(function(data) {
      var html = InsertHTML(data);
      $('.chat-messages').append(html);
      textField.val('');
    });
  });
});
