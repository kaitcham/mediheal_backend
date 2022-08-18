class User < ApplicationRecord
    has_secure_password

    validates :username, uniqueness: {case_sensitive: false}, length: {minimum:6}
    validates :email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}
end
