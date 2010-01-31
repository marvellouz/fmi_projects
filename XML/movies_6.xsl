<?xml version = "1.0" encoding = "utf-8"?>
<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0">
  <xsl:output method = "xml" encoding = 'utf-8' indent = 'yes' />

  <xsl:template match="/">
      <xsl:apply-templates select="Body/Movies/Movie"/>
  </xsl:template>

  <xsl:template match="Movie">
    <movie>
    <title><xsl:value-of select = "Title"/></title>
    <year> <xsl:value-of select = "Year"/> </year>
    <length><xsl:value-of select = "@Length"/></length>
    <directors>
      <xsl:for-each select = "Directors/Director">
      <director><xsl:value-of select = "Name"/></director>
      </xsl:for-each>
    </directors>
    <writers>
      <xsl:for-each select = "Writers/Writer">
        <writer><xsl:value-of select = "Name"/></writer>
    </xsl:for-each>
    </writers>
        <xsl:for-each select = "id(@Actors)">
          <actor><xsl:value-of select = "Name"/></actor>
        </xsl:for-each>
      </movie>

      </xsl:template>
    </xsl:stylesheet>
