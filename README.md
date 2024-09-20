# Brot Blitz
This project is a card game based on Dutch Blitz, a game created by a Dutch immigrant in the 20th century. I have played the game with friends and family since I was a child and I have
always wanted to play this game online as I can't play it with others as much as I want to. It is my hope I can utilize GoDot
to create an online version of this game. 

# Rules

- All Players have a "Blitz" pile with 10 cards stacked and only the top card is accessible and visible.

![image](https://github.com/user-attachments/assets/67ffb091-18b3-48f6-af38-0c268098e848)

- All players have 3 cards in front of them that they can play and replace the empty spot with a card from the blitz deck (this is handled automatically).
- These cards are counted towards the Blitz Score. Once you reach 10 played between these 3 cards and the blitz pile's top card, the game will end.

![image](https://github.com/user-attachments/assets/35a19d40-91b4-4bab-bd47-8621adfd9737)

- All players have a draw pile with the remaining 27 cards that they can draw from at any time.
- This deck does *NOT* count towards the Blitz score.

![image](https://github.com/user-attachments/assets/1161bc98-1a03-49c2-9489-5fb38863bd13)


- All Players play simultaneously.
- When a player reaches 10 blitz points, the game ends, and the score is calculated and sent to the Database.
- Played cards are 1 point and each card left in a player's Blitz pile is -1 point.
- Cards are played in ascending order on matching suits (1->10).

# Modes

**Brot Blitz** has three modes to choose from of varying difficulty.
- Easy
- Normal
- Hard

The mode's difficulty is tied to the restrictions placed on the AI players. The more difficult the mode, the faster the AI can play!
