class TestTest < MicroTest::Test

  before :all do
    @Test = Class.new(MicroTest::Test)
  end

  test "interface" do
    assert @Test.respond_to?(:inherited)
    assert @Test.respond_to?(:notify)
    assert @Test.respond_to?(:callbacks)
    assert @Test.respond_to?(:invoke)
    assert @Test.respond_to?(:before)
    assert @Test.respond_to?(:after)
    assert @Test.respond_to?(:tests)
    assert @Test.respond_to?(:test)
    assert @Test.respond_to?(:assert)
  end

  test "callbacks data structure" do
    assert @Test.callbacks.is_a?(Hash)
    assert @Test.callbacks[:before].is_a?(Hash)
    assert @Test.callbacks[:after].is_a?(Hash)
  end

  test "callbacks" do
    a = lambda {}
    b = lambda {}
    c = lambda {}
    d = lambda {}
    @Test.before(:all, &a)
    @Test.before(:each, &b)
    @Test.after(:each, &c)
    @Test.after(:all, &d)
    assert @Test.callbacks[:before][:all].equal?(a)
    assert @Test.callbacks[:before][:each].equal?(b)
    assert @Test.callbacks[:after][:each].equal?(c)
    assert @Test.callbacks[:after][:all].equal?(d)
  end

end
