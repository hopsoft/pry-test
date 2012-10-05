class Fail < MicroTest::Test

  test "failure" do
    # Failing on purpose for the demo.
    # Use pry to check out the current binding.
    # For example, type @Test.
    assert false
  end

end
