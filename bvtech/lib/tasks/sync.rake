namespace :sync do
  # with a little modification it can be used for other API-s too
  desc "Syncing a sports.json"
  task :sports, %i[url proxy] => :environment do |t, args|
    args.with_defaults(proxy: false)

    proxy_url = args['proxy'] ? WebProxy::DEFAULT_WEB_PROXY : nil
    proxy = WebProxy.new(proxy_url: proxy_url)

    proxy.get_content(args['url'])
  end
end
