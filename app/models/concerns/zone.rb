class Zone < ApplicationRecord
  belongs_to :county
  has_many :zipcodes, dependent: :destroy  
  
  validates :name, :description, :code, :county_id, presence: true
  validates :county_id, 
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
