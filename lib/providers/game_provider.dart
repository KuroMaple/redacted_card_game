import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum CardState { selected, removed, untouched }

class GameProvider extends ChangeNotifier {
  final List<List<CardState>> _gameState;
  bool _isPlayerTurn;
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
      _isPlayerTurn = true;

  bool get isPlayerTurn => _isPlayerTurn;

  List<List<CardState>> get gameState => _gameState;

  ({CardState state, int? selectedRow}) cardInfo(int rowIdx, int colIdx) =>
      (state: _gameState[rowIdx][colIdx], selectedRow: _selectedRow);

  /// Iterates through a row and returns true if any cards are selected and false otherwise
  bool isRowSelected(int rowIdx) {
    for (int i = 0; i < _gameState[rowIdx].length; ++i) {
      if (_gameState[rowIdx][i] == CardState.selected) {
        return true;
      }
    }
    return false;
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

  void changeTurn() {
    _isPlayerTurn = !_isPlayerTurn;
    notifyListeners();
  }

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
      for(int j = 0; j < numCards; ++j){
        if(_gameState[requestedRow][j] == CardState.untouched){
          _gameState[requestedRow][j] = CardState.removed;
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  /// Executes the cpus turn
  /// Has a timed delay to simulate thinking
  /// - Checks to see if player has won at beginning of turn
  /// - Has 3 second time delay
  /// 
  void playCPUTurn() async {
    if(isOneCardLeft()){
      print("Player has won");
    }
    await Future.delayed(const Duration(seconds: 2)); 

    // Formula to win nim game here:
    // TODO: Check for edge case where all heaps are size one

    int nimSum = 0;
    List<int> heapSums = [0,0,0,0]; // initialize with 4 heaps

    // STEP 1: Get Binary sum of all non zero heaps and XOR sum
    for(int i = 0; i < _gameState.length; i++){
      int currHeapSum = 0;
      for(int j = 0; j < _gameState[i].length; j++){
        if (_gameState[i][j] == CardState.untouched){
          currHeapSum++;
        }
      }
      heapSums[i] += currHeapSum; // Track the sum of each hap
      nimSum ^= currHeapSum;
    }

    print('nimSum is $nimSum');

    // STEP 2: If the nimSum is zero remove one random card from any heap since CPU is in losing position
    // otherwise play a winning move
    if(nimSum == 0){
      Random random = Random();
      int min = 0;
      int max = _gameState.length - 1;

      bool validMoveMade = false;
      while(!validMoveMade){
        int randomHeapIndex = random.nextInt(max - min) + min;
        // Find one random heap with at least 1 card and remove from it
        if(cardCountInRow(randomHeapIndex) >= 1){
          removeCards(randomHeapIndex, 1);
          validMoveMade = true;
        }
      }
    } else{
      // find a heap where the nimSum XOR currHeapSum < currHeapSum
      // reduce that heap such that its currHeapSum is eqaul to nimSum XOR original currHeapSum

      for(int i = 0; i < heapSums.length; ++i){
        if((nimSum ^ heapSums[i]) < heapSums[i]){
          // we can reduce this heap
          removeCards(i, heapSums[i] - (nimSum ^ heapSums[i]));
          break;
        }
      }
    }
    changeTurn(); // Change turn back to player
    if(isOneCardLeft()){
      print("CPU WINS");
    }
  }

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
}
