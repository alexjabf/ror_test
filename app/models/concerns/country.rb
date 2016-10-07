class Country < ApplicationRecord
  has_many :states, dependent: :destroy
  has_many :cities, through: :states
  has_many :counties, through: :cities
  has_many :zones, through: :counties
  has_many :zipcodes, through: :zones
  has_many :users, through: :counties
  has_many :users, through: :zipcodes
  has_many :zones_zipcodes, through: :zones
  has_many :zones_zipcodes, through: :zipcodes
  
  validates :name, :description, :code, presence: true
  validates :name, 
    format: { with: COMMUN_CHARS, multiline: true }, 
    length: { within: 2..200 },
    uniqueness: true
  validates :description, 
    format: { with: ALL_CHARS, multiline: true }, 
    length: { within: 2..10000 },
    uniqueness: {scope: :name}
  validates :code,
    format: { with: CHARS, multiline: true }, 
    length: { is: 3 },
    uniqueness: true
  
  #ALIAS
  public
  def link_display
    name
  rescue
    I18n.t('not_available')
  end
  
end
