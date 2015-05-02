# Admiral for AWS CloudFormation

An Admiral module that implements tasks for wielding AWS CloudFormation templates. Use it to manage CloudFormation templates and their parameters.

## Installation

Add this line to your application's Gemfile:

    gem 'admiral-cloudformation'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install admiral-cloudformation

## Usage

On your command line type:

    $ admiral help

To see a list of available commands. Make sure your bundle bin is in your PATH.

# CloudFormation Templates

Admiral for CloudFormation expects a single template file named `CloudFormation.template` in the current directory. This can be overwritten with the `--template` flag.

If your template declares a `Parameters` block, you can provide namespaced parameters by creating appropriately named JSON files in the same directory.

For example.