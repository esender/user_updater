require 'tilt'

module Hanami
  module Mailer
    # A logic-less template.
    #
    # @api private
    # @since 0.1.0
    #
    # TODO this is identical to Hanami::View, consider to move into Hanami::Utils
    class Template
      def initialize(template)
        @_template = Tilt.new(template)
      end

      # Render the template within the context of the given scope.
      #
      # @param scope [Class] the rendering scope
      # @param locals [Hash] set of objects passed to the constructor
      #
      # @return [String] the output of the rendering process
      #
      # @api private
      # @since 0.1.0
      def render(scope = Object.new, locals = {})
        @_template.render(scope, locals)
      end

      # Get the path to the template
      #
      # @return [String] the pathname
      #
      # @api private
      # @since 0.1.0
      def file
        @_template.file
      end
    end
  end
end
