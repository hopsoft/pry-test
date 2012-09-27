# /example/test/math_test.rb
class MathTest < MicroTest::Test

  before :all do
    # puts "runs once before all tests"
  end

  before :each do
    # puts "runs before each test"
  end

  test "addition" do
    assert 2 + 2 == 4
  end

  test "subtraction" do
    assert 2 - 2 == 0
  end

  test "multiplication" do
    assert 2 * 2 == 4
  end

  test "division" do
    assert 2 / 2 == 1 # add a trailing comment if you want a message
  end

  # and one failing test
  test "fail" do
    assert 2 + 2 == 5
  end

  after :each do
    # puts "runs after each test"
  end

  after :all do
    # puts "runs once after all tests"
  end

end
