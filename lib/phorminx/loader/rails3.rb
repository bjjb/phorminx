module Phorminx
  class Loader
    module Rails3
      include Rails2

      def requires
        @requires ||= ['config/application.rb']
      end
    end
  end
end
