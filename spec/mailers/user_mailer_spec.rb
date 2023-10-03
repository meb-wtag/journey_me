require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user) }

  describe '#registration_confirmation' do
    let(:mail) { UserMailer.registration_confirmation(user) }

    it 'sends an email to the user' do
      expect(mail.to).to eq(user.email)
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Registration Confirmation')
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'assigns the user' do
      expect(mail.body.encoded).to match(user.username)
    end
  end
end
