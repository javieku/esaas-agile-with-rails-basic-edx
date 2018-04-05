Given /the following movies exist/ do |movies_table|
    movies_table.hashes.each do |movie|
      # each returned element will be a hash whose key is the table header.
      # you should arrange to add that movie to the database here.
      Movie.create!(movie)
    end
  end
  
  Then /(.*) seed movies should exist/ do | n_seeds |
    Movie.count.should be n_seeds.to_i
  end
  
  # Make sure that one string (regexp) occurs before or after another one
  #   on the same page
  
  Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    #  ensure that that e1 occurs before e2.
    #  page.body is the entire content of the page as a string.
    page.body.index(e1).should < page.body.index(e2)
  end
  
  
  # Make it easier to expr./features/step_definitions/movie_steps.rb:19:iness checking or unchecking several boxes at once
  #  "When I uncheck the following ratings: PG, G, R"
  #  "When I check the following ratings: G"
  
  When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
    rating_list.split(", ").each do |r|
      if(uncheck)
        uncheck("ratings_#{r}")
      else
        check("ratings_#{r}")
      end
    end
  end
  
  Then /I should see all the movies/ do
    expect(page.all('table#movies tbody > tr').count ).to eq Movie.count
    Movie.find_each do |movie|
      page.should have_content(movie.title)
    end
  end

  Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
    page.should have_content(director)
  end