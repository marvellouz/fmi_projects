<?xml version = "1.0" encoding = "utf-8"?>
<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0">
  <xsl:output method = "html" encoding = 'utf-8' indent = 'yes' />

  <xsl:template match = "/">
    <html>
      <head>
        <Title>Филми</Title>
      </head>

      <body>

        <h1>Филми</h1>
        <ul id = "Movies">
          <xsl:apply-templates select="Body/Movies/Movie"/>
        </ul>

      </body>

    </html>
  </xsl:template>

  <xsl:template match = "Movie">
    <li>
      <h2>
        <xsl:value-of select = "Title"/> <br/> <xsl:value-of select = "Year"/>
      </h2>
      <img src = "{Picture}" alt = "Picture-{Title}"/><br/>
      <ul>
        <li><strong>Жанр:</strong> <xsl:value-of select = "Genres"/></li>
        <li><strong>На кратко: </strong> <xsl:value-of select = "Tagline"/></li>
        <li><strong>Сюжет: </strong> <xsl:value-of select = "Plot"/></li>
        <li><strong>Режисьор: </strong> <xsl:value-of select = "Directors"/></li>
        <li><strong>Сценаристи: </strong> <xsl:value-of select = "Writers"/></li>
        <li><strong>Актьори:</strong> 
          <ul> 
            <xsl:for-each select = "id(@Actors)">
              <li><strong>Име: <xsl:value-of select = "Name"/></strong></li>
              <li><strong>Биография: </strong> <xsl:value-of select = "Biography"/></li>
              <li><strong>Отличия:</strong> <xsl:value-of select = "Awards"/></li>
            </xsl:for-each>
          </ul>
        </li>
      </ul>  

    </li>
  </xsl:template>
</xsl:stylesheet>
