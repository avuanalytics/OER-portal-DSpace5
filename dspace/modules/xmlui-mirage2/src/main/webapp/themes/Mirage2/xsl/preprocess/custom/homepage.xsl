<!--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

-->

<!--
    Main structure of the page, determines where
    header, footer, body, navigation are structurally rendered.
    Rendering of the header, footer, trail and alerts

    Author: art.lowel at atmire.com
    Author: lieven.droogmans at atmire.com
    Author: ben at atmire.com
    Author: Alexey Maslov

-->

<xsl:stylesheet xmlns="http://di.tamu.edu/DRI/1.0/"
                xmlns:dri="http://di.tamu.edu/DRI/1.0/"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
                exclude-result-prefixes="xsl dri i18n">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:template match="//dri:div[@id='aspect.artifactbrowser.CommunityBrowser.div.comunity-browser']">
        <div>
        <xsl:call-template name="copy-attributes"/>
            <xsl:if test="//dri:pageMeta/dri:metadata[@element='request' and @qualifier='URI']=''">
                <xsl:attribute name="rend">
                    <xsl:text>homepage</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>


</xsl:stylesheet>