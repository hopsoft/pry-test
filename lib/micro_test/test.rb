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

      def invoke(which, what)
        callbacks[which][what].call if callbacks[which][what]
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
        binding.pry if MicroTest::PRY && !value
        notify(:assert, value)
      end

    end
  end
end
