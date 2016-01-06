module JSONRequests

  def json_get(url, arg2 = nil)
    get rootify(url), arg2, { 'HTTP_ACCEPT' => 'application/json' }
  end

  def json_post(url, arg2 = nil)
    post rootify(url), arg2, { 'HTTP_ACCEPT' => 'application/json' }
  end

  def json_put(url, arg2 = nil)
    put rootify(url), arg2, { 'HTTP_ACCEPT' => 'application/json' }
  end

  def json_delete(url, arg2 = nil)
    delete rootify(url), arg2, { 'HTTP_ACCEPT' => 'application/json' }
  end

  def authenticated_json_get(user, url, arg2 = nil)
    auth_header = user.create_new_auth_token
    get rootify(url), arg2, auth_header.merge({ 'HTTP_ACCEPT' => 'application/json' })
  end

  def authenticated_json_post(user, url, arg2 = nil)
    auth_header = user.create_new_auth_token
    post rootify(url), arg2, auth_header.merge({ 'HTTP_ACCEPT' => 'application/json' })
  end

  def authenticated_json_put(user, url, arg2 = nil)
    auth_header = user.create_new_auth_token
    put rootify(url), arg2, auth_header.merge({ 'HTTP_ACCEPT' => 'application/json' })
  end

  def authenticated_json_delete(user, url, arg2 = nil)
    auth_header = user.create_new_auth_token
    delete rootify(url), arg2, auth_header.merge({ 'HTTP_ACCEPT' => 'application/json' })
  end

  def rootify(url)
    if url[0] == '/'
      url
    else
      "/#{url}"
    end
  end


end

module RSpec::Rails::RequestExampleGroup
  include JSONRequests
  include JsonSpec::Matchers
  include JsonSpec::Helpers
end

RSpec.configure do |config|
  config.include JsonSpec::Helpers, :type => :serializer
end
