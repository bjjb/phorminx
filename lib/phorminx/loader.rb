require 'phorminx'
module Phorminx
  class Loader
    include Phorminx
    autoload :Rails2, 'phorminx/loader/rails2'
    autoload :Rails3, 'phorminx/loader/rails3'
    autoload :Rails4, 'phorminx/loader/rails4'

    def initialize
      super
      extend Rails2 if rails2?
      extend Rails3 if rails3?
      extend Rails4 if rails4?
    end

    def requires
      @requires ||= []
    end

    def require(*f)
      f.each { requires << f }
      requires.flatten!.uniq!
    end

    def load
      requires.map do |x|
        Kernel.send(:load, x)
      end
    end
  end
end
