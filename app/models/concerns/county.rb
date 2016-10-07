class County < ApplicationRecord
  belongs_to :city
  has_many :zones, dependent: :destroy
  has_many :zipcodes, through: :zones
  has_many :zones_zipcodes, through: :zones
  has_many :zones_zipcodes, through: :zipcodes
  has_many :user, dependent: :destroy
    
  validates :name, :description, :code, :city_id, presence: true
  validates :city_id, 
    numericality: true, 
    length: { within: 1..3 }
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