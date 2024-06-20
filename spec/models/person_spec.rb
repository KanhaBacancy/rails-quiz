# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  phone_number :string           not null
#  email        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#

require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to belong_to(:company).optional }
  describe '.by_email' do
    let!(:person) { Person.create(name: "abc", email: 'test@example.com', phone_number: "123423") }

    context 'when email exists' do
      it 'returns the person with the given email' do
        expect(Person.by_email('test@example.com')).to include(person)
      end
    end

    context 'when email does not exist' do
      it 'returns an empty relation' do
        expect(Person.by_email('nonexistent@example.com')).to be_empty
      end
    end

    context 'when email is nil' do
      it 'returns all people' do
        other_person = Person.create(name: "xyz", email: 'other@example.com', phone_number: "123423")
        expect(Person.by_email(nil)).to match_array([person, other_person])
      end
    end
  end
end
