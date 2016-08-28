Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

# stylesheets
Rails.application.config.assets.precompile += %w(
  forms.sass
  items.sass
  menus.sass
  orders.sass
  users.sass
)

# javascripts
Rails.application.config.assets.precompile += %w(
  plugins/file-field.coffee
  menus.coffee
  items.coffee
  orders.coffee
)