<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://jntsys.net/">
    
    <!-- Шаблон обработки класса контейнера типа [atom].
         Наследует базовый шаблон обработки класс Container.
         Одинаковый для всех режимов обработки. -->
    <xsl:template mode="#all" match="Container[@type='atom']">
        <лажа>
            <!--<xsl:apply-templates mode="atom" />-->
        </лажа>
        <xsl:next-match/> <!-- наследование базового шаблона контейнера -->
    </xsl:template>

    <!-- Абстрактный (базовый) шаблон обработки класса контейнера -->
    <xsl:template mode="#all" match="Container">
        <!-- для того, чтобы элемент контейнера можно было динамически поменять без смены шаблона -->
        <xsl:element name="{@element}">
            <!--<xsl:attribute name="id" select="@stelid" /> -->   
            <!-- При применении шаблона установка значения для параметра select обязательно,
                 иначе не сработает next-match -->
            <xsl:apply-templates mode="container" />
        </xsl:element> 
    </xsl:template>
    
   
    
    <!-- Обработка свойств контейнера представленного элементом <fieldset> -->
    <xsl:template mode="container" match="properties[parent::node()/@element = 'fieldset']">
        <xsl:next-match/> <!-- использование базового шаблона обработки свойств контейнера -->
        <legend>
            <xsl:value-of select="property[@name = 'title']/@value"/>
        </legend>
    </xsl:template>
    
    <!-- Базовый шаблон обработки свойств контейнера (независимо от элемента которым представлен контейнер) -->
    <xsl:template mode="container" match="properties">
        <xsl:apply-templates mode="#current" />
    </xsl:template>
    <!-- Обработка атрибута [id] (обязательный для любого контейнера) -->
    <xsl:template mode="container" match="property[@name = 'id']">
        <xsl:attribute name="{@name}" select="@value" />
    </xsl:template>
    
</xsl:stylesheet>