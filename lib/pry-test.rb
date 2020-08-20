# frozen_string_literal: true

path = File.expand_path("../pry-test/**/*.rb", __FILE__)
Dir[path].sort.each { |file| require file }
