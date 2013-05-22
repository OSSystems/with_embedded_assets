# WithEmbeddedAssets

WithEmbeddedAssets is a gem that allows you to easily embed CSS, JavaScript and
images into your Rails generated HTML. It uses the asset pipeline to include
compiled assets directly into templates.

The syntax is easy to use, and it is absolutely not intrusive, using Ruby blocks
to set the functionality on and off. However, you can also set it to be always
on, if desired.

The gem code is thread-safe, and using it in one thread will not affect the
behaviour in others.

## Installation

Add this line to your Rails application's Gemfile:

    gem 'with_embedded_assets'

And then execute:

    $ bundle

## Usage

The usage is very simple. Suppose you have a render method in a controller
action:

```ruby
def index
  # action stuff goes here...
  render "template"
end
```

If you want it to render the assets of the template embedded in it just put the
render method inside a block and give it to the with_embedded_assets method:

```ruby
def index
  # action stuff goes here...
  with_embedded_assets do
    render "template"
  end
end
```

You can also do this inside an ERB template:

```ruby
<% with_embedded_assets do %>
  <%= render :partial => "partial" %>
<% end %>
```

Or inside a HAML template:

```ruby
- with_embedded_assets do
  = render :partial => "partial"
```

To set it as always on just put this line somewhere on your code, like in a
config/initializer file:

```ruby
WithEmbeddedAssets.enabled = true
```

To turn it off, just set it to false:

```ruby
WithEmbeddedAssets.enabled = false
```

And you can always check it if it is on with this:

```ruby
WithEmbeddedAssets.enabled? # returns true or false
```

Also, using the with_embedded_assets temporarily set assets embedding on, but
returns to the original state after execution, even if there was an exception
during the execution of the block.

## Notes

Keep in mind that Internet Explorer up to version 7 has no support to embedded
images, and verion 8 has a very restricting image size limit (must be smaller
than 32 KiB).

Using embedded images increases in size due to the Base64 encoding. This can be
mitigated by HTTP compression, but it is still worth noting.

## TODO

* Add support for embedding fonts;
* Add support for embedding images with the image_tag view helpers;
* Add embedded assets minified to reduce file size in production environment;

## Running tests

This gem uses the standard Ruby test suite for the automated tests. First
install all the gem dependencies:

   $ bundle install

After that you can run all the tests:

   $ bundle exec rake test

## Acknowledgements

This gem uses portions of code from the embed-assets-rails gem. You can check
the original gem project here:

https://github.com/saulabs/embed-assets-rails

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
