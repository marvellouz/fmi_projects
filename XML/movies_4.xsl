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
        <p id = "Movies">
          <xsl:apply-templates select="Body/Movies/Movie"/>
        </p>

      </body>

    </html>
  </xsl:template>

  <xsl:template match = "Movie">
    <p>
      <h2>
        <xsl:value-of select = "Title"/> <br/> <xsl:value-of select = "Year"/>
      </h2>
      <img src = "{Picture}" alt = "Picture-{Title}"/><br/>
      <ul>
        <li><strong>Жанр:</strong> <xsl:value-of select = "Genres"/></li>
        <li><strong>На кратко: </strong> <xsl:value-of select = "Tagline"/></li>
        <li><strong>Сюжет: </strong> <xsl:value-of select = "Plot"/></li>
      </ul>  

    </p>
  </xsl:template>
</xsl:stylesheet>
