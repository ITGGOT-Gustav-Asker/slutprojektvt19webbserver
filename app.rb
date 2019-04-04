require 'sqlite3'
require 'sinatra'
require 'slim'
# enable :sessions

#Startsida
get('/') do
    slim(:index)
end

get('/register') do
    slim(:register)
end

post ('/create') do
    name = params["name"]
    tel = params["tel"]
    email = params["email"]
    password = params["password"]
    db = SQLite3::Database.new("database/database.db")
    db.results_as_hash = true
    db.execute("INSERT INTO users (name, tel, email, password) VALUES (?,?,?,?)", name, tel, email, password)
    redirect('/')
end

get('/logged') do
    slim(:logged)
end

post('/logged') do
    email = params["email"]
    password = params["password"]
    db = SQLite3::Database.new("database/database.db")
    db.results_as_hash = true
    current = db.execute("SELECT password FROM users WHERE email is (?)", email)
    current = current.first["password"]
    user_id = db.execute("SELECT id FROM users WHERE email is (?)", email)
    user_id = user_id.first["id"]



#   p "user_id: #{user_id}"
#   p "Password: #{password}"
#   p "Current: #{current}"
     if password == current
        redirect('/logged')
     else
        redirect('/')
     end
end
