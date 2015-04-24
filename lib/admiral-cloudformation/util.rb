require 'aws-sdk-v1'

module Admiral
  module Util
    module CloudFormation

      SUCCESS_STATS = [:create_complete, :update_complete, :update_rollback_complete]
      FAILED_STATS = [:create_failed, :update_failed, :rollback_complete]
      DEFAULT_RECIPES = [].join(",")

      def client
        AWS::CloudFormation.new
      end

      def create_or_update(stack_name, template, params)
        stack = client.stacks[stack_name]

        if stack.exists?
          begin
            puts "Updating CloudFormation stack #{stack_name}"
            stack.update(:template => template, :parameters => params)
          rescue => e
            raise unless e.message =~ /No updates are to be performed/
            puts "Your CloudFormation stack is already up to date"
          end
        else
          puts "Creating CloudFormation stack #{stack_name}"
          stack = client.stacks.create(stack_name, template, :parameters => params)
          wait_for_stack_op_to_finish stack
        end
      end

      def destroy(stack_name)
        stack = client.stacks[stack_name]

        if stack.exists?
          puts "Deleting stack #{stack_name}"
          stack.delete
        else
          puts "Environment #{environment} does not exist"
        end
      end

      private

      def wait_for_stack_op_to_finish(stack)
        stats = stack.status.downcase.to_sym
        puts "[admiral] Stack #{stack.name} current status: #{stats}"

        while !SUCCESS_STATS.include?(stats)
          sleep 15
          stats = stack.status.downcase.to_sym
          raise "[admiral] Resource stack update failed." if FAILED_STATS.include?(stats)
          puts "[admiral] Stack #{stack.name} current status: #{stats}"
        end
      end

      def cf_query_output(stack, key)
        output = stack.outputs.find { |o| o.key == key }
        output && output.value
      end

      def all_availability_zones
        ec2 = AWS::EC2.new
        ec2.availability_zones.map(&:name)
      end

    end
  end
end