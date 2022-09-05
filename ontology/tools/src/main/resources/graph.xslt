<?xml version="1.0" encoding="UTF-8" ?>
<!-- 
# Stylesheet to render an XML-based RDF ontology to a graph json
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
-->
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
  xmlns:owl="http://www.w3.org/2002/07/owl#" 
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  version="1.0">
  <xsl:output method="text" encoding="UTF-8"  omit-xml-declaration="yes" indent="no" media-type="application/json" />

  <xsl:template match="/rdf:RDF">
{ 
    "nodes":[<xsl:for-each select="owl:Class">
      { "data": { "id": "<xsl:value-of select="@rdf:about"/>", "category": "<xsl:value-of select="substring-before(@rdf:about, '#')"/>", "label": "<xsl:value-of select="rdfs:label"/>" } }<xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
    </xsl:for-each>],
    "edges":[<xsl:for-each select="owl:ObjectProperty">
      { "data": { "source": "<xsl:value-of select="rdfs:domain/@rdf:resource"/>", "type":"relation", "target": "<xsl:value-of select="rdfs:range/@rdf:resource"/>", "category": "<xsl:value-of select="substring-before(@rdf:about, '#')"/>", "label": "<xsl:value-of select="rdfs:label"/>" } } ,
    </xsl:for-each><xsl:for-each select="owl:Class/rdfs:subClassOf">
      { "data": { "source": "<xsl:value-of select="../@rdf:about"/>", "type":"subclass", "target": "<xsl:value-of select="@rdf:resource"/>", "category": "<xsl:value-of select="substring-before(../@rdf:about, '#')"/>", "label": "subclass" } } <xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
    </xsl:for-each>]
}
  </xsl:template>

</xsl:stylesheet>