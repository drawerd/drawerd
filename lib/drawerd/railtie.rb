class Drawerd::Railtie < Rails::Railtie
  rake_tasks do
    load 'tasks/drawerd.rake'
  end
end