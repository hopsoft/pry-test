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
          :number => (i + 1),
          :color => (i == index ? :red : :default),
          :code => assert[:lines][i]
        }
      end
    end

  end
end
