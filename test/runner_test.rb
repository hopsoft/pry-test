unless ENV["MT_DEMO"]
  require_relative "test_helper"

  class TestRunner < MicroTest::Test

    before do
      @runner = MicroTest::Runner.new(MicroTest::DefaultFormatter.new)
    end

    test ".running" do
      assert true
    end

  end
end
