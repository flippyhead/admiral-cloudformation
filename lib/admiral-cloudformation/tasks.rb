require 'json'
require 'thor'
require 'admiral/base'
require_relative 'util'

module Admiral
  module Tasks
    class CloudFormation < Thor
      extend Admiral::Base
      include Util::CloudFormation

      EXAMPLES = ['elasticsearch', 'meteor', 'mongo']
      NAME = 'cf'
      USAGE = 'cf <command> <options>'
      DESCRIPTION = 'Commands for wielding AWS CloudFormation templates.'

      namespace :cf

      class_option :template,
        desc: 'Path to CloudFormation JSON template.',
        default: 'CloudFormation.template'

      class_option :params,
        desc: 'Path to override parameter definitions file. Defaults to <environment>.json'


      desc 'create', 'Create new CloudFormation stack for environment.'

      def create
        template = File.read options[:template]
        create_stack stack_name(options[:environment]), template, params(options[:environment])
      end


      desc 'update', 'Update the existing CloudFormation stack'

      def update
        template = File.read options[:template]
        update_stack stack_name(options[:environment]), template, params(options[:environment])
      end


      desc 'destroy', 'Destroy the existing CloudFormation stack.'

      def destroy
        super stack_name options[:environment]
      end

      desc 'init TYPE', 'Create CloudFormation template and configuration files for TYPE. TYPE is one of "mongo", "meteor", or "elasticsearch"'

      def init(type)
        raise ArgumentError, "#{type} must be one of #{EXAMPLES.join(',')}" unless EXAMPLES.include?(type)

        path = File.expand_path("../../../examples/#{type}", __FILE__)
        FileUtils.cp Dir.glob("#{path}/*"), Dir.getwd
        puts "[admiral] #{type} CloudFormation setup initialized."
      end

    end
  end
end