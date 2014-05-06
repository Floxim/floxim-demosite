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

<div
    fx:template="vacancy_record"
    fx:name="Vacancy Record"
    fx:of="vacancy.record"
    fx:with="$item" 
    class="vacancy-record">
        <div fx:if="$image" class="vacancy_image">
            <img src="{$image | 'width:300'}" alt='{$name}' />
        </div>
        <h4>{%responsibilities_$id}Responsibilities{/%}</h4>
        <div>{$responsibilities}</div>
        <h4>{%requirements_$id}Requirements{/%}</h4>
        <div>{$requirements}</div>
        <h4>{%work_conditions_$id}Work Conditions{/%}</h4>
        <div>{$work_conditions}</div>
</div>