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
                            data.time                             +
                          "</p>"                                  +
                        "</div>"                                  +
                      "</div>"                                    +
                      "<div class='chat-message__message'>"       +
                        "<P>"                                     +
                         data.body                                +
                        "</p>"                                    +
                        "<img src=" + data.image.image.url + ">" +
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
    $('.flash-message').append(error_message);
    $('input').removeAttr("disabled");
  }

  $('.new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_form');
    var message = textField.val();
    var form = $('#new_message')[0];
    var formData = new FormData(form);

    $.ajax({
      type: 'POST',
      url:  './messages',
      data: formData,
      dataType: "json",
      processData: false,  // jQuery がデータを処理しないよう(文字列に変換されるのを避ける)指定
      contentType: false   // jQuery が contentType を設定しないよう指定(送信するデータをFormDataにする場合必要)
    })
    .done(function(data) {
      $('.alert').remove();
      if(data.body) {
        InsertHTML(data);
      } else {
        InsertErrorHTML(data);
      }
      textField.val('');
    })
    .fail(function(data){
      alert('エラーが発生しました');
    });
  });
});
