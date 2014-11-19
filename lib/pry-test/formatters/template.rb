require "erb"
require_relative "color"

module PryTest
  class Template
    include Color

    def self.view(name)
      @views ||= {}
      @views[name] ||= File.read(File.expand_path("../views/#{name}.txt.erb", __FILE__))
    end

    def initialize(context)
      @context = context
    end

    def render_to_string(name)
      instance_eval do
        ERB.new(self.class.view(name), nil, "%<>-").result(binding)
      end
    end

    def partial(name, *collection)
      return render_to_string(name) if collection.empty?
      collection.map do |item|
        Template.new(item).render_to_string(name)
      end.join("\n")
    end

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
          :color => (i == index ? :red : :gray)
        }
      end
    end

  end
end
