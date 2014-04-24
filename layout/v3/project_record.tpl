<div
    fx:template="project_record"
    fx:name="Project record"
    fx:of="project.record"
    fx:omit="true">
    <div fx:with="$item" class="project-record">
        {$short_description}
        
        {$description}
    </div>
</div>