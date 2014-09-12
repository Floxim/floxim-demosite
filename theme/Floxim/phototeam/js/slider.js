$(function(){
    $('html').on('click', '.slider .arrow', function(e) {
        var slider = $(this).closest('.slider');
        var cur_slide = slider.find('.slide.active');
        var index = slider.find('.slide').index(cur_slide);
        var length = slider.find('.slide').length;
        if ($(this).hasClass('right')) {
            index++;
            if (index>=length)
            index = 0;
        }
        else {
            index--;
            if (index < 0)
            index = length-1;
        }
        cur_slide.fadeOut(function() {
            $(this).removeClass('active');
        })
        slider.find('.slide').eq(index).fadeIn(function() {
            $(this).addClass('active');
        })
    })
    $('html').on('click', '.slider-wrapper .featured-photo-list .featured-photo-list-item', function(e) {
        var container = $(this).closest('.featured-photo-list');
        var index = container.find('.featured-photo-list-item').index($(this));
        var slider = $(this).closest('.slider-wrapper').find('.slider');
        var cur_slide = slider.find('.slide.active');
        cur_slide.fadeOut(function() {
            $(this).removeClass('active');
        })
        slider.find('.slide').eq(index).fadeIn(function() {
            $(this).addClass('active');
        })
    })
});