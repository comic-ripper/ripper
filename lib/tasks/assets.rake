namespace :assets do
  task :install do
    `bower install`
    `sed -i /\\icon-font\\/d vendor/assets/bower_components/bootswatch-scss/*/_variables.scss`
  end
end
