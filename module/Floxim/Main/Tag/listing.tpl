<div fx:template="tag_list" fx:of="tag:list" fx:name="Tag list" class="tag_list">
    <span fx:item class="tag">
        <a style="white-space:nowrap;" href="{$url}">{$name}</a>
    </span>
</div>
    
<div 
    fx:template="entity_tags" 
    fx:of="tag:list"
    fx:name="Tags for entity" 
    class="entity_tags">
        {%tags_label}Tags:{/%} 
        <a fx:item href="{$url}">
             {$name}
        </a>
        <span fx:separator>, </span>
</div>