import 'package:flutter/material.dart';

enum CardState { selected, removed, untouched }

class GameProvider extends ChangeNotifier {
  final List<List<CardState>> _gameState;
  bool _isPlayerTurn;
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
      ], _isPlayerTurn = true;

  bool get isPlayerTurn => _isPlayerTurn;
  
  List<List<CardState>> get gameState => _gameState;

  void updateCardState({
    required int rowIdx,
    required int colIdx,
    required CardState newState,
  }) {
    _gameState[rowIdx][colIdx] = newState;
    notifyListeners();
  }

  void changeTurn(){
    _isPlayerTurn = !_isPlayerTurn;
    notifyListeners();
  }
}
