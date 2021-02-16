class WebProxy
  DEFAULT_WEB_PROXY = 'https://web-proxy.io/proxy/'

  def initialize(proxy_url:)
    @proxy_url = proxy_url
  end

  def get_content(query)
    connection.get(query).body
  end

  private

  def connection
    Faraday.new(url: @proxy_url) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :json
    end
  end
end

