journal_dummy = Journal.create(title: "Test", description: "text")
entry_dummy = JournalEntry.create(journal: journal_dummy, title: "Test", content: "text", goal: "abc")
