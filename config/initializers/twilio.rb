TWILIO_CONFIG = YAML.load_file("#{::Rails.root}/config/twilio.yml")[::Rails.env]
