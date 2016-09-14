# JetRubyTest
The test project about lunch ordering.

#### Usage:

1. Fill `config/database.yml` and `config/application.yml`;
2. Execute next command:
    ```ruby
        rake db:create db:migrate db:seed
        
        # you can seed concrete models, ex. db:seed:items
    ```
    | Admin           | User                 | Api Client           |
    |:---------------:|:--------------------:|:--------------------:|
    | admin@lunch.com | user_\<n\>@lunch.com | api_client@lunch.com |
    | 12345678        | 12345678             | 228_322_228          |
3. System can access orders list to api by `/api/v1/orders.json?access_token=<your_access_token>&date=yyyy-mm-dd` # access_token - required, date - optional (default = today)).
    
    Default access token: `1234`.
