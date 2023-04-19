<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:cssm="http://www.nkutsche.com/css3-model"
    xmlns:cssp="http://www.nkutsche.com/css-parser" xmlns:r="http://maxtoroq.github.io/rng.xsl"
    xmlns="http://www.nkutsche.com/css3-model" exclude-result-prefixes="xs math" version="3.0">
    <xsl:import href="css3.xsl"/>

    <xsl:mode name="cssm:parse" on-no-match="shallow-copy"/>

    <xsl:function name="cssm:parse" as="element()" visibility="final">
        <xsl:param name="css" as="xs:string"/>
        <xsl:sequence select="cssm:parse($css, 0)"/>
    </xsl:function>
    <xsl:function name="cssm:parse" as="element()" visibility="final">
        <xsl:param name="css" as="xs:string"/>
        <xsl:param name="stlyesheet-specifity" as="xs:integer?"/>
        
        
        <xsl:variable name="parsed" select="cssp:parse-css($css)"/>
        <xsl:variable name="model" as="element()">
            <xsl:apply-templates select="$parsed" mode="cssm:parse">
                <xsl:with-param name="stlyesheet-specifity" select="($stlyesheet-specifity, 0)[1]" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$parsed/self::ERROR">
                <xsl:sequence select="$parsed"/>
            </xsl:when>
            <xsl:when test="$model/self::ERROR">
                <xsl:sequence select="$model"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:try>
                    <xsl:variable name="rng-validate" 
                        select="r:is-valid($model, doc('../rnc/css3-model.rng'))"
                        as="xs:boolean"/>
                    <xsl:choose>
                        <xsl:when test="$rng-validate">
                            <xsl:sequence select="$model"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:sequence select="error(xs:QName('Invalid-Result'))"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:catch>
                        <ERROR message="Invalid result:">
                            <xsl:sequence select="$model"/>
                        </ERROR>
                    </xsl:catch>
                </xsl:try>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:template match="css" mode="cssm:parse">
        <xsl:element namespace="http://www.nkutsche.com/css3-model" name="{local-name()}">
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="rule" mode="cssm:parse">
        <rule>
            <xsl:apply-templates select="selectors_group" mode="#current"/>
            <property-set>
                <xsl:apply-templates select="node() except selectors_group" mode="#current"/>
            </property-set>
        </rule>
    </xsl:template>

    <xsl:template match="selectors_group" mode="cssm:parse">
        <xsl:apply-templates select="selector" mode="#current"/>
    </xsl:template>

    <xsl:template match="selector" mode="cssm:parse">
        <xsl:param name="stlyesheet-specifity" as="xs:integer" tunnel="yes"/>
        <xsl:variable name="selects" as="element(cssm:select)*">
            <xsl:for-each-group select="node()" group-starting-with="combinator">
                
                <xsl:variable name="axisMap"
                    select="map{
                    '' : 'descendant',
                    '>' : 'child',
                    '+' : 'next-following',
                    '~' : 'following'
                    }"/>
                
                <xsl:variable name="combinator" select="(self::combinator/normalize-space(.), '#none')[1]"
                    as="xs:string?"/>
                
                <xsl:apply-templates select="current-group() except self::combinator" mode="#current">
                    <xsl:with-param name="axis" select="$axisMap($combinator)"/>
                </xsl:apply-templates>
            </xsl:for-each-group>
        </xsl:variable>
        <selector specifity="{cssm:specifity($stlyesheet-specifity, $selects)}">
            <xsl:sequence select="$selects"/>
        </selector>
    </xsl:template>

    <xsl:template match="simple_selector_sequence" mode="cssm:parse">
        <xsl:param name="axis" select="()" as="xs:string?"/>
        <select>
            <xsl:if test="$axis">
                <xsl:attribute name="axis" select="$axis"/>
            </xsl:if>
            <xsl:where-populated>
                <xsl:attribute name="classes" select="class/IDENT" separator=","/>
            </xsl:where-populated>
            <xsl:where-populated>
                <xsl:variable name="idName" select=" if (count(HASH) gt 1) then 'ids' else 'id'"/>
                <xsl:attribute name="{$idName}" select="HASH/replace(., '^#', '')" separator=" "/>
            </xsl:where-populated>
            <xsl:where-populated>
                <xsl:attribute name="at" select="atrule/IDENT" separator=" "/>
            </xsl:where-populated>
            <xsl:apply-templates select="type_selector" mode="#current"/>
            <xsl:apply-templates select="node() except (class | HASH | type_selector | atrule)"
                mode="#current"/>
        </select>
    </xsl:template>

    <xsl:template match="type_selector" mode="cssm:parse">
        <xsl:attribute name="name" select="element_name"/>
    </xsl:template>

    <xsl:template match="universal | TOKEN | S" mode="cssm:parse"/>

    <xsl:template match="attrib" mode="cssm:parse">
        <attribute name="{IDENT[1]}">
            <xsl:variable name="compare" select="TOKEN[contains(., '=')] ! substring(., 1, 1)"/>
            <xsl:if test="exists($compare)">
                <xsl:variable name="compare-attr"
                    select=" map{
                    '=' : 'equal',
                    '^' : 'prefix',
                    '$' : 'suffix',
                    '*' : 'substring',
                    '~' : 'includes',
                    '|' : 'dash-match'
                    }"/>
    
                <xsl:variable name="value-attribute-name" select="$compare-attr($compare)"/>
                <xsl:variable name="value" select="IDENT[2] | QUOTED_STRING/(STRING_CONTENT1 | STRING_CONTENT2)"/>
                <xsl:attribute name="{$value-attribute-name}" select="$value"/>
            </xsl:if>
        </attribute>
    </xsl:template>

    <xsl:template match="pseudo[IDENT]" mode="cssm:parse">
        <xsl:variable name="type"
            select="
                if (count(TOKEN[. = ':']) = 2) then
                    'element'
                else
                    'class'
                "/>
        <pseudo name="{IDENT}" type="{$type}"/>
    </xsl:template>

    <xsl:template match="negation" mode="cssm:parse">
        <xsl:variable name="neg_args" select="negation_arg"/>
        <not>
            <xsl:where-populated>
                <xsl:attribute name="class" select="$neg_args/class/IDENT"/>
            </xsl:where-populated>
            <xsl:where-populated>
                <xsl:attribute name="id" select="$neg_args/HASH/replace(., '^#', '')" separator=","/>
            </xsl:where-populated>
            <xsl:apply-templates select="$neg_args/type_selector" mode="#current"/>
            <xsl:apply-templates select="$neg_args/(node() except (class | HASH | type_selector))"
                mode="#current"/>
        </not>
    </xsl:template>

    <!--    
    Properties
    -->

    <xsl:template match="declaration" mode="cssm:parse">
        <xsl:variable name="properties" select="property"/>
        <xsl:variable name="values" as="node()*">
            <xsl:apply-templates select="node() except $properties" mode="#current"/>
        </xsl:variable>
        <xsl:for-each select="$properties">
            <xsl:variable name="name" select="IDENT | QUOTED_STRING/(STRING_CONTENT1|STRING_CONTENT2)"/>
            <property name="{$name}">
                <xsl:sequence select="$values"/>
            </property>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="declaration/values" mode="cssm:parse">

        <xsl:variable name="important" select="important"/>
        <xsl:if test="$important">
            <xsl:attribute name="important" select="true()"/>
        </xsl:if>
        <xsl:apply-templates select="value" mode="#current"/>
    </xsl:template>


    <xsl:template match="values[count(value) eq 1]/value" mode="cssm:parse" priority="10">
        <xsl:variable name="next-match" as="node()*">
            <xsl:next-match/>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$next-match/self::cssm:functionCall or not(count($next-match) eq 1)">
                <xsl:sequence select="$next-match"/>                
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="$next-match">
                    <xsl:attribute name="{local-name()}" select="string(.)"/>
                    <xsl:sequence select="@*"/>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template match="values/value" mode="cssm:parse">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="values/value/IDENT | expression/IDENT" mode="cssm:parse">
        <value>
            <xsl:value-of select="."/>
        </value>
    </xsl:template>

    <xsl:template match="values/value/QUOTED_STRING | expression/QUOTED_STRING" mode="cssm:parse">
        <string>
            <xsl:value-of select="(STRING_CONTENT1|STRING_CONTENT2)/cssm:escape-quoted-string(.)"/>
        </string>
    </xsl:template>

    <xsl:template match="values/value/URL | expression/URL " mode="cssm:parse">
        <xsl:variable name="url" select="
            QUOTED_STRING/(STRING_CONTENT1|STRING_CONTENT2)
            | BARE_URL
            "/>
        <url>
            <xsl:value-of select="$url"/>
        </url>
    </xsl:template>

    <xsl:template match="values/value/HEX | expression/HEX" mode="cssm:parse">
        <xsl:variable name="hex-value" select="substring-after(., '#')"/>
        <xsl:variable name="hex-value" select="replace($hex-value, '^([a-zA-Z0-9])([a-zA-Z0-9])([a-zA-Z0-9])$', '$1$1$2$2$3$3')"/>
        <hex>
            <xsl:value-of select="$hex-value"/>
        </hex>
    </xsl:template>
    
    <xsl:template match="values/value/DIMENSION | values/value/PERCENTAGE | expression/DIMENSION | expression/PERCENTAGE" mode="cssm:parse">
        <xsl:variable name="unit-value" select="cssm:unit-value(., '')"/>
        <numeric unit="{$unit-value?unit}">
            <xsl:value-of select="$unit-value?value"/>
        </numeric>
    </xsl:template>

    <xsl:template match="values/value/NUMBER | expression/NUMBER" mode="cssm:parse">
        <numeric>
            <xsl:value-of select="xs:double(.)"/>
        </numeric>
    </xsl:template>

    <xsl:template match="values/value/ATTR | expression/ATTR" mode="cssm:parse">
        <attr-ref>
            <xsl:value-of select="IDENT"/>
        </attr-ref>
    </xsl:template>

    <xsl:template match="values/value/functional_pseudo | expression/functional_pseudo" mode="cssm:parse">
        <xsl:variable name="name" select="FUNCTION/substring-before(., '(')"/>
        <functionCall name="{$name}">
            <xsl:for-each-group select="expression/*" group-ending-with="COMMA">
                <arg>
                    <xsl:apply-templates select="current-group()" mode="#current"/>
                </arg>
            </xsl:for-each-group> 
        </functionCall>
    </xsl:template>
    
    <xsl:template match="expression/COMMA" mode="cssm:parse"/>
<!--    
    Page query
    -->
    
    <xsl:template match="pagequery" mode="cssm:parse">
        <page>
            <xsl:apply-templates select="pagerule/*" mode="#current"/>
            <xsl:variable name="content" as="node()*">
                <xsl:apply-templates select="node() except pagerule" mode="#current"/>
            </xsl:variable>
            <xsl:variable name="properties" select="$content/self::cssm:property"/>
            <property-set>
                <xsl:sequence select="$properties"/>
            </property-set>
            <xsl:sequence select="$content except $properties"/>
        </page>
    </xsl:template>
    
    <xsl:template match="page_select_group" mode="cssm:parse">
        <xsl:apply-templates select="* except COMMA" mode="#current"/>
    </xsl:template>
    <xsl:template match="page_declaration" mode="cssm:parse">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="page_select" mode="cssm:parse">
        <select>
            <xsl:where-populated>
                <xsl:attribute name="name" select="IDENT"/>
            </xsl:where-populated>
            <xsl:where-populated>
                <xsl:attribute name="pseudo" select="pagearea/TOKEN[. != ':']" separator=" "/>
            </xsl:where-populated>
        </select>
    </xsl:template>
    
    <xsl:template match="areaquery" mode="cssm:parse">
        <xsl:variable name="pos" select="arearule/TOKEN[. != '@']"/>
        <area position="{$pos}">
            <property-set>
                <xsl:apply-templates select="declaration" mode="#current"/>
            </property-set>
        </area>
    </xsl:template>
    
<!--    
    Comments
    -->
    
    <xsl:template match="COMMENT" mode="cssm:parse">
        <xsl:comment>
            <xsl:value-of select="CommentContents"/>
        </xsl:comment>
    </xsl:template>
    
    <xsl:function name="cssm:unit-value" as="map(xs:string, item()?)" visibility="final">
        <xsl:param name="valueUnit" as="xs:string"/>
        <xsl:param name="defaultUnit" as="xs:string"/>
        <xsl:analyze-string select="$valueUnit" regex="^(-?\d+(\.\d+)?([eE]\d+)?)([\D]+)?$">
            <xsl:matching-substring>
                <xsl:sequence select="
                    map {
                    'value': regex-group(1) ! xs:double(.),
                    'unit': (regex-group(4)[. != ''], $defaultUnit)[1]
                    }
                    "/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:sequence select="map{'value' : -1, 'unit' : ()}"/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    
    <xsl:function name="cssm:specifity" as="xs:integer+">
        <xsl:param name="global-spec" as="xs:integer"/>
        <xsl:param name="selects" as="element(cssm:select)*"/>

        <xsl:variable name="selectNots" select="$selects/(.|cssm:not)"/>
        
        <xsl:variable name="spec1" select="$global-spec"/>
        <xsl:variable name="spec2" select="count($selectNots/(@id|@ids)/tokenize(., '\s'))"/>
        <xsl:variable name="spec3" select="count((
            $selectNots/@classes/tokenize(., '\s'), 
            $selectNots/@class, 
            $selectNots/cssm:attribute, 
            $selectNots/cssm:pseudo[@type = 'class']))"/>
        <xsl:variable name="spec4" select="count((
            $selectNots/@name, 
            $selectNots/@at/tokenize(., '\s'), 
            $selectNots/cssm:pseudo[@type = 'element'])
            )"/>
        <xsl:sequence select="$spec1, $spec2, $spec3, $spec4"/>
    </xsl:function>
    
    
    <!--    
    
    
-->
    <xsl:function name="cssm:hex-to-int" as="xs:integer">
        <xsl:param name="in" as="xs:string"/>
        
        <xsl:variable name="in" select="lower-case($in)"/>
        
        <xsl:variable name="chars" select="'0123456789abcdef'"/>
        <xsl:variable name="positions" select="string-length($in)"/>
        <xsl:variable name="values" select="
            for $i in 1 to $positions
            return
            string-length(substring-before($chars, substring($in, $i, 1)))
            *
            math:pow(16, $positions - $i)"/>
        <xsl:sequence select="
            $values => sum() => xs:integer()
            
            "/>
    </xsl:function>
    
    <xsl:function name="cssm:escape-quoted-string" as="xs:string">
        <xsl:param name="string" as="xs:string"/>
        <xsl:variable name="strings" as="xs:string*">
            <xsl:analyze-string select="$string" regex="\\(\\|n|r|'|&quot;|[0-9a-fA-F]{{0,4}})">
                <xsl:matching-substring>
                    <xsl:variable name="key" select="regex-group(1)"/>
                    <xsl:sequence select="
                        if (matches($key, '^[0-9a-fA-F]+$')) 
                        then (codepoints-to-string(cssm:hex-to-int($key))) 
                        else if ($key = ('\', '''', '&quot;')) 
                        then $key 
                        else if ($key = 'n') 
                        then '&#xA;' 
                        else if ($key = 'r') 
                        then '&#xD;' 
                        else .
                        "/>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:sequence select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <xsl:sequence select="string-join($strings)"/>
    </xsl:function>

</xsl:stylesheet>
