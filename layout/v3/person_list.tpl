<div
    fx:template="person_list"
    fx:name="Person List"
    fx:of="person.list"
    fx:size="high,wide"
    class="person-list">
    <div
        fx:each="$items"
        class="person-list-item">
        <div class="container">
            <h3>{$full_name}</h3>
            <div class="text">
                {$description}
            </div>
            <ul class="social-icons">
                <li class="social-icon facebook"><a href="{%facebook_$id}"></a></li>
                <li class="social-icon vk"><a href="{%vk_$id}"></a></li>
                <li class="social-icon twitter"><a href="{%twitter_$id}"></a></li>
                <li class="social-icon li"><a href="{%li_$id}"></a></li>
                <div style="clear:both;"></div>
            </ul>
        </div>
        <div style="clear:both;"></div>
        <img fx:if="$photo" src="{$photo | 'width:350,height:230'}">
    </div>
</div>