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
            <h3><a href="{$url}">{$full_name}</a></h3>
            <div class="text">
                {$description}
            </div>
            {*
            <ul class="social-icons">
                <li class="social-icon facebook"><a href="{%facebook_$id}"></a></li>
                <li class="social-icon vk"><a href="{%vk_$id}"></a></li>
                <li class="social-icon twitter"><a href="{%twitter_$id}"></a></li>
                <li class="social-icon li"><a href="{%li_$id}"></a></li>
                <div style="clear:both;"></div>
            </ul>
            *}
        </div>
        <a href="{$url}">
            <img src="{$photo | 'width:350,height:230'}img/ship.jpg{/$}">
        </a>
    </div>
</div>
    
<div
    fx:template="person_record"
    fx:name="Person Record"
    fx:of="person.record"
    fx:with="$item"
    class="person-record">
    <div class="image">
        <div class="slide active">
            <img src="{$photo|'crop:middle,height:360,width:735'}/img/ship.jpg{/$}">
        </div>
    </div>
    <div class="short-desc">
        <div class="text">
            <span class="name">{$name}</span>{if $short_description}: {/if}
            <div class="speciality">{$short_description}</div>
        </div>
        <div class="extra"><span fx:if="$birthday" class="birthday_title">Birthday: </span> {$birthday | 'Y-m-d'}</div>
    </div>
    <div style="clear:both;"></div>
    <div class="desc">{$description}</div>
</div>