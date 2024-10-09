<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:cssm="http://www.nkutsche.com/css3-model"
    xmlns:cssp="http://www.nkutsche.com/css-parser" xmlns:r="http://maxtoroq.github.io/rng.xsl"
    xmlns="http://www.nkutsche.com/css3-model" exclude-result-prefixes="xs math" version="3.0" xpath-default-namespace="http://www.nkutsche.com/css3-model">
    
    <xsl:mode name="cssm:serialize" on-no-match="deep-skip" warning-on-no-match="true"/>
    
    <xsl:function name="cssm:serialize-property-value" as="xs:string" visibility="final">
        <xsl:param name="property" as="element(property)"/>
        
        <xsl:sequence select="cssm:serialize-property-value($property, false(), false())"/>
        
    </xsl:function>
    
    <xsl:function name="cssm:serialize-property-value" as="xs:string" visibility="final">
        <xsl:param name="property" as="element(property)"/>
        <xsl:param name="requires-quotes" as="xs:boolean"/>
        <xsl:param name="with-important" as="xs:boolean"/>
        <xsl:variable name="impAttr" select="$property/@important"/>
        <xsl:variable name="valueAttributes" select="$property/(@* except @name)"/>
        <xsl:variable name="valueProvider" select="$valueAttributes | $property/cssm:*"/>
        <xsl:variable name="values" as="xs:string*">
            <xsl:choose>
                <xsl:when test="count($valueProvider) gt 1">
                    <xsl:apply-templates select="$valueProvider" mode="cssm:serialize">
                        <xsl:with-param name="requires-quotes" select="$requires-quotes" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="$valueProvider/(self::attribute(value)|self::cssm:value)">
                    <xsl:sequence select="string($valueProvider)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="$valueProvider" mode="cssm:serialize">
                        <xsl:with-param name="requires-quotes" select="$requires-quotes" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
            
            <xsl:if test="$with-important">
                <xsl:apply-templates select="$impAttr">
                    <xsl:with-param name="requires-quotes" select="$requires-quotes" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:if>
        </xsl:variable>
        <xsl:sequence select="string-join($values, ' ')"/>
    </xsl:function>
    
    <xsl:template match="@string | string" mode="cssm:serialize" priority="10">
        <xsl:param name="requires-quotes" select="true()" tunnel="yes" as="xs:boolean"/>
        <xsl:choose>
            <xsl:when test="$requires-quotes or matches(., '\s|&quot;|''|\\')">
                <xsl:variable name="q" select="
                    if (matches(., '''')) then '&quot;' else ''''
                    "/>
                <xsl:variable name="value" select="
                    replace(., '(\\|' || $q || ')', '\\$1')
                    ">
                </xsl:variable>
                
                <xsl:sequence select="$q || $value || $q"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="@value | value" mode="cssm:serialize">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="@hex | hex" mode="cssm:serialize">
        <xsl:sequence select="'#' || ."/>
    </xsl:template>
    
    <xsl:template match="@url | url" mode="cssm:serialize">
        <xsl:sequence select="'url(''' || . || ''')'"/>
    </xsl:template>

    <xsl:template match="@numeric" mode="cssm:serialize">
        <xsl:sequence select=". || ../@unit"/>
    </xsl:template>

    <xsl:template match="numeric" mode="cssm:serialize">
        <xsl:sequence select=". || @unit"/>
    </xsl:template>

    <xsl:template match="@unit" mode="cssm:serialize"/>

    <xsl:template match="@important[. = 'true']" mode="cssm:serialize">
        <xsl:sequence select="'!important'"/>
    </xsl:template>
    
    <xsl:template match="@important" mode="cssm:serialize"/>
    
    <xsl:template match="property/functionCall" mode="cssm:serialize">
        <xsl:variable name="arguments" as="xs:string*">
            <xsl:variable name="attr" select="@* except @name"/>
            <xsl:choose>
                <xsl:when test="$attr">
                    <xsl:apply-templates select="$attr" mode="#current"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="*" mode="#current"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:sequence select="@name || '(' || string-join($arguments, ', ') || ')'"/>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>
