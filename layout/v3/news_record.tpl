<div
    fx:template="news_record"
    fx:name="News Record"
    fx:of="news.record"
    fx:with="$item"
    class="news-record">
    <div class="image">
        <div class="slide active">
            <img src="{$image|'crop:middle,height:360,width:735'}<?=$template_dir?>/img/ship.jpg{/$}">
        </div>
    </div>
    <div class="short-desc">
        <div class="text">{$anounce}</div>
        <div class="extra">{$publish_date | 'Y-m-d'}</div>
    </div>
    <div style="clear:both;"></div>
    <div class="desc">{$text}</div>
</div>