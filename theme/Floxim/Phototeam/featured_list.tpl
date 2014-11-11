<div
    fx:template="featured_list"
    fx:name="Featured List"
    fx:of="page:list"
    fx:size="low,wide"
    data-four_items="{%four_items type='bool' label='Four items'}0{/%}"
    class="featured-list  {if $four_items && count($items) > 3}four-items{/if}">
    <a
        fx:each="$items"
        href="{$url}#{/$}"
        class="featured-list-item">
            <img 
                class="tpl_pic" 
                src="{$item.%photo | '300*200'}
                        {$item.%image}img/ship.jpg{/$}
                    {/$}">
        
        <div class="caption">
            <div class="h3">
                <p>{$name}</p>
            </div>
            <div fx:if="$price" class="price">{$price} {$currency}${/$}</div>
            <div style="clear:both;"></div>
        </div>
    </a>
    <div style="clear:both;"></div>
</div>