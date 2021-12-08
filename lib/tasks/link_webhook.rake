desc 'link webhooks, needs TELEGRAM_WEBHOOK_LINK set to true'
task :link_webhook do
  Rake::Task['telegram:bot:set_webhook'].invoke if ENV['TELEGRAM_WEBHOOK_LINK'] == 'true'
end
