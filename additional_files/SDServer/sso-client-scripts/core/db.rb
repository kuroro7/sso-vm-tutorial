require 'mysql2-cs-bind'

def db_connect
    Mysql2::Client.new(
        host: DB_HOST,
        port: DB_PORT,
        username: DB_USER,
        password: DB_PASSWORD,
        database: DB_NAME
      )
end