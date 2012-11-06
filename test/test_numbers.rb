class TestNumbers < MicroTest::Test

  def self.fib(n)
    n < 2 ? n : fib(n-1) + fib(n-2)
  end

  test "slow and cpu intense 1" do
    10.times { |i| TestNumbers.fib(i) }
    assert true
  end

  test "slow and cpu intense 2" do
    10.times { |i| TestNumbers.fib(i) }
    assert false
  end

end
