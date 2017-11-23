# RedirectCodeGenerator

RedirectCodeGenerator creates Apache redirect code

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redirect_code_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redirect_code_generator

## Usage

```
$ ./generate_apache_redirect_code /old_dir /new_dir
# 301 /old_dir -> /new_dir
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule ^/old_dir$ /new_dir? [R=301,L]
</IfModule>
```

## Options

```
$ ./generate_apache_redirect_code -h
Usage: generate_apache_redirect_code [options]
        --[no-]permanent             Use permanent redirect
        --[no-]escape                Escape any characters
    -v, --version                    Print version
```

## Todo

- Nginx

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/redirect_code_generator.

