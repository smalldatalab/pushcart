Griddler.configure do |config|
  config.processor_class = EmailProcessor
  config.processor_method = :process
  config.email_service = :mandrill
end