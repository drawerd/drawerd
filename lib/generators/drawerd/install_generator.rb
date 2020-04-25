module Drawerd
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy drawerd rakefiles for automatic graphic generation"
      source_root File.expand_path('../templates', __FILE__)

      # copy rake tasks
      def copy_tasks
        template "auto_drawerd.rake", "lib/tasks/auto_drawerd.rake"
      end

    end
  end
end
