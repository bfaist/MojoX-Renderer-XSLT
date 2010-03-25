<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:test="urn:test">

  <xsl:output method="xml"/>

  <xsl:template match="/doc">
      <d>
           <xsl:apply-templates/>
      </d>
  </xsl:template>

  <xsl:template match="/doc/chapter">
      <c>
           <xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
           <xsl:apply-templates/>
      </c>
  </xsl:template>

  <xsl:template match="/doc/chapter/title">
      <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="/doc/chapter/intro">
      <time><xsl:value-of select="test:time()"/></time>
      <i><xsl:apply-templates/></i>
  </xsl:template>
</xsl:stylesheet>
