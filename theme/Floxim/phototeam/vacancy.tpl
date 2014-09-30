<div
    fx:template="vacancies_list"
    fx:name="Vacancies List"
    fx:of="vacancy:list"
    fx:size="high,wide"
    fx:add="true"
    class="vacancies-list">
    <div fx:each="$items" class="vacancies-list-item">
        <div class="vacancy_image">
            <img src="{$image | '200*133'}img/ship.jpg{/$}" alt='{$name}' style="width:200px; height:133px;"/>
        </div>
        <div class="vacancy_data">
            <h3>
                <a href="{$url}">{$name}</a>
            </h3>
            {apply vacancy_salary /}
            <div class="desc">
                {$requirements}
            </div>
            <a href="{$url}" class="more">{$%more_info}more info{/$}</a>
        </div>
        <div style="clear:both;"></div>
    </div>
</div>
        
<div fx:template="vacancy_salary" class="vacancy_salary" fx:if="$salary_from || $salary_to">
    <span class="from" fx:if="$salary_from">
        From <b>{$salary_from}</b> 
    </span>
    <span class="to" fx:if="$salary_to">
        {if $salary_from}to{else}Up to{/if} 
        <b>{$salary_to}</b> 
    </span>
    <span class="currency">{$currency}</span>
</div>

<div
    fx:template="vacancy_record"
    fx:name="Vacancy Record"
    fx:of="vacancy:record"
    fx:with="$item" 
    class="vacancy-record">
        <div fx:if="$image || $_is_admin" class="vacancy_image">
            <img src="{$image | 'width:300'}" alt='{$name}' />
        </div>
        <h4>{%responsibilities_$id}Responsibilities{/%}</h4>
        <div>{$responsibilities}</div>
        <h4>{%requirements_$id}Requirements{/%}</h4>
        <div>{$requirements}</div>
        <h4>{%work_conditions_$id}Work Conditions{/%}</h4>
        <div>{$work_conditions}</div>
</div>