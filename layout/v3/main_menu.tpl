<div
        fx:template="main_menu"
        fx:name="Main menu"
        fx:of="section.list"
        fx:omit="true">
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
</div>