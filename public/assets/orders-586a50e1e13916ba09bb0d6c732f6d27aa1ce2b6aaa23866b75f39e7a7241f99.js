(function() {
  $(function() {
    $('#day').datepicker().datepicker("setDate", new Date()).on('change', function() {
      var url;
      url = $(this).data('url');
      return $.ajax({
        url: url,
        type: 'GET',
        dataType: 'script',
        data: {
          date: $(this).val()
        }
      });
    });
    $(document).on('click', '.order:not(".active") .panel-heading', function() {
      var url;
      $('.active .panel-body').remove();
      $(this).parent().siblings('.active').removeClass('active');
      $(this).parent().addClass('active');
      $('.orders-list .inline-header .right:hidden').show();
      $(this).parent().find('.inline-header .right').hide();
      url = $(this).parent().data('url');
      return $.ajax({
        url: url,
        type: 'GET',
        dataType: 'script'
      });
    });
    return $(document).on('click', '.active .panel-heading', function() {
      $('.active .panel-body').remove();
      $(this).parent().removeClass('active');
      return $(this).parent().find('.inline-header .right').show();
    });
  });

}).call(this);
