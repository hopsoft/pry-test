module MicroTest
  module DefaultHelper

    def duration_color(duration)
      return :yellow if @context.duration <= 0.01
      :red
    end

    def assert_lines(assert)
      index = assert[:line_num] - 1
      start = index - 2
      start = 0 if start <= 0
      finish = index + 2
      finish = assert[:lines].length - 1 if finish >= assert[:lines].length
      (start..finish).map do |i|
        {
          :line_num => (i + 1),
          :line => assert[:lines][i],
          :color => (i == index ? :red : :default)
        }
      end
    end

  end
end
