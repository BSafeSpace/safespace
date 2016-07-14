class Profile < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :characteristics
  validate :set_user_id

  def set_user_id
  	self.user_id = self.id 
  end

  def add_characteristic(characteristic)
    self.characteristics << characteristic
  end

  def self.online_or_all_profiles(online)
  	if online
  		return Profile.where('online = ?', true)
  	else
  		return Profile.all
  	end
  end

  def self.ransortable_attributes(auth_object = nil)
  	return ["age", "name", "recommend_count"]
  end

  def self.ransackable_scopes(auth_object = nil)
  	return [:online_or_all_profiles]
  end

  def build_query
    @search = Profile.search(params[:q])
    @search.build_sort if @search.sorts.empty?
    @profiles = order_preferences(@search.result(distinct: true).reject{ |p| p.user == current_user})
    @num_profiles = @profiles.count
    @profiles = put_peer_counselor_first(@profiles) if !current_user.peer_counselor
    @profiles.paginate(page: params[:page], per_page: 15)
  end

  def order_preferences(search_query)
    if params[:preferences]
      puts params[:preferences]
      @sorted_preferences = Hash[params[:preferences].sort_by{|k, v| v}.reverse]
      @sorted_preferences.each do |category, rank|
        search_query = put_preference_first(search_query, category)
      end
    end

    return search_query
  end

  def put_preference_first(search_query, name)
    characteristic = Characteristic.where('category = ?', name).first
    
    if characteristic
      matching_profiles = search_query.select { |profile| profile.characteristics.include? characteristic }
      search_query = search_query.reject!{ |profile| profile.characteristics.include? characteristic }
      search_query = matching_profiles ? matching_profiles + search_query : search_query
    end

    return search_query
  end

  def put_peer_counselor_first(search_query)
    peer_counselors = User.where("peer_counselor = ?", true)
    search_query = search_query.reject{ |p| peer_counselors.include? p.user }

    for i in 0..search_query.count
      search_query.insert(i, peer_counselors.sample.profile) if i % 15 == 0
    end
    
    return search_query
  end

  def query_online_only?
    return params[:q][:online_or_all_profiles] == "1" if params[:q]
  end

  def query_sort_type
    return params[:q][:s]["0"][:name] if params[:q]
    return ""
  end
end