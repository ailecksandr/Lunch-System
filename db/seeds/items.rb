Item.delete_all

items = JSON.parse(File.read('public/items.json'))['items'].map{|params| params.map{|key, value| [key.to_sym, value] }.to_h }
Item.create(items)
