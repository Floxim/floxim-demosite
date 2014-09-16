<div class="person_tiles" fx:template="person_tiles" fx:of="person.list" fx:name="Person tiles">
    {css}css/person-tiles.less{/css}
    <div class="person" fx:item>
        <div class="pic"><img src="{$photo | '130*130'}" /></div>
        <div class="data">
            <div class="title"><a href="{$url}">{$name}</a></div>
            <div class="birthday" fx:if="$birthday">
                Birthday: <span>{$birthday | 'F, d'}</span>
            </div>
            <div class="desc">{$short_description}</div>
        </div>
    </div>
</div>