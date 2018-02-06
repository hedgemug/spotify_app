require 'unirest'

while true
  system 'clear'
  puts "Welcome to the Spotify App!"
  puts "[1] Connect to Spotify"
  puts "[2] Show Spotify info"
  puts "[q] To quit"

  input_option = gets.chomp

  if input_option == "1"
    response = Unirest.get("http://localhost:3000/spotify/authorize")
    p response.body
    system "open '#{response.body["url"]}'"
    puts "In your web browser, hit okay, then enter the code: "
    code = gets.chomp
    response = Unirest.get("http://localhost:3000/spotify/tokens?code=#{code}")
    puts JSON.pretty_generate(response.body)
    access_token = response.body['access_token']
  elsif input_option == "2"
    response = Unirest.get("http://localhost:3000/spotify/profile?access_token=#{access_token}")
    puts JSON.pretty_generate(response.body)
  elsif input_option == "q"
    break
  end
  puts "Press enter to continue"
  gets.chomp
end