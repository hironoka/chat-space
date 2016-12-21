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

  function InsertErrorHTML(data) {
    var error_message = "<div class='alert alert-alert'>"         +
                          data.error                              +
                        "</div>"
                        console.log(error_message);
    $('.flash-message').append(error_message);
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
      $('.alert').remove();
      if(data.body==null) {
        var error_html = InsertErrorHTML(data);
        $('.alert').append(error_html);
        textField.val('');
      } else {
        var html = InsertHTML(data);
        $('.chat-messages').append(html);
        textField.val('');
      }
    });
  });
});
