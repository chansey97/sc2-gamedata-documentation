<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:core="http://sc2-mined-data/gamedata/core"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <xsl:variable name="model.xml-doc" select="doc(concat(resolve-uri('.'), '../resources/model.xml'))"/>
    
    <xsl:template name="main">
        <xsl:result-document href="../../project/main.cpp">
            <xsl:call-template name="include-directives"/>
<xsl:text xml:space="preserve">
int main()
{
    return 0;
}
</xsl:text>
        </xsl:result-document>

    </xsl:template>
    
    <xsl:template name="include-directives">
        <xsl:for-each select="$model.xml-doc//core:Package">
            <xsl:text/>#include "<xsl:value-of select="@name"/>.h"<xsl:call-template name="CRLF"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="CRLF">
        <xsl:text>&#x0D;&#x0A;</xsl:text>
    </xsl:template>
</xsl:stylesheet>