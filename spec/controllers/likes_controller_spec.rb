require 'rails_helper.rb'

RSpec.describe LikesController, type: :controller do

  describe "GET #index" do
    let(:likes) { create(:likes) }
    it "assigns @likes" do
      expect(assigns(:likes)).to eq(@likes)
    end

  end
end