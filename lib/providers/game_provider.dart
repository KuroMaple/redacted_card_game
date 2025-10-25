import 'dart:math';

import 'package:flutter/material.dart';

enum CardState { selected, removed, untouched }

class GameProvider extends ChangeNotifier {
  final List<List<CardState>> _gameState;
  bool _isPlayerTurn;
  bool _gameOver;
  int? _selectedRow;
  GameProvider()
    : _gameState = [
        [CardState.untouched],
        [CardState.untouched, CardState.untouched, CardState.untouched],
        [
          CardState.untouched,
          CardState.untouched,
          CardState.untouched,
          CardState.untouched,
          CardState.untouched,
        ],
        [
          CardState.untouched,
          CardState.untouched,
          CardState.untouched,
          CardState.untouched,
          CardState.untouched,
          CardState.untouched,
          CardState.untouched,
        ],
      ],
      _isPlayerTurn = true,
      _gameOver = false;

  /// State Getters
  bool get isPlayerTurn => _isPlayerTurn;

  bool get isGameOver => _gameOver;

  List<List<CardState>> get gameState => _gameState;

  ({CardState state, int? selectedRow, bool isPlayerTurn}) cardInfo(int rowIdx, int colIdx) =>
      (state: _gameState[rowIdx][colIdx], selectedRow: _selectedRow, isPlayerTurn: _isPlayerTurn);



  /// returns true if there is only one card left 
  bool isOneCardLeft(){
    int removedCards = 0;
    int totalCards = 0; // count cards in play at runtime for future dynamic changes
    for(int i = 0; i < _gameState.length; ++i){
      for(int j = 0; j < _gameState[i].length; ++j){
        totalCards++;
        if(_gameState[i][j] == CardState.removed){
          removedCards++;
        }
      }
    }

    return removedCards == (totalCards - 1);
  }

  /// Calculate the count of untouched cards in a given row
  int cardCountInRow(int row){
    int count = 0;
    for(int j = 0; j < _gameState[row].length; ++j){
      if(_gameState[row][j] == CardState.untouched){
        ++count;
      }
    }
    return count;
  }

  /// Removes the passed number of cards from the requested heap.
  ///   - if not possible throws an Out of cards exception
  void removeCards(int requestedRow, int numCards){
    print('CPU is removing $numCards from ${requestedRow + 1}');
    try {

      if(cardCountInRow(requestedRow) < numCards){
        throw Exception('Cannot remove $numCards cards from row $requestedRow');
      }

      // Remove numCards
      int removedCards = 0;
      int j = 0;
      while(removedCards < numCards){
        if(_gameState[requestedRow][j] == CardState.untouched){
          _gameState[requestedRow][j] = CardState.removed;
          removedCards++;
        }
        j++;
      }
    } on Exception catch (e) {
      print(e);
    }
  }


  /// Returns an array of sums of each heap ( the number of untouched cards in each row)
  List<int> getHeapSums(){
    List<int> heapSums = [];
    for(int i = 0; i < _gameState.length; i++){
      heapSums.add(cardCountInRow(i));
    }
    return heapSums;
  }


  /// returns true if there are an even number of heaps excluding the passed heap of size 1 false other wise
  bool evenHeaps(int rowIdx, List<int> heapSums){
    int excludedCount = 0;
    for(int i = 0; i < heapSums.length; ++i){
      if(i == rowIdx || heapSums[i] != 1){
        continue;
      }
      excludedCount++;
    }
    return (excludedCount % 2) == 0;
  }
  
 


  /// Main Client Functions*********************************************************
    
  /// Carries out the following actions:
  /// - Ensure at least one card is selected i.e Selected row is set
  /// - Converted selected cards into removed cards
  /// - Reset Selected row
  /// - Check if player has won
  /// - If player has not won, switch to pc turn
  /// - Call CPU turn function //TODO
  ///
  void endPlayerTurn() {

    if(_selectedRow == null){
      //TODO: Error message here
      return;
    }

    // Remove the cards the player selected
    for (int i = 0; i < _gameState[_selectedRow!].length; ++i) {
      if(_gameState[_selectedRow!][i] == CardState.selected){
        _gameState[_selectedRow!][i] = CardState.removed;
      }
    }

    _selectedRow = null;

    changeTurn(); 
    playCPUTurn();

    notifyListeners();
  }

  /// Updates card state of the requested indexed card if allowed
  /// Allowed conditions:
  /// - It is the players turn
  /// - current row is the selected row or selected row is null
  /// - Check if the row needs to be locked
  void handleCardTap({required int rowIdx, required int colIdx}) {
    if (!_isPlayerTurn) {
      //TODO: Dialog to tell player its not their turn
      return;
    }
    if (_selectedRow != null && _selectedRow != rowIdx) {
      //TODO: Dialog to tell player can only select from one row at a time
      return;
    }

    CardState newState;
    if (_gameState[rowIdx][colIdx] == CardState.untouched) {
      newState = CardState.selected;
    } else {
      newState = CardState.untouched;
    }
    _gameState[rowIdx][colIdx] = newState;

    // Update row lock
    if (isRowSelected(rowIdx)) {
      _selectedRow = rowIdx;
    } else {
      _selectedRow = null;
    }

    notifyListeners();
  }

  /// HELPER FUNCTIONS*********************************************************
  
  /// Executes the cpus turn
  /// Has a timed delay to simulate thinking
  /// - Checks to see if player has won at beginning of turn
  /// - Has 3 second time delay
  /// 
  void playCPUTurn() async {
    if(isOneCardLeft()){
      print("Player has won");
      _gameOver = true;
      notifyListeners();
      return;
    }
    await Future.delayed(const Duration(seconds: 2)); 

    // Formula to win nim game here:
    // TODO: Check for edge case where all heaps are size one

    int nimSum = 0;
    List<int> heapSums = getHeapSums();

    // STEP 1: Get Binary sum of all non zero heaps and XOR sum
    for(int i = 0; i < heapSums.length; i++){
      nimSum ^= heapSums[i];
    }

    print('nimSum is $nimSum');

    // STEP 2: If the nimSum is zero remove one random card from any heap since CPU is in losing position
    // otherwise play a winning move
    bool madeCPUMove = false;

    if(nimSum == 0){
      // CPU is in losing position
      List<int> nonEmptyHeaps = [];
      for(int i = 0; i < heapSums.length; ++i){
        if(heapSums[i] >= 1) nonEmptyHeaps.add(i);
      }
      if (nonEmptyHeaps.isNotEmpty){
        int idx = nonEmptyHeaps[getRandom(0, nonEmptyHeaps.length)];
        removeCards(idx, 1);
        madeCPUMove = true;
      } else {
        throw Exception('Unable to remove random card from heaps');
      }

    } else{
      // find a heap where the nimSum XOR currHeapSum < currHeapSum
      // reduce that heap such that its currHeapSum is eqaul to nimSum XOR original currHeapSum
      
      for(int i = 0; i < heapSums.length; ++i){
        if(heapSums[i] == 0) continue;
        final int target = nimSum ^ heapSums[i];

        if(target < heapSums[i]){
          int cardsToReduce = heapSums[i] - target;

          // Compute resulting heaps after reduction
          final List<int> newHeapSums = List<int>.from(heapSums);
          newHeapSums[i] = heapSums[i] - cardsToReduce;

          // Check if the heaps are of size 1
          if(newHeapSums.every((v) => v <= 1)){
            final int onesCount = newHeapSums.where((v) => v == 1).length;
            final int nonZeroHeapCountOrignal = heapSums.where((v) => v >= 1).length;
           
            if (onesCount % 2 == 0){
              if (cardsToReduce > 0){
                // we had odd number of heaps before, remove everything except the last card
                 if(nonZeroHeapCountOrignal % 2 == 1){
                  cardsToReduce = min(1, cardsToReduce);
                 } else{
                  // Remove the entire row to leave an odd number of cards
                  cardsToReduce = max(cardsToReduce, heapSums[i]);
                 }
                
              }
            }
          }

          if(cardsToReduce > 0){
            removeCards(i, cardsToReduce);
            madeCPUMove = true;
            break;
          }
        }
      }

    }

    if(!madeCPUMove){
      throw Exception('CPU has not made a move, could not find a valid move');
    }
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1)); 
    
    changeTurn(); // Change turn back to player
    if(isOneCardLeft()){
      print("CPU WINS");
      _gameOver = true;
    }
    notifyListeners();
  }

  /// Iterates through a row and returns true if any cards are selected and false otherwise
  bool isRowSelected(int rowIdx) {
    for (int i = 0; i < _gameState[rowIdx].length; ++i) {
      if (_gameState[rowIdx][i] == CardState.selected) {
        return true;
      }
    }
    return false;
  }

  /// Generate random integer in [min, max)
  int getRandom(int min, int max){
    return Random().nextInt(max - min) + min;
  }


  void changeTurn() {
    _isPlayerTurn = !_isPlayerTurn;
    notifyListeners();
  }

  /// Resets the entire game state to the initial configuration
  /// - All cards back to untouched
  /// - Player turn first
  /// - Game over cleared
  /// - No selected row
  void resetGame() {
    // Reset card states in-place to preserve the existing list references
    for (int i = 0; i < _gameState.length; i++) {
      for (int j = 0; j < _gameState[i].length; j++) {
        _gameState[i][j] = CardState.untouched;
      }
    }

    _isPlayerTurn = true;
    _gameOver = false;
    _selectedRow = null;

    notifyListeners();
  }
}
