class PermagramConnection
    attr_accessor :photos_hash
    attr_accessor :users_hash
    attr_accessor :this_month

    
    def initialize
        @get_users = Parse::Query.new("_User").get
        @users_hash = @get_users.collect {|x| x.to_h }

        @get_photos = Parse::Query.new("Photo").get
        @photos_hash = @get_photos.collect {|x| x.to_h }
        @this_month = Time.now.month
    end

    def month_viewed(month)
        @this_month = month
    end

    def all_users
        return users_hash
    end

    def all_users_by_id
        user_ids = all_users.collect {|user| user["objectId"] }
        return user_ids
    end

    def all_users_by_username
        user_usernames = all_users.collect {|user| user["username"] }
        return user_usernames
    end

    def select_user_by_id(userid)    
        user = all_users.find_all {|user| user["objectId"] == userid }
        return user
    end

    def select_user_by_username(userid)    
        user = all_users.find_all {|user| user["username"] == userid }
        return user
    end

    def all_photos
        return photos_hash 
    end
    
    def get_user_photos(userid)  
        all_photos = @photos_hash.find_all {|user| user["user"]["objectId"] == userid }
        return all_photos
    end

    def get_user_photos_urls(userid)
        all_user_photos = get_user_photos(userid)
        get_urls = all_user_photos.map {|i| i['image']['url']}
        return get_urls
    end

    def all_photos_this_month
        photos_from_this_month = photos_hash.find_all {|photo|  Time.strptime("#{photo["createdAt"]}", "%Y-%m-%dT%T.%LZ").month == Time.now.month }
        return photos_from_this_month
    end

    def get_user_photos_of_month(userid)     
        user_photos_this_month = all_photos_this_month.find_all {|user| user["user"]["objectId"] == userid }
        return user_photos_this_month
    end

end