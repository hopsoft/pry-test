# frozen_string_literal: true

module PryTest
  module Color
    extend self

    colors = {
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      magenta: 35,
      cyan: 36,
      white: 37,
      gray: 90
    }

    def default(text)
      text
    end

    colors.each do |name, code|
      define_method name do |text|
        "\e[#{code}m#{text}\e[0m"
      end
    end
  end
end
