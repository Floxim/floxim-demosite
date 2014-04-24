<div
    fx:template="featured_list"
    fx:name="Featured List"
    fx:of="page.list"
    fx:size="low,wide"
    data-four_items="{%four_items type='bool' label='Four items'}0{/%}"
    class="featured-list  {if $four_items}four-items{/if}">
    <?$pic = $template_dir.'/img/ship.jpg';?>
    <a
        fx:each="$items"
        href="{$url}#{/$}"
        class="featured-list-item">
        <img 
            fx:if="$item.has_field('image')" 
            class="own_pic"
            src="{$image | 'width:300,height:200'}<?=$pic?>{/$}" />
        <img 
            fx:elseif="$item.has_field('photo')" 
            class="own_pic"
            src="{$photo | 'width:300,height:200'}<?=$pic?>{/$}" />
        <img
            fx:else
            class="tpl_pic"
            src="{%image_$id | 'width:300,height:200'}<?=$pic?>{/%}" />
        
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