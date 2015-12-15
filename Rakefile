require 'html/proofer'


opts = { :empty_alt_ignore => true}

task :test do
  sh "bundle exec jekyll build"
  HTML::Proofer.new("./_site", opts).run
end
