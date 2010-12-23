<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0"                 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   >

  <xsl:param name="discount" select="0.20"/>

  <xsl:template match="/">
    <html>
      <body>
        <h1>
          <b>
            <i>
              Our music catalogue contains the following CDs:
            </i>
          </b>
        </h1>
        <table border="2" cellspacing="2" bgcolor="#C0C0C0">
          <tr>
            <td>
              <b>Album</b>
            </td>
            <td>
              <b>Artist</b>
            </td>
            <td>
              <b>Country</b>
            </td>
            <td>
              <b>Company</b>
            </td>
            <td>
              <b>Price</b>
            </td>
            <td>
              <b>Year</b>
            </td>
            <td>
              <b>Additional artist information</b>
            </td>
          </tr>
          <xsl:for-each select="/catalog/cd">
            <tr>
              <td>
                <xsl:value-of select="title"/>
              </td>
              <td>
                <xsl:value-of select="artist"/>
              </td>
              <td>
                <xsl:value-of select="country"/>
              </td>
              <td>
                <xsl:value-of select="company"/>
              </td>
              <td>
                <xsl:choose>
                  <xsl:when test="price &gt; 20">
                    <xsl:value-of select="price * (1.0 - $discount)"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="price"/>
                  </xsl:otherwise>
                </xsl:choose>
             </td>
              <td>
                <xsl:value-of select="year"/>
              </td>
              <td>
                <a href="SorryPage.html" >
                  Learn more about <xsl:value-of select="artist" />
                </a>
				  
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>