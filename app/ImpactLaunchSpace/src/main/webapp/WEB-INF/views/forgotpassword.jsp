<!DOCTYPE html><html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <title>ImpactLaunch.Space</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <!--custom css codes -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/app.css"/>
        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
        <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
    </head>
    <body class="signin">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-12">
                    
                    <nav class="navbar navbar-default navbar-fixed-top landing-nav">
                        <div class="container-fluid">
                            <div class="navbar-header">
                                <a class="navbar-brand" href="index.jsp">
                                    <img alt="ImpactLaunch.Space" id="logo" src="<%=request.getContextPath()%>/resources/img/logo.png"></a>
                            </div>
                            
                            <ul class="nav navbar-nav navbar-right nav_elements">
                                <li>
                                    <a href="/index">Home</a>
                                </li>
                                <li>
                                    <a href="/login1">Sign In</a>
                                </li>
                                <li>
                                    <a href="/register">Sign Up</a>
                                </li>
                            </ul>
                        </div>
                    </nav>
                    
                    <div class="col-lg-12 form_container">
                        <h4 class="welcome">Forgot your password?</h4>
                        <form action="forgotpassword" method="POST" class="form-horizontal forgot_form">
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <input type="email" name="usernameemail" class="form-control" id="inputEmail3" placeholder="Enter your email address">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <button type="submit" class="btn btn-info field">Send Verification Email</button>
                                </div>
                            </div>
                        </form>
                        <a href="/login1" class="btn btn-default returnLogin" role="button">Return to Login</a>
                    </div>
                </div>
            </div>
            
        </div>
        
    </body>
</html>
