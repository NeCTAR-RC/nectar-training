require 'html/proofer'


opts = { :empty_alt_ignore => true,
         :disable_external => true,
       }

task :test do
  sh "bundle exec jekyll build"
  HTML::Proofer.new("./_site", opts).run
end
