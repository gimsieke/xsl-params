<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="xs"
  version="3.0">
  
  <xsl:param name="foo" select="'bar'" as="xs:string"/>
  
  <xsl:mode on-no-match="deep-skip"/>
  
  <xsl:template name="xsl:initial-template">
    <xsl:document>
      <params>
      <xsl:variable name="prelim" as="element(*)*">
        <xsl:apply-templates select="/*"/>
      </xsl:variable>
      <xsl:for-each-group select="$prelim" group-by="@name">
        <param>
          <xsl:variable name="overridden" as="attribute(origin)*" 
              select="current-group()/self::*:overridden-param/@origin"/>
          <xsl:if test="exists($overridden)">
            <xsl:attribute name="overridden" select="$overridden" separator=" "/>
          </xsl:if>
          <xsl:copy-of select="(current-group()/self::*:param)[1]/(@*, node())"/>
        </param>
      </xsl:for-each-group>
    </params>
    </xsl:document>
  </xsl:template>
  
  <xsl:template match="/*">
    <xsl:apply-templates select="import | include | param"/>
  </xsl:template>
  
  <xsl:template match="import | include">
    <xsl:param name="seen" as="xs:string*" tunnel="yes"/>
    <xsl:apply-templates select="doc(resolve-uri(@href, base-uri(/)))">
      <xsl:with-param name="seen" as="xs:string*" tunnel="yes" select="(../param/@name, $seen)"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="param">
    <xsl:param name="seen" as="xs:string*" tunnel="yes"/>
    <xsl:choose>
      <xsl:when test="@name = $seen">
        <overridden-param>
          <xsl:attribute name="origin" select="base-uri(/)"/>
          <xsl:copy-of select="@*, node()"/>
        </overridden-param>
      </xsl:when>
      <xsl:otherwise>
        <param>
          <xsl:attribute name="origin" select="base-uri(/)"/>
          <xsl:copy-of select="@*, node()"/>
        </param>    
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>