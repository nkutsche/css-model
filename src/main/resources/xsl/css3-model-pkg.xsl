<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration [<!ENTITY % versions SYSTEM "../version.ent">%versions;]>
<xsl:package xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0"
    package-version="&project.version;"
    name="http://www.nkutsche.com/css3-model"
    declared-modes="false"
    >
    <xsl:use-package name="http://maxtoroq.github.io/rng-xsl" package-version="*"/>
    
    <xsl:import href="css3-model.xsl"/>
    
</xsl:package>