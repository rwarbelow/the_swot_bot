namespace :db do
  task :redo => ['db:drop', 'db:create', 'db:migrate', 'db:seed']
end
