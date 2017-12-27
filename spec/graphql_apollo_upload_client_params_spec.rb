require "spec_helper"

module GraphqlApolloUploadClientParams
  RSpec.describe GraphqlApolloUploadClientParams do
    it "has a version number" do
      expect(GraphqlApolloUploadClientParams::VERSION).not_to be nil
    end

    describe :convert do
      context "has operations" do
        let(:params) do
          {
            operations: ""
          }
        end
        it{ expect(GraphqlApolloUploadClientParams.convert params).to match Converters::ApolloUploadClient }
      end

      context "no operations" do
        let(:params) do
          {}
        end
        it{ expect(GraphqlApolloUploadClientParams.convert params).to match Converters::Regular }
      end
    end
  end
end
