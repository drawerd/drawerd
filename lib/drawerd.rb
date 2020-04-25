# frozen_string_literal: true

require 'drawerd/version'
require 'drawerd/railtie' if defined?(Rails)

module Drawerd
  class Error < StandardError; end
  # Your code goes here...
  class << self
    def loaded_tasks=(val); @loaded_tasks = val; end
    def loaded_tasks; return @loaded_tasks; end

    def load_tasks
      return if(self.loaded_tasks)
      self.loaded_tasks = true

      Dir[File.join(File.dirname(__FILE__), 'tasks', '**/*.rake')].each { |rake| load rake }
    end
  end
end
