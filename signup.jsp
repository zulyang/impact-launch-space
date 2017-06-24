<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <title>ImpactLaunch.Space</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <!--custom css codes -->
        <link type="text/css" rel="stylesheet" href="css/app.css">
        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
        <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
        <script src="./js/app.js"></script>
    </head>
    <body class="signup">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-12">

                    <nav class="navbar navbar-default navbar-fixed-top landing-nav">
                        <div class="container-fluid">
                            <div class="navbar-header">
                                <a class="navbar-brand" href="index.jsp">
                                    <img alt="ImpactLaunch.Space" id="logo" src="./img/logo.png"></a>
                            </div>

                            <ul class="nav navbar-nav navbar-right nav_elements">
                                <li>
                                    <a href="index.jsp">Home</a>
                                </li>
                                <li>
                                    <a href="signin.jsp">Sign In</a>
                                </li>
                                <li>
                                    <a href="signup.jsp">Sign Up</a>
                                </li>
                            </ul>
                        </div>
                    </nav>

                    <div class="col-lg-12 form_container" id="register_container">
                        <h4 class="createAccount">Create a new account</h4>
                        <form class="form-horizontal">                                                   
                            <br>
                            <div class="form-radio center">   
                                <div class="radio_indi">
                                    <input type="radio" name="entity">Individual
                                </div>     
                                <div class="radio_org">
                                    <input type="radio" name="entity">Organisation
                                </div>
                            </div>
                            <br>
                            <div class="form-group">   
                                <div class="col-lg-12">
                                    <input type="email" class="form-control field" placeholder="Username">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <input type="password" class="form-control field" placeholder="Password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <input type="password" class="form-control field" placeholder="Repeat your password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <input type="email" class="form-control field" placeholder="Email address">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <button type="submit" class="btn btn-success field" id="register_button">Register</button>
                                </div>
                            </div>
                            <p class="finePrint">By registering, you confirm that you agree with our Terms & Conditions and Privacy Policy.</p>
                        </form>
                    </div>

                    <div class="col-lg-12 register_success" id="register_success" style="display:none;">
                        <h4 class="register_success_message">Registration Successful</h4>
                        <p class="success_verify_message">You have successfully registered for an account. A verification code has been sent to your email.</p>
                            <a href="#" class="btn btn-info verify_account" id="verify_account" role="button">Verify My Account</a>
                    </div>

                    <div class="col-lg-12 verify_container" id="verify_container" style="display:none;">
                        <h4 class="verifyAccountMessage">Verify your account</h4>
                        <form class="form-horizontal">                                                   
                            <div class="form-group">   
                                <div class="col-lg-12">
                                    <input type="email" class="form-control field" placeholder="Username">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <input type="password" class="form-control field" placeholder="Password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <input type="text" class="form-control field" placeholder="Verification code">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <button type="submit" class="btn btn-success field" id="verify_button">Submit</button>
                                </div>
                            </div>
                        </form>
                    </div>


                    <div class="col-lg-12 verify_success" id="verify_success" style="display:none;">
                        <h4 class="verify_success_message">Verification Successful</h4>
                        <p>Hi username, your account has been verified!</p>
                        <a href="signin.jsp" class="btn btn-success signInNow" role="button">SIGN IN NOW</a>
                        <a href="index.jsp" class="btn btn-default returnHome" role="button">Return to Home</a>
                    </div>
                </div>
            </div>

        </div>

    </body>
</html>
