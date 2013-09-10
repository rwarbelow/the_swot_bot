SEND_GRID_CONFIG = YAML.load_file("#{::Rails.root}/config/send_grid.yml")[::Rails.env]
