# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # used to goes to tje sites and collects data
    require 'net/http'
    # pass that data once we collected and bring it back to our app
    require 'json'

    # API url
    $API_KEY = 'api_key=f86cc31e3850cd90ef8e189703f28ac1'
    $DOMEN = 'https://api.themoviedb.org/3/'
    $IMG_URL = 'https://image.tmdb.org/t/p/w500'

    $top_rated = 'movie/top_rated?'
    $popular_movies = 'movie/popular?'
    $SEARCH = 'search/movie?'

    # fetching new films
    def fetch_films(url)
      @url = url
      # uniform resource indicator - URL type thing
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)
    end

    # render films on the page
    def render_films(output_request)
      @output = output_request
      if @output['results'].empty?
        @error_on_request = 'Error nothing to render here'
      else
        render 'home/_card'
      end
    end

    def get_popular_films
      @url = $DOMEN + $popular_movies + $API_KEY
      @result = fetch_films(@url)
      render_films(@result)
      # the way to show the JSON on page
      # @output_JSON = @result
    end

    def searching
      @film_name = params[:search_request]
      if params[:top_films] == ''
        @film_name = 'Films is not found!'
      else
        @url = $DOMEN + $SEARCH + $API_KEY + '&query=' + @film_name.to_s
        @result = fetch_films(@url)
        render_films(@result)
      end
    end
  end
end
