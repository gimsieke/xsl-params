<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:params="tag:le-tex.de,2021-11-17:params"
  exclude-result-prefixes="xs params"
  version="3.0">
  
  <xsl:import href="params.xsl"/>
  
  <xsl:param name="foo" select="'baz'" as="xs:string"/>
  
  <xsl:function name="params:in-stylesheet" as="document-node(element(params))">
    <xsl:param name="stylesheet-node" as="document-node(element(*))"/>
    <xsl:sequence select="transform(
                            map{'stylesheet-location': 'params.xsl',
                                'document-node': $stylesheet-node,
                                'global-context-item': $stylesheet-node,
                                'initial-template': xs:QName('xsl:initial-template')}
                          )?output"></xsl:sequence>
  </xsl:function>
  
  <xsl:template name="test">
    <xsl:sequence select="params:in-stylesheet(doc(static-base-uri()))"/>
  </xsl:template>
</xsl:stylesheet>