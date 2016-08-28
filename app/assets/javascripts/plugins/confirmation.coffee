# Override standart confirmation
$ ->
  $.rails.allowAction = (link) ->
    return true unless link.data('confirm')
    $.rails.showConfirmDialog(link)
    false
  $.rails.confirmed = (link) ->
    confirm = link.data('confirm')
    link.data('confirm', null)
    link.trigger('click.rails')
    link.data('confirm', confirm)
  $.rails.showConfirmDialog = (link) ->
    apply = if (link.data('apply') == undefined) then 'Підтвердити' else link.data('apply')
    cancel = if (link.data('cancel') == undefined) then 'Відмінити' else link.data('cancel')
    html = """
           <div class='modal custom fade' id='ModalConfirmation'>
             <div class='modal-dialog'>
               <div class='modal-content'>
                 <div class='modal-header confirmation-header'>
                   <h4 class='modal-title'>#{link.data('confirm')}</h4>
                 </div>
                 <div class='modal-footer'>
                   <div class='actions'>
                     <a class="btn btn-shadow btn-info confirm" href="javascript:void(0)">#{apply}</a>
                     <button class='btn btn-shadow btn-default cancel' data-dismiss='modal' type='button'>#{cancel}</button>
                    </div>
                 </div>
               </div>
             </div>
           </div>
           """
    $visibleModal = $('.modal:visible').modal('hide')
    $modal = $(html).modal()
    $modal.find('a.confirm').on 'click', ->
      $modal.off('hidden.bs.modal').one 'hide.bs.modal', ->
        $visibleModal.modal('show') if link.data('confirm-modal') != undefined
        $.rails.confirmed(link)
      $modal.modal('hide')
    $modal.one 'hidden.bs.modal', ->
      $visibleModal.modal('show')