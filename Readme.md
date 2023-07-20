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
cssm:parse($css as xs:string, $config as map(xs:string, item()?)?) as element()
cssm:unit-value($dimension as xs:string) as map(xs:string, item()?)
cssm:unit-value($dimension as xs:string, $defaultUnit as xs:string?) as map(xs:string, item()?)
cssm:serialize-property-value(property as element(cssm:property)) as xs:string
cssm:serialize-property-value(property as element(cssm:property), $requires-quotes as xs:boolean, $with-important as xs:boolean) as xs:string
cssm:create-matching-rule-catalog($css as element(cssm:css)*, $nodes as node()*) as map(xs:string, element(cssm:rule)*)
cssm:create-matching-rule-catalog($css as element(cssm:css)*, $nodes as node()*, $namespace-strict as xs:boolean) as map(xs:string, element(cssm:rule)*)
cssm:create-matching-rule-catalog($css as element(cssm:css)*, $nodes as node()*, $namespace-strict as xs:boolean, $pseudo-element as xs:string?) as map(xs:string, element(cssm:rule)*)
cssm:effective-properties($css as element(cssm:css)*, $node as node()) as element(cssm:property-set)
cssm:effective-properties($css as element(cssm:css)*, $node as node(), $merge-handler as function(element(cssm:rule)*) as element(cssm:rule)*) as element(cssm:property-set)
cssm:effective-properties($css as element(cssm:css)*, $node as node(), $merge-handler as function(element(cssm:rule)*) as element(cssm:rule)*, $pseudo-handler as function(node(), xs:string) as xs:string*) as element(cssm:property-set)
cssm:merge-rules-with-context($matching-rules as element(cssm:rule)*, $node as node()) as element(cssm:property-set)
cssm:merge-rules-with-context($matching-rules as element(cssm:rule)*, $node as node(), $merge-handler as function(element(cssm:rule)*) as element(cssm:rule)*) as element(cssm:property-set)
cssm:top-right-button-left($values as item()*) as map(xs:string, item()?
cssm:top-right-button-left($values as item()*, $default as item()?) as map(xs:string, item()?
```

#### Function `cssm:parse`

Parses CSS code and returns it in the XML model defined by the [CSS Model schema](src/main/resources/rnc/css3-model.rnc). The parameter `config` (default: `map{}`) provides some configuration parameter:


| Config field | Meaning | Type | Default |
|---|---|---|---|
| `stlyesheet-specificity` |  This parameter provides a stylesheet specificity value for all `css:selector` elements in the returned model. The specificity is a list of four integer values and is used to calculate the priority of rules by merging them to an effective rule. The first value of this list is the stylesheet specificity and can only set by this parameter. | `xs:integer` | `0` |
| `strict` | If `true` the result model is validated against the [CSS Model schema](src/main/resources/rnc/css3-model.rnc). Otherwise the validation is skiped. | `xs:boolean` | `true` |
| `default-namespace` | Element name selectors with no prefix will be applied to this namespace. If the `default-namespace` is `*` they are applied to any namespace. | `xs:string` | `*` |


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


## Contribute & third-party licenses

This project is based on the work of others. 

### ReX Parser Generator

A core part of this project is an XSLT parser for CSS which is generated by the [REx Parser Generator](https://www.bottlecaps.de/rex/).

#### Affected file(s)

* [src/main/resources/xsl/css3.xsl](src/main/resources/xsl/css3.xsl)

#### Copyright statement

© 1979-2023 Gunther Rademacher grd@gmx.net

### EBNF file

ReX generates a parser based on an EBNF file. In our case it is a EBNF file describing the syntax of CSS, which was initialy developed as part of the [Transpect project](https://github.com/transpect/css-tools/blob/master/ebnf-scheme/CSS3.ebnf) and just extended by me. 

#### Affected file(s)

* [src/main/resources/ebnf/css3.ebnf](src/main/resources/ebnf/css3.ebnf)
* [src/main/resources/xsl/css3.xsl](src/main/resources/xsl/css3.xsl)

#### Copyright statement

Copyright (c) 2015, transpect.io
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 

### RelaxNG Schema

The provided RelaxNG schema describes the XML model which is the result of the main function `cssm:parse` and the input of some tool functions. The function `cssm:parse` converts the output of the core parser (see above ReX Parser Generator and EBNF) from a syntactic markup to a semantic model. However, some XML names and structures are taken over from the core parser output into the model, so that the EBNF authors could claim a co-authorship of the schemas.

#### Affected files

* [src/main/resources/rnc/css3-model.rnc](src/main/resources/rnc/css3-model.rnc)
* [src/main/resources/rnc/css3-model.rng](src/main/resources/rnc/css3-model.rng)

#### Copyright statement

See [EBNF](#ebnf-file).