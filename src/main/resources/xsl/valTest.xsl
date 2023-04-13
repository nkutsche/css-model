<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:p="http://www.nkutsche.com/css-parser"
    xmlns:r="http://maxtoroq.github.io/rng.xsl"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:import href="../rnc-compiler/rng.xsl"/>
    <xsl:variable name="instance">
        <css xmlns="http://www.nkutsche.com/css3-model">
            <rule>
                <selector>
                    <select id="id" />
                </selector>
                <property-set />
            </rule>
        </css>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:call-template name="r:main">
            <xsl:with-param name="schema" select="doc('../rnc/css3-model.rng')"/>
            <xsl:with-param name="instance" select="$instance"/>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>