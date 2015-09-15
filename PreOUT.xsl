<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:jts="http://jntsys.net/"
    xpath-default-namespace="http://jntsys.net/">
    
    <xsl:namespace-alias stylesheet-prefix="jts" result-prefix="xsl"/>
    <xsl:output method="xml" encoding="utf-8" indent="yes"/>
    
    <xsl:template mode="#all" match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="/">
        <xsl:result-document method="xml"
            include-content-type="no"
            href="{concat('Serialize', '.xsl')}">
            
            <jts:stylesheet xpath-default-namespace="http://jntsys.net/" version="2.0">
                <jts:template match="/">
                    <xsl:copy>
                        <xsl:copy-of select="." />
                    </xsl:copy>
                </jts:template>
            </jts:stylesheet>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>