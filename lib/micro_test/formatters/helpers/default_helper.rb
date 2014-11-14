module MicroTest
  module DefaultHelper

    def duration_color(duration)
      return :yellow if @context.duration <= 0.01
      :red
    end

  end
end
