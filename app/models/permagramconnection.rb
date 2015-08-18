class PermagramConnection
    attr_accessor :photos_hash
    attr_accessor :users_hash
    attr_accessor :this_month
    

    #descobrir como eu inicializo a class com ou sem um argumento.
    #descobrir como eu passo o mês pra classe de acordo com input do user.

    def initialize(this_month)
        @get_users = Parse::Query.new("_User").get
        @users_hash = @get_users.collect {|x| x.to_h }

        #trocar o get photos pra get-photos-do-mes
        # @get_photos = Parse::Query.new("Photo").get
        
        # @photos_hash = @get_photos.collect {|x| x.to_h }
        @this_month = this_month

        # self.all_photos_this_month

        
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

        #Set time interval to get photos - Get only photos of the month.

        month = @this_month
        next_month = month + 1

        #later refactor to get also year
        get_month_photos = Parse::Query.new("Photo").tap do |q|
          q.greater_than("createdAt", Parse::Date.new("#{Time.now.year}-#{month}-01T00:00:00-03:00"))
          q.less_than("createdAt", Parse::Date.new("#{Time.now.year}-#{next_month}-01T00:00:00-03:00"))
        end.get

        return get_month_photos
    end

    def get_user_photos_of_month(userid)     

        user_photos_this_month = all_photos_this_month.find_all {|user| user["user"].pointer.to_h["objectId"] == userid }
        return user_photos_this_month
    end

end