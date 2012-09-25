require "observer"

module MicroTest
  class Test
    class << self
      include Observable

      def inherited(subclass)
        notify(:add_test_class, subclass)
      end

      def notify(event, arg)
        MicroTest::Test.send :changed
        MicroTest::Test.send :notify_observers, event, arg
      end

      def callbacks
        @callbacks ||= { :before => {}, :after => {} }
      end

      def before(what, &block)
        callbacks[:before][what] = block
      end

      def after(what, &block)
        callbacks[:after][what] = block
      end

      def tests
        @tests ||= {}
      end

      def test(desc, &block)
        tests[desc] = block
      end

      def assert(value)
        notify(:assert, value)
      end

    end
  end
end
