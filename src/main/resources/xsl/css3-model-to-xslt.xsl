<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:cssm="http://www.nkutsche.com/css3-model"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    
    <xsl:namespace-alias result-prefix="xsl" stylesheet-prefix="axsl"/>
    
    
    
    <xsl:function name="cssm:as-xsl" as="element(xsl:transform)?">
        <xsl:param name="css" as="element(cssm:css)*"/>
        <xsl:sequence select="cssm:as-xsl($css, false())"/>
    </xsl:function>
    <xsl:function name="cssm:as-xsl" as="element(xsl:transform)?">
        <xsl:param name="css" as="element(cssm:css)*"/>
        <xsl:param name="namespace-strict" as="xs:boolean"/>
        <axsl:transform version="3.0">
            
            <axsl:mode on-multiple-match="use-last" warning-on-multiple-match="false"/>
            <axsl:mode name="Q{{http://www.nkutsche.com/css3-model}}after" on-multiple-match="use-last" warning-on-multiple-match="false"/>
            <axsl:mode name="Q{{http://www.nkutsche.com/css3-model}}before" on-multiple-match="use-last" warning-on-multiple-match="false"/>
            
            <axsl:output method="adaptive"/>
            <xsl:apply-templates select="$css/cssm:rule/cssm:selector" mode="cssm:as-xsl">
                <xsl:with-param name="namespace-strict" select="$namespace-strict"/>
            </xsl:apply-templates>
            
            <axsl:template match="*" priority="-10" mode="#all">
                <axsl:apply-templates select="node()|@*" mode="#current"/>
            </axsl:template>
            <axsl:template match="@* | node()" priority="-15" mode="#all"/>
            
        </axsl:transform>
    </xsl:function>
    
    
    <xsl:template match="cssm:rule/cssm:selector" mode="cssm:as-xsl">
        <xsl:param name="namespace-strict" as="xs:boolean" select="false()"/>
        <xsl:variable name="idx" as="xs:integer">
            <xsl:number count="cssm:selector" level="any"/>
        </xsl:variable>
        <xsl:variable name="template-content">
            <axsl:variable name="rule" as="element(cssm:rule)">
                <cssm:rule>
                    <xsl:copy-of select="."/>
                    <xsl:copy-of select="../cssm:property-set"/>
                </cssm:rule>
            </axsl:variable>
            <axsl:next-match/>
            <axsl:sequence select="map{{generate-id(.) : $rule}}"/>
        </xsl:variable>
        
        <xsl:variable name="default-match" select="cssm:template-match(., $namespace-strict)"/>
        <xsl:variable name="before-match" select="cssm:template-match(., $namespace-strict, 'before')"/>
        <xsl:variable name="after-match" select="cssm:template-match(., $namespace-strict, 'after')"/>
        
        <xsl:if test="exists($default-match)">
            <axsl:template match="{$default-match}" priority="{$idx}">
                <xsl:sequence select="$template-content"/>
            </axsl:template>
        </xsl:if>
        
        <xsl:if test="exists($before-match)">
            <axsl:template match="{$before-match}" priority="{$idx}" mode="Q{{http://www.nkutsche.com/css3-model}}before">
                <xsl:sequence select="$template-content"/>
            </axsl:template>
        </xsl:if>
        
        <xsl:if test="exists($after-match)">
            <axsl:template match="{$after-match}" priority="{$idx}" mode="Q{{http://www.nkutsche.com/css3-model}}after">
                <xsl:sequence select="$template-content"/>
            </axsl:template>
        </xsl:if>
        
    </xsl:template>
    
    <xsl:function name="cssm:template-match" as="xs:string?">
        <xsl:param name="selector" as="element(cssm:selector)"/>
        <xsl:param name="namespace-strict" as="xs:boolean"/>
        <xsl:sequence select="cssm:template-match($selector, $namespace-strict, ())"/>
    </xsl:function>
    
    <xsl:function name="cssm:template-match" as="xs:string?">
        <xsl:param name="selector" as="element(cssm:selector)"/>
        <xsl:param name="namespace-strict" as="xs:boolean"/>
        <xsl:param name="beforeAfter" as="xs:string?"/>
        
        <xsl:variable name="last-pseudo-class" select="($selector/cssm:select[last()]/cssm:pseudo[@type = 'element']/@name, '#default')[1]"/>
        <xsl:variable name="beforeAfter" select="($beforeAfter, '#default')[1]"/>
        <xsl:variable name="skip" select="
            not($last-pseudo-class = $beforeAfter)
            "/>
            
        <xsl:variable name="tokens" as="xs:string*">
            <xsl:for-each-group select="$selector/cssm:select" group-starting-with="cssm:select[@axis = ('descendant', 'child')]">
                <xsl:variable name="is-last" select="position() = last()"/>
                <xsl:value-of select=" 
                    if (@axis = 'descendant') 
                    then '//' 
                    else if (@axis = 'child') 
                    then '/' 
                    else '' "/>
                <xsl:apply-templates select="current-group()[last()]" mode="cssm:template-match">
                    <xsl:with-param name="is-last" select="$is-last" tunnel="yes"/>
                    <xsl:with-param name="namespace-strict" select="$namespace-strict" tunnel="yes"/>
                </xsl:apply-templates> 
            </xsl:for-each-group> 
        </xsl:variable>
        
        <xsl:sequence select="
            if ($skip) 
            then () 
            else string-join($tokens, '')
            "/>
            
        
    </xsl:function>
    
    
    <xsl:template match="cssm:select" mode="cssm:template-match" priority="50">
        <xsl:param name="namespace-strict" select="false()" as="xs:boolean" tunnel="yes"/>
        <xsl:value-of select="
            if (@name) 
            then ('*:'[not($namespace-strict)] || @name) 
            else '*'
            "/>
        <xsl:next-match/>
    </xsl:template>

    <xsl:template match="cssm:not" mode="cssm:template-match" priority="50">
        <xsl:param name="namespace-strict" select="false()" as="xs:boolean" tunnel="yes"/>
        <xsl:variable name="name" select="if (@name) then ('*:'[not($namespace-strict)] || @name) else '*'"/>
        <xsl:text>[not(self::</xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:next-match/>
        <xsl:text>)]</xsl:text>
    </xsl:template>
    
    <xsl:template match="cssm:select[@axis = 'following']" mode="cssm:template-match" priority="45">
        <xsl:variable name="preceding-select">
            <xsl:apply-templates select="preceding-sibling::cssm:select[1]" mode="#current"/>
        </xsl:variable>
        <xsl:text expand-text="true">[preceding-sibling::{string-join($preceding-select)}]</xsl:text>
        <xsl:next-match/>
    </xsl:template>

    <xsl:template match="cssm:select[@axis = 'next-following']" mode="cssm:template-match" priority="45">
        <xsl:variable name="preceding-select">
            <xsl:apply-templates select="preceding-sibling::cssm:select[1]" mode="#current"/>
        </xsl:variable>
        <xsl:text expand-text="true">[preceding-sibling::*[1]/self::{string-join($preceding-select)}]</xsl:text>
        <xsl:next-match/>
    </xsl:template>
    
    <xsl:template match="cssm:select[@classes] | cssm:not[@class]" mode="cssm:template-match" priority="40">
        <xsl:variable name="classes" select="tokenize(@classes | @class, '\s')"/>
        <xsl:for-each select="$classes">
            <xsl:text expand-text="true">[tokenize(@class, '\s') = '{.}']</xsl:text>
        </xsl:for-each>
        <xsl:next-match/>
    </xsl:template>

    <xsl:template match="cssm:select[@id | @ids] | cssm:not[@id | @ids]" mode="cssm:template-match" priority="40">
        <xsl:variable name="ids" select="tokenize((@id | @ids)[1], '\s')"/>
        <xsl:for-each select="$ids">
            <xsl:text expand-text="true">[@id = '{.}']</xsl:text>
        </xsl:for-each>
        <xsl:next-match/>
    </xsl:template>
    
    <xsl:template match="cssm:attribute" mode="cssm:template-match" priority="50">
        <xsl:variable name="name" select="(@name, '*')[1]"/>
        <xsl:text expand-text="yes">[@{$name}</xsl:text>
        <xsl:next-match/>
        <xsl:text expand-text="yes">]</xsl:text>
    </xsl:template>
    
    <xsl:template match="cssm:attribute[@equal]" mode="cssm:template-match" priority="40">
        <xsl:text expand-text="yes"> = '{@equal}'</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:attribute[@substring]" mode="cssm:template-match" priority="40">
        <xsl:text expand-text="yes">[contains(., '{@substring}')]</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:attribute[@dash-match]" mode="cssm:template-match" priority="40">
        <xsl:text expand-text="yes">[starts-with(., '{@dash-match}-')]</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:attribute[@prefix]" mode="cssm:template-match" priority="40">
        <xsl:text expand-text="yes">[starts-with(., '{@prefix}')]</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:attribute[@suffix]" mode="cssm:template-match" priority="40">
        <xsl:text expand-text="yes">[ends-with(., '{@suffix}')]</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:attribute[@includes]" mode="cssm:template-match" priority="40">
        <xsl:text expand-text="yes">[tokenize(., '\s') = '{@includes}']</xsl:text>
    </xsl:template>
    
    <xsl:template match="cssm:pseudo[@type = 'class'][@name = 'root']" mode="cssm:template-match">
        <xsl:text>[parent::document-node()]</xsl:text>
    </xsl:template>
    
    <xsl:template match="cssm:pseudo[@type = 'class'][@name = 'empty']" mode="cssm:template-match">
        <xsl:text>[empty(*|text()[normalize-space(.) != ''])]</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:pseudo[@type = 'class'][@name = 'first-child']" mode="cssm:template-match">
        <xsl:text>[not(preceding-sibling::*)]</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:pseudo[@type = 'class'][@name = 'last-child']" mode="cssm:template-match">
        <xsl:text>[not(following-sibling::*)]</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:pseudo[@type = 'class'][@name = 'only-child']" mode="cssm:template-match">
        <xsl:text>[not(../* except .)]</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:pseudo[@type = 'class'][@name = 'last-of-type']" mode="cssm:template-match">
        <xsl:text>[not(following-sibling::*/name() = name(.))]</xsl:text>
    </xsl:template>
    
    <xsl:template match="cssm:pseudo[@type = 'class'][@name = 'first-of-type']" mode="cssm:template-match">
        <xsl:text>[not(preceding-sibling::*/name() = name(.))]</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:pseudo[@type = 'class'][@name = 'only-of-type']" mode="cssm:template-match">
        <xsl:text>[not((../* except .)/name() = name(.))]</xsl:text>
    </xsl:template>

    <xsl:template match="cssm:pseudo[@type = 'element'][@name = ('before', 'after')]" mode="cssm:template-match">
        <xsl:param name="is-last" as="xs:boolean" tunnel="yes" select="false()"/>
        <xsl:if test="not($is-last)">
            <xsl:text>[false()]</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="*" mode="cssm:template-match" priority="-10">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="text()" mode="cssm:template-match" priority="-10"/>
        
    
    
    
    
    
</xsl:stylesheet>