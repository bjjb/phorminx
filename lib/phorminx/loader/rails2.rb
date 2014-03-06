module Phorminx
  class Loader
    module Rails2
      def requires
        @requires ||= ['config/environment.rb']
      end
    end
  end
end
