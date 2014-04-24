<div
    fx:template="vacancies_list"
    fx:name="Vacancies List"
    fx:of="vacancy.list"
    fx:size="high,wide"
    class="vacancies-list">
    <div fx:each="$items" class="vacancies-list-item">
        <div fx:if="$image" class="vacancy_image">
            <img src="{$image | 'width:200'}" alt='{$name}' />
        </div>
        <div class="vacancy_data">
            <h3><a href="{$url}">{$name}</a></h3>
            <div class="desc">
                {$requirements}
            </div>
            <a href="{$url}" class="more">more info</a>
        </div>
        <div style="clear:both;"></div>
    </div>
</div>