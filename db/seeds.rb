DAYS = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
ApiKey.create(access_token: '1234')

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