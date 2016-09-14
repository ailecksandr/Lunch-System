$ ->
  $('#day').datepicker({
    daysOfWeekDisabled: [0,6],
    todayHighlight: true,
    autoclose: true
  })
  .datepicker('setDate', new Date())
  .on 'change', ->
    url = $(this).data('url')
    $.ajax
      url: url
      type: 'GET'
      dataType: 'script',
      data:
        date: $(this).val()

  $(document).on 'click', '.order:not(".active") .panel-heading', ->
    $('.active .panel-body').remove()
    $(this).parent().siblings('.active').removeClass('active')
    $(this).parent().addClass('active')
    $('.orders-list .inline-header .right:hidden').show()
    $(this).parent().find('.inline-header .right').hide()
    url = $(this).parent().data('url')
    $.ajax
      url: url
      type: 'GET'
      dataType: 'script'

  $(document).on 'click', '.active .panel-heading', ->
    $('.active .panel-body').remove()
    $(this).parent().removeClass('active')
    $(this).parent().find('.inline-header .right').show()
  