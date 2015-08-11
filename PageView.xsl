<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:namespace-alias stylesheet-prefix="#default" result-prefix="xsl"/>

    <!-- параметр [indent] элемента [xsl:output] определяет, должен ли процессор
         добавлять пробельные символы для более наглядного форматирования выходного документа -->
    <xsl:output method="xml" indent="yes"/>      
    
    <xsl:variable name="xxx" select=" 'xsl/myFile.xsl' "/>
    
    <xsl:template match="/">
        <stylesheet version="2.0">
            <include>
                <xsl:attribute name="href">
                    <xsl:value-of select="$xxx" />
                </xsl:attribute>
            </include>
            
            <template match="/">

            </template>

        </stylesheet>
        
    </xsl:template>
</xsl:stylesheet>