module GraphqlApolloUploadClientParams
  module Converters
    class ApolloUploadClient < Base

      def variables
        ensure_hash(operations)["variables"].tap do |v|
          file_mapping v
        end.with_indifferent_access
      end

      def query
        ensure_hash(operations)["query"]
      end

      def operation_name
        ensure_hash(operations)["operationName"]
      end

      private
        def operations
          params[:operations]
        end

        def map
          ensure_hash(params[:map]) rescue {}
        end

        def set_file_at_end(hash, dot_path, file)
          *dots, last = dot_path.split(".")
          element = dots.inject(hash) do |h, k|
            h.is_a?(Array) ? h[k.to_i] : (h[k] || h[k.to_sym] || h[k] = nil)
          end

          element.is_a?(Array) ? element[last.to_i] = file : element[last] = file || element[last.to_sym] = file
        end

        def file_mapping(v)
          map.each do |file_index, dotted_paths|
            file = params[file_index]

            dotted_paths.each do |dotted_path|
              wrapper = dotted_path.split(".").first
              set_file_at_end({wrapper => v}, dotted_path, file)
            end
          end
        end

    end
  end
end