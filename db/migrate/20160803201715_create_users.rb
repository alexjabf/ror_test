class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false, unique: true
      t.string :email, null: false, unique: true
      t.boolean :active, null: false, default: true
      t.references :role, null: false, default: 3
      
      ## Database authenticatable
      t.string :username, null: false, unique: true, index: true
      t.string :email, null: false, unique: true, index: true
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token, unique: true, index: true
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.string   :provider
      t.string   :uid

      ## Confirmable
      t.string   :confirmation_token, unique: true, index: true
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
      
      ## Lockable
      t.integer  :failed_attempts, default: 0
      t.string   :unlock_token, unique: true, index: true
      t.datetime :locked_at

      ## Token authenticatable
      t.string :authentication_token, unique: true, index: true
      
      ##LOGO
      t.string :avatar
      
      t.timestamps
    end
  end
end

#rails g scaffold user first_name:string last_name:string last_name:string username:string email:string phone:string cellphone:string address1:string address2:string county:refereces zipcode:references age:integer avatar:string is_male:boolean active:boolean