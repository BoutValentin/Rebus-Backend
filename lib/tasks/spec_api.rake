require 'rspec/core/rake_task'

desc 'Run API specs test in spec/acceptance'
  RSpec::Core::RakeTask.new('spec:api') do |t|
  t.pattern = 'spec/requests/**/*_spec.rb'
  #t.rspec_opts = ["--format RspecApiDocumentation::ApiFormatter"]
end