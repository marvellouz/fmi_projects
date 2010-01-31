<?xml version = "1.0" encoding = "utf-8"?>
<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0">
  <xsl:output method = "text" encoding = "utf-8" indent = "yes" />
  <xsl:strip-space elements="*"/>
  <xsl:template match = "/">
    var doc=new ActiveXObject("MSXML.DOMDocument");
    var rootElem=doc.createElement("Body");
    doc.appendChild(rootElem);
    function append(root, t, content) {
      e=doc.createElement(t);
      e.appendChild(doc.createTextNode(content);
      movie.appendChild(e);
      return e;
    }
    <xsl:apply-templates select="Body/Movies"/> 
    <xsl:apply-templates select="Body/Actors"/> 
    doc.save("movies_dom_5.xml");

  </xsl:template>

  <xsl:template match = "Actors">
      var actors=doc.createElement("Actors");
      var actor;
      <xsl:apply-templates select = "Actor"/>
      rootElem.appendChild(actor);
  </xsl:template>

  <xsl:template match = "Actor">
    actor=doc.createElement("Actor");
    append(movie, "Name", "<xsl:value-of select="Name"/>");
    append(movie, "Biography", "<xsl:value-of select="Title"/>");
    append(movie, "Awards", "<xsl:value-of select="Title"/>");
    actors.appendChild(actor);
  </xsl:template>

<!-- Movies -->
  <xsl:template match = "Movies">
      var movies=doc.createElement("Movies");
      var movie;
      var e, nested;
      <xsl:apply-templates select = "Movie"/>
      rootElem.appendChild(movies);
  </xsl:template>

  <xsl:template match = "Movie">
    movie=doc.createElement("Movie");

    append(movie, "Title", "<xsl:value-of select="Title"/>");
    append(movie, "Year", "<xsl:value-of select="Year"/>");
    append(movie, "Picture", "<xsl:value-of select="Picture"/>");

    e=doc.createElement("Genres");
    <xsl:for-each select="Genres/Genre">append(e, "Genre", "<xsl:value-of select="."/>");</xsl:for-each>
    movie.appendChild(e);

    e=doc.createElement("Keywords");
    <xsl:for-each select="Keywords/Keyword">append(e, "Keyword", "<xsl:value-of select="."/>");</xsl:for-each>
    movie.appendChild(e);

    append(movie, "Tagline", "<xsl:value-of select="Tagline"/>");
    append(movie, "Plot", "<xsl:value-of select="Plot"/>");

    e=doc.createElement("Directors");
    <xsl:for-each select="Directors/Director">
      nested=doc.createElement("Director");
      append(nested, "Name", "<xsl:value-of select="Name"/>");
      e.appendChild(nested);
    </xsl:for-each>
    movie.appendChild(e);

    e=doc.createElement("Writers");
    <xsl:for-each select="Writers/Writer">
      nested=doc.createElement("Writer");
      append(nested, "Name", "<xsl:value-of select="Name"/>");
      e.appendChild(nested);
    </xsl:for-each>
    movie.appendChild(e);

    e=doc.createElement("Characters");
    <xsl:for-each select="Characters/Character">
      nested=doc.createElement("Character");
      nested.setAttribute("Actor", "<xsl:value-of select="@Actor"/>");
      e.appendChild(nested);
    </xsl:for-each>
    movie.appendChild(e);
  </xsl:template>

</xsl:stylesheet>
