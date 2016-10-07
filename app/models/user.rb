class User < ApplicationRecord  
  mount_uploader :avatar, AvatarUploader   
  belongs_to :role
  has_many :user_contacts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :timeoutable,
    :recoverable, :rememberable, :trackable, :confirmable, :validatable,
    :timeoutable, :omniauthable, omniauth_providers: [:facebook]
  attr_accessor :login, :fullname
  
  validates :first_name, :last_name, :email, :username, :role_id, presence: true
  validates :first_name, format: { with: NAMES, multiline: true }, length: { within: 1..30 }
  validates :last_name, format: { with: NAMES, multiline: true }, length: { within: 1..30 }
  validates :active, format: { with: BOOLEAN, multiline: true }, length: { within: 1..5 }
  validates :role_id, format: { with: INTEGER, multiline: true }, length: { within: 1..5 }
  validates :email, 
    format: { with: EMAIL, multiline: true },
    length: { within: 6..50 }
  validates :username, 
    format: { with: USERNAME, multiline: true },
    length: { within: 6..20 }
  validates :password, 
    format: { with: PASSWORD, multiline: true },
    length: { within: 8..20 },
    on: :create
  validates :active, 
    format: { with: BOOLEAN, multiline: true }, 
    length: { within: 1..5 }
  
  def self.find_for_facebook_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    # The User was found in our database
    return user if user
    # Check if the User is already registered without Facebook
    user = User.where(email: auth.info.email).first
    return user if user
    User.create(
      username: auth.extra.raw_info.id,
      first_name: auth.extra.raw_info.first_name,
      last_name: auth.extra.raw_info.last_name,
      provider: auth.provider, uid: auth.uid,
      email: auth.info.email,
      #image: auth.info.image,
      password: Devise.friendly_token[0,20])
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
  
  #protected

  # Attempt to find a user by it's email. If a record is found, send new
  # password instructions to it. If not user is found, returns a new user
  # with an email not found error.
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end 

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
      else  
        record = where(attributes).first
      end  
    end  

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end  
    end  
    record
  end

  def self.find_record(login)
    where(["username = :value OR email = :value", { :value => login }]).first
  end

  public
  def full_name
    [first_name, last_name].join " "
  rescue
    I18n.t('not_available')
  end
  
  public
  def link_display
    [first_name, last_name].join " "
  rescue
    I18n.t('not_available')
  end
  
end
