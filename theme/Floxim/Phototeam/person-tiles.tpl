<div class="person_tiles" fx:template="person_tiles" fx:of="person:list" fx:name="Person tiles" fx:add="true">
    {css}css/person-tiles.less{/css}
    <div class="person" fx:item>
        <div class="pic"><img src="{$photo | '130*130'}" /></div>
        <div class="data">
            <div class="title"><a href="{$url}">{$name}</a></div>
            <div class="birthday" fx:aif="$birthday">
                Birthday: <span>{$birthday | 'F, d'}</span>
            </div>
            <div class="desc">{$short_description}</div>
            <div class="contacts" fx:with-each="$contacts">
                <div class="contact" fx:item>
                    <span class="type">{$contact_type}</span>
                    <span class="val">{$value}</span>
                </div>
            </div>
        </div>
    </div>
</div>
