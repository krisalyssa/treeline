require 'bundler'
require 'rake'
require 'rake/testtask'
require File.expand_path('../lib/treeline/version', __FILE__)

Bundler::GemHelper.install_tasks

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
end

# namespace :test do
#   Rake::TestTask.new(:lint) do |test|
#     test.libs << 'lib' << 'test'
#     test.pattern = 'test/test_active_model_lint.rb'
#   end
# 
#   task :all => ['test', 'test:lint']
# end

# task :default => 'test:all'
task :default => 'test'

desc 'Builds the gem'
task :build do
  sh "gem build treeline.gemspec"
end

desc 'Builds and installs the gem'
task :install => :build do
  sh "gem install pkg/treeline-#{Treeline::VERSION}.gem"
end

desc 'Tags version, pushes to remote, and pushes gem'
task :release => :build do
  sh "git tag v#{Treeline::VERSION}"
  sh "git push origin master"
  sh "git push origin v#{Treeline::VERSION}"
  sh "gem push treeline-#{Treeline::VERSION}.gem"
end