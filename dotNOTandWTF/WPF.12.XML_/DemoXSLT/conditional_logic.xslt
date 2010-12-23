<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template match="/">
		<html>
		<head>
			<title>Our Items</title>
		</head>
		<body style="background-color:#DACFE5; font-family:Arial, Helvetica, sans-serif">
			<xsl:for-each select="/items/item">
				<xsl:if test="@available = 'no'">
					<h1 style="color:#8A8A8A">
						<img style="border:0; margin-left:10px">
							<xsl:attribute name="src">
								<xsl:value-of select="photo"/>
							</xsl:attribute>
						</img>
						<xsl:value-of select="name"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="type"/>
					</h1>
				</xsl:if>
				<xsl:if test="@available = 'yes'">
					<h1 style="color:#0D3427">
                  <img style="border:0; margin-left:10px">
                     <xsl:attribute name="src">
								<xsl:value-of select="photo"/>
							</xsl:attribute>
						</img>
						<xsl:value-of select="name"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="type"/>
					</h1>
				</xsl:if>
			</xsl:for-each>
		</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
