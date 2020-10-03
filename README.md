# describe at a high level what the application will do.
This is a betting management app keeping track of all the users information such as name, balance, and bet history. The user will be able to check there balance, withdraw, deposit, and make a bet, everytime the user makes a bet we will check to see if they win and payout accordingly. If they lose we subtract there bet from there balance, but either way we log the results after every bet. The admin account will have access to users bet history and the global bet history, as well as check for the highest winner. The app is roulett syle, so the users will select from a list of bets such as:
- any number between 1 and 36 including '0' or '00' #pays 35:1 
- 'red' - 1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36  #pays 1:1
- 'black' - 2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35 #pays 1:1
- 'odd' - every odd number between 1 & 36 #pays 1:1
- 'even' - every even number between 1 & 36 #pays 1:1
- '1-18' - top half of the board #pays 1:1
- '19-36' - bottom half of the board #pays 1:1
- 'split' - 2 numbers next to each other #pays 17:1

#### solving a problem:
The machine at the roulette tabe that tracks the bets is broken. So this app is so the users can make accounts and place bets though the app and so the casino have a bet history of all the current users. This would help the casino keep track of the roulette tables wins and loses.

#### Target audience: 
I believe this app will strike a large audience of people who already enjoy gambling but want a free and enjoyable app to simulate real gambling. There are tons of avid gamblers having fun responsibly and i think this app would appeal to them. For ethical reasons I would discourage under 18's from playing even though no real money is lost, I do not wish to encourage anyone to gamble. 

#### How the target audience will use it: 
after creating an account or logging in the user should be able to deposit some money and start betting, when the user is out money they will need to make a deposit again before betting, the user will also be able to look at there own betting history. When placing a bet the user will select from a list of options which will prompt the user for his bet type and bet amount, then we will let them know if they win or lose and ask if they would like to bet again or cancel back to the menu.

# Features
#### Gamble:
The gamble feature will start off by allowing the user to select a bet type, then asking for a bet amount as input. In the background the app will select a number between 1 & 36 or '0', '00', then check against the user input to calculate if they win/lose and how much to payout. If the user enters an invalid data type they will be prompt a help message and asked to try again.

#### Balance:
Users should be able to withdraw and deposit on to there account. The balance feature will let users check their current balance, withdrawal, and deposit. When withdrawing the user must have enough money in their account, and depositing should be limited to 500. While in the betting screen the user will see the current balance and potential win.

#### data logging:
When a new account is made the account will be added to the list of users. After every bet information about the bet should be logged in a global bet log, and in a user bet log. This allows users to access there own bet history and no one else's, but admins allowed to see a betting log across all users.


# App outline

#### help inside the app:
The user will be able to type "help" at any point to be prompt with a help message. At the bottom of all the menus will also be a help option they can press the enter key on. If any errors occurs it will show a help message about the how it input properly.

#### how the user interacts with the features:
On start up the app will prompt the user to log in or create new user, once sucsesful the user will be shown the in app menu were they can select balace, bet, bet history or help. The user will be able to scroll though the menu with the up and down arrow keys and press enter on the option they want. After the user has selected balance, their balance will be shown and will have the options to deposit or withdraw. If the user wants to put a bet on they select from the bet types, then input the number/numbers to bet on and bet amount. 

#### Error handling:
Every time the user enters something the input will go through some error checking to make sure the bet amount is a number or so the user cant withdraw more then they have. If any error occurs it will prompt the user with a help message for what the program expects the input to be, then ask for valid input.

# Installation

Tested on windows laptop

software requirements:
- unbuntu on windows 
- ruby 2.7.1 or greater 

To install the app gems naviagte to the directory were you cloned the src file and run the `run.sh` file with `./run.sh` this will install the latest version of bundler and install all of the gems used in the app. 
