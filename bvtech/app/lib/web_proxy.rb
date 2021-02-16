class WebProxy
  DEFAULT_WEB_PROXY = 'https://web-proxy.io/proxy/'

  def initialize(proxy_url: nil)
    @proxy_url = proxy_url
  end

  def get_content(query_url)
    # sorry for this, Faraday combined with webmock is dumb :/
    query_url = "https://#{query_url}" if @proxy_url.nil?
    connection.get(query_url).body
  end

  private

  def connection
    Faraday.new(url: @proxy_url) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :json
    end
  end
end

