FactoryBot.define do
  factory :journal_entry do
    journal_id {1}
    title { 'Test' }
    content { 'abc' }
    goal { 'abc' }
  end
end
