module TestUrlHelpers
  def full_url(rails_path)
    return "http://127.0.0.1:"+Capybara.current_session.server.port.to_s+rails_path
  end
end
