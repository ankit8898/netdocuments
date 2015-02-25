$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'netdocuments'
  s.version     = '0.0.6'
  s.licenses    = ['MIT']
  s.summary     = "Ruby wrapper for Netdocuments REST API"
  s.description = "A ruby wrapper to access the Netdocuments Rest API"
  s.authors     = ["ankit8898"]
  s.email       = 'ankit.gupta8898@gmail.com'
  s.files       = [
    "lib/netdocuments/access_token_master.rb",
    "lib/netdocuments/base.rb",
    "lib/netdocuments/cabinet.rb",
    "lib/netdocuments/client.rb",
    "lib/netdocuments/configuration.rb",
    "lib/netdocuments/document.rb",
    "lib/netdocuments/folder.rb",
    "lib/netdocuments/node.rb",
    "lib/netdocuments/path_formatter.rb",
    "lib/netdocuments.rb",
  ]
  s.homepage    = 'https://rubygems.org/gems/netdocuments'
  s.add_development_dependency 'rspec','~> 3.2', '>= 3.2.0'
  s.add_development_dependency 'rspec-collection_matchers', '~> 1.1', '>= 1.1.2'
  s.add_runtime_dependency 'httparty','~> 0'
  s.add_runtime_dependency 'time_difference','~> 0'
  s.add_runtime_dependency 'parallel','~> 0'
  s.post_install_message = "Thanks for installing!"
end
