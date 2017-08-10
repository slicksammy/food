require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe '#create' do

    it 'creates a new user' do
      expect(session[:user_uuid]).to be_nil

      expect(User.count).to eql(0)

      post :create, params: { firstName: 'sam', lastName: 'e', email: 'soccersam115@yahoo.com', password: 'food' }

      expect(User.count).to eql(1)
      expect(session[:user_uuid]).to eql(User.last.uuid)
      # expect(UserMailer).to receive(:welcome).with(User.last)
      expect(response.status).to eql(200)
    end

    it 'does not create duplicate user' do
      User.create!(first_name: 'sam', last_name: 'e', email: 'soccersam115@yahoo.com')

      post :create, params: { firstName: 'sam', lastName: 'e', email: 'soccersam115@yahoo.com', password: 'food' }

      expect(User.count).to eql(1)
      expect(session[:user_uuid]).to be_nil
      expect(response.status).to eql(500)
    end

    it 'sets user to cart' do
      c = Cart.create!
      expect(c.user).to be_nil

      allow_any_instance_of(UsersController).to receive(:cart).and_return(c)

      post :create, params: { firstName: 'sam', lastName: 'e', email: 'soccersam115@yahoo.com', password: 'food' }

      expect(c.user).to eql(User.last)
    end
  end
end
