require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

Dir.glob('lib/tasks/*.rake').each { |r| load r }

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
end

task default: :test
task spec: :test
