[:users, :api, :orders].each do |key|
  load("#{Rails.root}/db/seeds/#{key}.rb")
end