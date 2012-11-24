if ENV["MT_DEMO"]
  class TestIOLatency < MicroTest::Test

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
