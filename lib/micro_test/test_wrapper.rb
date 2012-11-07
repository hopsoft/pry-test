module MicroTest
  class TestWrapper
    include Celluloid
    attr_reader :test_class, :desc, :asserts, :duration

    def initialize(test_class, desc, &block)
      @test_class = test_class
      @desc = desc
      @test = block
    end

    def invoke(formatter)
      @formatter = formatter
      start = Time.now
      @test.call
      @duration = Time.now - start
      @asserts = @test_class.asserts[desc]
      @formatter.test_finished self
    end

    def finished?
      !duration.nil?
    end

    def passing?
      return false unless asserts
      asserts.map{ |a| !!a[:value] }.uniq == [true]
    end

    def reset
      @asserts = nil
      @duration = nil
    end

  end
end
