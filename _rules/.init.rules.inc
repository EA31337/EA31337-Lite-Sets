# Common functions for EA rules.

# Close all orders at the given hour.
close_all_orders() {
  input_set ^Account_Condition_1    1
  input_set ^Market_Condition_1    15
  input_set ^Action_On_Condition_1 10
  input_set ^MarketSpecificHour    ${1:-22}
}
