<div fx:template="list" class="vacancy_list" fx:name="Vacancy list" fx:of="vacancy:list">
    <div fx:item class="vacancy">
        <div class="image" fx:if="$image"><img src="{$image}" /></div>
        <div class="data">
           <a href="{$url}"><h2>{$name}</h2></a>
        </div>
    </div>
</div>