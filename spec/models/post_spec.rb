require 'spec_helper'

RSpec.describe Post, type: :model do
  	before(:all) do
  		@user = User.create(name: "Holden", password: "password")
		@post = Post.create(title: "Example", body: "Example text", user_id: @user.id)
	end
 
	after(:all) do
 		if !@post.destroyed?
 			@post.destroy
    		@user.destroy
  		end
	end

	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:body) }
	it { should validate_presence_of(:user_id) }
end