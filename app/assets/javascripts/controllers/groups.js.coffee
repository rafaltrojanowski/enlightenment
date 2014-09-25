$ ->
  $("#group_user_tokens").tokenInput($("#group_user_tokens").data('url') ,
      propertyToSearch: "email",
      preventDuplicates: true
    )
