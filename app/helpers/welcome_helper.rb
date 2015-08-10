module WelcomeHelper

	  	#retrieve user photos

	  	 #  	def get_user_photos(userid)
	  		  	
	  		#   	photos = Parse::Query.new("Photo").tap do |q|
	  		#   	  q.eq("user", Parse::Pointer.new({
	  		#   	    "className" => "_User",
	  		#   	    "objectId"  => userid #this is the user
	  		#   	  }))
	  		#   	end.get

	  		#   	#return photo url
	  		#   	return photos.map {|i| get_photo_url(i['objectId'])}

	  		#   	# photos_url_array = photos.map {|i| get_photo_url(i['objectId'])}
	  		#   	# return photos_url_array.map {|i| i }

	  		# end

	  		# def get_photo_url(photoid)
	  		# 	query = Parse::Query.new("Photo").eq("objectId", photoid).get
	  		# 	full_photo_info = query[0]["image"]
	  		# 	photo_hash = full_photo_info.to_h
	  		# 	photo_url = photo_hash["url"]

	  		# 	return photo_url
	  		# end


end
