# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "wordnik"
  s.version = "4.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zeke Sikelianos", "John McGrath"]
  s.date = "2013-03-01"
  s.description = "This gem provides a simple interface to the entire Wordnik API. Its methods are defined by the documentation that comes from the API itself, so it's guaranteed to be up to date."
  s.email = ["zeke@wordnik.com", "john@wordnik.com"]
  s.homepage = "http://developer.wordnik.com"
  s.require_paths = ["lib"]
  s.rubyforge_project = "wordnik"
  s.rubygems_version = "2.0.3"
  s.summary = "A ruby wrapper for the Wordnik API"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<typhoeus>, [">= 0.2.1"])
      s.add_runtime_dependency(%q<htmlentities>, [">= 4.2.4"])
      s.add_runtime_dependency(%q<addressable>, [">= 2.2.4"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.4"])
      s.add_runtime_dependency(%q<activemodel>, [">= 3.0.3"])
      s.add_runtime_dependency(%q<json>, [">= 1.4.6"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<vcr>, ["~> 1.11.3"])
      s.add_development_dependency(%q<webmock>, [">= 1.6.2"])
      s.add_development_dependency(%q<autotest>, [">= 0"])
      s.add_development_dependency(%q<autotest-rails-pure>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<ruby-prof>, [">= 0"])
    else
      s.add_dependency(%q<typhoeus>, [">= 0.2.1"])
      s.add_dependency(%q<htmlentities>, [">= 4.2.4"])
      s.add_dependency(%q<addressable>, [">= 2.2.4"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
      s.add_dependency(%q<activemodel>, [">= 3.0.3"])
      s.add_dependency(%q<json>, [">= 1.4.6"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<vcr>, ["~> 1.11.3"])
      s.add_dependency(%q<webmock>, [">= 1.6.2"])
      s.add_dependency(%q<autotest>, [">= 0"])
      s.add_dependency(%q<autotest-rails-pure>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<ruby-prof>, [">= 0"])
    end
  else
    s.add_dependency(%q<typhoeus>, [">= 0.2.1"])
    s.add_dependency(%q<htmlentities>, [">= 4.2.4"])
    s.add_dependency(%q<addressable>, [">= 2.2.4"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
    s.add_dependency(%q<activemodel>, [">= 3.0.3"])
    s.add_dependency(%q<json>, [">= 1.4.6"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<vcr>, ["~> 1.11.3"])
    s.add_dependency(%q<webmock>, [">= 1.6.2"])
    s.add_dependency(%q<autotest>, [">= 0"])
    s.add_dependency(%q<autotest-rails-pure>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<ruby-prof>, [">= 0"])
  end
end
