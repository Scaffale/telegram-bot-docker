desc 'link webhooks, needs TELEGRAM_WEBHOOK_LINK set to true'
task :link_webhook do
  if ENV['SKIP_FILE_CONVERSION'] == 'true'
    Rake::Task["telegram:bot:set_webhook"].invoke
  end
end
