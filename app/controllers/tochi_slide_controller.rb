require 'net/http'
require 'uri'
require 'json'

class TochiSlideController < ApplicationController
  def index
	lat = "4.72"
	lon = "115.07"
	if request.get? then
		if params['lat'] != nil then
			lat = params['lat']
			lon = params['lng']
		end
	end
	@GOOGLEMAP_KEY = ENV["GOOGLEMAP_KEY"]
	
	weatherMapApiUri = "http://api.openweathermap.org/data/2.5/weather"
	uri = URI.parse(weatherMapApiUri + "?APPID=" + ENV["WEATHER_APPID"] + "&lat=" + lat +"&lon=" + lon)
	json = Net::HTTP.get(uri)
	@result = JSON.parse(json)

	googleMapUri = "https://maps.googleapis.com/maps/api/timezone/json"
	timestamp = Time.now.to_i
	uri2 = URI.parse(googleMapUri +"?location=" + lat +"," + lon + "&timestamp=" + timestamp.to_s + "&key=" + ENV["GOOGLEMAP_KEY"])
	json2 = Net::HTTP.get(uri2)
	timeJson = JSON.parse(json2)
	@time = (Time.now + timeJson['rawOffset']).strftime("%d/%m/%Y %H:%M:%S")
	@timeZoneId = timeJson['timeZoneId'] 
  end
end
