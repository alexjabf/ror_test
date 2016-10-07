class Zipcode < ApplicationRecord
  belongs_to :zone
  has_many :users, dependent: :destroy
      
  validates :zipcode, :address_type, :latitude, :longitude, :zone_id, presence: true
  validates :zipcode,
    numericality: true, 
    length: { within: 4..5 }
  validates :zone_id,
    numericality: true, 
    length: { within: 1..8 }
  validates :address_type,
    format: { with: ALL_CHARS, multiline: true }, 
    length: { within: 2..200 }
  validates :latitude, :longitude, 
    numericality: true,
    length: { within: 2..40 }
  
  #ALIAS
  public
  def link_display
    zipcode
  rescue
    I18n.t('not_available')
  end
end
