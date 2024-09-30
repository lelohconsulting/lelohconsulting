# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :blog do |blog|
  blog.permalink = "blog/{category}/{title}.html"
end

activate :livereload
activate :i18n
set :relative_links, true
activate :directory_indexes

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

helpers do 
  def lang_helper    
    prefix="/";
    if I18n.locale.to_s != 'en' then 
      prefix ="/" + I18n.locale.to_s + "/"      
    end

    prefix
  end

  def frenchUrl
    page = current_page.url

    if page.start_with?('/fr/') then
      return page
    else
      return '/fr' + page
    end
  end

  def englishUrl
    page = current_page.url
    
    if page.start_with?('/fr/') == false then
      return page
    else
      return page[3, page.length]
    end
    
  end

  def activeEnglish
    activeClass=""
    if I18n.locale.to_s == 'en' then 
      activeClass = "active"
    end

    activeClass
  end

  def activeFrench
    activeClass=""
    if I18n.locale.to_s == 'fr' then 
      activeClass="active"
    end

    activeClass
  end  
end


configure :build do
  activate :minify_css
  activate :minify_javascript, compressor: Terser.new
  activate :minify_html
end
