require 'xing/nominal/yaml_config_validator'

module Xing
  module Nominal
    class DatabaseConfigValidator < YamlConfigValidator
      DATABASE_CONFIG_FILE = 'config/database.yml'
      COMMON_DATABASE_RULES = {
        'adapter'  => 'string',
        'database' => 'string'
      }
      PROD_DATABASE_RULES = COMMON_DATABASE_RULES.merge({
        'username' => 'string',
        'password' => 'string',
        'host'     => 'string'
      })

      def rules(environment)
        case environment
        when 'production', 'staging'
          PROD_DATABASE_RULES
        else
          COMMON_DATABASE_RULES
        end
      end

      def file_under_test
        DATABASE_CONFIG_FILE
      end
    end
  end
end
