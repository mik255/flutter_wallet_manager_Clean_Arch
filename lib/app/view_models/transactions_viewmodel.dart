import 'package:flutter/material.dart';
import '../../domain/models/transaction.dart';

class TransactionViewModel{
  IconData icon(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.INCOME:
        return Icons.attach_money;
      case TransactionCategory.LOANS_AND_FINANCING:
        return Icons.money_off;
      case TransactionCategory.LOANS:
        return Icons.credit_card;
      case TransactionCategory.INVESTMENTS:
        return Icons.show_chart;
      case TransactionCategory.SAME_PERSON_TRANSFER:
        return Icons.compare_arrows;
      case TransactionCategory.TRANSFERS:
        return Icons.swap_horizontal_circle;
      case TransactionCategory.CREDIT_CARD_PAYMENT:
        return Icons.payment;
      case TransactionCategory.LEGAL_OBLIGATIONS:
        return Icons.gavel;
      case TransactionCategory.SERVICES:
        return Icons.build;
      case TransactionCategory.TELECOMMUNICATIONS:
        return Icons.phone;
      case TransactionCategory.EDUCATION:
        return Icons.school;
      case TransactionCategory.WELLNESS_AND_FITNESS:
        return Icons.fitness_center;
      case TransactionCategory.TICKETS:
        return Icons.event;
      case TransactionCategory.SHOPPING:
        return Icons.shopping_cart;
      case TransactionCategory.DIGITAL_SERVICES:
        return Icons.cloud;
      case TransactionCategory.GROCERIES:
        return Icons.local_grocery_store;
      case TransactionCategory.FOOD_AND_DRINKS:
        return Icons.restaurant;
      case TransactionCategory.TRAVEL:
        return Icons.flight;
      case TransactionCategory.DONATIONS:
        return Icons.favorite;
      case TransactionCategory.GAMBLING:
        return Icons.casino;
      case TransactionCategory.TAXES:
        return Icons.money;
      case TransactionCategory.BANK_FEES:
        return Icons.account_balance_wallet;
      case TransactionCategory.HOUSING:
        return Icons.home;
      case TransactionCategory.UTILITIES:
        return Icons.lightbulb;
      case TransactionCategory.HOUSEWARE:
        return Icons.kitchen;
      case TransactionCategory.HEALTHCARE:
        return Icons.local_hospital;
      case TransactionCategory.TRANSPORTATION:
        return Icons.directions_car;
      case TransactionCategory.INSURANCE:
        return Icons.security;
      case TransactionCategory.LEISURE:
        return Icons.sports_soccer;
      case TransactionCategory.OTHERS:
        return Icons.category;
      default:
        return Icons.help;
    }
  }
}

