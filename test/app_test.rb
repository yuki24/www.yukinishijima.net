require "minitest"
require "minitest/autorun"
require "rack/test"
require "pry-byebug"

require_relative "../app"

class HomepageTest < Minitest::Test
  include Rack::Test::Methods

  def app
    builder = Rack::Builder.new
    builder.run REDIRECT_APP
  end

  def test_redirect_to_medium_top
    get '/'

    assert_equal 302, last_response.status
    assert_equal 'https://medium.com/@yuki.nishijima/', last_response.headers['location']

    get '/does_not_exist'

    assert_equal 302, last_response.status
    assert_equal 'https://medium.com/@yuki.nishijima/', last_response.headers['location']
  end

  def test_redirect_to_medium_blog_on_kaminari_and_bootstrap
    get '/2012/11/17/kaminari-plus-bootstrap.html'

    assert_equal 302, last_response.status
    assert_equal 'https://medium.com/@yuki.nishijima/kaminari-bootstrap-987bfd34feef', last_response.headers['location']
  end

  def test_redirect_to_medium_blog_on_did_you_mean
    get '/2014/10/21/did-you-mean-experience-in-ruby.html'

    assert_equal 302, last_response.status
    assert_equal 'https://medium.com/@yuki.nishijima/did-you-mean-experience-in-ruby-be0d4dcf2ad2', last_response.headers['location']
  end

  def test_redirect_to_medium_blog_on_kaminari_1_0_0
    get '/2017/01/14/kaminari-1-0-0.html'

    assert_equal 302, last_response.status
    assert_equal 'https://medium.com/@yuki.nishijima/5-major-changes-in-kaminari-1-0-0-44cb3d12ae54', last_response.headers['location']
  end
end
