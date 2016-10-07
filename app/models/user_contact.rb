class UserContact < ApplicationRecord
  belongs_to :user
  validates :name, :email, :address, :phone, presence: true
  validates :name, format: { with: NAMES, multiline: true }, length: { within: 1..30 }
  validates :email, 
    format: { with: EMAIL, multiline: true },
    length: { within: 6..50 }
  validates :address, 
    format: { with: COMMUN_CHARS, multiline: true },
    length: { within: 3..100 }
  validates :phone, 
    format: { with: PHONE, multiline: true },
    length: { within: 6..16 }
end
