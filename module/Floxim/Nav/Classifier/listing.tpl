<div 
    fx:template="entity_classifier" 
    fx:of="classifier:list"
    fx:name="Classifier" 
    class="classifiers">
    <span class="tags_label">{%tags_label}Tags:{/%} </span>
    <a fx:item href="{$url}">{$name}</a>
    <span fx:separator>, </span>
</div>