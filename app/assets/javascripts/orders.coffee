$ ->
  $('#day')
  .datepicker().datepicker("setDate", new Date())
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
    url = $(this).parent().data('url')
    $.ajax
      url: url
      type: 'GET'
      dataType: 'script'

  $(document).on 'click', '.active .panel-heading', ->
    $('.active .panel-body').remove()
    $(this).parent().removeClass('active')
  