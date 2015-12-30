module RSpec
  module Rails
    module Matchers
      # Matchers to help with specs for routing code.
      module RoutingMatchers
        class RouteToMatcher
          def matches_with_patches?(verb_to_path_map)
            path = verb_to_path_map.values.first
            verb_to_path_map[verb_to_path_map.keys.first] = "http://#{BACKEND_SUBDOMAIN}.example.com#{path[0] == "/" ? "" : "/"}#{path}";
            matches_without_patches?(verb_to_path_map)
          end
          alias_method_chain :matches?, :patches
        end

        class FrontendRouteToMatcher < RouteToMatcher
          def matches?(verb_to_path_map)
            matches_without_patches?(verb_to_path_map)
          end
        end

        def frontend_route_to(*expected)
          FrontendRouteToMatcher.new(self, *expected)
        end

      end
    end
  end
end
