require 'rails_helper'

describe Movie do
    describe '.find_similar_movies' do
        let!(:first_movie) { FactoryGirl.create(:movie, title: 'A Clockwork Orange', director: 'Stanley Kubrick')}
        let!(:second_movie) { FactoryGirl.create(:movie, title: 'Full Metal Jacket', director: 'Stanley Kubrick')}
        let!(:third_movie) { FactoryGirl.create(:movie, title: 'The Dark Knight Rises', director: 'Christopher Nolan')}
        let!(:fourth_movie) { FactoryGirl.create(:movie, title: 'Venom')}

        context "director exists" do
            it "finds similar movies by director" do
                expect(Movie.similar_movies(first_movie.title)).to eql(['A Clockwork Orange', 'Full Metal Jacket'])
                expect(Movie.similar_movies(first_movie.title)).to_not include(['The Dark Knight Rises'])
                expect(Movie.similar_movies(second_movie.title)).to eql(['A Clockwork Orange', 'Full Metal Jacket'])
            end
        end

        context "director does not exist" do
            it 'handles failed path' do
                expect(Movie.similar_movies(fourth_movie.title)).to eql(nil)
            end
        end
    end

    describe ".all_ratings" do
        it "returns all ratings" do
            expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
        end
    end
end
