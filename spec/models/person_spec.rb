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
  subject { described_class.new(name: 'John Doe', phone_number: '1234567890', email: 'john.doe@example.com', email_confirmation: 'john.doe@example.com') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an email confirmation' do
    subject.email_confirmation = ""
    expect(subject).to_not be_valid
  end

  it 'is not valid if email and email confirmation do not match' do
    subject.email_confirmation = 'different.email@example.com'
    expect(subject).to_not be_valid
  end

  it 'is not valid if email is not unique' do
    described_class.create!(name: 'Jane Doe', phone_number: '0987654321', email: 'john.doe@example.com', email_confirmation: 'john.doe@example.com')
    expect(subject).to_not be_valid
  end
end
