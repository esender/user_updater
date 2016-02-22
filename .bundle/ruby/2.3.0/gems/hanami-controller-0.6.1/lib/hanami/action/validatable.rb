module Hanami
  module Action
    module Validatable
      # Defines the class name for anoymous params
      #
      # @api private
      # @since 0.3.0
      PARAMS_CLASS_NAME = 'Params'.freeze

      def self.included(base)
        base.class_eval do
          extend ClassMethods
          expose :params, :errors
        end
      end

      # Validatable API class methods
      #
      # @since 0.1.0
      # @api private
      module ClassMethods
        # Whitelist valid parameters to be passed to Hanami::Action#call.
        #
        # This feature isn't mandatory, but higly recommended for security
        # reasons.
        #
        # Because params come into your application from untrusted sources, it's
        # a good practice to filter only the wanted keys that serve for your
        # specific use case.
        #
        # Once whitelisted, the params are available as an Hash with symbols
        # as keys.
        #
        #
        #
        # It accepts an anonymous block where all the params can be listed.
        # It internally creates an inner class which inherits from
        # Hanami::Action::Params.
        #
        #
        # Alternatively, it accepts an concrete class that should inherit from
        # Hanami::Action::Params.
        #
        # @param klass [Class,nil] a Hanami::Action::Params subclass
        # @param blk [Proc] a block which defines the whitelisted params
        #
        # @return void
        #
        # @since 0.3.0
        #
        # @see Hanami::Action::Params
        #
        # @example Anonymous Block
        #   require 'hanami/controller'
        #
        #   class Signup
        #     include Hanami::Action
        #
        #     params do
        #       param :first_name
        #       param :last_name
        #       param :email
        #     end
        #
        #     def call(params)
        #       puts params.class            # => Signup::Params
        #       puts params.class.superclass # => Hanami::Action::Params
        #
        #       puts params[:first_name]     # => "Luca"
        #       puts params[:admin]          # => nil
        #     end
        #   end
        #
        # @example Concrete class
        #   require 'hanami/controller'
        #
        #   class SignupParams < Hanami::Action::Params
        #     param :first_name
        #     param :last_name
        #     param :email
        #   end
        #
        #   class Signup
        #     include Hanami::Action
        #     params SignupParams
        #
        #     def call(params)
        #       puts params.class            # => SignupParams
        #       puts params.class.superclass # => Hanami::Action::Params
        #
        #       params[:first_name]          # => "Luca"
        #       params[:admin]               # => nil
        #     end
        #   end
        def params(klass = nil, &blk)
          if block_given?
            @params_class = const_set(PARAMS_CLASS_NAME,
                                      Class.new(Params, &blk))
          else
            @params_class = klass
          end
        end

        # Returns the class which defines the params
        #
        # Returns the class which has been provided to define the
        # params. By default this will be Hanami::Action::Params.
        #
        # @return [Class] A params class (when whitelisted) or
        #   Hanami::Action::Params
        #
        # @api private
        # @since 0.3.0
        def params_class
          @params_class ||= params { }
        end

      end
    end

    # Expose validation errors
    #
    # @since 0.3.0
    def errors
      params.errors
    end
  end
end
