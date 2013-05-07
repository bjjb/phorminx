> This is a *work in progress*

# phorminx

Pollution Heavy ORM INspector/eXtractor. Use it to inspect a bloated Rails
application and extract _just_ the ActiveRecord classes. Then plug those into
your Rails re-write! Or just use it to play around with the database, or
something.

## Installation

    $ gem install phorminx

## Usage

If you load 'phorminx' while within your Rails environment (in the console, for
example, or in a runner script), you can just do something like

```ruby
# Using the default (Rails-hierarchy) dumper
Phorminx.dump
```

to see what will be written (to STDOUT). Better, you can pass it a block, which
can be used to control the IO. For example:

```ruby
Phorminx.dump do |phobj|
  # phobj is a Phorminx::Object - something with a filename and a useful #to_s.
  File.open(phobj.filename, 'w') { |f| f.print(phobj) }
end
```

This will write a `tmp/phorminx/schema.rb`, and a `tmp/phorminx/models/`
directory with a model for each model it can find. Or:

There are a couple of dumping behaviours built in:

`:file`::  creates a file ('tmp/phorminx.rb', by default), containing a
           script that can be used to muck around with the database.
`:rails`:: creates a Rails hierarchy (the default, as described above)

but it's fairly easy to roll your own.

There are vague plans to build a command-line version, so you won't have to boot
up the environment (what if it's broken? or dependent on something broken?).

## Customizing behaviour

It's pretty easy to change how any part of the inspectors work. Check out the
comments in the source for ideas.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
