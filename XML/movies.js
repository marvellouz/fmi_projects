
    function append(root, t, content) {
      x=doc.createElement(t);
      x.appendChild(doc.createTextNode(content));
      root.appendChild(x);
      return x;
    }

    var doc=new ActiveXObject("MSXML.DOMDocument");
    var rootElem=doc.createElement("Body");
    
      var movies=doc.createElement("Movies");
      var movie;
      var e, nested;
      
    movie=doc.createElement("Movie");
    movie.setAttribute("MovieId", "sr");
    movie.setAttribute("Length", "185");
    movie.setAttribute("Color", "yes");
    movie.setAttribute("Actors", "rdn jf ab");

    append(movie, "Title", "Taxi Driver");
    append(movie, "Year", "1976");
    append(movie, "Picture", "http://ia.media-imdb.com/images/M/MV5BMTAzNzY1NzYzMzFeQTJeQWpwZ15BbWU3MDc3MjA0NTE@._V1._SX99_SY140_.jpg");

    e=doc.createElement("Genres");
    append(e, "Genre", "Drama");append(e, "Genre", "Thriller");
    movie.appendChild(e);

    e=doc.createElement("Keywords");
    append(e, "Keyword", "New York City");append(e, "Keyword", "Taxi Driver");append(e, "Keyword", "Date");
    movie.appendChild(e);

    append(movie, "Tagline", "On every street in every city, there's a nobody who dreams of being a somebody. ");
    append(movie, "Plot", "A mentally unstable Vietnam war veteran works as nighttime taxi driver in a city whose perceived decadence and sleaze feeds his urge to violently lash out, attempting to save a teenage prostitute in the process.");

    e=doc.createElement("Directors");
    
      nested=doc.createElement("Director");
      append(nested, "Name", "Martin Scorsese");
      e.appendChild(nested);
    
    movie.appendChild(e);

    e=doc.createElement("Writers");
    
      nested=doc.createElement("Writer");
      append(nested, "Name", "Paul Schrader");
      e.appendChild(nested);
    
    movie.appendChild(e);

    e=doc.createElement("Characters");
    
      nested=doc.createElement("Character");
      nested.setAttribute("Actor", "rdn");
      e.appendChild(nested);
    
      nested=doc.createElement("Character");
      nested.setAttribute("Actor", "jf");
      e.appendChild(nested);
    
      nested=doc.createElement("Character");
      nested.setAttribute("Actor", "ab");
      e.appendChild(nested);
    
    movie.appendChild(e);

    movies.appendChild(movie);
  
    movie=doc.createElement("Movie");
    movie.setAttribute("MovieId", "pf");
    movie.setAttribute("Length", "184");
    movie.setAttribute("Color", "yes");
    movie.setAttribute("Actors", "jt sj ut");

    append(movie, "Title", "Pulp Fiction");
    append(movie, "Year", "1994");
    append(movie, "Picture", "http://www.imdb.com/rg/action-box-title/primary-photo/media/rm3216480512/tt0110912");

    e=doc.createElement("Genres");
    append(e, "Genre", "Crime");append(e, "Genre", "Thriller");
    movie.appendChild(e);

    e=doc.createElement("Keywords");
    append(e, "Keyword", "Boxer");append(e, "Keyword", "Restaurant");append(e, "Keyword", "Diner");
    movie.appendChild(e);

    append(movie, "Tagline", "Girls like me don't make invitations like this to just anyone! ");
    append(movie, "Plot", "The lives of two mob hit men, a boxer, a gangster's wife, and a pair of diner bandits intertwine in four tales of violence and redemption.");

    e=doc.createElement("Directors");
    
      nested=doc.createElement("Director");
      append(nested, "Name", "Quentin Tarantino");
      e.appendChild(nested);
    
    movie.appendChild(e);

    e=doc.createElement("Writers");
    
      nested=doc.createElement("Writer");
      append(nested, "Name", "Quentin Tarantino");
      e.appendChild(nested);
    
    movie.appendChild(e);

    e=doc.createElement("Characters");
    
      nested=doc.createElement("Character");
      nested.setAttribute("Actor", "jt");
      e.appendChild(nested);
    
      nested=doc.createElement("Character");
      nested.setAttribute("Actor", "sj");
      e.appendChild(nested);
    
      nested=doc.createElement("Character");
      nested.setAttribute("Actor", "ut");
      e.appendChild(nested);
    
    movie.appendChild(e);

    movies.appendChild(movie);
  
    movie=doc.createElement("Movie");
    movie.setAttribute("MovieId", "bc");
    movie.setAttribute("Length", "199");
    movie.setAttribute("Color", "yes");
    movie.setAttribute("Actors", "jt ut vv");

    append(movie, "Title", "Be Cool");
    append(movie, "Year", "2005");
    append(movie, "Picture", "http://ia.media-imdb.com/images/M/MV5BMTQ4NTI2NTg1MF5BMl5BanBnXkFtZTcwMzkxOTgyMQ@@._V1._SX100_SY136_.jpg");

    e=doc.createElement("Genres");
    append(e, "Genre", "Comedy");append(e, "Genre", "Crime");
    movie.appendChild(e);

    e=doc.createElement("Keywords");
    append(e, "Keyword", "Sequel");append(e, "Keyword", "Music Business");append(e, "Keyword", "Russian Mafia");
    movie.appendChild(e);

    append(movie, "Tagline", " Everyone is looking for the next big hit ");
    append(movie, "Plot", "Disenchanted with the movie industry, Chili Palmer (John Travolta) tries the music industry, meeting and romancing a widow of a music exec (Uma Thurman) on the way.");

    e=doc.createElement("Directors");
    
      nested=doc.createElement("Director");
      append(nested, "Name", "F. Gary Gray");
      e.appendChild(nested);
    
    movie.appendChild(e);

    e=doc.createElement("Writers");
    
      nested=doc.createElement("Writer");
      append(nested, "Name", "Elmore Leonard");
      e.appendChild(nested);
    
      nested=doc.createElement("Writer");
      append(nested, "Name", "Peter Steinfeld");
      e.appendChild(nested);
    
    movie.appendChild(e);

    e=doc.createElement("Characters");
    
      nested=doc.createElement("Character");
      nested.setAttribute("Actor", "jt");
      e.appendChild(nested);
    
      nested=doc.createElement("Character");
      nested.setAttribute("Actor", "ut");
      e.appendChild(nested);
    
      nested=doc.createElement("Character");
      nested.setAttribute("Actor", "vv");
      e.appendChild(nested);
    
    movie.appendChild(e);

    movies.appendChild(movie);
  
      rootElem.appendChild(movies);
  
      var actors=doc.createElement("Actors");
      var actor;
      
    actor=doc.createElement("Actor");
    actor.setAttribute("ActorId", "rdn");
    append(actor, "Name", "Robert De Niro");
    append(actor, "Biography", "Robert De Niro, who is thought of as one of the greatest actors of his time, was born in New York City in 1943 to two artists. He was trained at the Stella Adler Conservatory and the American Workshop. He first gained fame for his role in Bang the Drum Slowly (1973), but he gained his reputation as a volatile actor in Mean Streets (1973), which was his first film with director Martin Scorsese. In 1974 De Niro received an Academy Award for best supporting actor for his role in The Godfather: Part II (1974) and received Academy Award nomations for best actor in Taxi Driver (1976), The Deer Hunter (1978), and Cape Fear (1991).");
    append(actor, "Awards", "Won 2 Oscars. Another 28 wins and 34 nominations ");
    actors.appendChild(actor);
  
    actor=doc.createElement("Actor");
    actor.setAttribute("ActorId", "jf");
    append(actor, "Name", "Jodie Foster");
    append(actor, "Biography", "Alicia Christian Foster was born on November 19, 1962, in Los Angeles.");
    append(actor, "Awards", "Won 2 Oscars. Another 36 wins and 20 nominations ");
    actors.appendChild(actor);
  
    actor=doc.createElement("Actor");
    actor.setAttribute("ActorId", "ab");
    append(actor, "Name", "Albert Brooks");
    append(actor, "Biography", "Born in 22 July 1947, Beverly Hills, California, USA");
    append(actor, "Awards", "Nominated for Oscar. Another 6 wins and 1 nomination ");
    actors.appendChild(actor);
  
    actor=doc.createElement("Actor");
    actor.setAttribute("ActorId", "jt");
    append(actor, "Name", "John Travolta");
    append(actor, "Biography", "John Travolta first gained fame as the swaggering Vinnie Barbarino on the television series 'Welcome Back, Kotter' (1975). In 1977, he parlayed his teeny-bopper fame into a big-screen career with the disco blockbuster Saturday Night Fever (1977). He languished in light dramas and television movies in the 1980s, but started a comeback in 1989 with Look Who's Talking (1989).");
    append(actor, "Awards", "Nominated for 2 Oscars. Another 30 wins and 28 nominations");
    actors.appendChild(actor);
  
    actor=doc.createElement("Actor");
    actor.setAttribute("ActorId", "sj");
    append(actor, "Name", "Samuel L. Jackson  ");
    append(actor, "Biography", "Samuel L. Jackson usually played bad guys and drug addicts before becoming an action hero, as the character Mitch Henessey, in The Long Kiss Goodnight (1996) and in Die Hard: With a Vengeance (1995). From character player to leading man. His performance in Pulp Fiction (1994) gave him an Oscar nomination for his character Jules Winnfield.");
    append(actor, "Awards", "Nominated for Oscar. Another 17 wins and 34 nominations");
    actors.appendChild(actor);
  
    actor=doc.createElement("Actor");
    actor.setAttribute("ActorId", "ut");
    append(actor, "Name", "Uma Thurman");
    append(actor, "Biography", "Uma Karuna Thurman, daughter of Robert Thurman and Nena Thurman, was born in Boston, Massachusetts, on April 29, 1970. Uma grew up in Amherst, Massachusetts, where her father worked at Amherst College. She left boarding school at just 15, already determined to become an actress. She moved to New York to follow her dream.");
    append(actor, "Awards", "Nominated for Oscar. Another 11 wins and 29 nominations");
    actors.appendChild(actor);
  
    actor=doc.createElement("Actor");
    actor.setAttribute("ActorId", "vv");
    append(actor, "Name", "Vince Vaughn");
    append(actor, "Biography", "Vincent Anthony Vaughn was born on March 28, 1970, in Minneapolis, Minnesota, USA and raised in Lake Forest, Illinois, USA.");
    append(actor, "Awards", "5 wins and 8 nominations ");
    actors.appendChild(actor);
  
      rootElem.appendChild(actors);
   
    doc.appendChild(rootElem);
    doc.save("movies_dom_5.xml");

  