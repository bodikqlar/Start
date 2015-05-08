require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:category) { create(:category) }
  describe 'GET #index' do
    before(:each) { get :index }

    it 'assigns all categories as @categories' do
      expect(assigns(:categories)).to eq [category]
    end

    it 'renders the :index view' do
      expect(response).to render_template :index
    end

    it 'returns success response' do
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    before(:each) { get :new }

    it('assigns new category as @category') do
      expect(assigns(:category)).to be_a_new Category
    end

    it 'renders the :new view' do
      expect(response).to render_template :new
    end

    it 'returns success response' do
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    before(:each) { get :edit, { id: category.id } }

    it 'renders the :edit view' do
      expect(response).to render_template(:edit)
    end

    it('assigns category as @category') do
      expect(assigns(:category)).to eq category
    end

    it('returns success response') { expect(response).to be_success }
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested category' do
      expect{ delete :destroy, { id: category.id } }.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete :destroy, { id: category.id }
      expect(response).to redirect_to categories_path
    end
  end

  describe 'POST #create' do
    context 'with valid params' do

      it 'creates a new Category' do
        expect {
          post :create, category: attributes_for(:category)
        }.to change(Category, :count).by(1)
      end

      it 'assigns a newly created as @category' do
        post :create, category: attributes_for(:category)
        expect(assigns(:category)).to be_a Category
        expect(assigns(:category)).to be_persisted
      end

      it 'redirects to the categories' do
        post :create, category: attributes_for(:category)
        expect(response).to redirect_to categories_path
      end
    end

    context 'with invalid params' do
      let!(:invalid_params) { { name: nil } }

      it 'does not save the new contact' do
        expect{
          post :create, category: invalid_params
        }.to_not change(Category, :count)
      end

      it 're-renders the new method' do
        post :create, category: invalid_params
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Yuhu'} }
      before(:each) { put :update, {id: category.id, category: new_attributes} }

      it 'updates the requested category' do
        category.reload
      end

      it 'redirects to the categories' do
        expect(response).to redirect_to categories_path
      end
    end

    context 'with invalid params' do
      let(:unvalid_attributes) {{ name: nil }}
      it 're-renders the edit method' do
        put :update, {id: category.id, category: unvalid_attributes}
        expect(response).to render_template :edit
      end

    end
  end
end
