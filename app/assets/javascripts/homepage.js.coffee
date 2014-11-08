$('#success-message').hide()

window.signup_success = (e, data, status, xhr) ->
  if data.success
    $('#new_user_sign_up').hide()
    $('#new_user_sign_up_promo').hide()
    $('.hide-if-success').hide()
    $('.success-message').text('Thanks! Check your e-mail for a confirmation!')
  else
    $('.success-message').text("#{data.errors}")

$("form#new_user_sign_up_promo").bind "ajax:success", (e, data, status, xhr) ->
  signup_success(e, data, status, xhr)

$("form#new_user_sign_up").bind "ajax:success", (e, data, status, xhr) ->
  signup_success(e, data, status, xhr) 