# Admiral for AWS CloudFormation

An Admiral module that implements tasks for wielding AWS CloudFormation templates and configuration.

For additional modules, see the [Admiral base prjoect](https://github.com/flippyhead/admiral).

Developed in Seattle at [Fetching](http://fetching.io).

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
  admiral cf init TYPE       # Create CloudFormation template and configuration files for TYPE. TYPE is one of "mongo", "meteor", or "elasticsearch"
  admiral cf update          # Update the existing CloudFormation stack

Options:
  --env, [--environment=ENVIRONMENT]  # The environment (e.g. staging or production). Can also be specified with ADMIRAL_ENV.
                                      # Default: production
      [--template=TEMPLATE]           # Path to CloudFormation JSON template.
                                      # Default: CloudFormation.template
      [--params=PARAMS]               # Path to override parameter definitions file. Defaults to <environment>.json
```

Some commands have additional options you can discover with:

    $ admiral cf help [COMMAND]

# Configuration

Admiral CloudFormation is designed around the concept of the deployment `environment`. You parameterize your CloudFormation templates, then encode specific parameter values in JSON files for each distinct environment.

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

You then specify specific values for each environment. For example, in the `production.json` file:

```javascript
  {
    "InstanceCount":"2",
    "InstanceType": "t2.medium",
  }
```

Admiral then applies the parameters for a given environment to your CloudFormation templates as required by whatever action you are performing.

## Easy Setup

Admiral CloudFormation provides complete CloudFormation templates for some common server configurations. To initialize your project you can use:

      $ admiral cf init <type>

Where type is one of `mongo`, `elasticsearch` or `meteor`. In the current working directory, this will create a `CloudFormation.template` and `staging.json` and `production.json` files. These are complete configurations using best practices for each server type but you'll need to customize a few things including SSL certificate and security group names.

More example templates will be added in the future.

## Examples

To create a new CloudFormation stack (and its associated resources) using a staging configuration:

      $ admiral cf create --environment staging --template ./CloudFormation.template

Create a stack using the default template (./CloudFormation.template) using a custom JSON file:

      $ admiral cf create --params /usr/local/config/custom.json

Update using the default template (./CloudFormation.template) and the default environment config (./production.json):

      $ admiral cf update