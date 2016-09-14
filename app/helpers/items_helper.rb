module ItemsHelper
  def types_for_select
    Item.item_types.keys.map{|type| [humanize_type!(type), type] }
  end

  def humanize_type!(type)
    type.to_s.split('_').map(&:capitalize).join(' ')
  end
end
