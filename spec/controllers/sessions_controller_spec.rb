require 'rails_helper'

describe SessionsController do
  describe '#new' do
    context 'when the user is already authenticated' do
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
    let(:user) { FactoryGirl.create(:user) }

    context 'when the user is already authenticated' do
      before do
        session[:user_id] = FactoryGirl.create(:user).id
      end

      it 'redirects to the dashboard' do
        post :create
        expect(response).to redirect_to dashboard_path
      end
    end

    context 'when the credentials are valid' do
      it 'redirects to the dashboard' do
        post :create, params: { email: user.email, password: 'password' }
        expect(response).to redirect_to dashboard_path
      end

      it 'sets a session token' do
        post :create, params: { email: user.email, password: 'password' }
        expect(session[:user_id]).to eq user.id
      end

      context 'when given a `continue` query parameter' do
        context 'when the parameter is a path' do
          it 'redirects to the parameter url' do
            post :create, params: { email: user.email, password: 'password', continue: '/target' }
            expect(response).to redirect_to '/target'
          end
        end

        context 'when the parameter is a known URL' do
          it 'redirects to the parameter url' do
            post :create, params: { email: user.email, password: 'password', continue: 'http://test.host/target' }
            expect(response).to redirect_to 'http://test.host/target'
          end
        end

        context 'when the parameter is an untrusted URL' do
          it 'redirects to the dashboard' do
            post :create, params: { email: user.email, password: 'password', continue: 'https://www.google.com' }
            expect(response).to redirect_to dashboard_path
          end
        end
      end
    end

    context 'when the credentials are not valid' do
      it 'does not set the user_id session key' do
        post :create, params: { email: 'test@invalid.eu', password: 'deadbeef' }
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe '#destroy' do
    let(:user) { FactoryGirl.create(:user) }

    context 'when the user is authenticated' do
      before do
        session[:user_id] = FactoryGirl.create(:user).id
      end
    end

    it 'deletes the session cookie' do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the signin page' do
      delete :destroy
      expect(response).to redirect_to signin_path
    end
  end
end
