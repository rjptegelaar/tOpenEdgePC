<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  exclude-result-prefixes="xsl">

	<xsl:variable name="deps" select="document('../../../target/deps.xml')" />
	
	<xsl:output method="xml" encoding="utf-8" indent="yes" />

	<!-- Identity template : copy all text nodes, elements and attributes -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<!-- When matching DataSeriesBodyType: do nothing -->
	<xsl:template match="IMPORTS">
		<IMPORTS>
			<xsl:apply-templates select="$deps/list/dep" />
		</IMPORTS>
	</xsl:template>

	<xsl:template match="dep">		
		<IMPORT>			
			<xsl:variable name="groupid" select="substring-before (text(), ':')"/>
			<xsl:variable name="artifactid" select="substring-before(substring-after (text(), ':'),':')"/>
			<xsl:variable name="extension" select="substring-before(substring-after(substring-after (text(), ':'),':'),':')"/>
			<xsl:variable name="version" select="substring-after(substring-after(substring-after(text(),':'),':'),':')"/>
			<xsl:attribute name="NAME"><xsl:value-of select="concat($artifactid,'-',$version)"/></xsl:attribute>
			<xsl:attribute name="MODULE"><xsl:value-of select="concat($artifactid,'-',$version,'.',$extension)"/></xsl:attribute>
			<xsl:attribute name="REQUIRED"><xsl:text>true</xsl:text></xsl:attribute>						
		</IMPORT>
	</xsl:template>

</xsl:stylesheet>