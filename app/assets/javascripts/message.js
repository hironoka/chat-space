$(function() {
  function InsertHTML(data) {
    if (data.body) {
      var bodyHTML = "<P>" + data.body + "</p>";
    } else {
      var bodyHTML = '';
    }

    if (data.image) {
      var imageHTML = '<img src="' + data.image + '">';
    } else {
      var imageHTML = '';
    }

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
                        bodyHTML                                  +
                        imageHTML                                 +
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

//自動スクロール機能
  function automaticScroll() {
    $('body').delay(0).animate( {
      scrollTop: $(document).height()
    }, 0);
  }

//自動更新機能
  setInterval( function(data) {

    if (messageLength != 0) {  //投稿が存在しない時には自動更新を行わない
      $('.chat-messages__list').remove();
      var messageLength = $('.chat-messages__list').length;
      $.ajax({
        type: 'GET',
        url: './messages',
        dataType: "json",
      })
      .done(function(data) {
        var html = '';
        $.each(data, function(i, data) {
          InsertHTML(data);
        })
        automaticScroll();
      })
      .fail(function(data){
        alert('エラーが発生しました');
      });
    }
  }
  , 5000);

//メッセージ投稿時の非同期通信機能
  $('.new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_form');
    var fileField = $('#message_image');

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
      fileField.val('');
      automaticScroll();
    })
    .fail(function(data){
      alert('エラーが発生しました');
    });
  });
});
