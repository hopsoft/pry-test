if ENV["MT_DEMO"]
  class TestCPULatency < MicroTest::Test

    before do
      @count = 35
    end

    test "fibonacci recursion 1" do
      @count.times { |i| TestCPULatency.fib(i) }
      assert true
    end

    test "fibonacci recursion 2" do
      @count.times { |i| TestCPULatency.fib(i) }
      assert true
    end

    test "fibonacci recursion 3" do
      raise
      @count.times { |i| TestCPULatency.fib(i) }
      assert true
    end

    def self.fib(n)
      n < 2 ? n : fib(n-1) + fib(n-2)
    end

  end
end
