#!/usr/bin/env bash
# Common functions for EA rules.

## OPTIMIZATION ##

# Enables/disable all optimization settings.
ea_optimize_all_set() {
  input_set .*,F $1
}

# Optimize specific parameter.
ea_optimize_param_set() {
  local param=$1
  local start=$2
  local end=$3
  local step=${4:-1}
  # Optimization settings (F-On, 1-Min, 2-Step, 3-Max).
  input_set $param,F 1
  input_set $param,1 $start
  input_set $param,2 $step
  input_set $param,3 $end
}

# Close all orders at the given hour.
ea_orders_close_all_at() {
  local hour=${1:-22}
  ea_action_set 1 15 10
  input_set ^MarketSpecificHour hour
}

## TRADE ##

ea_lotsize_set() {
  input_set ^LotSize $1
}

## ACTIONS ##

# Enables/disables account conditional actions.
ea_actions_enabled() {
  input_set Account_Conditions_Active $1
}

# Set action with the specific condition.
ea_action_set() {
  input_set ^Account_Condition_1   $1
  input_set ^Market_Condition_1    $2
  input_set ^Action_On_Condition_1 $3
}

## BOOSTING ##

# Enables/disables boosting.
ea_boost_enabled() {
  input_set ^Boosting_Enabled $1
}

## STRATEGIES ##

# Enables/disables strategies.
ea_strategies_enabled() {
  input_set .*_Active $1
}

# Set strategy parameters.
ea_strategies_param_set() {
  local strategy=$1
  local pattern=$2
  local value=$3
  input_set ^${strategy}.*_${pattern} $3
}

ea_strategy_enabled() {
  input_set ^$1.*_Active ${2:-1}
}

## MISC ##
