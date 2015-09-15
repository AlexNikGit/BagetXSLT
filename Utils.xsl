<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
    
    <!-- Шаблон обработки для всех элементов по-умолчанию.
         Применяется если шаблон для элементы не определены ни при в основном, ни в импортируемых/включаемых XSL.
         Данный шаблон необходимо импортировать самым первым для того чтобы он не переопределял импортируемые -->
    <xsl:template mode="#all" match="@* | node()" />
    
    <!--<!-\- Лишние/ошибочные блоки входного XML копируются в выходной документ -\->
    <xsl:template mode="#all" match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>-->
    
</xsl:stylesheet>