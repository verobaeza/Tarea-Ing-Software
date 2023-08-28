class RankingController < ApplicationController
    def index
        @all_rankings = Ranking.all
        render json: @all_rankings
    end

    def ranking_params
        params.require(:ranking).permit(:page, :min_score, :score, :max_score)
    end

    def create
        @director = Director.find(params[:director_id])
        @ranking = Ranking.new(ranking_params)
        @ranking.director = @director

        if @ranking.save
            render json: @ranking
        else
            render json: @ranking.errors, status: :unprocessable_entity
        end
    end 

    def director
        @director = Director.find(params[:director_id])
        @rankings = Ranking.where(director_id: @director.id)
        render json: @rankings
    end

    def top
        @quantity = params[:quantity].to_i # transforma el parametro a integer
        @all_rankings = Ranking.all
        @all_rankings_sorted = @all_rankings.sort_by {|ranking| (ranking.score - ranking.min_score) / (ranking.max_score - ranking.min_score)}.reverse!
        @top = @all_rankings_sorted.first(@quantity)
        render json: @top
    end

    def directorRankings
        @movie = Movie.find(params[:movie_id])
        @director = Director.find(@movie.director_id)
        @rankings = Ranking.where(director_id: @director.id)
        render json: @rankings
    end

    def deleteLow
        @all_rankings = Ranking.all
        @all_rankings_sorted = @all_rankings.sort_by {|ranking| (ranking.score - ranking.min_score) / (ranking.max_score - ranking.min_score)}
        @low = @all_rankings_sorted.first(1)[0]
        @director = Director.find(@low.director_id)
        @director.destroy
        render json: @director
    end

    def all
        @imdb = Ranking.where("page ILIKE ?", "imdb")
        @metacritic = Ranking.where("page ILIKE ?", "metacritic")
        @rotten_tomatoes = Ranking.where("page ILIKE ?", "rotten_tomatoes")
        @imdb_sorted = @imdb.sort_by {|ranking| (ranking.score - ranking.min_score) / (ranking.max_score - ranking.min_score)}.reverse!
        @metacritic_sorted = @metacritic.sort_by {|ranking| (ranking.score - ranking.min_score) / (ranking.max_score - ranking.min_score)}.reverse!
        @rotten_tomatoes_sorted = @rotten_tomatoes.sort_by {|ranking| (ranking.score - ranking.min_score) / (ranking.max_score - ranking.min_score)}.reverse!
        render json: {
            "imdb": @imdb_sorted,
            "metacritic": @metacritic_sorted,
            "rotten_tomatoes": @rotten_tomatoes_sorted
        }
    end
end
