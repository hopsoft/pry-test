unless ENV["MT_DEMO"]
  class TestWrapperTest < MicroTest::Test

    test ".new" do
      desc = "test_#{rand(999**10)}"
      meth = lambda { ".new" }
      t = MicroTest::TestWrapper.new(TestWrapperTest, desc, &meth)
      assert t.desc == desc
      assert t.test == ".new"
      assert t.passed?
      assert t.finished? == false
      assert t.duration.nil?
      assert t.asserts.empty?
    end

  end
end
