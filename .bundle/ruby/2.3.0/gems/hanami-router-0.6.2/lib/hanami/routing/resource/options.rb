module Hanami
  module Routing
    class Resource
      # Options for RESTFul resource(s)
      #
      # @api private
      # @since 0.1.0
      #
      # @see Hanami::Router#resource
      # @see Hanami::Router#resources
      class Options
        # @api private
        # @since 0.1.0
        attr_reader :actions

        # Initialize the options for:
        #   * Hanami::Router#resource
        #   * Hanami::Router#resources
        #
        # @param actions [Array<Symbol>] the name of the actions
        # @param options [Hash]
        # @option options [Hash] :only white list of the default actions
        # @option options [Hash] :except black list of the default actions
        # @option options [String] :controller namespace for an actions
        #
        # @api private
        # @since 0.1.0
        #
        # @see Hanami::Routing::Resource
        # @see Hanami::Routing::Resources
        #
        # @example
        #   require 'hanami/router'
        #
        #   Hanami::Router.new do
        #     resources 'articles', only:   [:index]
        #     resource  'profile',  except: [:new, :create, :destroy]
        #   end
        def initialize(actions, options = {})
          only     = Array(options.delete(:only) || actions)
          except   = Array(options.delete(:except))
          @actions = ( actions & only ) - except

          @options = options
        end

        # Return the option for the given key
        #
        # @param key [Symbol] the key that should be searched
        #
        # @return [Object,nil] returns the object associated to the given key
        #   or nil, if missing.
        #
        # @api private
        # @since 0.1.1
        def [](key)
          @options[key]
        end

        # Merge the current options with the given hash, without mutating self.
        #
        # @param hash [Hash] the hash to be merged
        #
        # @return [Hash] the result of the merging operation
        #
        # @api private
        # @since 0.1.1
        def merge(hash)
          @options.merge(hash)
        end
      end
    end
  end
end
