# Admiral for AWS CloudFormation

An Admiral module that implements tasks for wielding AWS CloudFormation templates. Use it to manage CloudFormation templates and their parameters.

## Installation

Add this line to your application's Gemfile (recommended):

    gem 'admiral-cloudformation'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install admiral-cloudformation

## Usage

On your command line type:

    $ admiral cf help

To see a list of available commands. Make sure your bundle bin is in your PATH.

The following commands are available:

```
Commands:
  admiral cf create          # Create new CloudFormation stack for environment.
  admiral cf destroy         # Destroy the existing CloudFormation stack.
  admiral cf help [COMMAND]  # Describe subcommands or one specific subcommand
  admiral cf update          # Update the existing CloudFormation stack

Options:
  --env, [--environment=ENVIRONMENT]  # The environment (e.g. staging or production). Can also be specified with ADMIRAL_ENV.
                                      # Default: production
      [--template=TEMPLATE]           # Path to CloudFormation JSON template.
                                      # Default: CloudFormation.template
      [--params=PARAMS]               # Path to override parameter definitions file. Defaults to <environment>.json
```

# Setup and Configuration

Admiral CloudFormation is designed around the concept of deployment environments. You parameterize your CloudFormation templates, then encode specific parameter values in JSON files for each distinct environment.

For example you may have CloudFormation templates for your database servers and your web application servers, and distinct configurations for production, staging and test environments.

CloudFormation provides a facility to parameterize templates via the [`Parameters`](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/parameters-section-structure.html) section. For example:

```javascript
  ...
  "InstanceType": {
      "Description": "The type of instance to launch.",
      "Type": "String",
      "Default": "t2.small"
  },
  ...
```

Admiral CloudFormation let's you specify specific values. For example:

```javascript
  {
    "InstanceCount":"2",
    "InstanceType": "t2.medium",
  }
```

## Examples

To create a new CloudFormation stack (and its associated resources) using a staging configuration:

      $ admiral cf create --environment staging --template ./CloudFormation.template

# CloudFormation Templates

Example CloudFormation templates for ElasticSearch, Meteor and MongoDB are included in the `examples` directory.