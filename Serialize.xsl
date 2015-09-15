<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:jts="http://jntsys.net/"
    xpath-default-namespace="http://jntsys.net/"
    exclude-result-prefixes="xs jts">
    
    <xsl:import href="Utils.xsl"/>
    <xsl:import href="HeadElements.xsl"/>
    <xsl:import href="Container.xsl"/>
    <xsl:import href="Iterative.xsl"/>

    
    <!-- параметр [indent] элемента [xsl:output] определяет, должен ли процессор
         добавлять пробельные символы для более наглядного форматирования выходного документа -->
    <xsl:output method="xml" encoding="utf-8" indent="yes" />   
    
    <xsl:template match="PageDescription">
        <html>
            <head>
                <meta charset="UTF-8" />
                <xsl:apply-imports />
            </head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    
    <!-- Обработка свойств блока описания структуры страницы -->
    <xsl:template match="properties[parent::PageDescription]" >
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="container" >
        <xsl:apply-templates select="document( concat(@in_stream, '.xml') )[node()/@stelid=current()/@stelid]" />
    </xsl:template>
    
</xsl:stylesheet>


<!--<xsl:namespace-alias stylesheet-prefix="jts" result-prefix="xsl"/>

<xsl:template match="WebApp">
    <jts:stylesheet xpath-default-namespace="http://jntsys.net/" version="2.0">
        <xsl:call-template name="ContainerXSLImport"/>
        <jts:template match="/">
            <xsl:apply-templates select="WebPage" />
        </jts:template>
    </jts:stylesheet>
</xsl:template>
<xsl:template name="ContainerXSLImport">
    <xsl:for-each select="//container">
        <jts:include>
            <xsl:attribute name="href">
                <!-\- <xsl:value-of select="."/> -\->
                <xsl:value-of select="string-join( (./@type, concat(./@id, '.xsl') ), '/')"/>
            </xsl:attribute>
        </jts:include>
    </xsl:for-each>
</xsl:template>-->

<!-- http://stackoverflow.com/questions/14167074/xpath-to-return-all-ancestors-until -->
<!--<xsl:variable name="import_list" select="
    for $target in //jts:container,
    $top in $target/ancestor::*[starts-with( name(), 'WebApp')][1]
    return
    string-join(
    ( $top/@id
    , $top/descendant::*[name() and . intersect $target/ancestor::*]/name()
    , concat($target/@url, '.xsl')
    ),
    '/'
    )
    "/>
<xsl:for-each select="$import_list">--> 