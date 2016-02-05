require_relative "lib/MutantsAPIGem/version"

Gem::Specification.new do |spec|
  spec.name          = "MutantsAPIGem"
  spec.version       = MutantsAPIGem::VERSION
  spec.authors       = ["Will Brooks"]
  spec.email         = ["wbrooks@salesforce.com"]

  spec.summary       = "API Gem to create Mutant Tests"
  spec.description   = "API Gem to create Mutant Tests"
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~>0.13.7"
  spec.add_dependency "cucumber", "~>1.3.20"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8.2"
end
