require_relative 'lib/nessus_client/version'
Gem::Specification.new do |spec|
  spec.name           = %q{nessus_client}
  spec.author         = %q{Heyder}
  spec.platform       = Gem::Platform::RUBY
  spec.version        = NessusClient::VERSION
  spec.date           = %q{2018-11-28}
  spec.summary        = %q{Usable, fast, simple Ruby gem for Tenable Nessus Pro v6.x and v7.x }
  spec.licenses       = ['MIT']  
  spec.description    = "NessusClient was designed to be simple, fast and performant through communication with Nessus over REST interface."
  spec.email          = 'eu@heyderandrade.org'
  spec.homepage       = 'https://github.com/heyder/nessus_client'
  spec.metadata["yard.run"] = "yri"
  spec.metadata = { 
    "documentation_uri" => "https://rubydoc.info/github/heyder/nessus_client/",
    "source_code_uri"   => "https://github.com/heyder/nessus_client"
  }
  spec.extra_rdoc_files = ['README.md', 'CONTRIBUTING.md']
  spec.files          = Dir['lib/**/*.rb']
  spec.require_paths  = ["lib"]
  spec.required_ruby_version = '>= 2.5.1'

  spec.add_dependency( 'excon', '~> 0.62' )
  spec.add_dependency( 'oj', '~> 3.7' )
  spec.add_dependency( 'json', '~> 2.1' )

  spec.add_development_dependency( 'rspec', '~> 3.2' )
  spec.add_development_dependency( 'bundler', '~> 1.12' )
  spec.add_development_dependency( 'pry', '~> 0.12.2' )
  spec.add_development_dependency( 'simplecov', '~> 0.17.0' )
  spec.add_development_dependency( 'codecov', '~> 0.1.14' )
  spec.add_development_dependency( 'yard', '~> 0.9', '>= 0.9.20')

end