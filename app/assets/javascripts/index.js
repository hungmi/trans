document.addEventListener('turbolinks:load', () => {
    /// 讓頁面跳轉接過場柔順一點
    $('body').removeClass('hide')
    $('#nav').on('click', 'a', function() {
        $('body').addClass('hide')
    });

    /// 載入 partial 們
    // $('#nav').load('../../partail/_nav.html');
    // $('#header').load('../partail/_header.html');
    // $('#footer').load('../partail/_footer.html');

    $('#header').on('click', '#mobile-nav', function() {
        $('.mobile-nav-btn').toggleClass('active');
        $('#mobile-nav-list').toggleClass('active');
    });

    //FAQ展開的部分
    $(".faq-q").click(function() {
        var container = $(this).parents(".faq-c");
        var answer = container.find(".faq-a");
        var trigger = container.find(".faq-t");

        answer.slideToggle(200);

        if (trigger.hasClass("faq-o")) {
            trigger.removeClass("faq-o");
        } else {
            trigger.addClass("faq-o");
        }
    });

    // CommunityPartner
    // var $partnerLink = $('#partner_link');
    // if ($partnerLink.length > 0) {
    //     $(window).bind('scroll', function() {
    //         var whereAmI = $(this).scrollTop(),
    //             target = $('.main_title').offset().top;
            
    //         if (whereAmI < target) {
    //             $('#partner_link').removeClass('fixed')
    //         } else if (whereAmI > target) {
    //             $('#partner_link').addClass('fixed')
    //         }
    //     }).scroll();
    // }

    //議程的tab
    $('.tabgroup > div').hide();
    $('.tabgroup > div:first-of-type').show();
    $('.tabs a').click(function(e) {
        e.preventDefault();
        var $this = $(this),
            tabgroup = '#' + $this.parents('.tabs').data('tabgroup'),
            others = $this.closest('li').siblings().children('a'),
            target = $this.attr('href');

        others.removeClass('active');
        $this.addClass('active');
        $(tabgroup).children('div').hide();
        $(target).show();

    });
});

// new Vue({
//  el: '#shift'
//  data: {
//      videos: [],
//      photos: [],
//      files: []
//  }
// })