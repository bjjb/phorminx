# phorminx

Pollution Heavy ORM INspector/eXtractor. Use it to inspect a bloated Rails
application and extract _just_ the ActiveRecord classes. Then plug those into
your Rails re-write! Or just use it to play around with the database, or
something.

It was written to make a really simple and fast console ActiveRecord application
on top of a really old Rails 2 application's database.

## Installation

    $ gem install phorminx

## Usage

If you load 'phorminx' while within your Rails environment (in the console, for
example, or in a runner script), you can just do something like

```ruby
ActiveRecord.export
```

It will spit out all known classes as stripped down ActiveRecord subclasses
(source code).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
