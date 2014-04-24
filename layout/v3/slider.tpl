<div
    fx:template="slider"
    fx:name="Simple slider"
    fx:of="photo.list"
    fx:size="high,wide"
    data-thumbnails="{%thumbnails type='bool' label='Show thumnails'}0{/%}"
    class="slider-wrapper">
    <div  class="slider">
        <div fx:each="$items" class="slide {if $is_first}active{/$}">
            <img src="{$photo|'width:990px,height:360'}<?=$template_dir?>img/ship.jpg{/$}">
        </div>
        {if count($items)>1}
            <a class="arrow"></a>
            <a class="arrow right"></a>
        {/if}
    </div>
    <div style="clear:both;"></div>
    {if $thumbnails}
        <div class="featured-photo-list">
            <div fx:each="$items" class="featured-photo-list-item">
                <img src="{$photo|'width:385px,height:240'}<?=$template_dir?>img/ship.jpg{/$}">
            </div>
        </div>
    {/if}
</div>