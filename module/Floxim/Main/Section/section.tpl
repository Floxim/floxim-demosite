<nav 
    fx:template="list" 
    fx:name="Standard menu"
    fx:of="section:list"
    class="std_menu">
    <ul>
        <li fx:item {if $is_active}class="active"{/if}>
            <a href="{$url}"><span>{$name}</span></a>
        </li>
    </ul>
</nav>