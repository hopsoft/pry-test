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

  test "properly stores files" do
    assert MicroTest::Test.files.is_a?(Hash)
    assert MicroTest::Test.files.has_key?(__FILE__)
    assert MicroTest::Test.files[__FILE__].is_a?(Array)
    assert MicroTest::Test.files[__FILE__].select{ |l| l.start_with?("    assert MicroTest::Test.files[__FILE__].select{ |l| l.start_with?(") }.length > 0
  end



end
