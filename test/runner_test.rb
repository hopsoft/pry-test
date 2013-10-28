unless ENV["MT_DEMO"]
  class TestRunner < MicroTest::Test

    before do
      @runner = MicroTest::Runner.new(MicroTest::DefaultFormatter.new)
    end

    test ".running" do
      assert true
    end

  end
end
