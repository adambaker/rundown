require 'spec_helper'

describe ItemsController do
  before :all do
    @user = a_user
  end

  def valid_attributes
    {
      name: 'a wacky poster',
      price: '10.00',
      quantity: 8,
    }
  end
  def valid_session
    {user_id: @user._id}
  end

  describe "GET index" do
    it "assigns all items as @items" do
      item = Item.create! valid_attributes
      get :index, {}, valid_session
      assigns(:items).should == Item.all
    end

    it 'requires you to be logged in' do
      get :index
      response.should redirect_to '/auth/google_oauth2'
    end
  end

  describe "GET show" do
    it "assigns the requested item as @item" do
      item = Item.create! valid_attributes
      get :show, {id: item}, valid_session
      assigns(:item).should eq(item)
    end
  end

  describe "GET new" do
    it "assigns a new item as @item" do
      get :new, {}, valid_session
      assigns(:item).should be_a_new(Item)
    end

    it 'requires you to be logged in' do
      get :new
      response.should redirect_to '/auth/google_oauth2'
    end
  end

  describe "POST create" do
    it 'requires you to be logged in' do
      get :index
      response.should redirect_to '/auth/google_oauth2'
    end

    describe "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, {item: valid_attributes}, valid_session
        }.to change(Item, :count).by(1)
      end

      it "assigns a newly created item as @item" do
        post :create, {item: valid_attributes}, valid_session
        assigns(:item).should be_a(Item)
        assigns(:item).should be_persisted
      end

      it "redirects to the created item" do
        post :create, {item: valid_attributes}, valid_session
        response.should redirect_to(Item.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item as @item" do
        Item.any_instance.stub(:save).and_return(false)
        post :create, {item: {}}, valid_session
        assigns(:item).should be_a_new(Item)
      end

      it "re-renders the 'new' template" do
        Item.any_instance.stub(:save).and_return(false)
        post :create, {item: {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do

    it 'requires you to be logged in' do
      get :index
      response.should redirect_to '/auth/google_oauth2'
    end

    describe "with valid params" do
      it "updates the requested item" do
        item = Item.create! valid_attributes
        Item.any_instance.should_receive(:update_attributes).with(
          {'a' => 'b'}
        )
        put :update, {id: item, item: {'a' => 'b'}}, valid_session
      end

      it "assigns the requested item as @item" do
        item = Item.create! valid_attributes
        put :update, {id: item, item: valid_attributes}, valid_session
        assigns(:item).should eq(item)
      end

      it "redirects to the item" do
        item = Item.create! valid_attributes
        put :update, {id: item, item: valid_attributes}, valid_session
        response.should redirect_to(item)
      end
    end

    describe "with invalid params" do
      it "assigns the item as @item" do
        item = Item.create! valid_attributes
        Item.any_instance.stub(:save).and_return(false)
        put :update, {id: item, item: {}}, valid_session
        assigns(:item).should eq(item)
      end

      it "re-renders the 'show' template" do
        item = Item.create! valid_attributes
        Item.any_instance.stub(:save).and_return(false)
        put :update, {id: item, item: {}}, valid_session
        response.should render_template("show")
      end
    end
  end

  describe "DELETE destroy" do

    it 'requires you to be logged in' do
      get :index
      response.should redirect_to '/auth/google_oauth2'
    end

    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, {id: item}, valid_session
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      item = Item.create! valid_attributes
      delete :destroy, {id: item}, valid_session
      response.should redirect_to(items_url)
    end
  end

end
