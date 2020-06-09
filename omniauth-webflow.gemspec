require_relative 'lib/omniauth-webflow/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-webflow"
  spec.version       = Omniauth::Webflow::VERSION
  spec.authors       = ["Andrew Gertig"]
  spec.email         = ["andrew.gertig@gmail.com"]

  spec.summary       = %q{Omniauth strategy for Webflow}
  spec.description   = %q{Omniauth strategy for Webflow}
  spec.homepage      = "https://github.com/gertig/omniauth-webflow"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gertig/omniauth-webflow"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.add_runtime_dependency 'omniauth-oauth2'
  # spec.add_runtime_dependency 'multi_json'

  spec.add_dependency 'omniauth-oauth2', '~> 1.6.0'
  spec.add_dependency 'multi_json', '~> 1.13.1'
end
