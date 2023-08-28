class MovieController < ApplicationController
    def index
        @all_movies = Movie.all
        render json: @all_movies
    end

    def movie_params
        params.require(:movie).permit(:title, :sinopsis, :duration, :premiere)
    end

    def director
        @director = Director.find(params[:director_id])
        @movies = Movie.where(director_id: @director.id)
        render json: @movies
    end

    def create
        @director = Director.find(params[:director_id])
        @movie = Movie.new(movie_params)
        @movie.director = @director

        if @movie.save
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
        end
    end 

    def show
        @movie = Movie.find(params[:id])
        render json: @movie
    end

    def update
        @director = Director.find(params[:director_id])
        @movie = @director.movies.find(params[:movie_id])

        if @movie.update(movie_params)
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
        end        
    end

    def find
        @movie = Movie.where("sinopsis like ?", "%" + params[:keyword] + "%")
        render json: @movie
    end
end
