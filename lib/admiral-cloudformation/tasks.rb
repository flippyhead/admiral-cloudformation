require 'json'
require_relative 'util'

module Admiral
  module Tasks
    module CloudFormation

      include Util::CloudFormation

      def self.included(thor_cli)
        thor_cli.class_eval do

          desc "create ENVIRONMENT", "Create stack for ENVIRONMENT"
          option :template, desc: 'A CloudFormation template', default: "CloudFormation.template"
          option :params, desc: 'Parameter definitions for CloudFormation template.'
          option :update_instances, desc: 'Replace and update existing instances', type: :boolean, default: 'true'
          def create(env)
            template = File.read options[:template]
            params = JSON.parse File.read(options[:params] || "#{environment}.json")

            create_or_update stack_name(env), template, params
          end

          desc "destroy ENVIRONMENT", "Destroys ENVIRONMENT"
          def destroy(env)
            super stack_name(env)
          end

        end
      end

      private

      def stack_name(env)
        "#{env}-#{name}"
      end

      def name
        ENV["NAME"] || "test"
      end

    end
  end
end