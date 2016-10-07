class UserContactsController < ApplicationController
  before_action :set_user_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]
  respond_to :html
  respond_to :json
  
  def index
    if is_admin? and params[:show_all_contacts]
      @user_contacts = UserContact.order('id ASC')
      .paginate(:per_page => params[:per_page], :page => params[:page])
      respond_with(@user_contacts)
    else
      @user_contacts = current_user.user_contacts.order('id ASC')
      .paginate(:per_page => params[:per_page], :page => params[:page])
      respond_with(@user_contacts)
    end
  end
  
  def show
  end

  def new
    @user_contact = UserContact.new
  end

  def create
    @user_contact = UserContact.new(user_contact_params)
    flash[:notice] =  actions_flash_message('created', 'male', false) if @user_contact.save
    respond_with(@user_contact)
  end
  
  def edit
  end

  def update 
    flash[:notice] =  actions_flash_message('updated', 'male', false) if @user_contact.update(user_contact_params)
    respond_with(@user_contact)
  end
  
  def destroy
    flash[:notice] =  actions_flash_message('destroyed', 'male', false)  if @user_contact.destroy
    respond_with(@user_contact)
  end
  
  def destroy_multiple
    destroy_multiple_method('male', true)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_contact
    @user_contact = UserContact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_contact_params
    params.require(:user_contact).permit(:user_id, :name, :email, :phone, :address)
  end
end
