(function() {
  $(function() {
    $(document).on('click', '.menu:not(".active") .panel-heading', function() {
      var url;
      $('.active .panel-body').remove();
      $(this).parent().siblings('.active').removeClass('active');
      $(this).parent().addClass('active');
      url = $(this).parent().data('url');
      return $.ajax({
        url: url,
        type: 'GET',
        dataType: 'script'
      });
    });
    return $(document).on('change', '.radio', function() {
      var price, sum, type;
      type = $(this).data('type');
      price = $(this).data('price');
      $(".summ ." + type + " h3").html(price);
      sum = parseFloat($(".summ .first_meal h3").text()) + parseFloat($(".summ .main_meal h3").text()) + parseFloat($(".summ .drink h3").text());
      $('.summ .total h3').html(sum.toFixed(1));
      if ($('input[data-type="first_meal"]:checked').length !== 0 && $('input[data-type="main_meal"]:checked').length !== 0 && $('input[data-type="drink"]:checked').length !== 0) {
        return $('.menu input[type=submit]').removeClass('btn-danger').addClass('btn-success');
      }
    });
  });

}).call(this);
