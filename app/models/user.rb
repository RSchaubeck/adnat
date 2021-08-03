# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  organisation_id :integer          not null
#  name            :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :name, presence: true
    validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, length: { minimum: 6, allow_nil: true }
    validates :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true

    has_many :shifts,
        class_name: :Shift,
        dependent: :destroy

    belongs_to :organisation,
        class_name: :Organisation,
        foreign_key: :organisation_id
end
