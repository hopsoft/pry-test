module MicroTest
  module Runner

    def self.red(text)
      "\e[31m#{text}\e[0m"
    end

    def self.green(text)
      "\e[32m#{text}\e[0m"
    end

    def self.test_classes
      @test_classes ||= []
    end

    def self.log(value)
      file_path = caller[1][0, caller[1].index(/:[0-9]+:/)]
      line_num = caller[1].scan(/:[0-9]+:/).first.gsub(/:/, "").to_i
      @files ||= {}
      @files[file_path] ||= File.open(file_path, "r").readlines.map { |l| l.gsub(/\n/, "") }
      line = @files[file_path][line_num - 1].strip

      if value
        puts "   #{green :PASS}: #{line}"
        @passed += 1
      else
        puts "   #{red :FAIL}: #{red line}"
        puts "         #{file_path}:#{line_num}"
        @failed += 1
      end
    end

    def self.run
      @passed = @failed = 0
      test_classes.shuffle.each do |test_class|
        before = test_class.callbacks[:before]
        after = test_class.callbacks[:after]

        puts test_class.name
        before[:all].call if before[:all]
        test_class.tests.keys.shuffle.each do |desc|
          before[:each].call if before[:each]
          puts "- test #{desc}"
          test_class.tests[desc].call
          after[:each].call if after[:each]
        end
        after[:all].call if after[:all]
      end
      puts "---"
      puts "Passed: #{green @passed}, Failed: #{red @failed}"
      puts "---"
    end
  end

  class Test
    def self.inherited(subclass)
      MicroTest::Runner.test_classes << subclass
    end

    def self.callbacks
      @callbacks ||= { :before => {}, :after => {} }
    end

    def self.before(what, &block)
      callbacks[:before][what] = block
    end

    def self.after(what, &block)
      callbacks[:after][what] = block
    end

    def self.tests
      @tests ||= {}
    end

    def self.test(desc, &block)
      tests[desc] = block
    end

    def self.assert(value)
      MicroTest::Runner.log(value)
    end
  end
end
