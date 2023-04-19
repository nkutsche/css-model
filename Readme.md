# CSS Model

This project provides a CSS parser written in XSLT. 

## How to build this project

### Create the jar package

Just run `mvn clean package`.

### Deployment

Currently the binaries are deployed to the public repository of data2type's Nexus server. You need permissions to deploy on that server.

## How to include

This project uses the [XSLT Package Handler](https://github.com/nkutsche/xslt-package-handler). 

**Node:** There is a more detailed but general description how to include modules using the XSLT Package Handler [here](https://github.com/nkutsche/xslt-package-handler#how-to-use). The following description is just a summary of the important points inclusive the project specific informations and adjustments. 

### Maven Settings

Add to your Maven pom.xml:

```xml
<dependencies>
    [...]
    <dependency>
        <groupId>com.nkutsche</groupId>
        <artifactId>css-model</artifactId>
        <version>{this.project.version}</version>
    </dependency>
    <dependency>
        <groupId>com.nkutsche</groupId>
        <artifactId>xslt-pkg-managerXXX</artifactId>
        <version>2.0.0</version>
    </dependency>
</dependencies>

[...]
    
<repositories>
    [...]
    <repository>
        <id>d2t-nexus-public</id>
        <url>https://repo.data2type.de/repository/maven-public/</url>
        <releases>
            <enabled>true</enabled>
        </releases>
    </repository>
</repositories>
```

**IMPORTANT:** Replace `XXX` with `99`, `100` or `110` depending on if you use Saxon 9.9.x or 10.x in your project.

### Saxon Setup

1. Check that all dependency jars are in your classpath. This includes the project jar (`css-model-X.Y.Z.jar`) and those from the Package Manager (`xslt-pkg-manager100-2.0.0.jar`, ...). Usually Maven should manage this for you.
1. Add to your Saxon call the argument `-init:com.nkutsche.xslt.pkg.handler.PackageManager`. 

### Package usage in XSLT.

Add to your Main stylesheet the following on top level:

```xml
<xsl:use-package name="http://www.nkutsche.com/css3-model" version="*"/>
```

This should enable you to use the following functions in the namespace `http://www.nkutsche.com/css3-model` (prefix `cssm`):

```xpath
cssm:parse($css as xs:string) as element()
cssm:parse($css as xs:string, $stlyesheet-specifity as xs:integer?) as element()
cssm:unit-value($dimension as xs:string) as map(xs:string, item()?)
cssm:unit-value($dimension as xs:string, $defaultUnit as xs:string?) as map(xs:string, item()?)
cssm:serialize-property-value(property as element(cssm:property)) as xs:string
cssm:serialize-property-value(property as element(cssm:property), $requires-quotes as xs:boolean, $with-important as xs:boolean) as xs:string
cssm:create-matching-rule-catalog($css as element(cssm:css)*, $nodes as node()*) as map(xs:string, element(cssm:rule)*)
cssm:create-matching-rule-catalog($css as element(cssm:css)*, $nodes as node()*, $pseudo-handler-factory as function(node(), element(cssm:select)) as function(node(), xs:string) as xs:string*) as map(xs:string, element(cssm:rule)*)
cssm:effective-properties($css as element(cssm:css)*, $node as node()) as element(cssm:property-set)
cssm:effective-properties($css as element(cssm:css)*, $node as node(), $merge-handler as function(element(cssm:rule)*) as element(cssm:rule)*) as element(cssm:property-set)
cssm:effective-properties($css as element(cssm:css)*, $node as node(), $merge-handler as function(element(cssm:rule)*) as element(cssm:rule)*, $pseudo-handler as function(node(), xs:string) as xs:string*) as element(cssm:property-set)
cssm:merge-rules-with-context($matching-rules as element(cssm:rule)*, $node as node()) as element(cssm:property-set)
cssm:merge-rules-with-context($matching-rules as element(cssm:rule)*, $node as node(), $merge-handler as function(element(cssm:rule)*) as element(cssm:rule)*) as element(cssm:property-set)
cssm:top-right-button-left($values as item()*) as map(xs:string, item()?
cssm:top-right-button-left($values as item()*, $default as item()?) as map(xs:string, item()?
```

#### Function `cssm:parse`

Parses CSS code and returns it in the XML model defined by the [CSS Model schema](src/main/resources/rnc/css3-model.rnc). The parameter `$stlyesheet-specifity`  (default: `0`) provides a stylesheet specifity value for all `css:selector` elements in the returned model. The specifity is a list of four integer values and is used to calculate the priority of rules by merging them to an effective rule. The first value of this list is the stylesheet specifity and can only set by this parameter.

#### Function `cssm:unit-value`

Receives a CSS dimension like `10px` and returns a map with the fields `value` and `unit` having the numerical value and the unit as value. If the dimension does not contains a unit, the `$defaultUnit` (which is by default an empty sequence) is used for the field `unit`. In error cases a map `map{'value' : -1, 'unit' : ()}` is returned.

#### Function `cssm:serialize-property-value`

Serializes a property value of the CSS model. If the parameter `$requires-quotes` (default `false`) is `true` string values will be quoted. If the parameter `$with-important` (default `false`) is `true` the `!important` statement is serialized as well. 

#### Function `cssm:create-matching-rule-catalog`

Todo.

#### Function `cssm:effective-properties`

Receives a CSS model (`$css`) and an XML node (`$node`) and returns the effective property set for the node. `$merge-handler` is used making interactions between the selection of the affected rules and the rule merging. `$pseudo-handler` is used to specify which CSS pseudo classes or elements should be applied to the `$node`.

#### Function `cssm:merge-rules-with-context`

Receives rules of a CSS model (`$matching-rules`) and returns the effective property set for the given context node (`$node`). Therefore it creates a pseudo rule by `$node/@style` attribute if available, applies the context on the rule property values (e.g. resolving CSS function `attr(...)`) and merges the rules to one property set based on there selector specifity. Between context applying and rule merging the `$merge-handler` is applied on the rules.

#### Function `cssm:top-right-button-left`

Receives a sequence of 0-4 values (`$values`) and interprets this values as top-right-bottom-left CSS shorthands. It returns a map with the fields `top`, `right`, `bottom` and `left` which has the correpsonding effective values. `$default` (by default an empty sequence) is used for all Map entries if `$values` contains an empty sequence.




