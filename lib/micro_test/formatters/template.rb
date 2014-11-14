module MicroTest
  class Template
    include Color

    def self.view(name)
      @views ||= {}
      @views[name] ||= File.read(File.expand_path("../views/default/#{name}.txt.erb", __FILE__))
    end

    def initialize(object, *helpers)
      @context = object
      helpers.each { |helper| extend helper }
    end

    def render(name)
      instance_eval do
        print ERB.new(self.class.view(name), nil, ">").result(binding)
      end
    end

    def partial(name, options={})
      return render(name) if options[:collection].nil?
      options[:collection].each do |item|
        Template.new(item).render(name)
      end
    end

  end
end
