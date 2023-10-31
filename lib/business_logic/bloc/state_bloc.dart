// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:pizza/data/model/food_model.dart';

import '../../data/database/food_database.dart';

// Events
abstract class FoodEvent {}

class LoadTodosEvent extends FoodEvent {}

class AddFoodEvent extends FoodEvent {
  final FoodModel food;

  AddFoodEvent(this.food);
}

class UpdateFoodEvent extends FoodEvent {
  final FoodModel food;

  UpdateFoodEvent(this.food);
}

class DeleteFoods extends FoodEvent {
  DeleteFoods();
}

class DeleteFood extends FoodEvent {
  final FoodModel food;

  DeleteFood(this.food);
}

class UpdateCountEvent extends FoodEvent {
  final FoodModel food;
  final int newCount;

  UpdateCountEvent(this.food, this.newCount);
}

class UpdateTotalCostEvent extends FoodEvent {
  final double newTotalCost;

  UpdateTotalCostEvent(this.newTotalCost);
}

class IncrementCountEvent extends FoodEvent {
  final FoodModel food;

  IncrementCountEvent(this.food);
}

class DecrementCountEvent extends FoodEvent {
  final FoodModel food;

  DecrementCountEvent(this.food);
}

// States
abstract class FoodState {}

class TodoInitialState extends FoodState {}

class FoodLoadingState extends FoodState {}

class FoodLoadedState extends FoodState {
  final List<FoodModel> foods;
  final double totalValue;

  FoodLoadedState(this.foods, this.totalValue);
}

class FoodErrorState extends FoodState {
  final String errorMessage;

  FoodErrorState(this.errorMessage);
}

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final LocalDatabase foodRepository = LocalDatabase();
  List<FoodModel> foodItems = [];
  double totalValue = 0.0;

  FoodBloc() : super(TodoInitialState()) {
    on<LoadTodosEvent>(_handleLoadTodosEvent);
    on<AddFoodEvent>(_handleAddFoodEvent);
    on<DeleteFoods>(_handleDeleteFoods);
    on<UpdateCountEvent>(_handleUpdateCountEvent);
    on<DeleteFood>(_handleDeleteFoodEvent);
    on<IncrementCountEvent>(_handleIncrementCountEvent);
    on<DecrementCountEvent>(_handleDecrementCountEvent);
    on<UpdateTotalCostEvent>(_handleUpdateTotalCostEvent);
  }

  void updateTotalValue() {
    totalValue =
        foodItems.fold(0.0, (previousValue, item) => previousValue + item.price * item.count);
  }

  void _handleLoadTodosEvent(LoadTodosEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoadingState());
    try {
      final foods = await foodRepository.fetchAllFoodItems();
      foodItems = foods;
      updateTotalValue();
      emit(FoodLoadedState(foods, totalValue));
    } catch (e) {
      emit(FoodErrorState('Failed to load foods: $e'));
    }
  }

  void _handleAddFoodEvent(AddFoodEvent event, Emitter<FoodState> emit) async {
    try {
      await foodRepository.insertFood(event.food);
      final foods = await foodRepository.fetchAllFoodItems();
      foodItems = foods;
      updateTotalValue();
      emit(FoodLoadedState(foods, totalValue));
    } catch (e) {
      emit(FoodErrorState('Failed to add food: $e'));
    }
  }

  void _handleUpdateCountEvent(UpdateCountEvent event, Emitter<FoodState> emit) async {
    try {
      final updatedFood = event.food.copyWith(count: event.newCount);
      await foodRepository.updateFoodByCount(updatedFood.description, updatedFood.count);
      final foods = await foodRepository.fetchAllFoodItems();
      foodItems = foods;
      updateTotalValue();
      emit(FoodLoadedState(foods, totalValue));
    } catch (e) {
      emit(FoodErrorState('Failed to update food count: $e'));
    }
  }

  void _handleIncrementCountEvent(IncrementCountEvent event, Emitter<FoodState> emit) async {
    try {
      final FoodModel updatedFood = event.food.copyWith(count: event.food.count + 1);
      await foodRepository.updateFoodByCount(updatedFood.description, updatedFood.count);
      final foods = await foodRepository.fetchAllFoodItems();
      foodItems = foods;
      updateTotalValue();
      emit(FoodLoadedState(foods, totalValue));
    } catch (e) {
      emit(FoodErrorState('Failed to increment item count: $e'));
    }
  }

  void _handleDecrementCountEvent(DecrementCountEvent event, Emitter<FoodState> emit) async {
    try {
      if (event.food.count > 1) {
        final FoodModel updatedFood = event.food.copyWith(count: event.food.count - 1);
        await foodRepository.updateFoodByCount(updatedFood.description, updatedFood.count);
        final foods = await foodRepository.fetchAllFoodItems();
        foodItems = foods;
        updateTotalValue();
        emit(FoodLoadedState(foods, totalValue));
      }
    } catch (e) {
      emit(FoodErrorState('Failed to decrement item count: $e'));
    }
  }

  void _handleDeleteFoods(DeleteFoods event, Emitter<FoodState> emit) async {
    try {
      await foodRepository.deleteAll();
      final foods = await foodRepository.fetchAllFoodItems();
      foodItems = foods;
      totalValue = 0.0;
      emit(FoodLoadedState(foods, totalValue));
    } catch (e) {
      emit(FoodErrorState('Failed to delete foods: $e'));
    }
  }

  void _handleDeleteFoodEvent(DeleteFood event, Emitter<FoodState> emit) async {
    try {
      final FoodModel food = event.food;

      await foodRepository.deleteFood(food.description);
      final foods = await foodRepository.fetchAllFoodItems();
      foodItems = foods;
      updateTotalValue();
      emit(FoodLoadedState(foods, totalValue));
    } catch (e) {
      emit(FoodErrorState('Failed to delete food: $e'));
    }
  }

  void _handleUpdateTotalCostEvent(UpdateTotalCostEvent event, Emitter<FoodState> emit) async {
    try {
      totalValue = event.newTotalCost;
      emit(FoodLoadedState(foodItems, totalValue));
    } catch (e) {
      emit(FoodErrorState('Failed to update total cost: $e'));
    }
  }
}
