<ul
    fx:template="side_menu"
    fx:name="Side menu"
    fx:of="page.list"
    data-unstylized="{%unstylized type='bool' label='Unstylize'}0{/%}"
    class="side-menu {if $unstylized}unstylized{/if}">
    <li
        fx:each="$items"
        class="side-menu-item {if $is_active}active{/if}">
        <a href="{$url}">{$name}</a>
    </li>
    <div style="clear:both;"></div>
</ul>