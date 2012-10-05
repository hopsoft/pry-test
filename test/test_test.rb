class TestTest < MicroTest::Test

  before :each do
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

  test "notify" do
    observer = Class.new do
      def update(event, arg)
        (@events ||= {})[event] = arg
      end
    end
    o = observer.new
    MicroTest::Test.add_observer o
    MicroTest::Test.notify(:foo, :bar)
    events = o.instance_eval { @events }
    assert events[:foo] == :bar
  end

  test "notification when inherited" do
    observer = Class.new do
      def update(event, arg)
        (@events ||= {})[event] = arg
      end
    end
    o = observer.new
    MicroTest::Test.add_observer o
    t = Class.new(MicroTest::Test)
    events = o.instance_eval { @events }
    assert events[:add_test_class] == t
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

  test "invoke callbacks" do
    before_all = false
    before_each = false
    after_each = false
    after_all = false
    @Test.before(:all) { before_all = true }
    @Test.before(:each) { before_each = true }
    @Test.after(:each) { after_each = true }
    @Test.after(:all) { after_all = true }
    @Test.invoke(:before, :all)
    @Test.invoke(:before, :each)
    @Test.invoke(:after, :each)
    @Test.invoke(:after, :all)
    assert before_all
    assert before_each
    assert after_each
    assert after_all
  end

  test "tests" do
    assert MicroTest::Test.tests.is_a?(Hash)
  end

  test "add tests" do
    a = lambda {}
    b = lambda {}
    c = lambda {}
    @Test.test("a", &a)
    @Test.test("b", &b)
    @Test.test("c", &c)
    assert @Test.tests["a"].equal?(a)
    assert @Test.tests["b"].equal?(b)
    assert @Test.tests["c"].equal?(c)
  end

  test "assert" do
    observer = Class.new do
      def update(event, arg)
        (@events ||= {})[event] = arg
      end
    end
    o = observer.new
    MicroTest::Test.add_observer o
    @Test.test "assert test" do
      assert true
    end
    @Test.tests["assert test"].call
    events = o.instance_eval { @events }
    assert events[:assert] == true
  end

end
