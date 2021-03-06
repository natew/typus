module Admin

  module BaseHelper

    def typus_block(resource = @resource.to_resource, partial = params[:action])
      render "admin/#{resource}/#{partial}"
    rescue ActionView::MissingTemplate
    end

    def title(page_title)
      content_for(:title) { page_title }
    end

    def header
      render "admin/helpers/header"
    end

    def apps
      render "admin/helpers/apps"
    end

    def login_info(user = @current_user)
      return if user.kind_of?(Admin::FakeUser)

      admin_edit_typus_user_path = { :controller => "/admin/#{Typus.user_class.to_resource}",
                                     :action => 'edit',
                                     :id => user.id }

      message = _t("Are you sure you want to sign out and end your session?")

      user_details = if user.can?('edit', Typus.user_class_name)
                       link_to user.name, admin_edit_typus_user_path
                     else
                       user.name
                     end

      render "admin/helpers/login_info", :message => message, :user_details => user_details
    end

    def display_flash_message(message = flash)
      return if message.empty?
      render "admin/helpers/flash_message", :flash_type => message.keys.first, :message => message
    end

  end

end