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
  it { is_expected.to have_many :people }
  describe '.by_name' do
    let!(:company) { Company.create(name: 'DigitalOcean') }

    context 'when name exists' do
      it 'returns the company with the given name' do
        expect(Company.by_name('Digital')).to include(company)
      end
    end

    context 'when name does not exist' do
      it 'returns an empty relation' do
        expect(Company.by_name('Nonexistent')).to be_empty
      end
    end

    context 'when name is nil' do
      it 'returns all companies' do
        other_company = Company.create(name: 'OtherCompany')
        expect(Company.by_name(nil)).to match_array([company, other_company])
      end
    end
  end
end
