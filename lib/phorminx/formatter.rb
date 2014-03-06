require 'phorminx'
module Phorminx
  class Formatter
    include Phorminx
    autoload :JSON, 'phorminx/formatter/json'
  end
end
