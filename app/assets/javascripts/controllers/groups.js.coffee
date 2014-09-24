$ ->
  $("#group_user_tokens").tokenInput(location.pathname + "/other_users.json",
      propertyToSearch: "email"
    )
