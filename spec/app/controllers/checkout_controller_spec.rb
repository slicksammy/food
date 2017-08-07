require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do

  let(:subject) { get :view }

  context 'redirecting to login when necessary' do

    it 'cart items' do
      subject.should redirect_to('/signup')
    end

    it 'signed in but no items - nothing here' do
      allow_any_instance_of(CheckoutController).to receive(:redirect_to_login_if_neccessary).and_return(nil)

      subject

      expect(assigns(:message)).to eql('Nothing Here')
    end

    it 'signed in with items' do
      allow_any_instance_of(CheckoutController).to receive(:redirect_to_login_if_neccessary).and_return(nil)
      allow_any_instance_of(CheckoutController).to receive(:create_items).and_return([])
      allow_any_instance_of(CheckoutController).to receive(:create_order).and_return(nil)
      allow_any_instance_of(CheckoutController).to receive(:create_options).and_return(nil)

      subject
      
      expect(assigns(:message)).to be_nil
    end
  end

  context '#update_order' do
    
    let(:user) { User.create_with_password!({first_name: 'sam', last_name: 'e', email: 'email@email.com'}, 'password') }
    let(:address) { Address.create!(user: nil) }
    let(:order) { Order.create!(subtotal: 1, tax: 1, shipping: 0, total: 2) }

    before do
      user
      address
      order
      #allow_any_instance_of(CheckoutController).to receive_message_chain(:session, :[], :user_uuid).and_return(user.uuid)
    end

    it 'does not update order if address does not match user' do
      allow_any_instance_of(CheckoutController).to receive(:order).and_return(order)
      expect(order.address).to be_nil
      expect(address.uuid).to_not be_nil

      post :update_order, params: { order: {address: address.uuid} }, session: {user_uuid: user.uuid}

      expect(order.address).to be_nil
    end

    it 'updates order if address matches user' do
      allow_any_instance_of(CheckoutController).to receive(:order).and_return(order)
      expect(order.address).to be_nil
      expect(address.uuid).to_not be_nil
      
      address.update_attributes!(user: user)

      post :update_order, params: { order: {address: address.uuid} }, session: {user_uuid: user.uuid}

      expect(order.address).to eql(address)
    end
  end 
end
