<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:cssm="http://www.nkutsche.com/css3-model" xmlns="http://www.nkutsche.com/css3-model" xmlns:map="http://www.w3.org/2005/xpath-functions/map" exclude-result-prefixes="#all" version="3.0">
    
    <xsl:mode name="cssm:apply-context" on-no-match="shallow-copy"/>
    
    
    <xsl:function name="cssm:create-matching-rule-catalog" as="map(xs:string, element(cssm:rule)*)" visibility="final">
        <xsl:param name="css" as="element(cssm:css)*"/>
        <xsl:param name="nodes" as="node()*"/>
        <xsl:sequence select="cssm:create-matching-rule-catalog($css, $nodes, ())"/>
    </xsl:function>
    
    <xsl:function name="cssm:create-matching-rule-catalog" as="map(xs:string, element(cssm:rule)*)" visibility="final">
        <xsl:param name="css" as="element(cssm:css)*"/>
        <xsl:param name="nodes" as="node()*"/>
        <xsl:param name="pseudo-element" as="xs:string?"/>
        
        <xsl:variable name="as-xsl" select="cssm:as-xsl($css)"/>
        

        <xsl:variable name="css-matches" as="map(xs:string, element(cssm:rule)*)*">
            <xsl:variable name="context-roots" select="$nodes/ancestor-or-self::*[not(parent::*)]"/>
            
            <xsl:variable name="transform-options" select="
                map{
                'stylesheet-node' : $as-xsl,
                'delivery-format' : 'raw'
                }
                "/>
            
            <xsl:variable name="transform-options" select="
                if (exists($pseudo-element)) 
                then map:put($transform-options, 'initial-mode', QName('http://www.nkutsche.com/css3-model', $pseudo-element)) 
                else $transform-options
                "/>
            
            
            <xsl:for-each select="$context-roots">
                <xsl:variable name="transform-options" select="map:put($transform-options, 'source-node', .)"/>
                <xsl:variable name="transform" select="transform($transform-options)"/>
                <xsl:sequence select="$transform?*"/>
            </xsl:for-each>
            
        </xsl:variable>
        
        <xsl:sequence select="
            $css-matches => map:merge(map{'duplicates' : 'combine'})
            "/>
    </xsl:function>
    
    
    
    <xsl:function name="cssm:effective-properties" as="element(cssm:property-set)" visibility="final">
        <xsl:param name="css" as="element(cssm:css)*"/>
        <xsl:param name="node" as="node()"/>
        <xsl:sequence select="cssm:effective-properties($css, $node, function($rules){$rules})"/>
    </xsl:function>
    
    <xsl:function name="cssm:effective-properties" as="element(cssm:property-set)" visibility="final">
        <xsl:param name="css" as="element(cssm:css)*"/>
        <xsl:param name="node" as="node()"/>
        <xsl:param name="merge-handler" as="function(element(cssm:rule)*) as element(cssm:rule)*"/>
        <xsl:sequence select="cssm:effective-properties($css, $node, $merge-handler, function($node, $type){})"/>
    </xsl:function>
    
    <xsl:function name="cssm:effective-properties" as="element(cssm:property-set)" visibility="final">
        <xsl:param name="css" as="element(cssm:css)*"/>
        <xsl:param name="node" as="node()"/>
        <xsl:param name="merge-handler" as="function(element(cssm:rule)*) as element(cssm:rule)*"/>
        <xsl:param name="pseudo-handler" as="function(node(), xs:string) as xs:string*"/>
        
        <xsl:variable name="matching-rules" select="$css ! cssm:rule[cssm:rule-match(., $node, $pseudo-handler)]"/>
        
        <xsl:sequence select="cssm:merge-rules-with-context($matching-rules, $node, $merge-handler)"/>
        
    </xsl:function>
    
    <xsl:function name="cssm:merge-rules-with-context" as="element(cssm:property-set)" visibility="final">
        <xsl:param name="matching-rules" as="element(cssm:rule)*"/>
        <xsl:param name="node" as="node()"/>
        <xsl:sequence select="cssm:merge-rules-with-context($matching-rules, $node, function($rules){$rules})"/>
    </xsl:function>
    <xsl:function name="cssm:merge-rules-with-context" as="element(cssm:property-set)" visibility="final">
        <xsl:param name="matching-rules" as="element(cssm:rule)*"/>
        <xsl:param name="node" as="node()"/>
        <xsl:param name="merge-handler" as="function(element(cssm:rule)*) as element(cssm:rule)*"/>
        
        <xsl:variable name="matching-rules" select="$matching-rules, $node/@style/cssm:create-pseudo-rule(.)"/>
        
        
        <xsl:variable name="merge-rule" select="$matching-rules ! cssm:apply-context(., $node) => $merge-handler() => cssm:merge-rules()"/>
        <xsl:sequence select="$merge-rule ! cssm:normalize-properties(.)"/>
        
    </xsl:function>
    
    <xsl:function name="cssm:create-pseudo-rule" as="element(cssm:rule)">
        <xsl:param name="css-attribute" as="attribute()"/>
        <xsl:variable name="pseudo-rule" select="'* {' || $css-attribute || '}'"/>
        <rule>
            <selector specificity="1 0 0 0"/>
            <xsl:sequence select="cssm:parse($pseudo-rule)/cssm:rule/cssm:property-set"/>
        </rule>
    </xsl:function>
    
    <xsl:function name="cssm:merge-rules" as="element(cssm:property-set)">
        <xsl:param name="rules" as="element(cssm:rule)*"/>
        <xsl:variable name="rules" select="$rules/cssm:split-rule(.)"/>
        <xsl:variable name="rules-sorted" as="element(cssm:rule)*">
            <xsl:perform-sort select="$rules">
                <xsl:sort select="cssm:selector/@specificity/tokenize(., '\s')[1] ! xs:integer(.)" data-type="number"/>
                <xsl:sort select="cssm:selector/@specificity/tokenize(., '\s')[2] ! xs:integer(.)" data-type="number"/>
                <xsl:sort select="cssm:selector/@specificity/tokenize(., '\s')[3] ! xs:integer(.)" data-type="number"/>
                <xsl:sort select="cssm:selector/@specificity/tokenize(., '\s')[4] ! xs:integer(.)" data-type="number"/>
            </xsl:perform-sort>
        </xsl:variable>
        <property-set>
            <xsl:for-each-group select="$rules-sorted ! cssm:property-set/cssm:property" group-by="@name">
                <xsl:variable name="important" select="current-group()[@important='true'][last()]"/>
                <xsl:sequence select="(current-group(), $important)[last()]"/>
            </xsl:for-each-group>
        </property-set>
    </xsl:function>
    
    <xsl:function name="cssm:split-rule" as="element(cssm:rule)*">
        <xsl:param name="rule" as="element(cssm:rule)"/>
        <xsl:for-each select="$rule/cssm:selector">
            <xsl:variable name="selector" select="."/>
            <xsl:copy select="$rule">
                <xsl:apply-templates select="@*"/>
                <xsl:sequence select="$selector"/>
                <xsl:sequence select="node() except cssm:selector"/>
            </xsl:copy>
        </xsl:for-each>
    </xsl:function>

    <xsl:function name="cssm:rule-match" as="xs:boolean">
        <xsl:param name="rule" as="element(cssm:rule)"/>
        <xsl:param name="node" as="node()"/>
        <xsl:sequence select="cssm:rule-match($rule, $node, function($node, $type){})"/>
    </xsl:function>

    <xsl:function name="cssm:rule-match" as="xs:boolean">
        <xsl:param name="rule" as="element(cssm:rule)"/>
        <xsl:param name="node" as="node()"/>
        <xsl:param name="pseudo-handler" as="function(node(), xs:string) as xs:string*"/>
        <xsl:sequence select="
                some $sel in $rule/cssm:selector
                    satisfies cssm:selector-match($sel/cssm:select, $node, $pseudo-handler)"/>
    </xsl:function>

    <xsl:function name="cssm:selector-match" as="xs:boolean">
        <xsl:param name="selects" as="element(cssm:select)*"/>
        <xsl:param name="node" as="node()"/>
        <xsl:param name="pseudo-handler" as="function(node(), xs:string) as xs:string*"/>

        <xsl:variable name="lastSelect" select="$selects[last()]"/>
        <xsl:variable name="restSelect" select="$selects except $lastSelect"/>

        <xsl:choose>
            <xsl:when test="not(cssm:select($lastSelect, $node, $pseudo-handler))">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:when test="not($restSelect)">
                <xsl:sequence select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="look-back" select="cssm:reverse-navigate($node, $lastSelect/@axis)"/>
                <xsl:variable name="look-back-select" select="$look-back[cssm:selector-match($restSelect, ., $pseudo-handler)]"/>
                <xsl:sequence select="exists($look-back-select)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="cssm:select" as="xs:boolean">
        <xsl:param name="select" as="element(cssm:select)"/>
        <xsl:param name="node" as="node()"/>
        <xsl:param name="pseudo-handler" as="function(node(), xs:string) as xs:string*"/>
        <!--        
        name?, classes?, idOrIds?, at?, (attributeMatch | TODO: pseudo | not)*
        -->
        <xsl:sequence select="
            $node instance of element()
            and
            cssm:select-name($select/@name, $node)
            and
            cssm:select-classes($select/@classes/tokenize(., '\s'), $node)
            and
            cssm:select-id($select/@id, $node)
            and
            cssm:select-ids($select/@ids, $node)
            and
            (
                every $a in $select/cssm:attribute
                satisfies
                cssm:select-attribute($a, $node)
            )
            and
            (
                if($select/cssm:not) then 
                    some $n in $select/cssm:not 
                    satisfies 
                    not(cssm:select-by-not($n, $node, $pseudo-handler))
                else
                true()
            )
            and
            cssm:select-pseudo($select/cssm:pseudo, $node, $pseudo-handler)
            "/>
    </xsl:function>

    <xsl:function name="cssm:select-name" as="xs:boolean">
        <xsl:param name="name" as="xs:string?"/>
        <xsl:param name="node" as="node()"/>
        <xsl:sequence select="name($node) = $name or not($name)"/>
    </xsl:function>

    <xsl:function name="cssm:select-classes" as="xs:boolean">
        <xsl:param name="classes" as="xs:string*"/>
        <xsl:param name="node" as="node()"/>
        <xsl:sequence select="
                every $c in $classes
                    satisfies $node/@class/tokenize(., '\s') = $c"/>
    </xsl:function>

    <xsl:function name="cssm:select-id" as="xs:boolean">
        <xsl:param name="id" as="xs:string?"/>
        <xsl:param name="node" as="node()"/>
        <xsl:sequence select="not($id) or $node/@id = $id"/>
    </xsl:function>

    <xsl:function name="cssm:select-ids" as="xs:boolean">
        <xsl:param name="ids" as="xs:string*"/>
        <xsl:param name="node" as="node()"/>
        <xsl:sequence select="
                every $id in $ids
                    satisfies $node/@id = $id"/>
    </xsl:function>

    <xsl:function name="cssm:select-pseudo" as="xs:boolean">
        <xsl:param name="pseudos" as="element(cssm:pseudo)*"/>
        <xsl:param name="node" as="node()"/>
        <xsl:param name="pseudo-handler" as="function(node(), xs:string) as xs:string*"/>
        
        <xsl:variable name="struct-pseudos" select="$pseudos[@type = 'class'][@name = map:keys($struct-classes)]"/>
        <xsl:variable name="pseudos" select="$pseudos except $struct-pseudos"/>
        
        <xsl:variable name="select-ps-classes" select="$pseudos[@type = 'class']/@name/string(.) => sort()"/>
        <xsl:variable name="select-ps-elements" select="$pseudos[@type = 'element']/@name/string(.) => sort()"/>
        
        <xsl:variable name="node-ps-classes" select="$pseudo-handler($node, 'class') => sort()"/>
        <xsl:variable name="node-ps-elements" select="$pseudo-handler($node, 'element') => sort()"/>
        
        <xsl:sequence select="
                deep-equal($select-ps-classes, $node-ps-classes)
                and
                deep-equal($select-ps-elements, $node-ps-elements)
                and
                (
                every $pssc in $struct-pseudos
                satisfies
                    $struct-classes($pssc/@name)($node)
                )
                "/>
    </xsl:function>
    
    <xsl:function name="cssm:select-by-not" as="xs:boolean">
        <xsl:param name="not" as="element(cssm:not)"/>
        <xsl:param name="node" as="node()"/>
        <xsl:param name="pseudo-handler" as="function(node(), xs:string) as xs:string*"/>
        <xsl:sequence select="
            cssm:select-name($not/@name, $node)
            and
            cssm:select-classes($not/@class/tokenize(., '\s'), $node)
            and
            cssm:select-id($not/@id, $node)
            and
            (
                every $a in $not/cssm:attribute
                satisfies
                cssm:select-attribute($a, $node)
            )
            and
            (
                cssm:select-pseudo($not/cssm:pseudo, $node, $pseudo-handler)
            )
            "/>
    </xsl:function>
    
    
    <xsl:variable name="struct-classes" select="
        map {
            'root' : function($n){exists($n/parent::document-node())},
            'empty' : function($n){not($n/(node() except (comment(), processing-instruction(), text()[normalize-space(.) = ''])))},
            'first-child' : function($n){not($n/preceding-sibling::*)},
            'last-child' : function($n){not($n/following-sibling::*)},
            'only-child' : function($n){not($n/../*)},
            'first-of-type' : function($n){not($n/preceding-sibling::*/name() = $n/name(.))},
            'last-of-type' : function($n){not($n/following-sibling::*/name() = $n/name(.))},
            'only-of-type' : function($n){not($n/../*/name() = $n/name(.))}
        }
        "/>

    <xsl:function name="cssm:select-attribute" as="xs:boolean">
        <xsl:param name="attr" as="element(cssm:attribute)"/>
        <xsl:param name="node" as="node()"/>
        <xsl:variable name="attr-name" select="$attr/@name"/>
        <xsl:variable name="nodeAttr" select="$node/@*[name() = $attr-name]"/>
        <xsl:variable name="compareAttr" select="$attr/(@equal | @substring | @prefix | @suffix | @dash-match | @includes)"/>
        <xsl:sequence select="cssm:compare-attribute-value($nodeAttr, $compareAttr, ($compareAttr/name(), 'exists')[1])"/>
    </xsl:function>

    <xsl:function name="cssm:compare-attribute-value" as="xs:boolean">
        <xsl:param name="value" as="xs:string?"/>
        <xsl:param name="compare" as="xs:string?"/>
        <xsl:param name="compare-mode" as="xs:string"/>

        <xsl:sequence
            select="
                if (not($value)) then
                    false()
                else 
                    if ($compare-mode = 'exists') then
                        true()
                    else
                        if ($compare-mode = 'equal') then
                            $value = $compare
                        else
                            if ($compare-mode = 'prefix') then
                                starts-with($value, $compare)
                            else
                                if ($compare-mode = 'suffix') then
                                    ends-with($value, $compare)
                                else
                                    if ($compare-mode = 'substring') then
                                        contains($value, $compare)
                                    else
                                        if ($compare-mode = 'includes') then
                                            tokenize($value, '\s') = $compare
                                        else
                                            if ($compare-mode = 'dash-match') then
                                                starts-with($value, $compare || '-')
                                            else
                                                error(xs:QName('cssm:bad-compare-mode'), 'Unkown attribute compare mode ' || $compare-mode)
                "/>

    </xsl:function>

    <xsl:function name="cssm:reverse-navigate" as="node()*">
        <xsl:param name="node" as="node()"/>
        <xsl:param name="axis" as="xs:string"/>

        <xsl:sequence select="
                if ($axis = 'descendant') then
                    $node/ancestor::node()
                else
                    if ($axis = 'child') then
                        $node/parent::node()
                    else
                        if ($axis = 'following') then
                            $node/preceding-sibling::node()
                        else
                            if ($axis = 'next-following') then
                                $node/preceding-sibling::*[1]
                            else
                                ()
                "/>

    </xsl:function>
    
    <xsl:function name="cssm:top-right-button-left" as="map(xs:string, item()?)" visibility="final">
        <xsl:param name="values" as="item()*"/>
        <xsl:sequence select="cssm:top-right-button-left($values, ())"/>
    </xsl:function>
    
    <xsl:function name="cssm:top-right-button-left" as="map(xs:string, item()?)" visibility="final">
        <xsl:param name="values" as="item()*"/>
        <xsl:param name="default" as="item()?"/>
        <xsl:variable name="top" select="$values[1]"/>
        <xsl:variable name="right" select="($values[2], $values[1])[1]"/>
        <xsl:variable name="bottom" select="($values[3], $values[1])[1]"/>
        <xsl:variable name="left" select="($values[4], $values[2], $values[1])[1]"/>
        <xsl:sequence select="
            map {
            'top': ($top, $default)[1],
            'right': ($right, $default)[1],
            'left': ($left, $default)[1],
            'bottom': ($bottom, $default)[1]
            }"/>
    </xsl:function>
    
    <xsl:function name="cssm:apply-context" as="element(cssm:rule)">
        <xsl:param name="rule" as="element(cssm:rule)"/>
        <xsl:param name="context" as="node()"/>
        <xsl:copy select="$rule">
            <xsl:sequence select="@*"/>
            <xsl:apply-templates mode="cssm:apply-context">
                <xsl:with-param name="context" select="$context" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:function>
    
    <xsl:template match="@attr-ref" mode="cssm:apply-context">
        <xsl:param name="context" as="node()" tunnel="yes"/>
        <xsl:variable name="attrName" select="."/>
        <xsl:attribute name="string" select="$context/@*[name() = $attrName]"/>
    </xsl:template>

    <xsl:template match="cssm:attr-ref" mode="cssm:apply-context">
        <xsl:param name="context" as="node()" tunnel="yes"/>
        <xsl:variable name="attrName" select="."/>
        <string>
            <xsl:value-of select="$context/@*[name() = $attrName]"/>
        </string>
    </xsl:template>
    
    <xsl:template match="cssm:functionCall[@name = '-cssm-attr']" mode="cssm:apply-context">
        <xsl:param name="context" as="node()" tunnel="yes"/>
        <xsl:variable name="attrName" select="string(cssm:arg[1])"/>
        <xsl:variable name="default">
            <xsl:apply-templates select="cssm:arg[2]/node()" mode="#current"/>
        </xsl:variable>
        <string>
            <xsl:value-of select="($context/@*[name() = $attrName], $default)[1]"/>
        </string>
    </xsl:template>
    
    <xsl:template match="cssm:functionCall[@name = '-cssm-content']" mode="cssm:apply-context">
        <xsl:param name="context" as="node()" tunnel="yes"/>
        <string>
            <xsl:value-of select="$context"/>
        </string>
    </xsl:template>

    <xsl:template match="cssm:functionCall[@name = '-cssm-xpath']" mode="cssm:apply-context">
        <xsl:param name="context" as="node()" tunnel="yes"/>
        <xsl:variable name="xpath">
            <xsl:apply-templates select="cssm:arg[1]/node()" mode="#current"/>
        </xsl:variable>
        <string>
            <xsl:evaluate xpath="$xpath" context-item="$context" with-params="map{QName('', 'current') : $context}"/>
        </string>
    </xsl:template>

    
    <xsl:function name="cssm:normalize-properties" as="element(cssm:property-set)">
        <xsl:param name="property-set" as="element(cssm:property-set)"/>
        <xsl:copy select="$property-set">
            <xsl:sequence select="@*"/>
            <xsl:for-each select="cssm:property">
                <xsl:variable name="content" as="element()*"
                    select="cssm:normalize-property-content(*)"/>
                <xsl:copy>
                    <xsl:sequence select="@*"/>
                    <xsl:choose>
                        <xsl:when test="count($content) ne 1 or $content/self::cssm:functionCall">
                            <xsl:sequence select="$content"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="{local-name($content)}" select="string($content)"/>
                            <xsl:sequence select="$content/@*"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:copy>
            </xsl:for-each>
        </xsl:copy>
    </xsl:function>
    
    <xsl:function name="cssm:normalize-property-content" as="element()*">
        <xsl:param name="content" as="element()*"/>
        <xsl:for-each-group select="$content" group-adjacent="local-name() = 'string'">
            <xsl:choose>
                <xsl:when test="current-grouping-key()">
                    <string>
                        <xsl:value-of select="current-group()" separator=""/>
                    </string>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:sequence select="current-group()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each-group> 
    </xsl:function>
    
</xsl:stylesheet>
