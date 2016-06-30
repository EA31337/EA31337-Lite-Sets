#!/usr/bin/env bash
# Common functions for EA rules.

# Close all orders at the given hour.
close_all_orders_at() {
  local hour=${1:-22}
  input_set ^Account_Condition_1    1
  input_set ^Market_Condition_1    15
  input_set ^Action_On_Condition_1 10
  input_set ^MarketSpecificHour    hour
}
