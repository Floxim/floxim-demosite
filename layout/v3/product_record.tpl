<div
        fx:template="product_record"
        fx:name="Product Record"
        fx:of="product.record"
        fx:omit="true">
    <div
        fx:with="$item"
        class="product-record">
        <div class="image">
            <div class="slide active">
                <img src="{$image|'crop:middle,height:360,width:735'}<?=$template_dir?>/img/ship.jpg{/$}">
            </div>
        </div>
        <div class="short-desc">
            <div class="text">
                {$short_description}<p>Description</p>{/$}
            </div>
            <div class="extra price">{$price} {%product_currency}${/%}</div>
            <div style="clear: both;"></div>
        </div>
        <div style="clear:both;"></div>
        <div class="desc">
            {$description}
        </div>
    </div>
</div>