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

  /// Executes the cpus turn
  /// Has a timed delay to simulate thinking
  /// - Checks to see if player has won at beginning of turn
  /// - Has 3 second time delay
  /// 
  void playCPUTurn() async {
    if(isOneCardLeft()){
      print("Player has won");
    }
    await Future.delayed(const Duration(seconds: 3)); 

    changeTurn(); // Change turn back to player

  }

  /// Carries out the following actions:
  /// - Check to see if the game is  at player turn start
  /// - Ensure at least one card is selected i.e Selected row is set
  /// - Converted selected cards into removed cards
  /// - Reset Selected row
  /// - Check if player has won
  /// - If player has not won, switch to pc turn
  /// - Call CPU turn function //TODO
  ///
  void endPlayerTurn() {
    //TODO: Checking win conditions should be at the start of player turn not when endPlayer turn is called
    if(isOneCardLeft()){
      //TODO: Player has won logic here
      print('Game over. CPU won');
    }
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
