# -*- encoding: utf-8 -*-
# stub: hanami-mailer 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hanami-mailer"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Luca Guidi", "Ines Coelho", "Rosa Faria"]
  s.bindir = "exe"
  s.date = "2016-01-22"
  s.description = "Mail for Ruby applications and Hanami mailers"
  s.email = ["me@lucaguidi.com", "ines.opcoelho@gmail.com", "rosa1853@live.com"]
  s.homepage = "http://hanamirb.org"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Mail for Ruby applications."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hanami-utils>, ["~> 0.7"])
      s.add_runtime_dependency(%q<tilt>, [">= 2.0.1", "~> 2.0"])
      s.add_runtime_dependency(%q<mail>, ["~> 2.5"])
      s.add_development_dependency(%q<bundler>, ["~> 1.10"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>, ["~> 5.7"])
    else
      s.add_dependency(%q<hanami-utils>, ["~> 0.7"])
      s.add_dependency(%q<tilt>, [">= 2.0.1", "~> 2.0"])
      s.add_dependency(%q<mail>, ["~> 2.5"])
      s.add_dependency(%q<bundler>, ["~> 1.10"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<minitest>, ["~> 5.7"])
    end
  else
    s.add_dependency(%q<hanami-utils>, ["~> 0.7"])
    s.add_dependency(%q<tilt>, [">= 2.0.1", "~> 2.0"])
    s.add_dependency(%q<mail>, ["~> 2.5"])
    s.add_dependency(%q<bundler>, ["~> 1.10"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<minitest>, ["~> 5.7"])
  end
end
