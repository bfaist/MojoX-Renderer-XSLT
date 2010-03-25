<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:test="urn:test">

  <xsl:output method="html"/>

  <xsl:template match="/root">
     <html>
        <head><title>XSLT</title></head>
        <body>
           <xsl:apply-templates/>
        </body>
     </html>
  </xsl:template>

  <xsl:template match="para">
     <p><xsl:value-of select="test:uc(text())"/></p>
  </xsl:template>

</xsl:stylesheet>
