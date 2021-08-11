# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  organisation_id :integer
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
    #allow_nil b/c @password attribute is only set if we change it with #password=
    validates :password, length: { minimum: 6, allow_nil: true }
    validates :password, confirmation: { case_sensitive: true }
    validates :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true

    has_many :shifts,
        class_name: :Shift,
        dependent: :destroy

    belongs_to :organisation,
        class_name: :Organisation,
        optional: true

    after_initialize :ensure_session_token

    attr_reader :password

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        return nil if user.nil?
        user.is_password?(password) ? user : nil
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    #setter method that hashes password using BCrypt gem
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64(16)
        self.save!
        self.session_token
    end

    private

    def ensure_session_token
        self.session_token ||= SecureRandom.urlsafe_base64(16)
    end
end
