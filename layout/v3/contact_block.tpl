<div
    fx:template="contact_block"
    fx:name="Contact Block"
    fx:of="text.list"
    fx:size="high,narrow"
    class="contacts-list">
    <div
        fx:each="$items"
        class="contacts-list-item">
        {$text}Text{/$}
    </div>
</div>