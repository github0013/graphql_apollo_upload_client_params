module GraphqlApolloUploadClientParams
  module Converters
    class Base
      def initialize(params)
        @params = params
      end

      def variables
      end

      def query
      end

      def operation_name
      end

      private
        attr_reader :params

        # Handle form data, JSON body, or a blank value
        def ensure_hash(ambiguous_param)
          case ambiguous_param
          when String
            if ambiguous_param.present?
              ensure_hash(JSON.parse(ambiguous_param))
            else
              {}
            end
          when Hash, ActionController::Parameters
            ambiguous_param
          when nil
            {}
          else
            raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
          end
        end

    end
  end
end