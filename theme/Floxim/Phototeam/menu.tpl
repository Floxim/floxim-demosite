<nav
        fx:template="main_menu"
        fx:name="Main menu"
        fx:size="low,wide"
        fx:of="section:list">
    <div class="menu-icon"></div>
    <ul class="main-menu">
        <div class="close"></div>
        <li
            fx:each="$items"
            class="main-menu-item {if $submenu} dropdown{/if} {if $is_active}current{/if}">
            <a href="{$url}">
                {$name}
                {if $submenu}<div class="more">+</div>{/if}
            </a>
            <div
                fx:with-each="$submenu"
                class="width-helper">
                <ul class="sub-menu">
                    <li
                        fx:item
                        class="sub-menu-item {if $is_active} active {/if}">
                        <a href="{$url}">{$name}</a>
                    </li>
                </ul>
            </div>
        </li>
    </ul>
</nav>
                    
<ul
    fx:template="side_menu"
    fx:name="Side menu"
    fx:of="page:list"
    fx:size="narrow,high"
    {*data-unstylized="{%unstylized type='bool' label='Unstylize'}0{/%}"*}
    class="side-menu {*{if $unstylized}unstylized{/if}*}"
    >
    <li
        fx:each="$items"
        class="side-menu-item {if $is_active}active{/if}">
        <a href="{$url}">{$name}</a>
    </li>
    <div style="clear:both;"></div>
</ul>
    
<div
    fx:template="full_screen_menu"
    fx:name="Full screen menu" 
    fx:of="page:list"
    fx:size="wide,high"
    {set $ai = $items.findOne('is_active', true)}
    {if !$ai}
        {set $ai = $items.first()}
    {/if}
    {set $cid = fx::env('page_id')}
    style="background-image: url('{%bg_$cid | 'max-width:1200'}{$ai.image}{$ai.photo}img/ship.jpg{/$}{/$}{/%}');"
    class="full-back">

    <div class="caption">
        <div class="h2">
            {%header_$cid}
            <p>{$ai.name}Place header here{/$}</p>
            {/%}
        </div>
        <div class="text">
            <div>{%caption_$cid type="html"}{$ai.short_description}<p>This writing is on</p>{/$}{/%}</div>
            <a fx:if="$ai" class="go" href="{$ai.url}#content"></a>
        </div>
    </div>
    
    <ul fx:if="count($items) > 1" class="side-menu">
        <li
            fx:each="$items"
            class="side-menu-item {if $is_active}active{/if}">
            <a href="{$url}">{$name}</a>
        </li>
    </ul>
    <a name="content" class="content_anchor"></a>
</div>