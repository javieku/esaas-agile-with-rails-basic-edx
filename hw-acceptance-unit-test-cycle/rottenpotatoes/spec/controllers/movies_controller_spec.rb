require 'rails_helper'

describe MoviesController do
	describe 'find movies with same director' do
    it 'should call the model method that finds movies with same director' do
        fake_movie = double('Movie', :title => 'Aladdin', :director => 'Satoshi')
        Movie.should_receive(:find).and_return(fake_movie)
        Movie.should_receive(:find_with_same_director).with("1")
        get :similar, {:id => 1}
    end
    it 'should select a Similar template for rendering when movie has a director' do
      fake_movie = double('Movie', :title => 'Aladdin', :director => 'Satoshi')
      fake_results = [double('Movie'), double('Movie')]
      Movie.stub(:find).and_return(fake_movie)
      Movie.stub(:find_with_same_director).and_return(fake_results)
      get :similar, {:id => 1}
      response.should render_template('similar')
    end
		it 'should make the movies with same director available to that template' do
      fake_movie = double('Movie', :title => 'Aladdin', :director => 'Satoshi')
      fake_results = [double('Movie'), double('Movie')]
      Movie.stub(:find).and_return(fake_movie)
      Movie.stub(:find_with_same_director).and_return(fake_results)
      get :similar, {:id => 1}
      assigns(:movie).should == fake_movie
      assigns(:movies).should == fake_results
    end
    it 'should select the Index page to redirect to when movie has no director' do
      fake_movie = double('Movie', :title => 'Aladdin', :director => '')       
      Movie.should_receive(:find).and_return(fake_movie)
      Movie.stub(:find_with_same_director).and_return(nil)
      get :similar, {:id => 1}
      response.should redirect_to movies_path
    end
    it 'should make the error message available to that template' do
      fake_movie = double('Movie', :title => 'Aladdin', :director => '')
      Movie.should_receive(:find).and_return(fake_movie)
      Movie.stub(:find_with_same_director).and_return(nil)
      get :similar, {:id => 1}
      flash[:notice].should eq("'#{fake_movie.title}' has no director info.")
    end
  end

  describe 'create movies' do
    let(:valid_params) { {'movie' => {'title' => 'Test movie'} }}
    it 'works' do
      expect {
        post :create, valid_params
      }.to change(Movie, :count).by(1)
    end
  end
end
