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
  subject { described_class.new(name: 'John Doe', phone_number: '1234567890', email: 'john.doe@example.com') }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value('john.doe@example.com').for(:email) }
  it { should_not allow_value('john.doe').for(:email) }
end
