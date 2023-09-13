5.times do
  journal_dummy = Journal.create(title: FFaker::Lorem.sentence, description: FFaker::Lorem.sentence)
  journal_entry_dummy = JournalEntry.create(
    journal:,
    title: FFaker::Lorem.sentence,
    content: FFaker::Lorem.sentence,
    goal: FFaker::Lorem.sentence
  )
end
