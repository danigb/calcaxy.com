require 'lib/calcaxy'
Calcaxy.load


Calcaxy.booc_years.each do |year|
  proxy "/booc/#{year}", "/booc/year.html",
    locals: { current_year: year}, ignore: true
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'



# Build-specific configuration
configure :build do
  # activate :minify_css
  # activate :minify_javascript
  # activate :asset_hash
  # activate :relative_assets
  # set :http_prefix, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = 'liki.es'
  deploy.path   = '/home/deployer/calcaxy.com'
  deploy.user  = 'deployer' # no default
  # deploy.port  = 5309 # ssh port, default: 22
  # deploy.clean = true # remove orphaned files on remote host, default: false
  # deploy.flags = '-rltgoDvzO --no-p --del' # add custom flags, default: -avz
end
