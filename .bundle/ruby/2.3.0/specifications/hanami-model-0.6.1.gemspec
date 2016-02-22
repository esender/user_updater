# -*- encoding: utf-8 -*-
# stub: hanami-model 0.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "hanami-model"
  s.version = "0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Luca Guidi", "Trung L\u{ea}", "Alfonso Uceda"]
  s.date = "2016-02-05"
  s.description = "A persistence framework with entities, repositories, data mapper and query objects"
  s.email = ["me@lucaguidi.com", "trung.le@ruby-journal.com", "uceda73@gmail.com"]
  s.homepage = "http://hanamirb.org"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "A persistence layer for Hanami"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hanami-utils>, ["~> 0.7"])
      s.add_runtime_dependency(%q<sequel>, ["~> 4.9"])
      s.add_development_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<minitest>, ["~> 5"])
      s.add_development_dependency(%q<rake>, ["~> 10"])
    else
      s.add_dependency(%q<hanami-utils>, ["~> 0.7"])
      s.add_dependency(%q<sequel>, ["~> 4.9"])
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<minitest>, ["~> 5"])
      s.add_dependency(%q<rake>, ["~> 10"])
    end
  else
    s.add_dependency(%q<hanami-utils>, ["~> 0.7"])
    s.add_dependency(%q<sequel>, ["~> 4.9"])
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<minitest>, ["~> 5"])
    s.add_dependency(%q<rake>, ["~> 10"])
  end
end
