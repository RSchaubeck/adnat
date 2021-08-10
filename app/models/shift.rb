# == Schema Information
#
# Table name: shifts
#
#  id           :bigint           not null, primary key
#  user_id      :integer          not null
#  start        :datetime         not null
#  finish       :datetime         not null
#  break_length :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Shift < ApplicationRecord
    validates :start, :finish, presence: true
    validates :break_length, numericality: { only_integer: true }, allow_nil: true

    belongs_to :user,
        class_name: :User
end
