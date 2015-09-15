<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:jts="http://jntsys.net/"
    xpath-default-namespace="http://jntsys.net/" >
    
    <xsl:include href="Functions.xsl"/>
    
    <!-- Объект с динамической структурой, элементы которого являются повторяющимися.
         Одинаковый для всех режимов обработки. -->
    <xsl:template mode="#all" match="dos[child::iter]">
        <xsl:apply-templates mode="iterative"/>
    </xsl:template>
    
    <!-- http://stackoverflow.com/questions/16160768/xslt-for-loop-or-alternative-for-node-duplication -->
    <xsl:template mode="iterative" match="iter[@count]">    <!-- обработка блоков повторения с указанным атрибутом количества повторений -->
        <xsl:variable name="currElement" select="current()"/>
        <xsl:for-each select="1 to @count">
            <xsl:apply-templates mode="iterative" select="$currElement/*">    <!-- обработка всех элементов внутри блока повторений -->
                <!-- http://xsltdev.ru/lib/param-tunnel-xslt20/ -->
                <xsl:with-param name="numIter" select="current()" tunnel="yes"/> <!-- текущий элемента внутри цикла отражает состояние счётчика цикла (итератор) -->
            </xsl:apply-templates>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template mode="iterative" match="layout">
        <xsl:element name="{@element}">
            <xsl:apply-templates mode="iterative" />
        </xsl:element>
    </xsl:template>
    
    <xsl:template mode="iterative" match="tag">
        <xsl:variable name="enumInTag">
            <input type="radio" />
            <input type="text" />
        </xsl:variable>
        <xsl:variable name="element_name" select="if (@element=$enumInTag/*/@type) then 'input' else @element"/>
        <xsl:element name="{$element_name}">
            <xsl:if test="@element=$enumInTag/*/@type">
                <xsl:attribute name="type" select="@element" />
            </xsl:if>
            <!-- <tag> является конечным элементом, поэтому apply-templates вызывается только для оработки аттрибутов и вывода содержимого элемента -->
            <xsl:apply-templates mode="iterative" select="properties/property[@name='attributes']/attr"/>
            <xsl:apply-templates mode="iterative" select="content"/>
        </xsl:element>
    </xsl:template>
    
    <!-- обработка аттрибутов итеративных тегов -->
    <xsl:template mode="iterative" match="attr">
        <xsl:param name="numIter" tunnel="yes"/>
        <xsl:variable name="attr_name" select="@name"/>
        <xsl:attribute name="{$attr_name}" select="jts:getIterValue( $numIter, current()/@value )" />
    </xsl:template>
    <!-- для всех тегов кроме radio формат аттрибута checked: false/true; ... -->
    <xsl:template mode="iterative" match="attr[@name='checked']">
        <xsl:param name="numIter" tunnel="yes"/>
        <xsl:if test="jts:getIterValue( $numIter, current()/@value )='true'">
            <xsl:attribute name="checked">checked</xsl:attribute>
        </xsl:if>
    </xsl:template>
    <!-- для тега radio формат аттрибута checked: номер итерации в ходе которой элементу будет установлен аттрибут checked -->
    <xsl:template mode="iterative" match="attr[@name='checked' and ../../../@element = 'radio']">
        <xsl:param name="numIter" tunnel="yes"/>
        <xsl:if test="$numIter = number( jts:getIterValue( $numIter, current()/@inum ) )">
            <xsl:attribute name="checked">checked</xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <!-- Недопустим вывод значения из значения содержимого XML-элемента: если у него нет содержимого,
         то на обработку будет передаваться пустой параметр, а в случае с шаблоном - он просто не
         выполнится -->
    <xsl:template mode="iterative" match="content">
        <xsl:param name="numIter" tunnel="yes"/>
        <xsl:value-of select="jts:getIterValue( $numIter, @value )"/>
    </xsl:template>
    
</xsl:stylesheet>