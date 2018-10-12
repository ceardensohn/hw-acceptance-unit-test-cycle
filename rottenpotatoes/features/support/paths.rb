module NavigationHelpers
    def path_to(page_name)
        case page_name

        when /^the home\s?page$/
          movies_path
        when /^the edit page for "(.*)"$/
          movie_id = Movie.find_by(title: $1).id
          edit_movie_path(movie_id)
        when /^the details page for "(.+)"$/
          movie_id = Movie.find_by(title: $1)
          movie_path(movie_id)
        when /^the Similar Movies page for "(.+)"/
          search_similar_movies_path($1)





        else
          begin
            page_name =~ /^the (.*) page$/
            path_components = $1.split(/\s+/)
            self.send(path_components.push('path').joing('_').to_sym)
          rescue NoMethodError, ArgumentError
            raise "Can't find mapping from \"#{page_name}\" to a pth.\n"+"Now, go and add a mapping in #{__FILE__}"
          end
        end
    end
end

World(NavigationHelpers)

