require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  it 'signs user in' do
    u = User.create_with_password!(
      {
        first_name: 'sam',
        last_name: 'e',
        email: 'sam@sam.com'
      },
      'food'
    )

    expect(session[:user_uuid]).to be_nil

    post :new, params: { email: 'Sam@sam.Com', password: 'food' }

    expect(session[:user_uuid]).to eql(u.uuid)

    expect(response.status).to be(202)
  end

  it 'does not sign user in with incorrect password' do
    u = User.create_with_password!(
      {
        first_name: 'sam',
        last_name: 'e',
        email: 'sam@sam.com'
      },
      'food'
    )

    expect(session[:user_uuid]).to be_nil

    post :new, params: { email: 'Sam@sam.Com', password: 'food1' }

    expect(session[:user_uuid]).to be_nil

    expect(response.status).to be(401)

    expect(response.body).to eql("{\"error\":\"email and password do not match\"}")
  end
end
