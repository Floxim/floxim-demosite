<div
    fx:template="banner"
    fx:name="Simple banner"
    fx:of="page:list"
    fx:size="high,wide">
    <div
        fx:item
        class="banner">
        <img src="{$%banner_image|'crop:middle,width:1160,min-height:350,max-height:500'}{$.image}img/ship.jpg{/$}{/%}">
        <div class="caption">
            <div class="h2">
                {$%banner_header type="html"}<p fx:if="$name">{$name /}</p>{/%}
            </div>
            <div class="text">
                <div>
                    {$%banner_text}
                        <p>This is <strong>text</strong></p>
                    {/%}
                </div>
                <a class="go" href="{$url}"></a>
            </div>
        </div>
    </div>
</div>