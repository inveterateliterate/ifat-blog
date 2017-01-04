require 'spec_helper'

RSpec.describe PostsController, type: :controller do

before(:each) do
  @user = FactoryGirl.create(:user)
  login(@user) 
  @post = FactoryGirl.create(:post)
end
after(:each) do
  if !@post.nil?
    @post.destroy
    @user.destroy
  end
end


describe "GET index" do
  it 'responds with success' do
    get :index
    expect(response.success?).to be(true)
  end

  	it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
  	end

  it "populates an instance variable @posts with all pins in the database" do
    get :index
    expect(assigns[:posts]).to eq(Post.all.order("created_at DESC"))
  end
end

describe "GET new" do
  it 'responds with success' do
    get :new
    expect(response.success?).to be(true)
  end

  it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
  end

  it 'assigns an instance variable to a new post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
  end

  it "redirects to login if user is not signed in" do
      logout(@user)
      get :new
      expect(response).to redirect_to(:login)
  end
end

describe "POST create" do
  before(:each) do
    @post_hash = {
    	title: "Example Post",
      body: "This is an example post.",
      user_id: @user.id
    } 
  end
  after(:each) do
    post = Post.find_by_title("Example Post")
    if !post.nil?
      	post.destroy
    end
  end

  	it 'responds with a redirect' do
    post :create, post: @post_hash
    expect(response.redirect?).to be(true) 
  	end

  	it 'creates a post' do
      post :create, post: @post_hash  
      expect(Post.find_by_title("Example Post").present?).to be(true)
    end

  	it 'redirects to the index view' do
      post :create, post: @post_hash
      expect(response).to redirect_to(posts_path)
  	end

  	it 'redisplays new form on error' do
      @post_hash[:body] = nil
      post :create, post: @post_hash
      expect(response).to render_template(:new)
    end
    
    it 'assigns the @errors instance variable on error' do
      @post_hash[:body] = ""
      post :create, post: @post_hash
      expect(assigns[:post].errors.any?).to be(true)
    end 
end

describe "GET edit" do
  it "responds with success" do
	 get :edit, id: @post.id
	 expect(response.success?).to be(true)
  end

  it 'renders the edit view' do
      get :edit, id: @post.id     
      expect(response).to render_template(:edit)
  end

  it "assigns an instance variable called @post to the post with the appropriate id" do
      get :edit, id: @post.id
      expect(assigns(:post)).to eq(@post)
  end

  it "redirects to login if user is not signed in" do
      logout(@user)
      get :edit, id: @post.id 
      expect(response).to redirect_to(:login)
  end
end

describe "PUT update" do

  before(:each) do
    @post = Post.last
    @post_hash = {
      title: "New Title",
      body: "This is an example post.",
      user_id: @user.id
    } 
  end

    it 'responds with a redirect' do
      put :update, post: @post_hash, id: @post.id
      expect(response.redirect?).to be(true)
    end
   
    it 'updates a post' do
      put :update, post: @post_hash, id: @post.id
      @post.reload
      expect(@post.title).to eq(@post_hash[:title])
    end
  
    it 'redirects to the index view' do
      put :update, post: @post_hash, id: @post.id 
      @post.reload
      expect(response).to redirect_to(posts_path)
    end

  	it 'assigns the @errors instance variable on error' do
      @post_hash[:title] = ""
      put :update, post: @post_hash, id: @post.id
      expect(assigns[:post].errors.any?).to be(true)
  	end

  	it "re-renders the 'edit' template" do
       @post_hash[:title] = ""
       put :update, post: @post_hash, id: @post.id
       expect(response).to render_template(:edit)
  	end
end

end