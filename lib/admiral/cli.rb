require 'thor'
require 'json'
require_relative 'cloud_formation'

module Admiral
  class Cli < Thor

    include CloudFormation

    attr_accessor :environment

    desc "provision ENVIRONMENT", "Provisions ENVIRONMENT"
    option :template, desc: 'A CloudFormation template', default: "CloudFormation.template"
    option :params, desc: 'Parameter definitions for CloudFormation template.'
    option :update_instances, desc: 'Replace and update existing instances', type: :boolean, default: 'true'
    def create(env)
      self.environment = env
      template = File.read options[:template]
      params = JSON.parse File.read(options[:params] || "#{environment}.json")
      create_or_update(stack_name, template, params)
    end

    desc "destroy ENVIRONMENT", "Destroys ENVIRONMENT"
    def destroy(env)
      self.environment = env
      destroy(stack_name)
    end

    private

    def stack_name
      "#{environment}-#{name}"
    end

    def name
      ENV["NAME"] || "test"
    end

  end
end