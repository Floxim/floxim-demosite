<div
    fx:template="featured_news_list"
    fx:name="Featured News List"
    fx:of="publication.list"
    fx:size="low,wide"
    class="featuared-news-list"
    data-show_more="{%show_more label='show more link?' type='bool'}"
    data-show_anounce="{%show_anounce label='show anounce?' type='bool'}">
    <div
        fx:each="$items"
        class="featuared-news-list-item">
        <a href="{$url}" fx:if="$image"><img src="{$image | 'width:300,height:200'}"></a>
        <a href="{$url}" class="title">{$name}</a>
        <div class="date">{$publish_date | 'Y.m.d'}</div>
        <div fx:if="$show_anounce" class="text">
            {$anounce}
        </div>
    </div>
    <div style="clear:both;"></div>
    <a fx:if="$show_more" href="{%more_news_url label="More link"}#{/%}" class="more">{%more_news}more news{/%}</a>
    <div style="clear:both;"></div>
</div>