class TestTest < MicroTest::Test


  test "properly stores subclasses" do
    assert MicroTest::Test.subclasses.is_a?(Array)
    assert MicroTest::Test.subclasses.length > 0
    assert MicroTest::Test.subclasses.first.ancestors.include?(MicroTest::Test)
  end

  test "properly stores tests" do
    assert MicroTest::Test.tests.is_a?(Array)
    assert MicroTest::Test.subclasses.first.tests.length > 0
    assert MicroTest::Test.subclasses.first.tests.first.is_a?(MicroTest::TestWrapper)
  end



end
