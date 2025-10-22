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

  /// Carries out the following actions:
  /// - Converted selected cards into removed cards
  /// - Check if player has won
  /// - If player has not won, switch to pc turn
  /// - Call CPU turn function //TODO
  ///
  void endPlayerTurn() {
    // Apply player cards
    for (int i = 0; i < _gameState.length; ++i) {
      for (int j = 0; j < _gameState[i].length; ++j) {}
    }
  }
}
