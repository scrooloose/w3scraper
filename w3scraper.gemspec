Gem::Specification.new do |s|
  s.name        = 'w3scraper'
  s.version     = '0.0.1'
  s.date        = '2012-05-02'
  s.summary     = "Command line interface to http://validator.w3.org"
  s.description = "Sends a file to http://validator.w3.org and parses/outputs any errors."
  s.authors     = ["Martin Grenfell"]
  s.email       = 'martin.grenfell@gmail.com'
  s.files       = ["lib/w3scraper.rb", "bin/w3scraper"]
  s.executables = ["w3scraper"]
  s.homepage    = 'http://rubygems.org/gems/w3scraper'
end
