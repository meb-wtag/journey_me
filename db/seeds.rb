# frozen_string_literal: true

5.times do
  Journal.create(title: FFaker::Lorem.sentence, description: FFaker::Lorem.sentence)
  JournalEntry.create(
    journal:,
    title: FFaker::Lorem.sentence,
    content: FFaker::Lorem.sentence,
    goal: FFaker::Lorem.sentence
  )
end
