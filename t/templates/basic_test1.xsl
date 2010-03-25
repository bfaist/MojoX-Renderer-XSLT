<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
     <p><xsl:apply-templates/></p>
  </xsl:template>

</xsl:stylesheet>
