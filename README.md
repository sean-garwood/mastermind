# README

Mastermind - The Odin Project

## spec

### done

Build a Mastermind game from the command line where you have 12 turns to guess
the secret code, starting with you guessing the computer’s random code.

- Build the game assuming the computer randomly selects the secret colors and
the human player must guess them. Remember that you need to give the proper
feedback on how good the guess was each turn!

### todo

- Now refactor your code to allow the human player to choose whether they want
to be the creator of the secret code or the guesser.
- Build it out so that the computer will guess if you decide to choose your own
secret colors. You may choose to implement a computer strategy that follows the
rules of the game or you can modify these rules.

- If you choose to modify the rules, you can provide the computer additional
information about each guess. For example, you can start by having the computer
guess randomly, but keep the ones that match exactly. You can add a little bit
more intelligence to the computer player so that, if the computer has guessed
the right color but the wrong position, its next guess will need to include that
color somewhere.

- If you want to follow the rules of the game, you’ll need to research
strategies for solving Mastermind, such as this post.

## strategy

1. first guess will always be two pair of colors
2. get feedback > remove all non-existent colors (feedback peg = 'x') > keep all
correct/in-code guesses in pool
3. next guess will
  - have all 'c' guesses in place
  - rearrange correct/wrong position guesses to other slots
  - guess remaining possible colors

### implementation

#### objects

- Player class to instantiate players
  attributes:
  - computer/human
  - maker/breaker

- array of colors to assemble guesses from
  dynamic, shrinks as guesses increase
