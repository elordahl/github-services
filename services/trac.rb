class Service::Trac < Service
  string :url, :token

  def receive_push
    http.ssl[:verify] = false
    http.url_prefix = data['url']
    http_post "github/#{data['token']}", :payload => payload.to_json
  rescue Faraday::Error::ConnectionFailed
    raise_config_error "Connection refused. Invalid server URL."
  end
end
