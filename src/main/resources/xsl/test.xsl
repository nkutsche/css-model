<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:p="http://www.nkutsche.com/css-parser"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:import href="css3.xsl"/>
    <xsl:variable name="css">* {nested-func: function1(function2(value))}</xsl:variable>
    
    <xsl:template match="/">
        <xsl:sequence select="p:parse-css($css)"/>
    </xsl:template>
</xsl:stylesheet>