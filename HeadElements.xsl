<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://jntsys.net/">
    
    <!-- Любой элемент внутри PageDescription может стать компонентом заголовка если для него
         определён соответствующий шаблон обработки в режиме head -->
    <xsl:template match="PageDescription">
        <xsl:apply-templates mode="head"/>
    </xsl:template>
    
    <xsl:template mode="head" match="properties" >
        <title>
            <xsl:value-of select="property[@name = 'title']/@value"/>
        </title>
    </xsl:template>
</xsl:stylesheet>