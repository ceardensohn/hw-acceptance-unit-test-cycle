require 'rails_helper'

describe MoviesController do
    describe "Search Movies by the same director" do
        it 'should call Movie.similar_movies' do
            expect(Movie).to receive(:similar_movies).with('Star Wars')
            get :search, { title: 'Star Wars'}
        end

        it "should assign similar movies if director exists" do
            movies = ['Star Wars, THX-1138']
            Movie.stub(:similar_movies).with('Star Wars').and_return(movies)
            get :search, { title: 'Star Wars'}
            expect(assigns(:similar_movies)).to eql(movies)
        end

        it "should redirect to the home page if director isn't known" do
            Movie.stub(:similar_movies).with("No name").and_return(nil)
            get :search, { title: 'No name'}
            expect(response).to redirect_to(movies_url)
        end
    end

    describe 'GET index' do
        let!(:movie) {FactoryGirl.create(:movie)}

        it "should render the index view" do
            get :index
            expect(response).to render_template('index')
        end

        it "should assign an instance variable for title header" do
            get :index, { sort: 'title'}
            expect(assigns(:title_header)).to eql('hilite')
        end

        it "should assign an instance variable for release_date header" do
            get :index, { sort: 'release_date'}
            expect(assigns(:date_header)).to eql('hilite')
        end
    end

    describe "POST #create" do
        let!(:movie) {Movie.new}
        it "it creates a new movie" do
            post :create, movie: FactoryGirl.attributes_for(:movie)
            expect(response).to redirect_to(movies_url)
        end
    end

    describe "GET #show" do
        let!(:movie) {FactoryGirl.create(:movie)}
        before(:each) do
            get :show, id: movie.id
        end

        it "should find the movie" do
            expect(assigns(:movie)).to eql(movie)
        end

        it "should render the show view" do
            expect(response).to render_template('show')
        end
    end

    describe "GET #edit" do
        let!(:movie) {FactoryGirl.create(:movie) }
        before do
            get :edit, id: movie.id
        end

        it "should find the movie" do
            expect(assigns(:movie)).to eql(movie)
        end

        it 'should render the edit template' do
            expect(response).to render_template('edit')
        end
    end

    describe "PUT #update" do
        let!(:first_movie) { FactoryGirl.create(:movie)}
        
        before(:each) do
            put :update, id: first_movie.id, movie: FactoryGirl.attributes_for(:movie)
        end
        
        it "updates an existing movie" do
            first_movie.reload
            expect(first_movie.title).to eql("New Movie")
        end
       
        it "redirects to the movie view" do
             expect(response).to redirect_to(movies_path(first_movie))
        end
    end

    describe "DELETE #destroy" do
        let!(:first_movie) {FactoryGirl.create(:movie)}
        it "deletes a movie" do
            expect { delete :destroy, id: first_movie.id}.to change(Movie, :count).by(-1)
        end

        it "redirects to movies_path after deleting" do
            delete :destroy, id: first_movie.id
            expect(response).to redirect_to(movies_path)
        end
    end
end
