$(function(){
    var ratio = 0.364;
    $(document).ready(resizeBanner);
    $(window).resize(resizeBanner);

    function resizeBanner() {
        $.each($('.banner, .slider'), function(i, item) {
            var $item = $(item);
            var width = $item.width();
            $item.height(width*ratio);
        });
    }
    
    toggleIconPane($('form.fx_form_sent').closest('li.icon'));
    
    function desk () {

        $('nav .main-menu').css('width', 'auto');
        $('html').on('mouseover.res', 'nav .main-menu .main-menu-item', function (e) {
            if ($('.main-menu .fx_selected').length > 0) {
                return;
            }
            var $item = $(this);
            if ($item.hasClass('dropdown')){
                $('nav .main-menu .main-menu-item.dropdown.active').removeClass('active');
                $item.addClass('active');
                clearTimeout($item.data('mouseout_timeout'));
                var $sub = $('ul.sub-menu', $item).first();
                var left_offset = $item.offset().left + ($item.width() / 2) - ($sub.width() / 2);
                $sub.css('margin-left', left_offset);
            } else {
                $('nav .main-menu .main-menu-item').removeClass('active');
                clearTimeout($item.data('mouseout_timeout'));
            }
        });


        $('html').on('mouseout.res', 'nav .main-menu .main-menu-item', function (e) {
            if ($('.main-menu .fx_selected').length > 0) {
                return;
            }
            var $item = $(this);
            if ($item.hasClass('dropdown')){
                $item.data('mouseout_timeout', setTimeout(
                    function() {
                        $item.removeClass('active');
                    }, 500
                ));
            }
        });
    }

    function mob () {

        $('html').on('click.res', 'nav .menu-icon', function (e) {
            var ul = $(this).parent().find('.main-menu');
            if (!ul.hasClass('active'))
                ul.addClass('active');
            else
                ul.removeClass('active');
        });

        $('html').on('click.res', 'nav .main-menu .main-menu-item.dropdown a .more', function (e){
            e.preventDefault();
            var menu = $(this).closest('.main-menu-item');
            if (!menu.hasClass('active')) {
                menu.addClass('active');
                $(this).text('-');
            }
            else {
                menu.removeClass('active');
                $(this).text('+');
            }

        })

        $('html').on('click.res', 'nav .main-menu .close', function (e){
            var menu = $(this).parent();
            if (!menu.hasClass('active')) {
                menu.addClass('active');
            }
            else {
                menu.removeClass('active');
            }

        });

        function setMenuWidth() {
            var width = $(window).width();
            $('nav .main-menu').width(width);
        }
        $(document).on('ready.res', setMenuWidth);
        $(window).on('resize.res', setMenuWidth);
    }
    
    function toggleIconPane($node) {
        if (!$node || $node.length === 0) {
            return;
        }
        if (!$node.hasClass('active')) {
            $('.icon').removeClass('active');
            $node.addClass('active');
            $node.find('form input').not('[type="hidden"]').eq(0).focus();
            $('html').on('click.clickover', function(e) {
                if (!$.contains($node.get(0), e.target)) {
                    toggleIconPane($node);
                    ///node.removeClass('active');
                    //
                }
            });
            $node.off('keydown').on('keydown', function(e) {
                if (e.which === 27) {
                    toggleIconPane($node);
                }
            });
            return;
        } else {
            $node.removeClass('active');
            $('html').off('click.clickover');
        }
    };
    
    $('html').on('click', '.icon > a', function (e) {
        toggleIconPane($(this).parent());
    });
    function full_back(){
            var height = $(window).height();
            $('.full-back').height(height-120);
    }
    $(document).ready(full_back);
    $(window).resize(full_back);
    $("html").on("fx_infoblock_loaded", full_back);

    /*
    $(window).resize(function() {
        var width = $(window).width();
        $('.icons .icon .width-helper').width(width-41);
        $.each($('.icons .icon .width-helper'), function(i, item) {
            var $item = $(item);
            var $parent = $item.parent();
            var offset = $parent.offset().left;
            $item.css('left', -offset);
        })
    })
    */

    function WidthChange(mq) {
        $('html').off('.res');
        $(document).off('.res');
        $(window).off('.res');
        if (mq.matches) {
            mob();
        } else {
            desk();
        }
    }

    if (matchMedia) {
        var mq = window.matchMedia("(min-width:320px) and (max-width:1000px)");
        mq.addListener(WidthChange);
        WidthChange(mq);
    }

});