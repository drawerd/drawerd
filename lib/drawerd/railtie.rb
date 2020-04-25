# frozen_string_literal: true

class Drawerd::Railtie < Rails::Railtie
  rake_tasks do
    Drawerd.load_tasks
  end
end
