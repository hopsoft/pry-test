if ENV["PRY_TEST_DEMO"]
  require_relative "../test_helper"

  class Fail < PryTest::Test

    before do
      @var = "fubar"
    end

    test "fail on purpose" do
      # Failing on purpose for the demo.
      # Use pry to check out the current binding.
      # For example, type @var.
      assert false
    end

  end
end
