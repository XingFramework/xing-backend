require 'xing/nominal/yaml_config_validator'

module Xing
  module Nominal
    class SecretsValidator < YamlConfigValidator
      SECRETS_FILE = 'config/secrets.yml'
      COMMON_SECRETS_VALIDATION = {
        'secret_key_base' => 'string',
        'smtp' => {
          'address'   => 'string',
          'port'      => 'integer',
          'domain'    => 'string',
          'user_name' => 'string',
          'password'  => 'string'
        },
        'email' => {
          'from'        => 'email',
          'reply_to'    => 'email',
          'from_domain' => 'string'
        },
        'snapshot_server' => {
          'url'       => 'string',
          'user'      => 'string',
          'password'  => 'string'
        },
        'sitemap_base_url' => 'string'
      }

      # Development needs the additional email key 'test'
      DEV_SECRETS_VALIDATION = COMMON_SECRETS_VALIDATION.deep_merge(
        'email' => {
          'test' => 'email'
        }
      )

      def rules(environment)
        case environment
        when 'development'
          DEV_SECRETS_VALIDATION
        else
          COMMON_SECRETS_VALIDATION
        end
      end

      def file_under_test
        SECRETS_FILE
      end
    end
  end
end
