require 'rails_helper'

describe UsersController do
  describe '#new' do
    context 'when the user is not authenticated' do
      it 'is successful' do
        get :new
        expect(response).to be_successful
      end
    end

    context 'when the user is authenticated' do
      before do
        session[:user_id] = FactoryGirl.create(:user).id
      end

      it 'redirects to the dashboard' do
        get :new
        expect(response).to redirect_to dashboard_path
      end
    end
  end

  describe '#create' do
    context 'when the user info are valid' do
      let(:user_params) { { name: 'Test User', email: 'test@example.com', password: 'test', password_confirmation: 'test' } }

      it 'is creates a new user' do
        expect {
          post :create, params: { user: user_params }
        }.to change { User.count }.by 1
      end

      it 'redirects to the dashboard' do
        post :create, params: { user: user_params }
        expect(response).to redirect_to dashboard_path
      end

      it 'signs in the new user' do
        post :create, params: { user: user_params }
        expect(session[:user_id]).to eq User.last.id
      end
    end

    context 'when the user info are not valid' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: { email: '' } }
        }.to_not change { User.count }
      end
    end

    context 'when the user is authenticated' do
      before do
        session[:user_id] = FactoryGirl.create(:user).id
      end

      it 'redirects to the dashboard' do
        post :create, params: { user: {} }
        expect(response).to redirect_to dashboard_path
      end
    end
  end
end
