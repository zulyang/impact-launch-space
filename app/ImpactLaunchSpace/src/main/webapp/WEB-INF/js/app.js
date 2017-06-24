$(document).ready(function () {
    $("#sendVerify").click(function () {
        document.getElementById("verify").style.display = '';
        event.preventDefault();
    });

    $('#register_button').click(function () {
        if ($('#register_container').css('display') !== 'none') {
            $('#register_success').show().siblings('div').hide();
            event.preventDefault();
        }
    });
    
    $('#verify_account').click(function () {
        if ($('#register_success').css('display') !== 'none') {
            $('#verify_container').show().siblings('div').hide();
            event.preventDefault();
        }
    });
    
    $('#verify_button').click(function () {
        if ($('#verify_container').css('display') !== 'none') {
            $('#verify_success').show().siblings('div').hide();
            event.preventDefault();
        }
    });
});