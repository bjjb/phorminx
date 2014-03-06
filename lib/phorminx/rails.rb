module Phorminx
  module Rails
    def rails?
      rails2? or rails3? or rails4?
    end

    def rails2?
      Pathname.new('.').join('config/environment.rb').exist?
    end

    def rails3?
      Pathname.new('.').join('config/application.rb').exist?
    end

    def rails4?
      Pathname.new('.').join('config/application.rb').exist?
    end
  end
end
