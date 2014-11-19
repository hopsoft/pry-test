if ENV["PRY_TEST_DEMO"]
  require_relative "test_helper"

  class TestIOLatency < PryTest::Test

    test "sleep 1 sec" do
      sleep 1
      assert true
    end

    test "sleep another 1 sec" do
      sleep 1
      assert true
    end

    test "sleep a third 1 sec" do
      sleep 1
      assert true
    end

  end
end
