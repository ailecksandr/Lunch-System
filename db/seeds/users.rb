User.delete_all

user = User.new(
    nickname: 'Typical Odmen',
    email: 'admin@lunch.com',
    password: '12345678',
    role: 'admin',
    avatar: open('http://cliparts.co/cliparts/Aib/r5r/Aibr5rMET.jpg')
)
user.skip_confirmation!
user.save

(1..10).each do |i|
  user = User.new(
      nickname: "Typical User #{i}",
      email: "user_#{i}@lunch.com",
      password: '12345678',
      avatar: open('http://orig14.deviantart.net/cd69/f/2013/124/1/7/new_id_by_a_man_with_no_art-d642mu3.jpg')
  )
  user.skip_confirmation!
  user.save
end


user = User.new(
    nickname: 'ApiClient',
    email: 'api_client@lunch.com',
    password: '228_322_228',
    role: 'system'
)
user.skip_confirmation!
user.save
