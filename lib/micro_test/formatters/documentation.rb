require File.join(File.dirname(__FILE__), "..", "color")

module MicroTest
  class Formatter
    include MicroTest::Color

    def initialize
      @total = 0
      @passed = 0
      @failed = 0
      @start_time = Time.now
      @current_group = ""
      @failures = []
    end

    def header
      # puts "Testing in progress...\n\n"
    end

    def group(name)
      @current_group = name
      puts white("\n#{name}")
    end

    def test(info)
      @total += 1
      info[:passed] ? @passed += 1 : @failed += 1
      if info[:passed]
        puts green("  #{info[:name]}")
      else
        info[:asserts].each do |assert|
          next if assert[:passed]
          @failures << { :group => @current_group, :name => info[:name], :assert => assert }

          puts red("  #{info[:name]} (FAILED - #{@failures.count})")
        end
      end
    end

    def print_failures
      puts "\nFailures:\n"
      @failures.each_with_index do |failure, idx|
        puts "\n  #{idx + 1}) #{failure[:group]} #{failure[:name]}"
        puts red("     Failure/Error: #{failure[:assert][:line]}")
        puts cyan("     #{failure[:assert][:path]}:#{failure[:assert][:line_num]}")
      end
    end

    def footer
      if @failures.count > 0
        print_failures
      end
      puts ""
      puts "Finished in #{Time.now - @start_time} seconds"
      msg = "#{@total} examples, #{@failed} failures"
      if @failed > 0
        puts red(msg)
      else
        puts msg
      end
      puts ""
    end

  end
end
