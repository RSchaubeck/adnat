# == Schema Information
#
# Table name: organisations
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  hourly_rate :decimal(12, 2)   not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Organisation < ApplicationRecord
    validates :name, presence: true
    validates :hourly_rate, presence: true, format: {with: /\A\d+(?:\.\d{0,2})?\z/}, numericality: {greater_than: 0}

    has_many :users,
        class_name: :User
end
