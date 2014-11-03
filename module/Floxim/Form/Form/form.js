(function($) {

$('html').on('click', '.fx_refresh_captcha', function() {
    var $pic = $(this).closest('.fx_form_row').find('.fx_captcha_image');
    var src = $pic.attr('src');
    var new_src = src.replace(/rand=\d+/, 'rand='+Math.round(Math.random()*10000));
    $pic.attr('src', new_src);
    $pic.closest('.fx_captcha_input').find('.fx_input_type_captcha').val('').focus();
});

$('html').on('change', '.fx_file_switcher', function() {
    var c_value = $('input:checked', this).attr('value');
    var $block = $(this).closest('.fx_input_block');
    $('.fx_file_input', $block).hide();
    $('.fx_file_input_'+c_value, $block).show();
});

$('html').on('submit', 'form.fx_form_ajax', function() {
    var $form = $(this);
    var event_before = $.Event('fx_before_ajax_form_sent');
    $form.trigger(event_before);
    if (event_before.isDefaultPrevented()) {
        return false;
    }
    $form.append('<input type="hidden" name="_ajax_base_url" value="'+document.location.href+'" />');
    var form_data = $form.serialize();
    $.ajax({
        type:'post',
        url:$form.attr('action'),
        dataType:'html',
        data:form_data,
        success: function(data) {
            var $data = $(data);
            var $ib = $form.closest('.fx_infoblock');
            var $container = $ib.parent();
            $ib.before($data);
            $ib.remove();
            $('form.fx_form_sent .fx_form_row_error :input', $container).first().focus();
            $data.trigger('fx_form_loaded');
        }
    });
    return false;
});

$(function() {
    $('.fx_input_block .livesearch').each(function() {
        var $node = $(this);
        var ls = new fx_livesearch($node);
        $node.data('livesearch', ls);
        //console.log('c ls', ls);
        if (ls.ajax_preload) {
            ls.loadValues(ls.plain_values);
        }
    });
});

})(window.jQuery);