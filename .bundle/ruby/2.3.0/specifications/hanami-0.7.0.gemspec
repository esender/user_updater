# -*- encoding: utf-8 -*-
# stub: hanami 0.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hanami"
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Luca Guidi", "Trung L\u{ea}", "Alfonso Uceda Pompa"]
  s.date = "2016-01-22"
  s.description = "Hanami is a web framework for Ruby"
  s.email = ["me@lucaguidi.com", "trung.le@ruby-journal.com", "uceda73@gmail.com"]
  s.executables = ["hanami"]
  s.files = ["bin/hanami"]
  s.homepage = "http://hanamirb.org"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "The web, with simplicity."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hanami-utils>, ["~> 0.7"])
      s.add_runtime_dependency(%q<hanami-router>, ["~> 0.6"])
      s.add_runtime_dependency(%q<hanami-controller>, ["~> 0.6"])
      s.add_runtime_dependency(%q<hanami-view>, ["~> 0.6"])
      s.add_runtime_dependency(%q<hanami-helpers>, ["~> 0.3"])
      s.add_runtime_dependency(%q<hanami-mailer>, ["~> 0.2"])
      s.add_runtime_dependency(%q<hanami-assets>, ["~> 0.2"])
      s.add_runtime_dependency(%q<shotgun>, ["~> 0.9"])
      s.add_runtime_dependency(%q<dotenv>, ["~> 2.0"])
      s.add_runtime_dependency(%q<thor>, ["~> 0.19"])
      s.add_runtime_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<minispec-metadata>, ["~> 3.2.1"])
      s.add_development_dependency(%q<minitest>, ["~> 5"])
      s.add_development_dependency(%q<rack-test>, ["~> 0.6"])
      s.add_development_dependency(%q<rake>, ["~> 10"])
    else
      s.add_dependency(%q<hanami-utils>, ["~> 0.7"])
      s.add_dependency(%q<hanami-router>, ["~> 0.6"])
      s.add_dependency(%q<hanami-controller>, ["~> 0.6"])
      s.add_dependency(%q<hanami-view>, ["~> 0.6"])
      s.add_dependency(%q<hanami-helpers>, ["~> 0.3"])
      s.add_dependency(%q<hanami-mailer>, ["~> 0.2"])
      s.add_dependency(%q<hanami-assets>, ["~> 0.2"])
      s.add_dependency(%q<shotgun>, ["~> 0.9"])
      s.add_dependency(%q<dotenv>, ["~> 2.0"])
      s.add_dependency(%q<thor>, ["~> 0.19"])
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<minispec-metadata>, ["~> 3.2.1"])
      s.add_dependency(%q<minitest>, ["~> 5"])
      s.add_dependency(%q<rack-test>, ["~> 0.6"])
      s.add_dependency(%q<rake>, ["~> 10"])
    end
  else
    s.add_dependency(%q<hanami-utils>, ["~> 0.7"])
    s.add_dependency(%q<hanami-router>, ["~> 0.6"])
    s.add_dependency(%q<hanami-controller>, ["~> 0.6"])
    s.add_dependency(%q<hanami-view>, ["~> 0.6"])
    s.add_dependency(%q<hanami-helpers>, ["~> 0.3"])
    s.add_dependency(%q<hanami-mailer>, ["~> 0.2"])
    s.add_dependency(%q<hanami-assets>, ["~> 0.2"])
    s.add_dependency(%q<shotgun>, ["~> 0.9"])
    s.add_dependency(%q<dotenv>, ["~> 2.0"])
    s.add_dependency(%q<thor>, ["~> 0.19"])
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<minispec-metadata>, ["~> 3.2.1"])
    s.add_dependency(%q<minitest>, ["~> 5"])
    s.add_dependency(%q<rack-test>, ["~> 0.6"])
    s.add_dependency(%q<rake>, ["~> 10"])
  end
end
