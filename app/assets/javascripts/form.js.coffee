jQuery ->
  $('#edit_form').on 'click', '.delete_association', (event) ->
    $(this).closest('fieldset').find("input[id=destroy]").val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('#edit_form').on 'click', '.delete_attribute', (event) ->
    $(this).closest('fieldset').attr "disabled", "disabled"
    $(this).closest('fieldset').hide()
    event.preventDefault()
