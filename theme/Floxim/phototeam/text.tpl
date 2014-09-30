<div
    fx:template="text"
    fx:name="Text hilightable"
    fx:of="text:list"
    fx:size="high,wide"
    class="hilight-text">
    <div
        fx:each="$items"
        data-hilight="{%hilight_$id type='bool' label='Blue?'}0{/%}"
        class="{if $hilight_$id}hilight{else}regular{/if}">
        {$text}Text{/$}
    </div>
    <div style="clear:both;"></div>
</div>