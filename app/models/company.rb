# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ApplicationRecord

  has_many :people

  scope :by_name, -> (name) { where('LOWER(name) LIKE ?', "%#{name.downcase}%") if name.present? }
end
