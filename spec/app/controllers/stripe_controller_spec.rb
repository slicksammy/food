require 'rails_helper'


RSpec.describe StripeController, type: :controller do

  let(:instance) { instance_double(Stripe::Create, create!: stipe_token) }
  let(:stipe_token) { double(uuid: 'uuid')}
  let(:user)   { instance_double(User) }
  let(:subject) { post :create, session: { user_uuid: 'something' } }
  let(:details) { {something: 'something'} }

  before do
    allow_any_instance_of(StripeController).to receive(:current_user).and_return(user)
    allow(Stripe::Create).to receive(:new).and_return(instance)
    controller.stub(:params).and_return({details: details}.with_indifferent_access)
    allow_any_instance_of(StripeController).to receive(:permit_params).and_return(nil)
  end

  it 'hits the stripe class' do
    Stripe::Create.should_receive(:new).with(user, details)

    subject

    expect(subject.body).to eql("{\"uuid\":\"uuid\"}")
  end
end


