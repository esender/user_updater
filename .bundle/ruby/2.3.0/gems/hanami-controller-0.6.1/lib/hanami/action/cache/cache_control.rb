require 'hanami/action/cache/directives'

module Hanami
  module Action
    module Cache

      # Module with Cache-Control logic
      #
      # @since 0.3.0
      # @api private
      module CacheControl

        # The HTTP header for Cache-Control
        #
        # @since 0.3.0
        # @api private
        HEADER = 'Cache-Control'.freeze

        def self.included(base)
          base.extend ClassMethods
        end

        module ClassMethods
          def cache_control(*values)
            @cache_control_directives ||= Directives.new(*values)
          end

          def cache_control_directives
            @cache_control_directives || Object.new.tap do |null_object|
              def null_object.headers
                Hash.new
              end
            end
          end
        end

        # Finalize the response including default cache headers into the response
        #
        # @since 0.3.0
        # @api private
        #
        # @see Hanami::Action#finish
        def finish
          super
          headers.merge!(self.class.cache_control_directives.headers) unless headers.include? HEADER
        end

        # Class which stores CacheControl values
        #
        # @since 0.3.0
        #
        # @api private
        #
        class Directives
          def initialize(*values)
            @directives = Hanami::Action::Cache::Directives.new(*values)
          end

          def headers
            if @directives.any?
              { HEADER => @directives.join(', ') }
            else
              {}
            end
          end
        end
      end
    end
  end
end
