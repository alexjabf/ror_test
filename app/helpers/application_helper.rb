module ApplicationHelper
  
  def is_admin?
    signed_in? and current_user.role.superadmin
  end
  
  def has_action?(controller, action)
    controller = controller.nil? ? controller_name : to_controller_name(controller)
    "#{controller}_controller".camelize.constantize.new.respond_to?(action)
  rescue
    false
  end
  
  
  def actions_flash_message(action, gender, is_plural)
    model_name = is_plural ?  get_controller_name : get_controller_name.singularize
    I18n.t("actions.#{action}.#{gender}",  
      model: t("activerecord.models.#{model_name}").downcase)
  end
  
  def actions_titles
    t("actions.#{action_name}", model: t("activerecord.models.#{get_controller_name.singularize}").titlecase)
  end
  
  def disable_titles(action)
    t("actions.#{action}", model: t("activerecord.models.#{get_controller_name.singularize}").downcase) 
  end
  
  def get_title(controller, action)
    if is_model?(controller)
      action = action.nil? ?  action_name : action
      action = action == 'show' ? "#{action}ing" : action
      controller = controller.nil? ?  get_controller_name : controller
      controller = (action == 'index') ?  controller : controller.singularize
      return I18n.t("actions.#{action}", model: t("activerecord.models.#{controller}").titlecase)
    else
      return t('layouts.application.welcome').titlecase
    end
  end
  
  def get_models_for_sidebar
    get_models
    side_models = []
    @models.each do |model|
      if can? :index, to_model(model) and has_index?(model)
        side_models << {'name' => model, 'human_name' => t("activerecord.models.#{to_controller_name(model)}")}
      end
    end
    @sidebar = side_models.sort_by { |m| m["human_name"] }
  end
  
  def flash_message
    flash_collection = []
    if flash[:notice]
      flash_collection << flash_type('info', flash[:notice])
    elsif flash[:error]
      flash_collection << flash_type('danger', flash[:error])
    elsif flash[:alert]
      flash_collection << flash_type('warning', flash[:alert])
    elsif flash[:success]
      flash_collection << flash_type('success', flash[:success])
    end
    return flash_collection.join.html_safe
  end
  
  def flash_type(type, message)
    button_properties = {
      :type => 'button', 
      :class => 'btn close',
      :'data-dismiss' => 'alert', 
      :'aria-label' => 'Close'
    }
    content_tag(:div, :class => "alert alert-#{type} alert-dismissible") do
      concat(message)
      concat(content_tag(:button, button_properties) do
          content_tag(:span, :'aria-hidden' => 'true') do
            concat('&times;'.html_safe)
          end
        end)
    end    
  end
  
  def show_pagination?
    if action_name == 'index' and is_model?(get_controller_name)
      return true
    else
      return false
    end 
  end
  
  def is_model?(model)
    if File.exist?("app/models/#{to_model_file_name(model)}.rb")
      return true
    else
      return false
    end
  end
  
  def to_model(model)
    name = eval("#{to_model_name(model)}")
    return name
  rescue
    'Error on to_model: ' + model.to_s
  end
  
  def to_model_name(model)
    name = model.to_s.gsub('_id', '').singularize.camelize
    return name
  rescue
    'Error on to_model_name: ' + model.to_s
  end
  
  def to_model_file_name(model)
    name = model.to_s.gsub('_id', '').tableize.singularize
    return name
  rescue
    'Error on to_model_file_name: ' + model.to_s
  end
  
  def to_controller_name(model)
    name = model.to_s.gsub('_id', '').tableize
    return name
  rescue
    'Error on to_controller_name: ' + model.to_s
  end
  
  def get_model
    eval("@#{get_controller_name.singularize}")
  end
  
  def get_controller_name
    devise_controllers = [
      'registrations', 
      'sessions', 
      'confirmations', 
      'omniauth_callbacks', 
      'passwords', 
      'unlocks'
    ]
    return devise_controllers.include?(controller_name) ? 'users' : controller_name
  end  
  
  def custom_link(model, action, object, css_class)
    if object.nil?
      custom_link = I18n.t('not_available')
    else
      display_text = (object.is_a? Numeric) ? object : object.link_display
      link_id = (object.is_a? Numeric) ? object : object.id
      if can? eval(":#{action}"), to_model(model) and has_action?(model, action)
        if action == 'show'
          url = eval("#{to_model_file_name(model)}_path(#{link_id})")
        elsif action == 'edit'
          url = eval("edit_#{to_model_file_name(model)}_path(#{link_id})")
        else
          url = eval("#{to_controller_name(model)}_path")
        end
        custom_link = content_tag(:a, display_text, {href: url, :class => css_class, title: get_title(model, action)})
      else
        custom_link = content_tag(:span, display_text, {:class => css_class, title: get_title(model, action), disabled: true})
      end
    end
    return custom_link
  end
  
end
