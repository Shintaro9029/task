class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, presence: true

    has_many :tasks
    has_many :tasks, dependent: :destroy
end
