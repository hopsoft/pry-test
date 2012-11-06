class Fail < MicroTest::Test

  # before do
  #   @var = "fubar"
  # end

  test "fail" do
    # Failing on purpose for the demo.
    # Use pry to check out the current binding.
    # For example, type @var.
    assert false
  end

end
