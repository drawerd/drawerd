# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'drawerd/version'

Gem::Specification.new do |spec|
  spec.name          = 'drawerd'
  spec.version       = Drawerd::VERSION
  spec.authors       = ['Hooopo Wang']
  spec.email         = ['hoooopo@gmail.com']

  spec.summary       = 'generate erd for rails, using rails-erd and drawerd.com service.'
  spec.description   = 'Generate erd for rails, usiing rails-erd and drawerd.com service.'
  spec.homepage      = 'https://help.drawerd.com'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'rails-erd', '~> 1.6'
  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 12.3.3'
end
