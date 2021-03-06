require "rails/generators/resource_helpers"
module Rails
  module Generators
    class DashboardGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)
      include ResourceHelpers
      check_class_collision suffix: "Controller"
      class_option :namespace, type: :string, default: 'admin'
      class_option :orm, banner: "NAME", type: :string, required: true, desc: "ORM to generate the controller for"
      # argument :attributes, type: :array, default: [], banner: "field[:type][:index][:uniq] field[:type][:index][:uniq]"
      # hook_for :scaffold_controller, as: :controller
      # def create_model_file
      #   template 'model.rb', "app/models/#{file_name}.rb"
      # end

      def create_model
        # creates the migration file for the model.
        generate "model", "#{file_name} #{args.join(' ')}"
      end

      def create_controller_file
        template 'controller.rb', "app/controllers/#{options[:namespace]}/#{plural_name}_controller.rb"
      end

      def create_policy_file
        template 'policy.rb', "app/policies/#{options[:namespace]}/#{singular_name}_policy.rb"
      end

      def copy_view_files
        available_views.each do |view|
          filename = "#{view}.html.erb"
          template filename, "app/views/#{options[:namespace]}/#{plural_name}/#{filename}"
        end
      end

      def create_resource_partial
        filename = "_#{singular_name}.html.erb"
        template "_resource.html.erb", "app/views/#{options[:namespace]}/#{plural_name}/#{filename}"
        template "_filter.html.erb", "app/views/#{options[:namespace]}/#{plural_name}/_filter.html.erb"
        # template "_search_modal.html.erb", "app/views/#{options[:namespace]}/#{plural_name}/_search_modal.html.erb"
        # template "_short_search_input_group.html.erb", "app/views/#{options[:namespace]}/#{plural_name}/_short_search_input_group.html.erb"
      end

      def create_css_file
        template 'dashboard.scss', "app/assets/stylesheets/#{options[:namespace]}/dashboard.scss"
        append_file 'app/assets/stylesheets/admin.scss' do
          "\n@import 'admin/dashboard';"
        end
      end

      def copy_helper_file
        copy_file "time_helper.rb", "app/helpers/time_helper.rb"
      end

      def create_routes
        inject_into_file 'config/routes.rb', after: "namespace :admin do\n" do
          "\t\tresources :#{plural_name}\n"
        end 
      end

      # hook_for :resource_route, required: true
      # hook_for :test_framework

      private

      def available_views
        %w(index edit show new _form)
      end

      def attributes_names
        # 此方法似乎本來就定義在 rails generators 的某處，但會變成該 class 的 array，不好用，所以重新產生
        args.map { |arg| arg.split(":")[0] }
      end


    end
  end
end

# frozen_string_literal: true

# require "rails/generators/resource_helpers"

# module Rails
#   module Generators
#     class DashboardGenerator < NamedBase # :nodoc:
#       include ResourceHelpers
#       source_root File.expand_path('templates', __dir__)
#       check_class_collision suffix: "Controller"

#       class_option :helper, type: :boolean
#       class_option :orm, banner: "NAME", type: :string, required: true,
#                          desc: "ORM to generate the controller for"
#       class_option :api, type: :boolean,
#                          desc: "Generates API controller"

#       argument :attributes, type: :array, default: [], banner: "field:type field:type"

#       def create_controller_files
#         template_file = options.api? ? "api_controller.rb" : "controller.rb"
#         template template_file, File.join("app/controllers", controller_class_path, "#{controller_file_name}_controller.rb")
#       end

#       hook_for :template_engine, as: :scaffold do |template_engine|
#         invoke template_engine unless options.api?
#       end

#       hook_for :test_framework, as: :scaffold

#       # Invoke the helper using the controller name (pluralized)
#       hook_for :helper, as: :scaffold do |invoked|
#         invoke invoked, [ controller_name ]
#       end
#     end
#   end
# end