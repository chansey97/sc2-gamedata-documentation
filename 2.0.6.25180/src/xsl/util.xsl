<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:core="http://sc2-mined-data/gamedata/core"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:import-schema schema-location="../xsd/core.xsd"/>
    <xsl:key name="type-by-name" match="element(*, core:Type)" use="@name"/>
    <xsl:key name="class-by-name" match="core:Class" use="@name"/>
    <xsl:key name="enum-by-name" match="core:Enum" use="@name"/>
    
    <xsl:function name="core:class-hierarchy" as="element()*">
        <xsl:param name="class" as="element()" />
        <xsl:sequence select="core:_class-hierarchy($class, ())"/>
    </xsl:function>
    
    <xsl:function name="core:_class-hierarchy" as="element()*">
        <xsl:param name="class" as="element()"/>
        <xsl:param name="visited" as="element()*"/>
        <xsl:variable name="superClass" select="key('class-by-name', $class/@superClass, root($class))"/>
        <xsl:choose>
            <xsl:when test="$superClass and $superClass except $visited">
                <xsl:sequence select="core:_class-hierarchy($superClass, ($visited, $superClass))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$visited"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>