require 'rails_helper'

RSpec.describe CartController, type: :controller do

  describe '#update' do

    it 'creates a new Cart and CartsProduct' do
      expect(Cart.count).to eql(0)
      expect(CartsProduct.count).to eql(0)
      expect(session[:cart_uuid]).to be_nil

      post :update, params: { product_id: '111', amount: 2 }

      expect(Cart.count).to eql(1)
      expect(CartsProduct.count).to eql(1)

      c = CartsProduct.last
      expect(c.product_uuid).to eql('111')
      expect(c.amount).to eql(2)

      expect(session[:cart_uuid]).to eql(Cart.last.uuid)
    end

    context 'updating products' do

      let(:c) { Cart.create! }
      let(:cp) { CartsProduct.create!(cart: c, amount: 3, product_uuid: '111') }

      before do
        cp
        allow_any_instance_of(CartController).to receive(:cart_uuid).and_return(c.uuid)
      end

      it 'creates a new Cart and CartsProduct' do
        post :update, params: { product_id: '111', amount: 2 }

        cp.reload
        expect(cp.amount).to eql(2) # updates amount
        expect(CartsProduct.count).to eql(1) # does not create new cartsproduct
        expect(Cart.count).to eql(1) # does not create new cart
      end
    end
  end
end
