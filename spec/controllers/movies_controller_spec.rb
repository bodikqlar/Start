require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie, user: user) }

  before(:each) { sign_in user }

  describe 'GET #index' do
    before(:each) { get :index }

    it 'assigns all movies as @movies' do
      expect(assigns(:movies)).to eq [movie]
    end

    it "renders the :index view" do
      expect(response).to render_template :index
    end

    it "returns success response" do
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    before(:each) { get :new }

    it("assigns new movie as @movie") do
      expect(assigns(:movie)).to be_a_new Movie
    end

    it 'renders the :new view' do
      expect(response).to render_template :new
    end

    it "returns success response" do
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    before(:each) { get :edit, { id: movie.id } }

    it 'renders the :edit view' do
      expect(response).to render_template(:edit)
    end

    it('assigns movie as @movie') do
      expect(assigns(:movie)).to eq movie
    end

    it('returns success response') { expect(response).to be_success }
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested movie' do
      expect{ delete :destroy, { id: movie.id } }.to change(Movie, :count).by(-1)
    end

    it 'redirects to the movies list' do
      delete :destroy, { id: movie.id }
      expect(response).to redirect_to movies_path
    end
  end

  describe 'POST #create' do
    context 'with valid params' do

      it 'creates a new Movie' do
        expect {
          post :create, movie: attributes_for(:movie)
        }.to change(Movie, :count).by(1)
      end

      it 'assigns a newly created as @movie' do
        post :create, movie: attributes_for(:movie)
        expect(assigns(:movie)).to be_a Movie
        expect(assigns(:movie)).to be_persisted
      end

      it 'redirects to the movies' do
        post :create, movie: attributes_for(:movie)
        expect(response).to redirect_to movies_path
      end
    end

    context 'with invalid params' do
      let!(:invalid_params) { { name: nil, rating: 2 } }

      it 'does not save the new movie' do
        expect{ post :create, movie: invalid_params }.to_not change(Movie, :count)
      end

      it 're-renders the new method' do
        post :create, movie: invalid_params
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Yuhu', rating: 2} }
      before(:each) { put :update, {id: movie.id, movie: new_attributes} }

      it 'updates the requested movie' do
        movie.reload
      end

      it 'redirects to the movies' do
        expect(response).to redirect_to movies_path
      end
    end

    context 'with invalid params' do
      let(:unvalid_attributes) {{ name: nil, rating: 1 }}
      it 're-renders the edit method' do
        put :update, {id: movie.id, movie: unvalid_attributes}
        expect(response).to render_template :edit
      end

    end
  end
end
