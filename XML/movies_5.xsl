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
        <table>
          <tr>
            <td><strong>Филм   </strong> </td>
            <td><strong>Снимка </strong> </td>
            <td><strong>Актьори</strong> </td>
          </tr>

          <xsl:apply-templates select="Body/Movies/Movie"/>
        </table>

      </body>

    </html>
  </xsl:template>

  <xsl:template match = "Movie">
    <tr>
      <td>
        <xsl:value-of select = "Title"/> <br/> <xsl:value-of select = "Year"/>
      </td>
      <td>
        <img src = "{Picture}" alt = "Picture-{Title}"/><br/>
      </td>
      <td>
        <ul> 
          <xsl:for-each select = "id(@Actors)">
            <li><strong>Име: <xsl:value-of select = "Name"/></strong></li>
            <li><strong>Биография: </strong> <xsl:value-of select = "Biography"/></li>
            <li><strong>Отличия:</strong> <xsl:value-of select = "Awards"/></li>
          </xsl:for-each>
        </ul>
      </td>
    </tr>  

  </xsl:template>
</xsl:stylesheet>
