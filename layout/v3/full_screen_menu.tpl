{template id="full_screen_menu" name="Full screen menu" of="page.list"}
<?php
$items = $this->v('items');
if ( ($active = $items->find_one('is_active', true) ) ) {
    $this->set_var('ai', $active);
} else {
    $this->set_var('ai', $items->first());
}
$this->set_var('cid', fx::env('page_id'));
?>
<div
    style="background-image: url({%bg_$cid | 'max-width:1200'}{$ai.image}<?php echo $template_dir?>img/ship.jpg{/$}{/%});"
    class="full-back">

    <div class="caption">
        <div class="h2">
            {%header_$cid}
            <p>{$ai.name}Place header here{/$}</p>
            {/%}
        </div>
        <div class="text">
            <div>{%caption_$cid type="html"}<p>This writing is on</p>{/%}</div>
            <a fx:if="$ai" class="go" href="{$ai.url}#content">Go</a>
        </div>
    </div>
    
    <ul fx:if="count($items) > 1" class="side-menu">
        <li
            fx:each="$items"
            class="side-menu-item {if $is_active}active{/if}">
            <a href="{$url}">{$name}</a>
        </li>
    </ul>
    <a name="content" class="content_anchor"></a>
</div>
{/template}