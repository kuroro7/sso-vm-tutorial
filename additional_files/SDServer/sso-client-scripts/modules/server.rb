require 'fileutils'
require 'fiddle/import'
require 'net/http'
require 'digest'

module Server
    def self.add_user
        client = db_connect()
    
        puts '[[[ USER CREATION SCRIPT ]]]'
        puts ' -------------------------- '

        print ' login: '
        login = gets.chomp
        print ' passwd: '
        pass = gets.chomp
        print ' email: '
        email = gets.chomp
    
        salt = login + pass
        salt = Digest::MD5.hexdigest(salt)
        salt = "0x#{salt}"
        date = Time.now.strftime('%Y-%m-%d %H:%M:%S')
        client.xquery("CALL adduser(?, ?, 0, 0, 0, 0, ?, 0, 0, 0, 0, 0, 0, 0, ?, '', ?)", login, salt, email, date, salt)

        client.close
    
        puts "Created!"
    rescue => e
        raise e
    end

    def self.get_users
        client = db_connect()
        results = client.xquery("SELECT * FROM users").to_a
        client.close
        results
    end

    def self.add_gm_role
        client = db_connect()
    
        puts '[[[ SET GM ROLE SCRIPT ]]]'
        puts ' ------------------------ '
        print ' Username: '
        username = gets.chomp
    
        results = client.xquery("SELECT * FROM users WHERE name = ?", username).to_a
    
        user = results.first
    
        unless user
            puts ' [INFO] User not found!'
            return
        end
    
        puts " { id: #{user['ID']}, name: #{user['name']} } found!"
        client.xquery(" CALL `zx`.`addGM`(#{user['ID']}, 0);")
        puts " GM role added!"
    
        client.close
    rescue => e
        client.close
        raise e
    end
    
    def self.stop
        puts '[INFO] Killing server ...'
        Net::HTTP.post(URI("http://#{SDS_HOST}:4567/stop"), '')
    end

    def self.start
        puts '[INFO] Starting server ...'
        Net::HTTP.post(URI("http://#{SDS_HOST}:4567/start"), '')
    end

    def self.options
        [:start, :stop, :get_users, :add_user, :add_gm_role]
    end
end
