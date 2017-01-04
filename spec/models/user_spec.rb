require 'spec_helper'

RSpec.describe User, type: :model do
  before(:all) do
  		@user = User.create(name: "Holden", password: "password")
	end
 
	after(:all) do
 		if !@user.destroyed?
    		@user.destroy
  		end
	end
 
	it 'authenticates and returns a user when valid email and password passed in' do
 		expect(User.authenticate(@user.name, @user.password)).to eq(@user)
	end

	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:password) }

end
