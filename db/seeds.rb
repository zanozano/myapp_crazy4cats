require 'faker'
require 'json'
require 'httparty'

# Generar 10 usuarios falsos
10.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.save
end

10.times do
  response = HTTParty.get('https://api.thecatapi.com/v1/images/search')
  data = JSON.parse(response.body)

  image_url = data.first['url']

  post = Post.new(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 5),
    img: image_url
  )
  post.save
end



