<div
    fx:template="news_list"
    fx:name="News List"
    fx:of="publication.list"
    fx:size="high,wide"
    class="news-list">
    <div
        fx:each="{$items->group('publish_date | fx::date : "F Y"') as $month => $news}"
        class="month-container">
        <div class="month">{$month}</div>
        <div fx:each="$news" class="news-list-item">
            <a href="{$url}">{$name}</a>
            <span class="date">{$publish_date}</span>
        </div>
    </div>
</div>
        
<div 
    fx:template="news_mixed" 
    fx:name="News list mixed" 
    fx:of="publication.list"
    data-fx_count_featured="{%count_featured type='int' label='Count featured'}2{/%}">
    {if $count_featured > 0}
        {apply featured_news_list with $items->slice(0,$count_featured) as $items /}
    {/if}
    {apply news_list with $items->slice($count_featured) as $items /}
</div>