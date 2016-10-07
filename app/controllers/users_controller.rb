class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]
  respond_to :html
  
  def index
    @users = User.order('id ASC')
    .paginate(:per_page => params[:per_page], :page => params[:page])
    respond_with(@users)
  end
  
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    flash[:notice] =  actions_flash_message('created', 'male', false) if @user.save
    respond_with(@user)
  end
  
  def edit
    unless current_user.role.superadmin
      flash[:alert] =  "La página solicitada no existe."
      redirect_to root_path
    end
  end

  def update 
    flash[:notice] =  actions_flash_message('updated', 'male', false) if @user.update(user_params)
    respond_with(@user)
  end
  
  def destroy
    flash[:notice] =  actions_flash_message('destroyed', 'male', false)  if @user.destroy
    respond_with(@user)
  end
  
  def destroy_multiple
    destroy_multiple_method('male', true)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :login, :user_id, :active, :avatar)
  end
end
