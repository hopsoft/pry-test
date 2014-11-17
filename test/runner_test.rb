unless ENV["MT_DEMO"]
  require_relative "test_helper"

  class TestRunner < PryTest::Test

    before do
      @runner = PryTest::Runner.new(PryTest::DefaultFormatter.new)
    end

    test ".running" do
      assert true
    end

  end
end
