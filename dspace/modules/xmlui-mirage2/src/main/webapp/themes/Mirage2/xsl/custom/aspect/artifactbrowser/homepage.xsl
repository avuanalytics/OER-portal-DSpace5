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

<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
                xmlns:dri="http://di.tamu.edu/DRI/1.0/"
                xmlns:mets="http://www.loc.gov/METS/"
                xmlns:xlink="http://www.w3.org/TR/xlink/"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:mods="http://www.loc.gov/mods/v3"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:confman="org.dspace.core.ConfigurationManager"
                exclude-result-prefixes="i18n dri mets xlink xsl dim xhtml mods dc confman">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>


    <xsl:template name="homepage-content">
        <xsl:if test="//dri:pageMeta/dri:metadata[@element='request' and @qualifier='URI']=''">
            <xsl:call-template name="homepage-squares"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="homepage-squares">
        <div class="homepage-content">

                    <div class="homepage-block">
                    <h3>
                        <i18n:text>xmlui.homepage-block.resources.header</i18n:text>
                    </h3>
                    <div class="homepage-block-content">
                        <xsl:apply-templates select="//dri:div[@rend='community-browser-wrapper']"/>
                    </div>
                    </div>

                    <div class="homepage-block">

                    <h3>
                        <i18n:text>xmlui.homepage-block.news.header</i18n:text>
                    </h3>
                    <div class="homepage-block-content">
                        <i18n:text>xmlui.homepage-block.news.content</i18n:text>
                    </div>
                </div>

                    <div class="homepage-block">

                    <h3>
                        <i18n:text>xmlui.homepage-block.about.header</i18n:text>
                    </h3>
                    <div class="homepage-block-content">
                        <i18n:text>xmlui.homepage-block.about.content</i18n:text>
                    </div>
                </div>

                    <div class="homepage-block">

                    <h3>
                        <i18n:text>xmlui.homepage-block.partners.header</i18n:text>
                    </h3>
                    <div class="homepage-block-content">
                        <i18n:text>xmlui.homepage-block.partners.content</i18n:text>
                    </div>
                </div>
            </div>
    </xsl:template>
    
    <xsl:template match="//dri:div[@id='aspect.discovery.SiteRecentSubmissions.div.site-recent-submission']/dri:head">
        <h3><i18n:text><xsl:value-of select="."/></i18n:text></h3>
    </xsl:template>

    <xsl:template match="//dri:div[@id='aspect.artifactbrowser.CommunityBrowser.div.comunity-browser' and @rend='homepage']"/>
    <xsl:template match="//dri:div[@id='file.news.div.news']"/>


</xsl:stylesheet>