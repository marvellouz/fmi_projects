<?xml version = "1.0" encoding = "utf-8"?>
<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0">
  <xsl:output method = "text" encoding = 'utf-8' indent = "yes"/>
  <xsl:template match = "/">
    <xsl:for-each select = "Body/Movies/Movie">
      <xsl:value-of select = "Title"/>, <xsl:value-of select = "Year"/> година, продължителност: <xsl:value-of select = "@Length"/> минути, актьори: <xsl:for-each select = "id(@Actors)"> <xsl:value-of select = "Name"/>, </xsl:for-each>;  

    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
