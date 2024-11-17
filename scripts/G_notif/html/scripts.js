$(function () {
    var sound = new Audio('son.mp3');
    sound.volume = 1.0;
    window.addEventListener('message', function (event) {
        if (event.data.action == 'open') {
            var number = Math.floor((Math.random() * 1000) + 1);
            $('.toast').append(`<div class="wrapper-${number}"><div class="notification_main-${number}"><div class="title-${number}"></div><div class="text-${number}">${event.data.message}</div></div></div>`)
            $(`.wrapper-${number}`).css({"margin-bottom": "10px", "width": "256px", "margin": "0 0 8px -170px", "border-radius": "0px"})
            $('.notification_main-'+number).addClass('main')
            $('.text-'+number).css({"font-size": "14px", "margin": "7px 10px 0px 1px"})
            if (event.data.type == 'notif') {$(`.title-${number}`).html(event.data.title).css({"font-size": "16px", "font-weight": "600"})
                $(`.wrapper-${number}`).addClass('notif notif-border')
                sound.play();
            } else if (event.data.type == 'notif2') {$(`.title-${number}`).html(event.data.title).css({"font-size": "16px", "font-weight": "600"})
                $(`.wrapper-${number}`).addClass('notif2 notif2-border')
                sound.play();
            } else if (event.data.type == 'notif3') {$(`.title-${number}`).html(event.data.title).css({"font-size": "16px", "font-weight": "600"})
                $(`.wrapper-${number}`).addClass('notif3 notif3-border')
                sound.play();
            }
            anime({targets: `.wrapper-${number}`, translateX: -50, duration: 750, easing: 'spring(1, 70, 100, 10)'})
            setTimeout(function () {anime({targets: `.wrapper-${number}`, translateX: -50, duration: 750, easing: 'spring(1, 70, 100, 10)'})
            setTimeout(function () {$(`.wrapper-${number}`).remove() },750)
            }, event.data.time)
        }
    })
})                 