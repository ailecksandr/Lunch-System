(function() {
  $(function() {
    $(":file").filestyle({
      buttonText: 'File',
      iconName: "fa fa-download"
    });
    $('.bootstrap-filestyle input').prop({
      placeholder: 'Select an avatar'
    });
    return $('.bootstrap-filestyle input').on('change', function(e) {
      if (this.val().length === 0) {
        return this.prop({
          placeholder: 'Select an avatar'
        });
      }
    });
  });

}).call(this);
