json.array!(@friendships) do |friendship|
  json.extract! friendship, :id, :user_id, :friend_id, :approved
  json.url friendship_url(friendship, format: :json)
end
