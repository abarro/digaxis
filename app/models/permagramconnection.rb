class PermagramConnection
    attr_accessor :photos_hash, :users_hash, :this_month, :month_photos

    def initialize(this_month, the_year)
        @get_users = Parse::Query.new("_User").get
        @users_hash = @get_users.collect {|x| x.to_h }

        #trocar o get photos pra get-photos-do-mes
        # @get_photos = Parse::Query.new("Photo").get
        
        # @photos_hash = @get_photos.collect {|x| x.to_h }
        @this_month = this_month
        @the_year = the_year
        @month_photos = self.all_photos_this_month

        
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


        #time interval for month
        month = @this_month
        next_month = month + 1
        year_one = @the_year
        year_two = @the_year

        if next_month == 13
            next_month = 1
            year_two = @the_year + 1
            
        end
        puts "month is #{month} next month is: #{next_month}"
        puts "betwenn year #{year_one} and: #{year_two}"

        get_month_photos = self.query_all_photos_based_on_date(month, next_month, year_one, year_two)

        photo_hash = get_month_photos.collect { |x| x.to_h }

        return photo_hash
    end

    def query_all_photos_based_on_date(month, next_month, year_one, year_two)
        Parse::Query.new("Photo").tap do |q|
          q.greater_eq("createdAt", Parse::Date.new("#{year_one}-#{month}-01T00:00:00-03:00"))
          q.less_eq("createdAt", Parse::Date.new("#{year_two}-#{next_month}-01T00:00:00-03:00"))
        end.get
    end

    def get_user_photos_of_month(userid)     

        user_photos_this_month = @month_photos.find_all {|user| user["user"]["objectId"] == userid }
        return user_photos_this_month
    end

end