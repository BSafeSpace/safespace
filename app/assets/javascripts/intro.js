$('iframe').load(function(){
    $(this).contents().find('body').html('Hey, i`ve changed content of <body>! Yay!!!');
});
