require "active_admin"
require "active_admin/duplicatable/version"

module ActiveAdmin
  module Duplicatable

    extend ActiveSupport::Concern

    # Public: Enable and configure resource duplication
    #
    # options - Duplication options (default: { via: :form }):
    #           :via - Method of duplication. Via `:save` is the only way to
    #                  copy a resources relations not present in the form.
    #
    # Examples
    #
    #   ActiveAdmin.register Post do
    #     duplicatable via: :save
    #   end
    #
    def duplicatable(options = {})
      via = options.fetch(:via) { :form }

      if via == :save
        enable_resource_duplication_via_save
      elsif via != :form
        enable_resource_duplication_via_custom_method(via)
      else
        enable_resource_duplication_via_form
      end
    end

    private

    # Enables resource duplication via new form.
    #
    # - Adds a duplicate action button.
    # - Preloads a duplicated resource on `:new` to pre-fill the form fields.
    #
    # No return.
    def enable_resource_duplication_via_form
      action_item(*compatible_action_item_parameters) do
        if controller.action_methods.include?('new') && authorized?(ActiveAdmin::Auth::CREATE, active_admin_config.resource_class)
          link_to(I18n.t(:duplicate_model, default: "Duplicate %{model}", scope: [:active_admin], model: active_admin_config.resource_label), action: :new, _source_id: resource.id)
        end
      end

      controller do
        before_action only: :new do
          if !params[:_source_id].blank?
            source = resource_class.find(params[:_source_id])
            @resource ||= source.amoeba_dup if source
          end
        end
      end
    end

    # Enables resource duplication via save.
    #
    # - Adds a duplicate action button.
    # - Duplicates a resource, persists it, and redirects the user to edit
    #   the newly duplicated resource.
    #
    # No return.
    def enable_resource_duplication_via_save
      action_item(*compatible_action_item_parameters) do
        if controller.action_methods.include?('new') && authorized?(ActiveAdmin::Auth::CREATE, active_admin_config.resource_class)
          link_to(I18n.t(:duplicate_model, default: "Duplicate %{model}", scope: [:active_admin], model: active_admin_config.resource_label), action: :duplicate)
        end
      end

      member_action :duplicate do
        resource  = resource_class.find(params[:id])

        authorize! ActiveAdmin::Auth::CREATE, resource

        duplicate = resource.amoeba_dup
        if duplicate.save
          redirect_to({ action: :edit, id: duplicate.id }, flash: { notice: "#{active_admin_config.resource_label} was successfully duplicated." })
        else
          redirect_to({ action: :show }, flash: { error: "#{active_admin_config.resource_label} could not be duplicated." })
        end
      end
    end

    # Enables resource duplication via a custom method
    #
    # - Adds a duplicate action button.
    # - Calls a custom duplication method on the model. The method should
    #   handle any copying of data and persistence of the new record.
    # - Redirects the user to edit the newly duplicated resource.
    #
    # No return.
    def enable_resource_duplication_via_custom_method(method)
      action_item(*compatible_action_item_parameters) do
        if controller.action_methods.include?('new') && authorized?(ActiveAdmin::Auth::CREATE, active_admin_config.resource_class)
          link_to(I18n.t(:duplicate_model, default: "Duplicate %{model}", scope: [:active_admin], model: active_admin_config.resource_label), action: :duplicate)
        end
      end

      member_action :duplicate do
        resource = resource_class.find(params[:id])

        authorize! ActiveAdmin::Auth::CREATE, resource

        begin
          duplicate = resource.send method
          redirect_to({ action: :edit, id: duplicate.id }, flash: { notice: "#{active_admin_config.resource_label} was successfully duplicated." })
        rescue => e
          Rails.logger.warn(e)
          redirect_to({ action: :show }, flash: { error: "#{active_admin_config.resource_label} could not be duplicated." })
        end
      end
    end

    # For ActiveAdmin `action_item` compatibility.
    #
    # - When ActiveAdmin is less than 1.0.0.pre1 exclude name parameter from
    #   calls to `action_item` for compatibility.
    # - When 1.0.0.pre1 or greater provide name to `action_item` to avoid the
    #   warning message, and later an error.
    #
    # Returns Array of parameters.
    def compatible_action_item_parameters
      parameters = [{ :only => [:show] }]
      parameters.unshift(:duplicatable_duplicate) if action_item_name_required?
      parameters
    end

    def action_item_name_required?
      method(:action_item).parameters.count == 3
    end
  end
end

ActiveAdmin::ResourceDSL.send :include, ActiveAdmin::Duplicatable
