<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:core="http://sc2-mined-data/gamedata/core"
    xmlns:local="http://sc2-mined-data/localized-data"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    <xsl:include href="util.xsl"/>
    
    <xsl:variable name="model.xml-doc" select="doc(concat(resolve-uri('.'), '../resources/model.xml'))"/>
    <xsl:variable name="LocalizedData.xml-doc" select="doc(concat(resolve-uri('.'), '../resources/LocalizedData.xml'))"/>
    <xsl:key name="LocalizedData-map-entry-by-key" match="local:MapEntry" use="local:Key"/>
    
    <xsl:template name="main">
        <xsl:apply-templates select="$model.xml-doc"/>
    </xsl:template>
    
    <xsl:template match="core:Package[@name eq 'UnderlyingTypes']">
        <xsl:result-document href="../../project/{@name}.h">
            <xsl:text/>// <xsl:value-of select="@name"/>.h generated from model.xml using generate-code.xsl<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
            <xsl:text/>#ifndef <xsl:value-of select="upper-case(@name)"/>_H<xsl:call-template name="CRLF"/>
            <xsl:text/>#define <xsl:value-of select="upper-case(@name)"/>_H<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
            <xsl:text/>#include &lt;QtCore/qglobal.h&gt;<xsl:call-template name="CRLF"/>
            <xsl:text/>#include &lt;vector&gt;<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
            <xsl:call-template name="primitive-types"/>
            <xsl:call-template name="NNet-types"/>
            <xsl:call-template name="cataloglink-types"/>
            <xsl:call-template name="fixed-types"/>
            <xsl:call-template name="flags-types"/>
            <xsl:call-template name="float-types"/>
            <xsl:call-template name="fourcc-types"/>
            <xsl:call-template name="intsigned-types"/>
            <xsl:call-template name="intunsigned-types"/>
            <xsl:call-template name="string-types"/>
            <xsl:call-template name="unknown-types"/>
            <xsl:text/>#endif // <xsl:value-of select="upper-case(@name)"/>_H<xsl:call-template name="CRLF"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="primitive-types">
        <xsl:text xml:space="preserve">/*!
 * \remark IntUnsigned
 */
typedef quint8 uint8;

/*!
 * \remark IntUnsigned
 */
typedef quint16 uint16;

/*!
 * \remark IntUnsigned
 */
typedef quint32 uint32;

/*!
 * \remark IntUnsigned
 */
typedef quint64 uint64;

/*!
 * \remark IntSigned
 */
typedef qint8 int8;

/*!
 * \remark IntSigned
 */
typedef qint16 int16;

/*!
 * \remark IntSigned
 */
typedef qint32 int32;

/*!
 * \remark IntSigned
 */
typedef qint64 int64;

/*!
 * \remark Float
 */
typedef float real32;

/*!
 * \remark IntSigned
 */
typedef uint8 flag8;

/*!
 * \remark Unknown
 */
typedef bool flag;
</xsl:text>
        <xsl:call-template name="CRLF"/>
    </xsl:template>

    <xsl:template name="NNet-types">
<xsl:text xml:space="preserve">namespace NNet
{
    class Game
    {
    public:
        /*!
         * \remark IntUnsigned
         */
        typedef uint32 TAIBuild;
        
        /*!
         * \remark IntUnsigned
         */
        typedef uint32 TDifficulty;
        
        /*!
         * \remark IntUnsigned
         */
        typedef uint32 THandicap;

        static const int c_maxAIBuilds = 1000;
    };
}    
</xsl:text>
        <xsl:call-template name="CRLF"/>
    </xsl:template>

    <xsl:template name="cataloglink-types">
        <xsl:for-each select="core:UnderlyingType[@category eq 'CatalogLink']">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>class <xsl:value-of select="@name"/><xsl:call-template name="CRLF"/>
            <xsl:text/>{<xsl:call-template name="CRLF"/>
            <xsl:text/>};<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="fixed-types">
        <xsl:for-each select="core:UnderlyingType[@category eq 'Fixed'][starts-with(@name, 'C')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>class <xsl:value-of select="@name"/><xsl:call-template name="CRLF"/>
            <xsl:text/>{<xsl:call-template name="CRLF"/>
            <xsl:text/>};<xsl:call-template name="CRLF"/>  
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
        <xsl:for-each select="core:UnderlyingType[@category eq 'Fixed'][starts-with(@name, 'T')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>typedef CFixed <xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="flags-types">
<xsl:text xml:space="preserve">/*!
 * \remark Flags
 */
template &lt;int32 total_bits_&gt;
class CFlagArray
{
public:
    CFlagArray() : total_bits(total_bits_) {}
private:
    int32 total_bits;
};
</xsl:text>
        <xsl:call-template name="CRLF"/>
        <xsl:for-each select="core:UnderlyingType[@category eq 'Flags'][starts-with(@name, 'C')]">
            <xsl:if test="not(contains(@name, '>'))">
                <xsl:text/>/*!<xsl:call-template name="CRLF"/>
                <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
                <xsl:text/> */<xsl:call-template name="CRLF"/>
                <xsl:text/>class <xsl:value-of select="@name"/><xsl:call-template name="CRLF"/>
                <xsl:text/>{<xsl:call-template name="CRLF"/>
                <xsl:text/>};<xsl:call-template name="CRLF"/>
                <xsl:call-template name="CRLF"/>
            </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="core:UnderlyingType[@category eq 'Flags'][starts-with(@name, 'T')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>typedef CFlags <xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="float-types">
        <xsl:for-each select="core:UnderlyingType[@category eq 'Float'][starts-with(@name, 'T')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>typedef real32 <xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="fourcc-types">
        <xsl:for-each select="core:UnderlyingType[@category eq 'FourCC'][starts-with(@name, 'C')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>class <xsl:value-of select="@name"/><xsl:call-template name="CRLF"/>
            <xsl:text/>{<xsl:call-template name="CRLF"/>
            <xsl:text/>};<xsl:call-template name="CRLF"/>  
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
        <xsl:for-each select="core:UnderlyingType[@category eq 'FourCC'][starts-with(@name, 'T')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>typedef CFourCC <xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="intunsigned-types">
        <xsl:for-each select="core:UnderlyingType[@category eq 'IntSigned'][starts-with(@name, 'T')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>typedef int32 <xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
        </xsl:for-each> 
    </xsl:template>
    
    <xsl:template name="intsigned-types">
        <xsl:for-each select="core:UnderlyingType[@category eq 'IntUnsigned'][starts-with(@name, 'T')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>typedef uint32 <xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
        </xsl:for-each> 
    </xsl:template>
    
    <xsl:template name="string-types">
        <xsl:for-each select="core:UnderlyingType[@category eq 'String'][starts-with(@name, 'C')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>class <xsl:value-of select="@name"/><xsl:call-template name="CRLF"/>
            <xsl:text/>{<xsl:call-template name="CRLF"/>
            <xsl:text/>};<xsl:call-template name="CRLF"/>  
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
        <xsl:for-each select="core:UnderlyingType[@category eq 'String'][starts-with(@name, 'T')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>typedef CString <xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="unknown-types">
<xsl:text xml:space="preserve">/*!
 * \remark Unknown
 */
class CUnknown
{
};

/*!
 * \remark Unknown
 */
class CTechRequirementsGraph
{
};
</xsl:text>
        <xsl:call-template name="CRLF"/>
        <xsl:for-each select="core:UnderlyingType[@category eq 'Unknown'][starts-with(@name, 'C')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>class <xsl:value-of select="@name"/><xsl:call-template name="CRLF"/>
            <xsl:text/>{<xsl:call-template name="CRLF"/>
            <xsl:text/>};<xsl:call-template name="CRLF"/>  
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
        <xsl:for-each select="core:UnderlyingType[@category eq 'Unknown'][starts-with(@name, 'T')]">
            <xsl:text/>/*!<xsl:call-template name="CRLF"/>
            <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
            <xsl:text/> */<xsl:call-template name="CRLF"/>
            <xsl:text/>typedef CUnknown <xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="core:Package[@name ne 'UnderlyingTypes']">
        <xsl:result-document href="../../project/{@name}.h">
            <xsl:text/>// <xsl:value-of select="@name"/>.h generated from model.xml using generate-code.xsl<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
            <xsl:text/>#ifndef <xsl:value-of select="upper-case(@name)"/>_H<xsl:call-template name="CRLF"/>
            <xsl:text/>#define <xsl:value-of select="upper-case(@name)"/>_H<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
            <xsl:call-template name="include-directives"/>
            <xsl:apply-templates/>
            <xsl:text/>#endif // <xsl:value-of select="upper-case(@name)"/>_H<xsl:call-template name="CRLF"/>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="include-directives">
        <xsl:variable name="dependent-types" select="for $t in distinct-values((descendant::core:Field/@type, descendant::core:Class/@superClass)) return key('type-by-name', $t)"/>
        <xsl:variable name="dependent-packages" select="$dependent-types/parent::core:Package"/>
        <xsl:variable name="dependent-packages-excluded-self" select="$dependent-packages except ."/>
        <xsl:for-each select="$dependent-packages-excluded-self">
            <xsl:text/>#include "<xsl:value-of select="@name"/>.h"<xsl:call-template name="CRLF"/>
        </xsl:for-each>
        <xsl:call-template name="CRLF"/>
    </xsl:template>

    <xsl:template match="core:Enum">
        <xsl:text/>/*!<xsl:call-template name="CRLF"/>
        <xsl:text/> * \brief <xsl:value-of select="key('LocalizedData-map-entry-by-key', concat('EDSTR_ENUMNAME_', @name), $LocalizedData.xml-doc)[1]/local:Value"/><xsl:call-template name="CRLF"/>
        <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
        <xsl:text/> */<xsl:call-template name="CRLF"/>
        <xsl:text/>typedef enum<xsl:call-template name="CRLF"/>
        <xsl:text/>{<xsl:call-template name="CRLF"/>
        <!--        Note: ignore 1st literal which is Unknown-->
        <xsl:for-each select="core:Literal[position() > 1]">
            <!--            Note: the literal of EBoneID and EAttachmentID include whitespace, so replace it by _-->
            <xsl:variable name="enum-value" select="concat(../@literal-prefix, replace(@name, ' ', '_'))"/>
            <xsl:call-template name="Indent"/>/*!<xsl:call-template name="CRLF"/>
            <xsl:call-template name="Indent"/> * \brief <xsl:value-of select="key('LocalizedData-map-entry-by-key', concat('EDSTR_ENUMVAL_', $enum-value), $LocalizedData.xml-doc)[1]/local:Value"/><xsl:call-template name="CRLF"/>
            <xsl:call-template name="Indent"/> * \details <xsl:value-of select="key('LocalizedData-map-entry-by-key', concat('EDSTR_ENUMHINT_', $enum-value), $LocalizedData.xml-doc)[1]/local:Value"/><xsl:call-template name="CRLF"/>
            <xsl:call-template name="Indent"/> */<xsl:call-template name="CRLF"/>
            <xsl:call-template name="Indent"/><xsl:value-of select="$enum-value"/>,<xsl:call-template name="CRLF"/>
            <xsl:call-template name="CRLF"/>
        </xsl:for-each>
        <xsl:text/>} <xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
        <xsl:call-template name="CRLF"/>
        <xsl:choose>
            <!--            Note: all ECLassIdXX has the same literal-prefix e_classId-->
            <xsl:when test="@literal-prefix eq 'e_classId'">
                <xsl:text/>const int32 <xsl:value-of select="concat(@literal-prefix, substring-after(@name, 'EClassId'), 'Count')"/> = <xsl:value-of select="count(core:Literal) - 1"/>;<xsl:call-template name="CRLF"/>
                <xsl:call-template name="CRLF"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text/>const int32 <xsl:value-of select="concat(@literal-prefix, 'Count')"/> = <xsl:value-of select="count(core:Literal) - 1"/>;<xsl:call-template name="CRLF"/>
                <xsl:call-template name="CRLF"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="core:Class[starts-with(@name, 'C')]">
        <xsl:text/>/*!<xsl:call-template name="CRLF"/>
        <xsl:text/> * \brief <xsl:value-of select="key('LocalizedData-map-entry-by-key', concat('EDSTR_ENTRYTYPE_', @name), $LocalizedData.xml-doc)[1]/local:Value"/><xsl:call-template name="CRLF"/>
        <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
        <xsl:text/> */<xsl:call-template name="CRLF"/>
        <xsl:text/>class <xsl:value-of select="@name"/><xsl:if test="@superClass"> : <xsl:value-of select="@superClass"/></xsl:if><xsl:call-template name="CRLF"/>
        <xsl:text/>{<xsl:call-template name="CRLF"/>
        <xsl:text/>public:<xsl:call-template name="CRLF"/>
        <xsl:for-each select="core:Field">
            <xsl:call-template name="field-declaration"/>
        </xsl:for-each>
        <xsl:text/>};<xsl:call-template name="CRLF"/>
        <xsl:call-template name="CRLF"/>
    </xsl:template>
    
    <xsl:template match="core:Class[starts-with(@name, 'S')]">
        <xsl:text/>/*!<xsl:call-template name="CRLF"/>
        <xsl:text/> * \remark <xsl:value-of select="@category"/><xsl:call-template name="CRLF"/>
        <xsl:text/> */<xsl:call-template name="CRLF"/>
        <xsl:text/>struct <xsl:value-of select="@name"/><xsl:if test="@superClass"> : <xsl:value-of select="@superClass"/></xsl:if><xsl:call-template name="CRLF"/>
        <xsl:text/>{<xsl:call-template name="CRLF"/>
        <xsl:for-each select="core:Field">
            <xsl:call-template name="field-declaration"/>
        </xsl:for-each>
        <xsl:text/>};<xsl:call-template name="CRLF"/>
        <xsl:call-template name="CRLF"/>
    </xsl:template>
    
    <xsl:template name="field-declaration">
        <xsl:call-template name="Indent"/>/*!<xsl:call-template name="CRLF"/>
        <xsl:call-template name="Indent"/> * \brief <xsl:value-of select="key('LocalizedData-map-entry-by-key', concat('EDSTR_FIELDNAME_', parent::core:Class/@name, '_', @name), $LocalizedData.xml-doc)[1]/local:Value"/><xsl:call-template name="CRLF"/>
        <xsl:call-template name="Indent"/> * \details <xsl:value-of select="key('LocalizedData-map-entry-by-key', concat('EDSTR_FIELDHINT_', parent::core:Class/@name, '_', @name), $LocalizedData.xml-doc)[1]/local:Value"/><xsl:call-template name="CRLF"/>
        <xsl:if test="@indexEnum">
            <xsl:call-template name="Indent"/> * \remark indexEnum: \ref <xsl:value-of select="@indexEnum"/><xsl:call-template name="CRLF"/>
        </xsl:if>
        <xsl:if test="@minValue">
            <xsl:call-template name="Indent"/> * \remark minValue: <xsl:value-of select="@minValue"/><xsl:call-template name="CRLF"/>
        </xsl:if>
        <xsl:if test="@maxValue">
            <xsl:call-template name="Indent"/> * \remark maxValue: <xsl:value-of select="@minValue"/><xsl:call-template name="CRLF"/>
        </xsl:if>
        <xsl:call-template name="Indent"/> */<xsl:call-template name="CRLF"/>
        <xsl:choose>
            <xsl:when test="@array eq true()">
                <xsl:choose>
                    <xsl:when test="key('type-by-name', @type)/@category eq 'Flags'">
                        <xsl:call-template name="Indent"/><xsl:value-of select="@type"/><xsl:call-template name="Space"/><xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
                        <xsl:if test="position()!=last()"><xsl:call-template name="CRLF"/></xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="Indent"/>std::vector&lt;<xsl:value-of select="@type"/>&gt;<xsl:call-template name="Space"/><xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
                        <xsl:if test="position()!=last()"><xsl:call-template name="CRLF"/></xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="Indent"/><xsl:value-of select="@type"/><xsl:call-template name="Space"/><xsl:value-of select="@name"/>;<xsl:call-template name="CRLF"/>
                <xsl:if test="position()!=last()"><xsl:call-template name="CRLF"/></xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="CRLF">
        <xsl:text>&#x0D;&#x0A;</xsl:text>
    </xsl:template>
    
    <xsl:template name="Indent">
        <xsl:text>    </xsl:text>
    </xsl:template>
    
    <xsl:template name="Space">
        <xsl:text> </xsl:text>
    </xsl:template>
</xsl:stylesheet>