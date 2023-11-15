# frozen_string_literal: true

# 30.times do
#   title = Faker::Hipster.sentence(word_count: 3)
#   body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)

#   Question.create title:, body:
# end

40.times do
  body = Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)

  Answer.create(body:, question: Question.order(created_at: :desc).first)
end
