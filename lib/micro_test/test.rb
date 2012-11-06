require "observer"
require "thread"

module MicroTest
  class TestCell
    include Celluloid

    attr_reader :test_class, :desc, :asserts, :duration

    def initialize(test_class, desc, &block)
      @test_class = test_class
      @desc = desc
      @test = block
      @asserts = []
    end

    def invoke(formatter)
      @formatter = formatter
      start = Time.now
      @test.call
      @duration = Time.now - start
      @formatter.test self
    end

    # Triggered when assert is invoked.
    def update(value)
      @asserts << value
    end

  end

  class Test
    class << self
      include Observable

      def subclasses; @subclasses ||= []; end
      def tests; @tests ||= []; end

      def inherited(subclass)
        subclasses << subclass
      end

      def test(desc, &block)
        cell = TestCell.new(self, desc, &block)
        add_observer cell
        tests << cell
      end

      def assert(value)
        changed
        notify_observers value
      end

    end
  end
end
