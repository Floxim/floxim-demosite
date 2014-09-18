<!DOCTYPE html>
<html>
<head>
    <meta fx:layout="two_columns" fx:name="Two columns" content="two_columns" />
    <meta fx:layout="one_column" fx:name="One column" content="one_column" />
    <meta fx:layout="full_width" fx:name="Full width" content="full_width" />
    <meta fx:layout="index" fx:name="Index page" content="index" />
    {js}
        FX_JQUERY_PATH
        js/script.js
        js/slider.js
    {/js}

    {css}
        http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900&subset=latin,cyrillic
        css/styles.less
    {/css}
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <div class="wrapper">
        <header class="fixed fx_top_fixed">
            <div class="holder">
                <a href="/" class="logo">
                    {if $logo}
                        <img src="{%logo | 'max-height:40'}">
                    {else}
                        <span data-logo="{%logo type="image"}">{%logo_name}Logo{/%}</span>
                    {/if}
                </a>
                <div
                    fx:area="top_nav"
                    fx:size="wide,low"
                    class="main-menu-area">
                </div>
                <div class="main-icons-area">
                    <ul 
                        class="icons" 
                        fx:area="icons_area" 
                        fx:area-render="manual" fx:size="narrow,low">
                        <li 
                            fx:each="$area_infoblocks as $infoblock" 
                            class="icon {$controller}_{$action} {if $infoblock.is_hidden()}fx_infoblock_hidden{/if}">
                            <a class="block_toggler"></a>
                            <div class="width-helper">
                                {$infoblock.render()}
                                <div class="form auth_form" fx:template="auth_form" fx:of="user.auth_form">
                                    {apply helper_form.form with $form}
                                        <div class="input-group {$name}" fx:each="$fields">
                                            {apply helper_form.label  /}
                                            {apply helper_form.input /}
                                            {apply helper_form.errors /}
                                        </div>
                                    {/apply}
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <a class="phone">{%phone}8 (800) 123 12 45{/%}</a>
            </div>
        </header>
        <section fx:if="!$index && !$full_width">
            <div class="holder">
                    <div
                        fx:area="pre_content"
                        fx:size="wide,low"
                        class="breadcrumbs-area">
                    </div>
            </div>
        </section>
        <section fx:template="two_columns_grid" fx:of="widget_grid.two_columns" fx:with-each="$areas" class="two-column">
            <div fx:item="$keyword == 'sidebar'" class="left-column" fx:area="$id" fx:area-name="$name">

            </div>
            <div fx:item="$keyword == 'content'" class="main-column" fx:area="$id" fx:area-name="$name">

            </div>
        </section>
        <section 
            class="
                {if $full_width}full-width{/if}
                {if $two_columns}two-column{/if}">
            <div class="holder" fx:omit="$full_width">
                <div
                    fx:if="$two_columns"
                    fx:area="left_column"
                    fx:size="narrow,high"
                    class="left-column">
                </div>
                <div
                    fx:area="main_column"
                    fx:size="wide,high"
                    class="main-column">
                    <div
                        fx:template="full_width_banner"
                        fx:name="Full width banner"
                        fx:of="page.list"
                        fx:size="high,wide"
                        style="background-image: url({$image});"
                        class="full-back">
                        <div class="caption">
                            <h2>
                                {%header}<p>Header</p>{/%}
                                <div style="clear:both;"></div>
                            </h2>
                            <div fx:if="$text" class="text">
                                {$text}
                                <a fx:if="$url" class="go" href="{$url}">Go</a>
                            </div>
                        </div>
                    </div>
                    <div fx:template="block_titled" fx:of="wrapper" class="left-titled-block">
                        <h2>{%header}Block Header{/%}</h2>
                        <div class="content">
                            {$content}
                        </div>
                        <div style="clear: both;"></div>
                    </div>
                </div>
            </div>
        </section>
        <section fx:template="gray_block" fx:of="wrapper" class="titled_wrapper gray">
            <h2>{%header}Block Header{/%}</h2>
            <div class="main-column">{$content}</div>
            <div style="clear: both;"></div>
        </section>
        <section fx:template="titled_block" fx:of="wrapper" class="titled_wrapper">
            <h2>{%header}Block Header{/%}</h2>
            <div class="main-column">{$content}</div>
            <div style="clear: both;"></div>
        </section>
        <footer>
            <div class="holder">
                <div class="top-block">
                    <div
                        fx:area="footer_menu"
                        fx:size="wide,low"
                        class="footer-menu-area">
                        <ul
                            fx:template="footer_menu"
                            fx:name="Footer menu"
                            fx:of="section.list"
                            class="footer-menu">
                            <li fx:each="$items" class="footer-menu-item"><a href="{$url}">{$name}</a></li>
                            <div style="clear:both;"></div>
                        </ul>
                    </div>
                    <a class="email">{%email}floxim@floxim.loc{/%}</a>
                    <a class="phone">{%phone}8 (800) 192 16 81{/%}</a>
                    <div style="clear:both;"></div>
                    <div
                        class="footer-social-area">
                        <ul
                            fx:template="social_icons"
                            fx:name="Footer social icons"
                            fx:of="social_icon.list"
                            class="social-icons-list">
                            <h3 class="follow">Follow us</h3>
                            <li fx:each="$items" class="social-icons-list-item {$soc_type}"><a href="{$url}"></a></li>
                            <div style="clear:both;"></div>
                        </ul>
                        <div style="clear:both;"></div>
                    </div>
                </div>
                <div class="bottom-block">
                    <a class="copyright">{%copyright}© 2014 floxim inc.{/%}</a>
                </div>
            </div>
        </footer>
    </div>
</body>
</html>