$(function() {

//(1)検索した結果のユーザー候補を表示→②追加ボタン
  function searchUserListHTML(id, name) {
    var html = '<div class="chat-group-user clearfix chat-group-user-add">' +
                 '<p class="chat-group-user__name">' +
                   name +
                 '</p>' +
                 '<a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="' + id + '" data-user-name="' + name + '">追加' +
                 '</a>' +
               '</div>';
    return html;
  }

//(2)追加されたユーザーのリストを表示→③削除ボタン
  function userListHTML(id, name) {
    var html = '<div class="chat-group-user clearfix" id="chat-group-user-' + id + '">' +
                 '<input type="hidden" name="group[user_ids][]" value="' + id + '">' +
                 '<p class="chat-group-user__name">' +
                   name +
                 '</p>' +
                 '<a class="user-search-remove chat-group-user__btn chat-group-user__btn--remove" data-user-id="' + id + '">削除' +
                 '</a>' +
                '</div>';
    return html;
  }

  //①インクリメンタルサーチ作動→(1)
  $(document).on('keyup', '#user-search-field', function() {
    $('.chat-group-user-add').hide();
    $.ajax({
      type: 'GET',
      url: '/users.json',
      data: {
        name: $('#user-search-field').val()
      }
    })
    .done(function(data) {
      var insertHTML = '';
      var users = data;
      $.each(users, function(i, user) {
        $('#user-search-result').append(searchUserListHTML(user.id, user.name));
      });
    })
    .fail(function(data) {
      alert("エラーが発生しました");
    })
  });

  //②追加ボタンを押した時→(2)
  $(document).on('click', '.chat-group-user__btn--add', function(){
    $(this).parent().remove();
    var id   = $(this).data('user-id');
    var name = $(this).data('user-name');
    $('#chat-group-users').append(userListHTML(id, name));
  });

  //③削除ボタンを押した時
  $(document).on('click', '.chat-group-user__btn--remove', function(){
    $(this).parent().remove();
  });
});
