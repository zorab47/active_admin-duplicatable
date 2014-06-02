# ActiveAdmin::Duplicatable

Simple duplication of [ActiveAdmin][] resources.

Allow user duplication of [ActiveAdmin][] resources through the power of the
[Amoeba][] gem. Resource duplication can be performed by either persisting the
model and its relations, or by pre-filling a new resource's form fields with
defaults.

## Usage

Add duplication functionality to a Post resource. See [Duplicatable][] for
documentation.

```ruby
ActiveAdmin.register Post do
  duplicatable
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_admin-duplicatable'
```

And then execute:

    $ bundle

## Contributing

1. Fork it ( https://github.com/zorab47/active_admin-duplicatable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[ActiveAdmin]: https://github.com/gregbell/active_admin
[Amoeba]: https://github.com/rocksolidwebdesign/amoeba
[Duplicatable]: lib/active_admin/duplicatable.rb
