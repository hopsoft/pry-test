class TestNumbers < MicroTest::Test

  def self.fib(n)
    n < 2 ? n : fib(n-1) + fib(n-2)
  end

  test "slow io 1" do
    sleep 1
    assert true
  end

  test "slow io 2" do
    sleep 1
    assert true
  end

  # test "cpu intense 1" do
  #   40.times { |i| TestNumbers.fib(i) }
  #   assert true
  # end

  # test "cpu intense 2" do
  #   40.times { |i| TestNumbers.fib(i) }
  #   assert true
  # end

  # test "cpu intense 3" do
  #   40.times { |i| TestNumbers.fib(i) }
  #   assert true
  # end

end
