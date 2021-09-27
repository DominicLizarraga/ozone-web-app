class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url = "http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=11111&distance=0&API_KEY=F0D990AA-C672-4CBC-BF32-39F1CF27C931"
    @uri = URI(@url)

    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    # check for empty request result
    if @output.empty?
      @final_ouput = "Error, zip code not valid."
    else
      @final_ouput = @output[0]["AQI"]
    end

    if @final_ouput == "Error, zip code not valid."
      @api_color = "gray"
    elsif @final_ouput <= 50
      @api_color = "green"
    elsif @final_ouput >= 51 && @final_ouput <= 100
      @api_color = "yellow"
    elsif @final_ouput >= 101 && @final_ouput <= 150
      @api_color = "orange"
    elsif @final_ouput >= 151 && @final_ouput <= 200
      @api_color = "red"
    elsif @final_ouput >= 201 && @final_ouput <= 300
      @api_color = "purple"
    else
      @api_color = "maroon"
    end

  end
end
