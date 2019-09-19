module GraphqlApolloUploadClientParams
  module Converters
    class Regular < Base

      def variables
        ensure_hash(params[:variables])
      end

      def query
        params[:query]
      end

      def operation_name
        params[:operation_name]
      end

    end
  end
end