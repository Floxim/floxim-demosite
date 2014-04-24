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