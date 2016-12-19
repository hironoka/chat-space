require 'rails_helper'

describe MessagesController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  let(:group) { create(:group) }
  let(:message) { Message.new }
  let(:messages) { create_list(:message, 3, group: group) }

  #indexのテスト
  describe 'GET #index' do
    before do
      get :index, group_id: group
    end
    it "renders the :index template" do
      expect(response).to render_template(:index)
    end
    it "assigns the requested contact to messages" do
      expect(assigns(:messages)).to eq messages
    end
    it "assigns the requested contact to group" do
      expect(assigns(:group)).to eq group
    end
  end

  #createのテスト
  describe 'POST #create' do
    #when it is success
    it "saves the new message in the database" do
      expect {
        post :create, group_id: group, message: attributes_for(:message, group_id: group.id, user_id: user.id)
      }.to change(Message, :count).by(1)
    end
    it "redirect to :index" do
      post :create, group_id: group, message: attributes_for(:message, group_id: group.id, user_id: user.id)
      expect(response).to redirect_to group_messages_path
    end

    #when it is not success
    it "not saves the new message in the database" do
      expect {
        post :create, group_id: group, message: attributes_for(:message, body: "", group_id: group.id, user_id: user.id)
      }.not_to change(Message, :count)
    end
    it "renders the :index template" do
      post :create, group_id: group, message: attributes_for(:message, body: "", group_id: group.id, user_id: user.id)
      expect(response).to render_template(:index)
    end
  end
end
