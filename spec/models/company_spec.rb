# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  it "is valid with valid attributes" do
    company = Company.new(name: "Test Company")
    expect(company).to be_valid
  end

  it "is not valid without a name" do
    company = Company.new(name: nil)
    expect(company).to_not be_valid
  end
end
