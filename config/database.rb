configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///postgres/onebitbot_production')

  set :database, {
    adapter:  'postgresql',
    host:     db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  }
end

configure :test do
  set :database,
      adapter: 'postgresql',
      encoding: 'utf8',
      database: 'onebitbot_test',
      pool: 5,
      username: 'postgres',
      host: 'postgres'
end

configure :development do
  set :database,
      adapter: 'postgresql',
      encoding: 'utf8',
      database: 'onebitbot_development',
      pool: 5,
      username: 'postgres',
      host: 'postgres'
end


