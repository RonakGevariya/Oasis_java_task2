<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Random" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <title>Number Guessing Game</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
         body {
            text-align: center;
            font-family: Monospace, Monospace;
            margin-top: 0.5%;
        }

        h1 {
            color:#581845 ;
        }

        p {
            color: #454545;
        }

        .container {
            max-width: 700px;
            margin-bottom: 100px;
            margin: 0 auto;
            padding: 70px;
            background-color: #FFA07A;
            border: 2px solid #000000;
            border-radius: 15px;
        }

        .input-field {
            margin-top: 2px;
        }

        

        .button-33 {
            background-color: #c2fbd7;
            border-radius: 100px;
            box-shadow: rgba(44, 187, 99, .2) 0 -25px 18px -14px inset, rgba(44, 187, 99, .15) 0 1px 2px, rgba(44, 187, 99, .15) 0 2px 4px, rgba(44, 187, 99, .15) 0 4px 8px, rgba(44, 187, 99, .15) 0 8px 16px, rgba(44, 187, 99, .15) 0 16px 32px;
            color: green;
            cursor: pointer;
            display: inline-block;
            font-family: CerebriSans-Regular, -apple-system, system-ui, Roboto, sans-serif;
            padding: 7px 20px;
            text-align: center;
            text-decoration: none;
            transition: all 250ms;
            border: 0;
            font-size: 16px;
            user-select: none;
            -webkit-user-select: none;
            touch-action: manipulation;
        }

        .button-33:hover {
            box-shadow: rgba(44, 187, 99, .35) 0 -25px 18px -14px inset, rgba(44, 187, 99, .25) 0 1px 2px, rgba(44, 187, 99, .25) 0 2px 4px, rgba(44, 187, 99, .25) 0 4px 8px, rgba(44, 187, 99, .25) 0 8px 16px, rgba(44, 187, 99, .25) 0 16px 32px;
            transform: scale(1.05) rotate(-1deg);
        }

        .animate-charcter
{
   text-transform: uppercase;
  background-image: linear-gradient(
    -225deg,
    #231557 0%,
    #44107a 29%,
    #ff1361 67%,
    #fff800 100%
  );
  background-size: auto auto;
  background-clip: border-box;
  background-size: 200% auto;
  color: #fff;
  background-clip: text;
  text-fill-color: transparent;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: textclip 2s linear infinite;
  display: inline-block;
      font-size: 19px;
}

@keyframes textclip {
  to {
    background-position: 200% center;
  }
}
    </style>
</head>
<body>
    <div class="container">
        <h1>Number Guessing Game</h1>
        <div class="row">
            <div class="col-md-12 text-center">
                <h3 class="animate-charcter"> Uncover the hidden treasures of numbers through the power of your guesses!</h3>
            </div>
        </div>

        <p>Guess a number between 1 and 100</p>
        <form method="post">
            <!-- <input type="number" name="guess" required> -->
             <div class="input-field">
                <label for="guess">Enter your guess:</label>
                <input type="number" id="guess" name="guess" min="1" max="100" required>
            </div>
            <br>
            <!-- <input type="submit" value="Submit"> -->
            <button class="button-33" role="submit">Guess</button>
        </form>
        <p>${message}</p>
<img src="img/think2.png" width="200" height="200" style="margin-top: -180px; margin-left:80%" />
    
    <img src="img/think.png" width="200" height="200" style="margin-top: -130px; margin-right:100%" />
    <%-- Java code --%>
    <%
        // Retrieve the user's guess from the form submission
        String userGuess = request.getParameter("guess");
       
        HttpSession session1 = request.getSession();
        Integer attemptsLeft = (Integer) session1.getAttribute("attemptsLeft");
        Integer randomNumber = (Integer) session1.getAttribute("randomNumber");

        if (attemptsLeft == null || attemptsLeft <= 0) {
            attemptsLeft = 10;
            session1.setAttribute("attemptsLeft", attemptsLeft);
            
            int minRange = 1;
            int maxRange = 100;
            Random random = new Random();
            randomNumber = random.nextInt(maxRange - minRange + 1) + minRange;
            session1.setAttribute("randomNumber", randomNumber);
        }

        if (userGuess != null) {
            try {
                // Parse the user's guess to an integer
                int guess = Integer.parseInt(userGuess);

                // Compare the user's guess with the random number
                if (guess == randomNumber) {
                    out.println("Congratulations! You guessed the correct number.");
                    //attemptsLeft = 0; // Set attempts to zero to end the game
                } else if (guess < randomNumber) {
                    out.println("Too low! The correct number is higher.");
                    attemptsLeft--;
                    session1.setAttribute("attemptsLeft", attemptsLeft);

                } else {
                    out.println("Too high! The correct number is lower.");
                    attemptsLeft--;
                    session1.setAttribute("attemptsLeft", attemptsLeft);

                }

               
                if (attemptsLeft == 0) {
                    out.println("\nGame over! You have used all your attempts.");
                    out.println("\nCorrect guessing number is: " + randomNumber);
                } else {
                    out.println("Attempts left: " + attemptsLeft);
                }
            } catch (NumberFormatException e) {
                // Handle invalid number format input
                out.println("Invalid input. Please enter a valid number.");
            }
        }
    %>
    </div>
</body>
</html>
