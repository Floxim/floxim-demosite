
<div
    fx:template="addres_block"
    fx:name="Address Block"
    fx:of="text.list"
    fx:size="high,wide"
    class="address-block">
    <div
        fx:each="$items"
        data-blue="{%blue_$id type='bool' label='Blue?'}0{/%}"
        class="{if !$blue_$id}address{/if} {if $blue_$id}info{/if}">
        {$text}Text{/$}
    </div>
    <div style="clear:both;"></div>
</div>