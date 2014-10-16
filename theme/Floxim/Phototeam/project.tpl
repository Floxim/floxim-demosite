<div
    fx:template="project_record"
    fx:name="Project record"
    fx:of="project:record"
    fx:omit="true">
    <div fx:with="$item" class="project-record">
        <div class="summary">{$short_description}</div>
        
        <div class="desc">{$description}</div>
    </div>
</div>