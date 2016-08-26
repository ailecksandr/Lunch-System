$ ->
  $(":file").filestyle({
    buttonText: 'File',
    iconName: "fa fa-download"
  })

  $('.bootstrap-filestyle input').prop(placeholder: 'Select an avatar')

  $('.bootstrap-filestyle input').on 'change', (e) ->
    if this.val().length == 0
      this.prop(placeholder: 'Select an avatar')
