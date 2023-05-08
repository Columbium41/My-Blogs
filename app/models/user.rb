# email:string
# password_digest:string
#
# password:string virtual
# password_confirmation:string virtual
 
class User < ApplicationRecord
    # Authenticate and encrypt passwords with BCrypt
    has_secure_password

    # Validate that the user entered in an actual email address
    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }, uniqueness: true
    validates :password_confirmation, presence: true
end
