class DirectorController < ApplicationController
    def index
        @all_directors = Director.all
        render json: @all_directors
    end

    def directors_params
        params.require(:director).permit(:name, :age, :country, :has_oscars)
    end

    def create
        @director = Director.new(directors_params)
        if @director.save
            render json: @director
        else
            render json: @director.errors, status: :unprocessable_entity
    
        end
    end 

    def show
        @director = Director.find(params[:id])
        render json: @director, status: :unprocessable_entity
    end

    def destroy
        @director = Director.find(params[:id])
        @director.destroy
        render json: {}
    end

    def destroy_all
        Director.destroy_all
        @all_directors = Director.all
        render json: @all_directors
    end

    def oscars
        @director = Director.where(has_oscars: true)
        render json: @director
    end


end
