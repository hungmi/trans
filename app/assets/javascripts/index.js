document.addEventListener('turbolinks:load', () => {
    // 首頁影片
    videoContent = document.getElementById('videoBg');
    checkAutoplaySupport();

    /// 讓頁面跳轉接過場柔順一點
    $('body').removeClass('hide')
    
    //議程的tab
    $('.tabgroup > div').hide();
    $('.tabgroup > div:first-of-type').show();
});

$(document).on('click', '#nav a', function() {
    $('body').addClass('hide')
});

$(document).on('click', '#header #mobile-nav', function() {
    $('.mobile-nav-btn').toggleClass('active');
    $('#mobile-nav-list').toggleClass('active');
});

//FAQ展開的部分
$(document).on('click', '.faq-q', function() {
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

//議程的tab
$(document).on('click', '.tabs a', function(e) {
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

function checkAutoplaySupport() {
  var playPromise = videoContent.play();
  if (playPromise !== undefined) {
    playPromise.then(onAutoplayWithSoundSuccess).catch(onAutoplayWithSoundFail);
  }
}

function onAutoplayWithSoundSuccess() {
  console.log("If we make it here, unmuted autoplay works.")
  videoContent.pause();
  autoplayAllowed = true;
  autoplayRequiresMuted = false;
  autoplayChecksResolved();
}

function onAutoplayWithSoundFail() {
  console.log("Unmuted autoplay failed. Now try muted autoplay.")
  checkMutedAutoplaySupport();
}

function checkMutedAutoplaySupport() {
  videoContent.volume = 0;
  videoContent.muted = true;
  var playPromise = videoContent.play();
  if (playPromise !== undefined) {
    playPromise.then(onMutedAutoplaySuccess).catch(onMutedAutoplayFail);
  }
}

function onMutedAutoplaySuccess() {
  console.log("If we make it here, muted autoplay works but unmuted autoplay does not.")
  videoContent.pause();
  autoplayAllowed = true;
  autoplayRequiresMuted = true;
  autoplayChecksResolved();
}

function onMutedAutoplayFail() {
  console.log("Both muted and unmuted autoplay failed. Fall back to click to play.")
  videoContent.volume = 1;
  videoContent.muted = false;
  autoplayAllowed = false;
  autoplayRequiresMuted = false;
  autoplayChecksResolved();
}

function autoplayChecksResolved() {
  if (autoplayAllowed) {
    videoContent.play();
  } else {
    videoContent.controls = true;
  }
}