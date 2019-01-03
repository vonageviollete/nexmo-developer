require 'rails_helper'

RSpec.describe OpenApiController, type: :request do
  OpenApiConstraint.list.each do |name|
    describe "GET /api/#{name}" do
      it "renders #{name} correctly" do
        # Auto generated IDs need to be predictable
        allow(SecureRandom).to receive(:hex).and_return('abc123-this-is-a-hash')
        get "/api/#{name}"

        File.write("/tmp/#{name}", response.body)

        expect(response.body).to match_snapshot(name)
      end
    end
  end
end
