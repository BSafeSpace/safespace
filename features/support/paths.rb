
module NavigationHelpers
  # Maps a name to a path. Used by the

  def path_to(page_name)
    case page_name

    when /^the SafeSpace home\s?page$/
      '/'
      
     when /^the Sign Up page$/
         '/users/sign_up'
    
    when /^the Sign In page$/
        '/users/sign_in'
    
    when /^the chat page$/
        '/conversations'
        
    when /^the search page$/
        '/profiles'
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
