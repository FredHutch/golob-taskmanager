require 'tempfile'
require 'chef/cookbook/metadata'
require 'chef/application/knife'
require 'json'

branch = ENV['BRANCH_NAME']
puts "branch is #{branch}"
task :test do
  require 'foodcritic'
  require 'rubocop/rake_task'
  puts 'Running foodcritic'
  @foodcritic_options = {
    fail_tags: ['any'],
    cookbook_paths: ['.'],
    exclude_paths: ['test/**/*', 'spec/**/*', 'features/**/*'],
    progress: true
  }
  linter = FoodCritic::Linter.new
  result = linter.check(@foodcritic_options)
  if result.failed? || !result.warnings.empty?
    puts 'foodcritic failed:'
    puts result
    raise
  end
  puts 'Running rubocop'
  task = RuboCop::RakeTask.new
  task.fail_on_error = true
  result = task.run_main_task(false)
  puts result
  Rake::Task['jsonlint'].invoke
end

task :jsonlint do
  puts 'Running jsonlint'
  require 'jsonlint'
  linter = ::JsonLint::Linter.new
  files_to_check = Rake::FileList.new('./**/*.json')
  linter.check_all(files_to_check)
  if linter.errors?
    linter.display_errors
    puts "JSON lint found #{linter.errors.length} errors"
    abort('JsonLint failed!')
  else
    puts 'JsonLint found no errors'
  end
end
