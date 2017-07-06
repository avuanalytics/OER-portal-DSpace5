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

    <xsl:template match="dri:document">

        <xsl:choose>
            <xsl:when test="not($isModal)">


            <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;
            </xsl:text>
                <xsl:text disable-output-escaping="yes">&lt;!--[if lt IE 7]&gt; &lt;html class=&quot;no-js lt-ie9 lt-ie8 lt-ie7&quot; lang=&quot;en&quot;&gt; &lt;![endif]--&gt;
            &lt;!--[if IE 7]&gt;    &lt;html class=&quot;no-js lt-ie9 lt-ie8&quot; lang=&quot;en&quot;&gt; &lt;![endif]--&gt;
            &lt;!--[if IE 8]&gt;    &lt;html class=&quot;no-js lt-ie9&quot; lang=&quot;en&quot;&gt; &lt;![endif]--&gt;
            &lt;!--[if gt IE 8]&gt;&lt;!--&gt; &lt;html class=&quot;no-js&quot; lang=&quot;en&quot;&gt; &lt;!--&lt;![endif]--&gt;
            </xsl:text>

                <!-- First of all, build the HTML head element -->

                <xsl:call-template name="buildHead"/>

                <!-- Then proceed to the body -->
                <body>
                    <!-- Prompt IE 6 users to install Chrome Frame. Remove this if you support IE 6.
                   chromium.org/developers/how-tos/chrome-frame-getting-started -->
                    <!--[if lt IE 7]><p class=chromeframe>Your browser is <em>ancient!</em> <a href="http://browsehappy.com/">Upgrade to a different browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to experience this site.</p><![endif]-->
                    <xsl:choose>
                        <xsl:when
                                test="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='framing'][@qualifier='popup']">
                            <xsl:apply-templates select="dri:body/*"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="buildHeader"/>
                            <xsl:call-template name="buildTrail"/>
                            <!--javascript-disabled warning, will be invisible if javascript is enabled-->
                            <div id="no-js-warning-wrapper" class="hidden">
                                <div id="no-js-warning">
                                    <div class="notice failure">
                                        <xsl:text>JavaScript is disabled for your browser. Some features of this site may not work without it.</xsl:text>
                                    </div>
                                </div>
                            </div>

                            <div id="main-container" class="container">
                                <xsl:call-template name="addBannerImage"/>

                                <div class="row row-offcanvas row-offcanvas-right">
                                    <div class="horizontal-slider clearfix">
                                        <div class="col-xs-12 col-sm-12 col-md-9 main-content">
                                            <xsl:call-template name="homepage-content"/>
                                            <xsl:apply-templates select="*[not(self::dri:options)]"/>
                                        </div>

                                        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar" role="navigation">
                                            <xsl:apply-templates select="dri:options"/>
                                        </div>

                                    </div>
                                </div>

                                <!--
                            The footer div, dropping whatever extra information is needed on the page. It will
                            most likely be something similar in structure to the currently given example. -->
                            </div>
                                    <xsl:call-template name="buildFooter"/>


                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- Javascript at the bottom for fast page loading -->
                    <xsl:call-template name="addJavascript"/>
                </body>
                <xsl:text disable-output-escaping="yes">&lt;/html&gt;</xsl:text>

            </xsl:when>
            <xsl:otherwise>
                <!-- This is only a starting point. If you want to use this feature you need to implement
                JavaScript code and a XSLT template by yourself. Currently this is used for the DSpace Value Lookup -->
                <xsl:apply-templates select="dri:body" mode="modal"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template name="buildHeader">

        <header>
            <div class="navbar navbar-static-top" role="navigation">
                    <div class="navbar-top-bar row">
                        <div class="container">
                        <div class="col-sm-6 hidden-xs">
                            <ul class="list-inline">
                                <li>
                                    <a target="_blank" href="http://oer.avu.org">OER@AVU</a>
                                </li>
                                <li>
                                    <a target="_blank" href="http://www.avu.org/virtualclassroom/">MyAVU Virtual
                                        classroom
                                    </a>
                                </li>
                            </ul>
                        </div>

                        <div class="col-sm-3 hidden-xs">
                            <div class="dropdown">
                                <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">AVU Portals
                                    <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a target="_blank" href="http://oer.avu.org">OER@AVU</a>
                                    </li>
                                    <li>
                                        <a target="_blank" href="http://www.avu.org/virtualclassroom/">AVU Virtual
                                            Classroom
                                        </a>
                                    </li>
                                    <li>
                                        <a href="http://conference.avu.org/index.php/avuconference2016/3rdconference2016">
                                            Conference
                                        </a>
                                    </li>
                                    <li>
                                        <a href="http://journal.avu.org/index.php/JRODeL">Journal</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <ul class="pull-left">
                                <xsl:call-template name="languageSelection"/>
                            </ul>
                            <ul class="list-inline pull-right">
                                <xsl:choose>
                                    <xsl:when test="/dri:document/dri:meta/dri:userMeta/@authenticated = 'yes'">
                                        <li class="dropdown">
                                            <a id="user-dropdown-toggle" href="#" role="button" class="dropdown-toggle"
                                               data-toggle="dropdown">
                                                <span>
                                                    <xsl:value-of select="/dri:document/dri:meta/dri:userMeta/
                            dri:metadata[@element='identifier' and @qualifier='firstName']"/>
                                                    <xsl:text> </xsl:text>
                                                    <xsl:value-of select="/dri:document/dri:meta/dri:userMeta/
                            dri:metadata[@element='identifier' and @qualifier='lastName']"/>
                                                    &#160;
                                                    <b class="caret"/>
                                                </span>
                                            </a>
                                            <ul class="dropdown-menu pull-right" role="menu"
                                                aria-labelledby="user-dropdown-toggle" data-no-collapse="true">
                                                <li>
                                                    <a href="{/dri:document/dri:meta/dri:userMeta/
                            dri:metadata[@element='identifier' and @qualifier='url']}">
                                                        <i18n:text>xmlui.EPerson.Navigation.profile</i18n:text>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="{/dri:document/dri:meta/dri:userMeta/
                            dri:metadata[@element='identifier' and @qualifier='logoutURL']}">
                                                        <i18n:text>xmlui.dri2xhtml.structural.logout</i18n:text>
                                                    </a>
                                                </li>
                                            </ul>
                                        </li>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <li>
                                            <a href="{/dri:document/dri:meta/dri:userMeta/
                            dri:metadata[@element='identifier' and @qualifier='loginURL']}">
                                                <span>
                                                    <i18n:text>xmlui.dri2xhtml.structural.login</i18n:text>
                                                </span>
                                            </a>
                                        </li>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </ul>


                        </div>
                        </div>

                    </div>
                    <div class="row navbar-mid-bar">
                        <div class="container">
                    <div class="navbar-header col-sm-8">


                        <a href="{$context-path}/" class="navbar-brand">
                            <img src="{$theme-path}/images/new_logo.png"/>
                        </a>


                        <div class="navbar-header pull-right visible-xs hidden-sm hidden-md hidden-lg">
                            <ul class="nav nav-pills pull-left ">

                                <xsl:if test="count(/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='page'][@qualifier='supportedLocale']) &gt; 1">
                                    <li id="ds-language-selection-xs" class="dropdown">
                                        <xsl:variable name="active-locale"
                                                      select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='page'][@qualifier='currentLocale']"/>
                                        <button id="language-dropdown-toggle-xs" href="#" role="button"
                                                class="dropdown-toggle navbar-toggle navbar-link"
                                                data-toggle="dropdown">
                                            <b class="visible-xs glyphicon glyphicon-globe" aria-hidden="true"/>
                                        </button>
                                        <ul class="dropdown-menu pull-right" role="menu"
                                            aria-labelledby="language-dropdown-toggle-xs" data-no-collapse="true">
                                            <xsl:for-each
                                                    select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='page'][@qualifier='supportedLocale']">
                                                <xsl:variable name="locale" select="."/>
                                                <li role="presentation">
                                                    <xsl:if test="$locale = $active-locale">
                                                        <xsl:attribute name="class">
                                                            <xsl:text>disabled</xsl:text>
                                                        </xsl:attribute>
                                                    </xsl:if>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="$current-uri"/>
                                                            <xsl:text>?locale-attribute=</xsl:text>
                                                            <xsl:value-of select="$locale"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of
                                                                select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='supportedLocale'][@qualifier=$locale]"/>
                                                    </a>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </li>
                                </xsl:if>

                                <xsl:choose>
                                    <xsl:when test="/dri:document/dri:meta/dri:userMeta/@authenticated = 'yes'">
                                        <li class="dropdown">
                                            <button class="dropdown-toggle navbar-toggle navbar-link"
                                                    id="user-dropdown-toggle-xs" href="#" role="button"
                                                    data-toggle="dropdown">
                                                <b class="visible-xs glyphicon glyphicon-user" aria-hidden="true"/>
                                            </button>
                                            <ul class="dropdown-menu pull-right" role="menu"
                                                aria-labelledby="user-dropdown-toggle-xs" data-no-collapse="true">
                                                <li>
                                                    <a href="{/dri:document/dri:meta/dri:userMeta/
                            dri:metadata[@element='identifier' and @qualifier='url']}">
                                                        <i18n:text>xmlui.EPerson.Navigation.profile</i18n:text>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="{/dri:document/dri:meta/dri:userMeta/
                            dri:metadata[@element='identifier' and @qualifier='logoutURL']}">
                                                        <i18n:text>xmlui.dri2xhtml.structural.logout</i18n:text>
                                                    </a>
                                                </li>
                                            </ul>
                                        </li>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <li>
                                            <form style="display: inline" action="{/dri:document/dri:meta/dri:userMeta/
                            dri:metadata[@element='identifier' and @qualifier='loginURL']}" method="get">
                                                <button class="navbar-toggle navbar-link">
                                                    <b class="visible-xs glyphicon glyphicon-user" aria-hidden="true"/>
                                                </button>
                                            </form>
                                        </li>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </ul>
                        </div>
                    </div>

                    <div class="col-sm-4 navbar-header pull-right hidden-xs">
                        <div id="ds-search-option" class="ds-option-set">
                            <!-- The form, complete with a text box and a button, all built from attributes referenced
                         from under pageMeta. -->
                            <form id="ds-search-form" class="" method="post">
                                <xsl:attribute name="action">
                                    <xsl:value-of
                                            select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='contextPath']"/>
                                    <xsl:value-of
                                            select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='search'][@qualifier='simpleURL']"/>
                                </xsl:attribute>
                                <fieldset>
                                    <div class="input-group">
                                        <input class="ds-text-field form-control" type="text"
                                               placeholder="xmlui.general.search"
                                               i18n:attr="placeholder">
                                            <xsl:attribute name="name">
                                                <xsl:value-of
                                                        select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='search'][@qualifier='queryField']"/>
                                            </xsl:attribute>
                                        </input>
                                        <span class="input-group-btn">
                                            <button class="ds-button-field btn btn-primary" title="xmlui.general.go"
                                                    i18n:attr="title">
                                                <span class="glyphicon glyphicon-search" aria-hidden="true"/>
                                                <xsl:attribute name="onclick">
                                                    <xsl:text>
                                                        var radio = document.getElementById(&quot;ds-search-form-scope-container&quot;);
                                                        if (radio != undefined &amp;&amp; radio.checked)
                                                        {
                                                        var form = document.getElementById(&quot;ds-search-form&quot;);
                                                        form.action=
                                                    </xsl:text>
                                                    <xsl:text>&quot;</xsl:text>
                                                    <xsl:value-of
                                                            select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='contextPath']"/>
                                                    <xsl:text>/handle/&quot; + radio.value + &quot;</xsl:text>
                                                    <xsl:value-of
                                                            select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='search'][@qualifier='simpleURL']"/>
                                                    <xsl:text>&quot; ; </xsl:text>
                                                    <xsl:text>
                                                        }
                                                    </xsl:text>
                                                </xsl:attribute>
                                            </button>
                                        </span>
                                    </div>

                                </fieldset>
                            </form>
                        </div>


                    </div>
                    </div>
                    </div>

                    <div class="row navbar-bottom-bar">
                        <div class="container">

                        <ul class="nav navbar-nav hidden-xs">
                            <li>
                                <a href="{$context-path}/">OER@AVU home</a>
                            </li>
                            <li>
                                <a href="{$context-path}/community-list">Resources</a>
                            </li>
                            <li>
                                <a href="{$context-path}/contact">Contact</a>
                            </li>
                            <li>
                                <a href="{$context-path}/feedback">Feedback</a>
                            </li>
                        </ul>

                            <a href="{$context-path}/discover" class="visible-xs">
                                <button class="ds-button-field ds-search-button-mobile btn btn-primary" title="xmlui.general.go"
                                        i18n:attr="title">
                                    <span class="glyphicon glyphicon-search" aria-hidden="true"/>
                                </button>

                            </a>

                            <button type="button" class="navbar-toggle visible-xs visible-sm" data-toggle="offcanvas">
                                <span class="sr-only">
                                    <i18n:text>xmlui.mirage2.page-structure.toggleNavigation</i18n:text>
                                </span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>

                        </div>
                    </div>
            </div>

        </header>

    </xsl:template>


    <xsl:template name="buildFooter">
        <footer>
            <div class="container">
            <div class="row image-holder">
                <!--<div class="col-sm-5 hidden-xs">-->
                    <!--<img src="{$theme-path}/images/back-design-inverted.png"/>-->
                <!--</div>-->

                <div class="col-sm-12">
                    <div class="row">
                        <xsl:if test="count(/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='feed']) != 0">
                            <div class="col-sm-3">
                                <div id="rs-feed">
                                    <h5>
                                        <i18n:text>xmlui.feed.header</i18n:text>
                                    </h5>
                                    <xsl:call-template name="addRSSLinksInFooter"/>
                                </div>
                            </div>
                        </xsl:if>
                        <div class="col-sm-3">
                            <h5>Links</h5>
                            <ul>
                                <li>
                                    <a href="http://www.avu.org/avuweb/en/news/events/">Events</a>
                                </li>
                                <li>
                                    <a href="http://www.avu.org/avuweb/en/news/videos/">Videos</a>
                                </li>
                                <li>
                                    <a href="http://www.avu.org/avuweb/en/news/photo-gallery/">Photo Gallery</a>
                                </li>
                                <li>
                                    <a href="http://www.avu.org/avuweb/reports/">Annual Reports</a>
                                </li>
                                <li>
                                    <a href="http://www.avu.org/avuweb/avu_newsletters/">Newsletters</a>
                                </li>
                                <li>
                                    <a href="http://www.avu.org/avuweb/en/news/avu-in-the-press/">AVU in the press</a>
                                </li>
                                <li>
                                    <a href="http://www.avu.org/avuweb/jobs/">Careers</a>
                                </li>
                                <li>
                                    <a href="http://www.avu.org/avuweb/tenders/">Tenders</a>
                                </li>
                            </ul>
                        </div>

                        <div class="col-sm-3">
                            <h5>Contact us</h5>
                            <ul>
                                <li>Cape Office Park (Opposite Yaya Center</li>
                                <li>Ring Road, Kilimani</li>
                                <li>
                                    PO Box 25405 - 00603
                                </li>
                                <li>
                                    Tel : +254 20 2528333
                                </li>
                                <li>
                                    Fax: +254 20 3861460
                                </li>
                                <li>
                                    Email:
                                    <a href="mailto:contact@avu.org">contact@avu.org</a>
                                </li>

                            </ul>
                        </div>
                        <div class="col-sm-3">
                            <h5>Regional office</h5>
                            <ul>
                                <li>Bureau Regional de l'Afrique de l'Ouest</li>
                                <li>
                                    Sicap Liberte VI Extension
                                </li>
                                <li>
                                    Villa No. 8 VDN, B.P. 50609
                                </li>
                                <li>
                                    Dakar, Senegal
                                </li>
                                <li>
                                    Tel: +221.33.8670324
                                </li>
                                <li>
                                    Fax + 221 33 867 35 54
                                </li>
                                <li>
                                    email: <a href="mailto:bureauregional@uva.org">bureauregional@uva.org</a>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
            <div class="subfooter">

                <div class="row">
                    <div class="col-sm-6">
                        <div class="copyright">© 2010 - 2017.&#160;&#160;African Virtual University.&#160;&#160;All Rights Reserved</div>
                    </div>
                    <div class="col-sm-6">
                        <div class="social"><a href="http://www.facebook.com/home.php#/pages/The-African-Virtual-University-AVU/296137566560"><span class="fa fa-facebook"></span></a> <a href="http://twitter.com/avu_org"><i class="fa fa-twitter"></i></a> <a href="http://www.youtube.com/user/avuorg"><i class="fa fa-youtube"></i></a></div>
                    </div>
                </div>
            </div>
            </div>


            <!--Invisible link to HTML sitemap (for search engines) -->
            <a class="hidden">
                <xsl:attribute name="href">
                    <xsl:value-of
                            select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='contextPath'][not(@qualifier)]"/>
                    <xsl:text>/htmlmap</xsl:text>
                </xsl:attribute>
                <xsl:text>&#160;</xsl:text>
            </a>
            <p>&#160;</p>
        </footer>
    </xsl:template>

    <xsl:template name="buildHead">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

            <!-- Use the .htaccess and remove these lines to avoid edge case issues.
             More info: h5bp.com/i/378 -->
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

            <!-- Mobile viewport optimized: h5bp.com/viewport -->
            <meta name="viewport" content="width=device-width,initial-scale=1"/>

            <link rel="shortcut icon">
                <xsl:attribute name="href">
                    <xsl:value-of select="$theme-path"/>
                    <xsl:text>images/favicon.png</xsl:text>
                </xsl:attribute>
            </link>
            <link rel="apple-touch-icon">
                <xsl:attribute name="href">
                    <xsl:value-of select="$theme-path"/>
                    <xsl:text>images/apple-touch-icon.png</xsl:text>
                </xsl:attribute>
            </link>

            <meta name="Generator">
                <xsl:attribute name="content">
                    <xsl:text>DSpace</xsl:text>
                    <xsl:if test="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='dspace'][@qualifier='version']">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='dspace'][@qualifier='version']"/>
                    </xsl:if>
                </xsl:attribute>
            </meta>

            <!-- Add stylesheets -->

            <!--TODO figure out a way to include these in the concat & minify-->
            <xsl:for-each select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='stylesheet']">
                <link rel="stylesheet" type="text/css">
                    <xsl:attribute name="media">
                        <xsl:value-of select="@qualifier"/>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$theme-path"/>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </link>
            </xsl:for-each>

            <link rel="stylesheet" href="{concat($theme-path, 'styles/main.css')}"/>
            <link rel='stylesheet' id='simple-job-board-google-fonts-css'  href='https://fonts.googleapis.com/css?family=Lato%3A400%2C400italic%2C700%2C700italic%2C900%2C900italic%2C300italic%2C300&#038;ver=2.3.2' media='all' />


            <!-- Add syndication feeds -->
            <xsl:for-each select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='feed']">
                <link rel="alternate" type="application">
                    <xsl:attribute name="type">
                        <xsl:text>application/</xsl:text>
                        <xsl:value-of select="@qualifier"/>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                </link>
            </xsl:for-each>

            <!--  Add OpenSearch auto-discovery link -->
            <xsl:if test="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='opensearch'][@qualifier='shortName']">
                <link rel="search" type="application/opensearchdescription+xml">
                    <xsl:attribute name="href">
                        <xsl:value-of select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='request'][@qualifier='scheme']"/>
                        <xsl:text>://</xsl:text>
                        <xsl:value-of select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='request'][@qualifier='serverName']"/>
                        <xsl:text>:</xsl:text>
                        <xsl:value-of select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='request'][@qualifier='serverPort']"/>
                        <xsl:value-of select="$context-path"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='opensearch'][@qualifier='autolink']"/>
                    </xsl:attribute>
                    <xsl:attribute name="title" >
                        <xsl:value-of select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='opensearch'][@qualifier='shortName']"/>
                    </xsl:attribute>
                </link>
            </xsl:if>

            <!-- The following javascript removes the default text of empty text areas when they are focused on or submitted -->
            <!-- There is also javascript to disable submitting a form when the 'enter' key is pressed. -->
            <script>
                //Clear default text of emty text areas on focus
                function tFocus(element)
                {
                if (element.value == '<i18n:text>xmlui.dri2xhtml.default.textarea.value</i18n:text>'){element.value='';}
                }
                //Clear default text of emty text areas on submit
                function tSubmit(form)
                {
                var defaultedElements = document.getElementsByTagName("textarea");
                for (var i=0; i != defaultedElements.length; i++){
                if (defaultedElements[i].value == '<i18n:text>xmlui.dri2xhtml.default.textarea.value</i18n:text>'){
                defaultedElements[i].value='';}}
                }
                //Disable pressing 'enter' key to submit a form (otherwise pressing 'enter' causes a submission to start over)
                function disableEnterKey(e)
                {
                var key;

                if(window.event)
                key = window.event.keyCode;     //Internet Explorer
                else
                key = e.which;     //Firefox and Netscape

                if(key == 13)  //if "Enter" pressed, then disable!
                return false;
                else
                return true;
                }
            </script>

            <xsl:text disable-output-escaping="yes">&lt;!--[if lt IE 9]&gt;
                &lt;script src="</xsl:text><xsl:value-of select="concat($theme-path, 'node_modules/html5shiv/dist/html5shiv.js')"/><xsl:text disable-output-escaping="yes">"&gt;&#160;&lt;/script&gt;
                &lt;script src="</xsl:text><xsl:value-of select="concat($theme-path, 'node_modules/respond.min.js/respond.min.js')"/><xsl:text disable-output-escaping="yes">"&gt;&#160;&lt;/script&gt;
                &lt;![endif]--&gt;</xsl:text>

            <!-- Modernizr enables HTML5 elements & feature detects -->
            <script src="{concat($theme-path, 'vendor/modernizr/modernizr.min.js')}">&#160;</script>

            <!-- Add the title in -->
            <xsl:variable name="page_title" select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='title'][last()]" />
            <title>
                <xsl:choose>
                    <xsl:when test="starts-with($request-uri, 'page/about')">
                        <i18n:text>xmlui.mirage2.page-structure.aboutThisRepository</i18n:text>
                    </xsl:when>
                    <xsl:when test="not($page_title)">
                        <xsl:text>  </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="$page_title/node()" />
                    </xsl:otherwise>
                </xsl:choose>
            </title>

            <!-- Head metadata in item pages -->
            <xsl:if test="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='xhtml_head_item']">
                <xsl:value-of select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='xhtml_head_item']"
                              disable-output-escaping="yes"/>
            </xsl:if>

            <!-- Add all Google Scholar Metadata values -->
            <xsl:for-each select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[substring(@element, 1, 9) = 'citation_']">
                <meta name="{@element}" content="{.}"></meta>
            </xsl:for-each>

            <!-- Add MathJAX JS library to render scientific formulas-->
            <xsl:if test="confman:getProperty('webui.browse.render-scientific-formulas') = 'true'">
                <script type="text/x-mathjax-config">
                    MathJax.Hub.Config({
                    tex2jax: {
                    inlineMath: [['$','$'], ['\\(','\\)']],
                    ignoreClass: "detail-field-data|detailtable|exception"
                    },
                    TeX: {
                    Macros: {
                    AA: '{\\mathring A}'
                    }
                    }
                    });
                </script>
                <script type="text/javascript" src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">&#160;</script>
            </xsl:if>

        </head>
    </xsl:template>

    <xsl:template name="addBannerImage">
        <div class="main-content-banner row hidden-xs">
            <img src="{$theme-path}/images/AVU -WEB BANNER 01-04.png" class="col-xs-12"/>
        </div>
    </xsl:template>

    <!-- Add each RSS feed from meta to a list -->
    <xsl:template name="addRSSLinksInFooter">
        <ul>

            <xsl:for-each select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='feed']">
                <li>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="."/>
                        </xsl:attribute>

                        <img src="{concat($context-path, '/static/icons/feed.png')}" class="btn-xs"
                             alt="xmlui.mirage2.navigation.rss.feed" i18n:attr="alt"/>

                        <xsl:choose>
                            <xsl:when test="contains(., 'rss_1.0')">
                                <xsl:text>RSS 1.0</xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(., 'rss_2.0')">
                                <xsl:text>RSS 2.0</xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(., 'atom_1.0')">
                                <xsl:text>Atom</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="@qualifier"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </a>

                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>


</xsl:stylesheet>