<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:jts="http://jntsys.net/"
    xpath-default-namespace="http://jntsys.net/" >
    
    <xsl:function name="jts:getIterValue">
        <xsl:param name="numIter" as="xs:integer"/>
        <xsl:param name="content" as="xs:string"/>
        
        <!-- Добавить обработку пустого содержимого -->
        <xsl:variable name="content_array" select="jts:array($content)"/>
        
        <xsl:sequence select="if( count( $content_array ) = 1 )
            then $content_array
            else $content_array[ $numIter ]" />
        
    </xsl:function>
    
    <!-- Формат массива: [ x, x, ...] для дальнейшей совместимости с array в XPath 3.1 -->
    <xsl:function name="jts:array">
        <xsl:param name="input" as="xs:string"/>
        
        <!-- убираем лишние пробелы вначале и в конце строки -->
        <xsl:variable name="in_str" as="xs:string" select="normalize-space( $input )" />
        <!-- проверка входящей строки на соответствие формату конструктора массива
             (начало и конец - квадратные скобки, разделитель - запятая) и
             конструирование массива из строки соответствующего формата -->
        <xsl:sequence select="if(     starts-with( $in_str, '[')
            and ends-with($in_str, ']')
            and contains($in_str, ',') )
            then tokenize( substring-before( substring-after($in_str, '[' ), ']' ), ',\s*' )
            else $in_str" />
    </xsl:function>
</xsl:stylesheet>