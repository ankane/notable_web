# Notable Web

A web interface for [Notable](https://github.com/ankane/notable)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'notable_web'
```

And add it to your `config/routes.rb`.

```ruby
mount NotableWeb::Engine, at: "notable"
```

Be sure to secure the dashboard in production.

#### Basic Authentication

Set the following variables in your environment or an initializer.

```ruby
ENV["NOTABLE_USERNAME"] = "andrew"
ENV["NOTABLE_PASSWORD"] = "secret"
```

#### Devise

```ruby
authenticate :user, ->(user) { user.admin? } do
  mount NotableWeb::Engine, at: "notable"
end
```

#### will_paginate

If using will_paginate, create an initializer `config/initializers/kaminari.rb` with:

```ruby
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end
```

to avoid conflicts.

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/notable_web/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/notable_web/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
