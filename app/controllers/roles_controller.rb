class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]
  respond_to :html
  respond_to :json
  
  def index
    @roles = Role.order('id ASC')
    .paginate(:per_page => params[:per_page], :page => params[:page])
    respond_with(@roles)
  end
  
  def show
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    flash[:notice] =  actions_flash_message('created', 'male', false) if @role.save
    respond_with(@role)
  end
  
  def edit
  end

  def update 
    flash[:notice] =  actions_flash_message('updated', 'male', false) if @role.update(role_params)
    respond_with(@role)
  end
  
  def destroy
    flash[:notice] =  actions_flash_message('destroyed', 'male', false)  if @role.destroy
    respond_with(@role)
  end
  
  def destroy_multiple
    destroy_multiple_method('male', true)
  end

  private
  def set_role
    @role = Role.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.require(:role).permit(:name, :description, :superadmin, :default_user, :custom, :code)
  end
end
