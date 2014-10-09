<div
    fx:template="banner"
    fx:name="Simple banner"
    fx:of="page:list"
    fx:size="high,wide">
    <div
        fx:item
        class="banner">
        <img src="{$%banner_image|'crop:middle,width:1160,min-height:350'}img/ship.jpg{/%}">
        <div class="caption">
            <div class="h2">
                {%banner_header_$id type="html"}<p>{$name /}</p>{/%}
            </div>
            <div class="text">
                <div>
                    {%banner_text_$id}
                    <p>This is <strong>text</strong></p>
                    {/%}
                </div>
                <a class="go" href="{$url}"></a>
            </div>
        </div>
    </div>
</div>