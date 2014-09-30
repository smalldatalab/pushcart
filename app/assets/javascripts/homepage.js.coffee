$('#success-message').hide()

$("form#new_user_sign_up").bind "ajax:success", (e, data, status, xhr) ->
    if data.success
      $('#new_user_sign_up').hide()
      $('#success-message').text('Thanks! You should receive a confirmation e-mail momentarily!')
      $('#success-message').slideToggle(1000, "easeOutBack")
    else
      $('#success-message').text("#{data.errors}")
      $('#success-message').slideToggle(1000, "easeOutBack")      