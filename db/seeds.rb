# frozen_string_literal: true

# 30.times do
#   title = Faker::Hipster.sentence(word_count: 3)
#   body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)

#   Question.create title:, body:
# end

# 40.times do
#   body = Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)

#   Answer.create(body:, question: Question.order(created_at: :desc).first)
# end

# 30.times do
#   created_at, updated_at = Faker::Time.between(from: DateTime.now - 10, to: DateTime.now)

#   main_hash = Faker::Internet.user('username', 'email', 'password')

#   user = User.new(name: main_hash[:username], email: main_hash[:email], password: main_hash[:password],
#                   password_confirmation: main_hash[:password], created_at:, updated_at:)

#   user.save
# end

# User.find_each do |user|
#   user.send(:set_gravatar_hash)
#   user.save
# end

30.times do
  title = Faker::Hipster.word
  Tag.find_or_create_by title:
end
