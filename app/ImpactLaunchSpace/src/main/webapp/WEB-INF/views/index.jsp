<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <title>ImpactLaunch.Space</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <!--custom css codes -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/parallax.css"/>
        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
        <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
        <script src="https://www.solodev.com/assets/parallax/jquery.localscroll-1.2.7-min.js"></script>
        <script src="https://www.solodev.com/assets/parallax/jquery.parallax-1.1.3.js"></script>
        <script src="https://www.solodev.com/assets/parallax/jquery.scrollTo-1.4.2-min.js"></script>
        <script src="<%=request.getContextPath()%>/resources/js/scrolling.js"></script>
        </script>
    </head>
    <body class="landing">
        <div class="container-parallax">
<%@include file="common/navigationLogin.jspf" %>   
            <div id="intro">
   <div class="story">
      <div class="float-left">
         <h2>Impact Launch.Space</h2>
         <p>A unique and simple online tool to allow projects and
those looking to give back to share project ideas, communicate and collaborate to enable transformational change for those who need support most.</p> 
      <button type="button" class="btn-learn click" name="learnMore">Learn More</button></div>
   </div>
   <!--.story-->
</div>
<!--#intro-->
<div id="second">
   <div class="bg"></div>
   <div class="story">
     
      <div class="float-right">
         <h2>Fun with Multiple Backgrounds</h2>
         <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean nibh erat, sagittis sit amet congue at, aliquam eu libero. Integer molestie, turpis vel ultrices facilisis, nisi mauris sollicitudin mauris, volutpat elementum enim urna eget odio.</p> 
         <p>Donec egestas aliquet facilisis. Nunc eu nunc eget neque ornare fringilla. Nam vel sodales lectus. Nulla in pellentesque eros. Donec ultricies, enim vitae varius cursus, risus mauris iaculis neque, euismod sollicitudin metus erat vitae sapien. Sed pulvinar.</p>
      </div>
   </div>
   <!--.story-->
</div>
<!--#second-->
<div id="third">
<div class="bg"></div>
   <div class="story">
      <div class="float-left">
         <h2>Why is Parallax so Awesome?</h2>
         <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean nibh erat, sagittis sit amet congue at, aliquam eu libero. Integer molestie, turpis vel ultrices facilisis, nisi mauris sollicitudin mauris, volutpat elementum enim urna eget odio.</p> 
      </div>
   </div>
   <!--.story-->
</div>
<!--#third-->  
<div id="fourth">
<div class="story">
<div class="float-right">
<h2>Last heading</h2>
<p>Paragraph text here</p>
</div></div></div>
         
         <div id="footer">
         <p>Allied World Healthcare © 2017</p></div>     
        </div>
    </body>
</html>