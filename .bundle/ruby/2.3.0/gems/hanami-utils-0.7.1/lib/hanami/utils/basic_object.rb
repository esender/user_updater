module Hanami
  module Utils
    # BasicObject
    #
    # @since 0.3.5
    class BasicObject < ::BasicObject
      # Return the class for debugging purposes.
      #
      # @since 0.3.5
      #
      # @see http://ruby-doc.org/core/Object.html#method-i-class
      def class
        (class << self; self end).superclass
      end

      # Bare minimum inspect for debugging purposes.
      #
      # @return [String] the inspect string
      #
      # @since 0.3.5
      #
      # @see http://ruby-doc.org/core/Object.html#method-i-inspect
      def inspect
        "#<#{ self.class }:#{'%x' % (__id__ << 1)}#{ __inspect }>"
      end

      # Returns true if responds to the given method.
      #
      # @return [TrueClass,FalseClass] the result of the check
      #
      # @since 0.3.5
      #
      # @see http://ruby-doc.org/core-2.2.1/Object.html#method-i-respond_to-3F
      def respond_to?(method_name, include_all = false)
        respond_to_missing?(method_name, include_all)
      end

      private
      # Must be overridden by descendants
      #
      # @since 0.3.5
      # @api private
      def respond_to_missing?(method_name, include_all)
        ::Kernel.raise ::NotImplementedError
      end

      # @since 0.3.5
      # @api private
      def __inspect
      end
    end
  end
end
