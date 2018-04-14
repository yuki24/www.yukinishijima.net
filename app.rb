class App
  attr_reader :redirect_url_map, :default_redirect_url

  def initialize(default_redirect_url: , redirect_url_map: )
    @default_redirect_url, @redirect_url_map = default_redirect_url, redirect_url_map
  end

  def call(env)
    redirect_url = redirect_url_map[env['PATH_INFO']] || default_redirect_url

    [ 302, { "Location" => redirect_url }, ["You will be redirected to #{redirect_url}"] ]
  end
end

REDIRECT_APP =
  App.new(
    default_redirect_url: "https://medium.com/@yuki.nishijima/",
    redirect_url_map: {
      "/2017/01/14/kaminari-1-0-0.html"                  => 'https://medium.com/@yuki.nishijima/5-major-changes-in-kaminari-1-0-0-44cb3d12ae54',
      "/2014/10/21/did-you-mean-experience-in-ruby.html" => 'https://medium.com/@yuki.nishijima/did-you-mean-experience-in-ruby-be0d4dcf2ad2',
      "/2012/11/17/kaminari-plus-bootstrap.html"         => 'https://medium.com/@yuki.nishijima/kaminari-bootstrap-987bfd34feef',
    }
  )
