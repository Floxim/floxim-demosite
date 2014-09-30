<div
    fx:template="news_list"
    fx:name="News List"
    fx:of="publication:list"
    fx:size="high,wide"
    class="news-list">
    <div
        fx:each="{$items->group('publish_date | fx::date : "F Y"') as $month => $news}"
        class="month-container">
        <div class="month">{$month}</div>
        <div fx:each="$news" class="news-list-item">
            <a href="{$url}">{$name}</a>
            <span class="date">{$publish_date | 'Y-m-d'}</span>
        </div>
    </div>
</div>
        
<div 
    fx:template="news_mixed" 
    fx:name="News list mixed" 
    fx:of="publication:list"
    data-fx_count_featured="{%count_featured type='int' label='Count featured'}2{/%}">
    {if $count_featured > 0}
        {apply featured_news_list with $items->slice(0,$count_featured) as $items /}
    {/if}
    {apply news_list with $items->slice($count_featured) as $items /}
</div>

<div
    fx:template="news_record"
    fx:name="News Record"
    fx:of="news:record"
    fx:with="$item"
    class="news-record">
    <div class="image">
        <div class="slide active">
            <img src="{$image|'crop:middle,height:360,width:735'}img/ship.jpg{/$}">
        </div>
    </div>
    <div class="short-desc">
        <div class="text">{$description}</div>
        <div class="extra">{$publish_date | 'Y-m-d'}</div>
    </div>
    <div style="clear:both;"></div>
    <div class="desc">{$text}</div>
</div>

<div
    fx:template="featured_news_list"
    fx:name="Featured News List"
    fx:of="publication:list"
    fx:size="low,wide"
    class="featuared-news-list"
    data-show_more="{%show_more label='show more link?' type='bool'}"
    data-show_anounce="{%show_anounce label='show anounce?' type='bool'}">
    <div
        fx:each="$items"
        class="featuared-news-list-item">
        <a href="{$url}" fx:if="$image or $_is_admin"><img class="spic" src="{$image | 'width:300,height:200'}"></a>
        <a href="{$url}" class="title">{$name}</a>
        <div class="date">{$publish_date | 'F d, Y'}</div>
        <div fx:if="$show_anounce" class="text">
            {$description}
        </div>
        {*<div class="read_more"><a href="{$url editable=true}" data-name="{$name}">{$%read_more}Mooore{/$}</a></div>*}
    </div>
    <div style="clear:both;"></div>
    <a fx:if="$show_more" href="{%more_news_url label="More link"}#{/%}" class="more">{%more_news}more news{/%}</a>
    <div style="clear:both;"></div>
</div>