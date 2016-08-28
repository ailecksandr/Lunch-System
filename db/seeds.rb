DAYS = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
ApiKey.create(access_token: '1234', static: true)

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

Item.create(
    [
      {
          name: 'Common Borsch',
          item_type: :first_meal
      },
      {
          name: 'Mushroom soup',
          item_type: :first_meal
      },
      {
          name: 'Solyanka',
          item_type: :first_meal
      },
      {
          name: 'Fish soup',
          item_type: :first_meal
      },
      {
          name: 'Harcho',
          item_type: :first_meal
      },
      {
          name: 'Noodle soup',
          item_type: :first_meal
      },
      {
          name: 'Chicken soup',
          item_type: :first_meal
      },
      {
          name: 'Boiled potatoes with chop',
          item_type: :main_meal
      },
      {
          name: 'Noodle with meat',
          item_type: :main_meal
      },
      {
          name: 'Buckwheat with chicken breast',
          item_type: :main_meal
      },
      {
          name: 'Fried potatoes with sausages',
          item_type: :main_meal
      },
      {
          name: 'Holubci',
          item_type: :main_meal
      },
      {
          name: 'Stuffed pepper in tomato sauce',
          item_type: :main_meal
      },
      {
          name: 'Pilau with meat',
          item_type: :main_meal
      },
      {
          name: 'Cherry juice',
          item_type: :drink
      },
      {
          name: 'Black tea',
          item_type: :drink
      },
      {
          name: 'Milk',
          item_type: :drink
      },
      {
          name: 'Orange juice',
          item_type: :drink
      },
      {
          name: 'Apple compote',
          item_type: :drink
      },
      {
          name: 'Coca-Cola',
          item_type: :drink
      },
      {
          name: '7-Up',
          item_type: :drink
      }
    ]
)

(1..5).each do |i|
  Item::TYPES.each do |type|
    Random.rand(1..5).times do
      existing_item_names = Meal.up_to_date(Time.now - i.days).joins(:item).where(items: { item_type: type }).pluck(:name).uniq
      collection = Item.send("#{type}s").where.not(name: existing_item_names)
      Meal.create(
          price: Random.rand((type != :drink)? (10.0...75.0) : (1.0...10.0)),
          created_at: Time.now - i.days,
          item: collection.offset(Random.rand(collection.size)).first
      )
    end
  end

  Random.rand(1..5).times do
    order = Order.create(
      user: User.workers.offset(Random.rand(User.workers.size)).first,
      created_at: Time.now - i.days,
      status: (!Random.rand(3).zero?) ? 'open' : 'closed'
    )
    Item::TYPES.each do |type|
      collection = Meal.up_to_date(Time.now - i.days).send("#{type}s")
      MenuItem.create(
            order: order,
            meal: collection.offset(Random.rand(collection.size)).first
      )
    end
  end
end

