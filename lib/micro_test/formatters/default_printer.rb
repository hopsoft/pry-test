require_relative "template"
require_relative "./helpers/default_helper"

module MicroTest
  module DefaultPrinter

    protected

    def print_line
      puts "".ljust(80, "-")
    end

    def print_with_line(value)
      puts "#{value} ".ljust(80, "-")
    end

    def print_test_pass(test)
      print Template.new(test, DefaultHelper).render(:_test_pass)
    end

    def print_test_fail(test)
      print Template.new(test, DefaultHelper).render(:_test_fail)
    end

    #def print_assert_fail(assert)
    #  puts
    #  print "".ljust(9)
    #  puts "#{assert[:file_path]}:#{red(assert[:line_num])}"
    #  puts "".ljust(9) + "".rjust(71, "-")
    #  index = assert[:line_num] - 1
    #  start = index - 2
    #  start = 0 if start <= 0
    #  finish = index + 2
    #  finish = assert[:lines].length - 1 if finish >= assert[:lines].length
    #  print_assert_fail_lines assert, start, finish, index
    #end

    #def print_assert_fail_lines(assert, start, finish, index)
    #  (start..finish).each do |i|
    #    print "".ljust(9)
    #    if i == index
    #      print red((i + 1).to_s.rjust(3, "0"))
    #      print red("|")
    #      print red(assert[:lines][i])
    #    else
    #      print (i + 1).to_s.rjust(3, "0")
    #      print "|"
    #      print assert[:lines][i]
    #    end
    #  end
    #end

  end
end
