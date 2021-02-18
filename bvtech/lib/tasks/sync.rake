namespace :sync do
  # with a little modification it can be used for other API-s too
  desc "Syncing a sports.json"
  task :sports, %i[url proxy] => :environment do |t, args|
    args.with_defaults(proxy: false)

    proxy_url = args['proxy'] ? WebProxy::DEFAULT_WEB_PROXY : nil
    proxy = WebProxy.new(proxy_url: proxy_url)

    sports_from_api = proxy.get_content(args['url'])

    sports_from_api.each do |sport|
      if s = Sport.find_by(external_id: sport['id'], name: sport['description'])
        s.activate unless s.active
      else
        s = Sport.create!(external_id: sport['id'], name: sport['description'], active: false)
        s.activate
      end
    end
  end
end

