<div fx:template="list" class="project_list" fx:name="Default project list" fx:of="project:list" fx:size="wide, high">
    <div fx:item class="project">
        <div class="image">
            <img src="{$image | 'max-width:500'}" alt="" />
        </div>
        <div class="description">
            <h2><a href="{$url}">{$name}</a></h2>
            <div class="year" fx:if="$date">{$date|'Y'}</div>
            <div class="short_description">{$short_description}</div>
        </div>
    </div>
</div>