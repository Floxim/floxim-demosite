<div
    fx:template="breadcrumbs"
    fx:of="section.breadcrumbs"
    fx:name="Breadcumbs"
    class="breadcrumbs">
        <h2 fx:item="$position == 2"><a fx:omit="$is_current" href="{$url}">{$name}</a></h2>
        <h3 fx:item="$position > 2">
            <a fx:omit="$is_current" href="{$url}">{$name}</a>
        </h3>
        <span fx:separator>{if $position > 2} / {/if}</span>
</div>