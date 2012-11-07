require File.join(File.dirname(__FILE__), "base_formatter")

module MicroTest
  class Formatter < MicroTest::BaseFormatter

    def after_suite(test_classes)
      print "Passed: #{green MicroTest::Test.all_passed.count}, Failed: #{red MicroTest::Test.all_failed.count}"
      super
    end

  end
end
