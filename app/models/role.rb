class Role < ApplicationRecord
  #ASSOCIATIONS
  has_many :user, dependent: :destroy
  
  #VALIDATIONS
  validates  :name, :description, :code,  presence: true   
  validates  :name,
    format: { with: COMMUN_CHARS, multiline: true },     
    length: { within: 2..200 },
    uniqueness: true
  validates :description, 
    format: { with: ALL_CHARS, multiline: true }, 
    length: { within: 10..10000 },
    uniqueness: {scope: :name}
  validates :code,
    format: { with: CHARS, multiline: true }, 
    length: { is: 2 },
    presence: true,
    uniqueness: true
  
  public

  def link_display
    name
  rescue
    I18n.t('not_available')
  end
end
