require 'json'
require 'thor'
require_relative 'util'

module Admiral
  module Tasks
    class CloudFormation < Thor
      include Util::CloudFormation

      NAME = 'cf'
      USAGE = 'cf <command> <options>'
      DESCRIPTION = 'Commands for wielding AWS CloudFormation templates.'

      namespace :cf

      default_command :create

      class_option :template,
        desc: 'Path to CloudFormation JSON template.',
        default: "CloudFormation.template"

      class_option :params,
        desc: 'Path to parameter definitions JSON file. Defaults to ENVIRONMENT.'


      desc "create (or update) ENVIRONMENT", "Create (or update if exists) stack for ENVIRONMENT"

      def create(env)
        template = File.read options[:template]
        create_stack stack_name(env), template, params(env)
      end


      desc "update ENVIRONMENT", "Update stack for ENVIRONMENT"

      def update(env)
        template = File.read options[:template]
        update_stack stack_name(env), template, params(env)
      end

      desc "destroy ENVIRONMENT", "Destroys ENVIRONMENT"

      def destroy(env)
        super stack_name(env)
      end

    end
  end
end