class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url = "http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=92154&distance=0&API_KEY=F0D990AA-C672-4CBC-BF32-39F1CF27C931"
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
      @api_color = "silver"
      @api_message = "No description for this request."
    elsif @final_ouput <= 50
      @api_color = "green"
      @api_message = "Good (0 - 50) Air quality is considered satisfactory, and air pollution poses little or no risk."
    elsif @final_ouput >= 51 && @final_ouput <= 100
      @api_color = "yellow"
      @api_message = "Moderate (51 - 100) Air quality is acceptable."
    elsif @final_ouput >= 101 && @final_ouput <= 150
      @api_color = "orange"
      @api_message = "Unhealthy for Sensitive Groups (101 - 150)"
    elsif @final_ouput >= 151 && @final_ouput <= 200
      @api_color = "red"
      @api_message = "Unhealthy (151 - 200)"
    elsif @final_ouput >= 201 && @final_ouput <= 300
      @api_color = "purple"
      @api_message = "Very Unhealthy (201 - 300)"
    else
      @api_color = "maroon"
      @api_message = "Hazardous (301 - 500)
Health warnings of emergency conditions. The entire population is more likely to be affected."
    end

  end
end
